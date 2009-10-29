

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Geo::GoogleEarth::Pluggable::Plugin::CircleByCenterPoint',
    VERSION_FROM => 'lib/Geo/GoogleEarth/Pluggable/Plugin/CircleByCenterPoint.pm', # finds \$VERSION
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT     => 'CircleByCenterPoint plugin for Geo::GoogleEarth::Pluggable',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                     'strict' => 0,
                     'warnings' => 0,
                     'Geo::Forward' => 0,
                    },
);
