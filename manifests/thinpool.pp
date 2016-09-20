define lvm::thinpool (
  $volume_group,
  $logical_volume = $name,
  $extents = undef,
  $size    = undef,
  $manage_profile = true,
  $allocation = {},
  $activation = {},
) {

#  if (!$size && !$extents) {
#    fail("One of size or extents must be specified")
#  }
#
#  if $size && $extents {
#    fail("Can only specify one of size or extents")
#  }


  logical_volume { $logical_volume:
    ensure       => present,
    volume_group => $volume_group,
    thin         => true,
    extents      => $extents,
    size         => $size,
  }

  if $manage_profile {
    lvm::profile { $name:
      volume     => $logical_volume,
      group      => $volume_group,
      allocation => $allocation,
      activation => $activation,
    }
  }

}
