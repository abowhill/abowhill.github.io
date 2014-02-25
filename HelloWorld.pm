package HelloWorld;

sub new
   {
   bless { msg => "hello world" }, shift;
   }

sub message
   {
   my $a = shift;

   return $a->{msg};
   }

1;
