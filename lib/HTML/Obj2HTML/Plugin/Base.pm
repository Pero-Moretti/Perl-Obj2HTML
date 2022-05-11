HTML::Obj2HTML::register_extension("repeat", {
  tag => "",
  before => sub {
    my $o = shift;
    my $ret = [];
    if (!defined $o->{num}) { $o->{num} = 1; }
    for (my $i=0; $i<$o->{num}; $i++) {
      push(@{$ret}, @{$o->{_}});
    }
    return $ret;
  }
});

HTML::Obj2HTML::register_extension("editable", {
  tag => "",
  before => sub {
    my $o = shift;
    my $prevro = Obj2HTML::getopt("readonly");
    Obj2HTML::setopt("readonly", 0);
    my $ret = Obj2HTML::gen($o);
    Obj2HTML::setopt("readonly", $prevro);
    return $ret;
  }
});
HTML::Obj2HTML::register_extension("readonly", {
  tag => "",
  before => sub {
    my $o = shift;
    my $prevro = Obj2HTML::getopt("readonly");
    Obj2HTML::setopt("readonly", 1);
    my $ret = Obj2HTML::gen($o);
    Obj2HTML::setopt("readonly", $prevro);
    return $ret;
  }
});

HTML::Obj2HTML::register_extension("ifReadOnly", {
  tag => "if",
  before => sub {
    my $o = shift;
    if (ref $o eq "HASH") {
      $o->{cond} = Obj2HTML::getopt('readonly');
    }
    return "";
  }
});
HTML::Obj2HTML::register_extension("ifEditable", {
  tag => "if",
  before => sub {
    my $o = shift;
    if (ref $o eq "HASH") {
      $o->{cond} = !Obj2HTML::getopt("readonly");
    }
    return "";
  }
});

1;