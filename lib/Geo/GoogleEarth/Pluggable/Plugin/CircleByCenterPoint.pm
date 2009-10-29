package Geo::GoogleEarth::Pluggable::Plugin::CircleByCenterPoint;
use strict;
use warnings;
use Geo::Forward;

our $VERSION='0.01';

=head1 NAME

Geo::GoogleEarth::Pluggable::Plugin::CircleByCenterPoint - CircleByCenterPoint plugin for Geo::GoogleEarth::Pluggable

=head1 SYNOPSIS

  use Geo::GoogleEarth::Pluggable;
  my $document=Geo::GoogleEarth::Pluggable->new;
  my $polygon=$ducument->CircleByCenterPoint(
                                name       => "My CircleByCenterPoint",
                                radius     => 500,    #meters
                                lat        => 39.001, #WGS-84 degrees
                                lon        => -77.001,#WGS-84 degrees
                                alt        => 0,      #reference see LookAt
                               );

=head1 TODO

  my $polygon=$ducument->ArcByCenterPoint(
                                name       => "My ArcByCenterPoint",
                                radius     => 500,    #meters
                                startAngle => 0,  #degrees CW from North
                                endAngle   => 180,
                                lat        => 39.001, #WGS-84 degrees
                                lon        => -77.001,#WGS-84 degrees
                                alt        => 0,      #reference see LookAt
                                deltaAngle => 3.6,    #default
                               );

=head1 DESCRIPTION

=head1 USAGE

=head1 METHODS

=head2 CircleByCenterPoint

  my $polygon=$ducument->CircleByCenterPoint(
                                name       => "My CircleByCenterPoint",
                                radius     => 1000,    #meters
                                lat        => 39.001, #WGS-84 degrees
                                lon        => -77.001,#WGS-84 degrees
                                alt        => 0,      #reference see LookAt
                                deltaAngle => 7.2,    #default
                               );

=cut

sub CircleByCenterPoint {
  my $self=shift; #$self isa Geo::GoogleEarth::Pluggable::Folder object
  my %data=@_;
  $data{"startAngle"} ||= 0;
  $data{"deltaAngle"} ||= 7.2;
  $data{"deltaAngle"}   = 0.1 if $data{"deltaAngle"} < 0.1;
  $data{"deltaAngle"}   = 90 if $data{"deltaAngle"} > 90;
  my $interpolate       = int(360/$data{"deltaAngle"});
  $data{"deltaAngle"}   = 360/$interpolate;
  $data{"radius"}       = 1000 unless defined $data{"radius"};
  $data{"alt"}        ||= 0;
  my $coordinates=[];
  my $gf=Geo::Forward->new;
  foreach my $index (0 .. $interpolate) {
    $data{"angle"}=$data{"startAngle"} + $index * $data{"deltaAngle"};
    my ($lat,$lon,$baz)=$gf->forward(@data{qw{lat lon angle radius}});
    push @$coordinates, [$lon, $lat, $data{"alt"}];
  }
  $data{"coordinates"}=$coordinates;
  delete(@data{qw{lat lon angle radius alt deltaAngle startAngle}});
 #use Data::Dumper;
 #print Dumper([\%data]);
  return $self->LinearRing(%data);
}

=head2 ArcByCenterPoint

  my $polygon=$ducument->ArcByCenterPoint(
                                name       => "My ArcByCenterPoint",
                                radius     => 500,    #meters
                                startAngle => 33.3,   #degrees CW/North
                                endAngle   => 245.7,  #degrees CW/North
                                deltaAngle => 7.2,    #default
                                lat        => 38.889, #WGS-84 degrees
                                lon        =>-77.035, #WGS-84 degrees
                                alt        => 0,      #reference LookAt
                               );

=cut

sub ArcByCenterPoint {
  die("TODO");
}

=head1 BUGS

=head1 SUPPORT

=head1 AUTHOR

    Michael R. Davis
    CPAN ID: MRDVT
    STOP, LLC
    domain=>michaelrdavis,tld=>com,account=>perl
    http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

	The BSD License

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<Geo::GoogleEarth::Pluggable>

=cut

1;
