define lvm::thinpool (
  $volume_group,
  $logical_volume = $name,
  $extents = undef,
  $size    = undef,
  $manage_profile = true,
  $allocation = {},
  $activation = {},
) {


  logical_volume { $logical_volume:
    ensure       => present,
    volume_group => $volume_group,
    thinpool     => true,
    extents      => $extents,
    size         => $size,
  }

  if $manage_profile {
    lvm::profile { $name:
      volume     => $logical_volume,
      group      => $volume_group,
      allocation => $allocation,
      activation => $activation,
      require    => Logical_volume[$logical_volume],
    }
  }

}
