package boer::DBDesign;

use strict;
use warnings;
use ADBGUI::BasicVariables;
use ADBGUI::DBDesign(qw/$RIGHTS $DBUSER/);
use ADBGUI::Tools qw(Log);

our @ISA;

BEGIN {
   use Exporter;
   our @ISA = qw(Exporter);
   our @EXPORT = qw//;
}

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = shift;
   my $parent = $self ? ref($self) : "";
   @ISA = ($parent) if $parent;
   $self = $self ? $self : {};
   bless ($self, $class);
   return $self;
}

sub getDB {
   my $self = shift;
   my $DB = $self->SUPER::getDB() || {};

   $DB->{tables}->{"Player_Won_in_game"} =
   {
       rights     => $RIGHTS,
       dbuser     => $DBUSER,
       primarykey => ["id"],
   
       #label => "",
       order => 2,
   
       #dcolumnname => "id",
   
       columns =>
       {
           "Player_id" => {
               type   => "longnumber",
               linkto => "Player",
           },
           "Player_won" => { type => "boolean", },
           "Game_id"    => {
               type   => "longnumber",
               linkto => "Game",
           },
           "id" => { type => $UNIQUEIDCOLUMNNAME, },
       }
   };
   
   $DB->{tables}->{"Player"} =
   {
       rights     => $RIGHTS,
       dbuser     => $DBUSER,
       primarykey => ["id"],
   
       #label => "",
       order => 1,
   
       #idcolumnname => "id",
   
       columns =>
       {
           "Name" => { type => "text", },
   
           "id" => { type => $UNIQUEIDCOLUMNNAME, },
       }
   };
   
   $DB->{tables}->{"Game"} =
   {
       rights     => $RIGHTS,
       dbuser     => $DBUSER,
       primarykey => ["id"],
   
       #label => "",
       order => 2,
   
       #idcolumnname => "id",
   
       columns =>
       {
           "gamedate" => { type => "datetime", },
   
           "id" => { type => $UNIQUEIDCOLUMNNAME, },
       }
   };
   
   
   return $DB;
}

1;
