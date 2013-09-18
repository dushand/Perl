package SillyFunction;

sub group_products {
my $products = shift;
my %brand_type = ();
my $grouped_products = [];

foreach (@{$products})
{
$brand_type{$_->{brand}} ||= {};
$brand_type{$_->{brand}}->{$_->{type}} = 1;
}
foreach (sort keys %brand_type)
{
my $brand = $_;
foreach (sort keys %{$brand_type{$brand}}) {
push(@{$grouped_products}, { brand => $brand, type => $_});
}
}
$grouped_products;
}

1;

# test case01-----------------------------
$test=[map{{brand=>(join'',map{('a'..'z')[rand(rand 13+rand 13)]}0..1/(0.2+rand)),type=>(join'',map{('a'..'z')[rand 26]}0..1/(0.05+rand))}}-3..1/rand];

# test case02-----------------------------
my @l=split//,"etaoinshrdlucmfwypvbgkjqxz";
$test=[map{{brand=>(join'',map{$l[rand rand rand 26]}0..1/(0.2+rand)),type=>(join'',map{$l[rand rand 26]}0..1/(0.05+rand))}}-3..2/rand];

#---------------------------------------------------------------------------------

#for readability
sub group_products{
    return[sort{$a->{brand}cmp$b->{brand}||$a->{type}cmp$b->{type}}@{$_[0]}]
}
#---------------------------------------------------------------------------------

#for efficiency
sub group_products{  # assumes brand and type do not contain "\0"
  return [
      map{{split/\0/}}
      sort
      map{"brand\0$_->{brand}\0type\0$_->{type}"}
      @{+shift}
  ]
}

#---------------------------------------------------------------------------------
#assumed that brand,type pairs were unique in @{$products}
# if that's not guaranteed, you might use
sub unique_products{
    my %unique;
    @unique{map{"brand\0$_->{brand}\0type\0$_->{type}"}@{+shift}}=();
    return [
      map{{split/\0/}}
      sort
      keys %unique
  ]
}
#or
sub unique_products{
    return [
      map{{split/\0/}}
      sort
      keys %{{map{("brand\0$_->{brand}\0type\0$_->{type}",1)}@{+shift}}}
   ]
}
#---------------------------------------------------------------------------------