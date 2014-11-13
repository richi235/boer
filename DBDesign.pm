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

    $DB->{tables}->{"Player_Won_in_game"} = {
        rights     => $RIGHTS,
        dbuser     => $DBUSER,
        primarykey => ["id"],
        hidden     => 1,

        #label => "",
        order => 2,

        idcolumnname => "id",

        columns => {

            "id" => { type => $UNIQIDCOLUMNNAME, },

            "Player_id" => {
                label        => "Player",
                showInSelect => 1,
                order        => 1,
                type         => "longnumber",
                linkto       => "Player",
             },
            
            "Game_id" => {
                type         => "longnumber",
                order        => 2,
                showInSelect => 1,
                linkto       => "Game",
              },

            "Player_won" =>
            {
                  type         => "boolean",
                  order        => 3,
                  showInSelect => 1,
            },

            "deleted" =>
            {
               type => $DELETEDCOLUMNNAME,
               order => 5,
            },
        }
    };

    $DB->{tables}->{"Player"} = {
        rights     => $RIGHTS,
        dbuser     => $DBUSER,
        primarykey => ["id"],

        #label => "",
        order => 1,

        idcolumnname => "id",

        columns =>
        {
            "Name" =>
            {
                type         => "text",
                showInSelect => 1,
            },

            "id" => { type => $UNIQIDCOLUMNNAME, },

            "deleted" =>
            {
               type => $DELETEDCOLUMNNAME,
               order => 5,
            },
        }
    };

    $DB->{tables}->{"Game"} =
    {
        rights     => $RIGHTS,
        dbuser     => $DBUSER,
        primarykey => ["id"],

        order => 2,

        idcolumnname => "id",

        columns =>
        {
            "id" => { type => $UNIQIDCOLUMNNAME, },

            "gameday" => {
                type        => "date",
                # display date of current day per default:
                defaultfunc => sub
                {
                    my @date_arr=localtime();
                    return
                        ""
                      . ( 1900 + $date_arr[5] ) . "-"
                      . ( 1 +    $date_arr[4] ) . "-"
                      . ( $date_arr[3] )
                      . " 00:00:00";
                },
                showInSelect => 1,
                order        => 1,
                label        => "Spiel-Zeitpunkt",
              },

            "gameday_sub_id" => {
                type         => "number",
                default      => 1,
                order        => 2,
                label        => "Sub-ID",
              },

            "deleted" =>
            {
               type => $DELETEDCOLUMNNAME,
               order => 5,
            },
        }
    };

    return $DB;
}

1;
