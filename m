Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328333C4B72;
	Wed,  1 Jul 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900823; cv=none; b=D8/Tm/t1qziUgSzOzblvrzCk184jqXdHtAyFfurIoff+t3uqz+grzJBMHLIWm3StqgKQUw7b4NoZXtEdq2RMxD3svx9iP7rRpa24eF6+c2NwEEGERUXzdyWhCAVycMRb3Hzv6aZGOJp+wzcq7bcg6fTh7L2yyl4lfnhxJ5q764I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900823; c=relaxed/simple;
	bh=nu3dFizFFDwleuu4pYeeKi97FA2l9/Cw/yOx7g6woaU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ivV0jjlmIPWPWvnAwdiqG7SLaY5c6H32Jro6RhWDkD1NP4/7OsEtKY8DZT/b7dIjUcEbrdIJ4XuK49+8/Zi5lLUYpKnOPtXJ4c2DTOZOFGIvKFDDmuijuuwalDdQyd6NpmuKjqehVojuLW0u1lzTZt4XCEqpLRVnHKsKsWfUgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkoMU9FZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkoMU9FZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782900821; x=1814436821;
  h=date:from:to:cc:subject:message-id;
  bh=nu3dFizFFDwleuu4pYeeKi97FA2l9/Cw/yOx7g6woaU=;
  b=BkoMU9FZWSC0pgOYJHlHnE6glW6/ksGMwgGBTYyJJLgEmTAZ9Zhf7QQ8
   6S/KFtX6sgvsPAmMuweCu7zPC/Hhb/3xUdXtFHwLboMCG3+rI3pS7pVBl
   /rnaNg6MvPAlRIMxbeqJdf4CD6xPJsmn0KDRSg4EHD11dB7XfeKyWwTZj
   2ipQWr/rO84fJ/XpieV1SvIKAo6x0Us4USL6AYb6q33hQ7X9l5NtcTE4F
   nK6JyQKyzMUG/7K6MddgF5F82TnhmzYKtTZnZInUd+kaivIjgX98naGJ/
   y1ZxqOSHMsEbEG8c1xq3ORLKPLMaiL6XfJXGV6fFO1UqYbbsUmLqjgTRn
   g==;
X-CSE-ConnectionGUID: EJHPIVtoRvuyvydIQQUoQA==
X-CSE-MsgGUID: QM5oeIriSsWTgHqCjKzI6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="93985562"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="93985562"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 03:13:40 -0700
X-CSE-ConnectionGUID: XFPk9g1dTTae1GuN35VlHQ==
X-CSE-MsgGUID: XgGvB5sJR4Sola9dNJ93KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="251481385"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 01 Jul 2026 03:13:38 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1werwP-000000009BX-1oUE;
	Wed, 01 Jul 2026 10:13:25 +0000
Date: Wed, 01 Jul 2026 18:12:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 apparmor@lists.ubuntu.com, linux-arm-kernel@lists.infradead.org,
 linux-input@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
 virtualization@lists.linux.dev, Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 be5c93fa674f0fc3c8f359c2143abce6bbb422e6
Message-ID: <202607011852.7VW94YAL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: be5c93fa674f0fc3c8f359c2143abce6bbb422e6  Add linux-next specific files for 20260630

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202607010945.6lDjBFTU-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202607011210.PI7XDDb1-lkp@intel.com

    drivers/remoteproc/remoteproc_internal.h:131:5: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
    drivers/remoteproc/remoteproc_internal.h:131:7: error: call to undeclared function 'ioremap_prot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/remoteproc/remoteproc_internal.h:146:2: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    mm/hugetlb.c:3095:4: warning: array subscript -1 is below array bounds of 'struct list_head[1]' [-Warray-bounds]

Unverified Error/Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202607010826.2wLg1q08-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202607011451.icwPyCIk-lkp@intel.com

    drivers/hid/hid-asus.c:620 asus_kbd_backlight_work() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/i2c/busses/i2c-rk3x.c:1131 rk3x_i2c_xfer_common() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/rpmsg/rpmsg_char.c:236 rpmsg_eptdev_read_iter() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/usb/host/ehci-hub.c:1080 ehci_hub_control() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/usb/host/ehci-hub.c:691 ehci_hub_status_data() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/usb/host/ehci-sched.c:1290 itd_urb_transaction() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/usb/host/ehci-sched.c:2093 sitd_urb_transaction() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/virtio/virtio_input.c:333 virtinput_probe() error: calling 'spin_unlock_irqrestore()' with bogus flags
    drivers/virtio/virtio_input.c:56 virtinput_recv_events() error: calling 'spin_unlock_irqrestore()' with bogus flags
    security/apparmor/apparmorfs.c:590 policy_update() warn: passing zero to 'PTR_ERR'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- s390-randconfig-002-20260701
|   |-- drivers-remoteproc-remoteproc_internal.h:error:call-to-undeclared-function-ioremap_prot-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-remoteproc-remoteproc_internal.h:error:call-to-undeclared-function-iounmap-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-remoteproc-remoteproc_internal.h:error:incompatible-integer-to-pointer-conversion-assigning-to-void-from-int
|-- sparc-randconfig-r131-20260701
|   `-- mm-hugetlb.c:warning:array-subscript-is-below-array-bounds-of-struct-list_head
`-- x86_64-randconfig-161-20260701
    |-- drivers-hid-hid-asus.c-asus_kbd_backlight_work()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-i2c-busses-i2c-rk3x.c-rk3x_i2c_xfer_common()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-rpmsg-rpmsg_char.c-rpmsg_eptdev_read_iter()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-usb-host-ehci-hub.c-ehci_hub_control()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-usb-host-ehci-hub.c-ehci_hub_status_data()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-usb-host-ehci-sched.c-itd_urb_transaction()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-usb-host-ehci-sched.c-sitd_urb_transaction()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-virtio-virtio_input.c-virtinput_probe()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    |-- drivers-virtio-virtio_input.c-virtinput_recv_events()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
    `-- security-apparmor-apparmorfs.c-policy_update()-warn:passing-zero-to-PTR_ERR

elapsed time: 823m

configs tested: 227
configs skipped: 6

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260701    gcc-12.5.0
arc                   randconfig-002-20260701    gcc-12.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260701    gcc-12.5.0
arm                   randconfig-002-20260701    gcc-12.5.0
arm                   randconfig-003-20260701    gcc-12.5.0
arm                   randconfig-004-20260701    gcc-12.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260701    gcc-12.5.0
arm64                 randconfig-001-20260701    gcc-16.1.0
arm64                 randconfig-002-20260701    clang-17
arm64                 randconfig-002-20260701    gcc-12.5.0
arm64                 randconfig-003-20260701    gcc-12.5.0
arm64                 randconfig-004-20260701    clang-17
arm64                 randconfig-004-20260701    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260701    gcc-10.5.0
csky                  randconfig-001-20260701    gcc-12.5.0
csky                  randconfig-002-20260701    gcc-12.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260701    clang-23
hexagon               randconfig-001-20260701    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260701    clang-17
hexagon               randconfig-002-20260701    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260701    clang-22
i386        buildonly-randconfig-002-20260701    clang-22
i386        buildonly-randconfig-003-20260701    clang-22
i386        buildonly-randconfig-004-20260701    clang-22
i386        buildonly-randconfig-005-20260701    clang-22
i386        buildonly-randconfig-006-20260701    clang-22
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260701    clang-22
i386                  randconfig-002-20260701    clang-22
i386                  randconfig-003-20260701    clang-22
i386                  randconfig-004-20260701    clang-22
i386                  randconfig-005-20260701    clang-22
i386                  randconfig-006-20260701    clang-22
i386                  randconfig-007-20260701    clang-22
i386                  randconfig-011-20260701    gcc-14
i386                  randconfig-012-20260701    gcc-14
i386                  randconfig-013-20260701    gcc-14
i386                  randconfig-014-20260701    gcc-14
i386                  randconfig-015-20260701    gcc-14
i386                  randconfig-016-20260701    gcc-14
i386                  randconfig-017-20260701    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260701    clang-23
loongarch             randconfig-001-20260701    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260701    clang-19
loongarch             randconfig-002-20260701    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                            gpr_defconfig    clang-23
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260701    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260701    gcc-11.5.0
nios2                 randconfig-002-20260701    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260701    clang-17
parisc                randconfig-001-20260701    gcc-13.4.0
parisc                randconfig-002-20260701    clang-17
parisc                randconfig-002-20260701    gcc-15.2.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260701    clang-17
powerpc               randconfig-001-20260701    gcc-8.5.0
powerpc               randconfig-002-20260701    clang-17
powerpc               randconfig-002-20260701    clang-23
powerpc64             randconfig-001-20260701    clang-17
powerpc64             randconfig-002-20260701    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260701    clang-23
riscv                 randconfig-002-20260701    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260701    clang-23
s390                  randconfig-002-20260701    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260701    clang-23
sh                    randconfig-002-20260701    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260701    gcc-13.4.0
sparc                 randconfig-002-20260701    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260701    gcc-13.4.0
sparc64               randconfig-002-20260701    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260701    gcc-13.4.0
um                    randconfig-002-20260701    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260701    clang-22
x86_64      buildonly-randconfig-001-20260701    gcc-14
x86_64      buildonly-randconfig-002-20260701    clang-22
x86_64      buildonly-randconfig-003-20260701    clang-22
x86_64      buildonly-randconfig-004-20260701    clang-22
x86_64      buildonly-randconfig-004-20260701    gcc-14
x86_64      buildonly-randconfig-005-20260701    clang-22
x86_64      buildonly-randconfig-006-20260701    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260701    clang-22
x86_64                randconfig-001-20260701    gcc-14
x86_64                randconfig-002-20260701    gcc-14
x86_64                randconfig-003-20260701    gcc-14
x86_64                randconfig-004-20260701    clang-22
x86_64                randconfig-004-20260701    gcc-14
x86_64                randconfig-005-20260701    gcc-14
x86_64                randconfig-006-20260701    gcc-14
x86_64                randconfig-011-20260701    gcc-14
x86_64                randconfig-012-20260701    gcc-14
x86_64                randconfig-013-20260701    gcc-14
x86_64                randconfig-014-20260701    gcc-14
x86_64                randconfig-015-20260701    gcc-14
x86_64                randconfig-016-20260701    gcc-14
x86_64                randconfig-071-20260701    gcc-14
x86_64                randconfig-072-20260701    gcc-14
x86_64                randconfig-073-20260701    gcc-14
x86_64                randconfig-074-20260701    gcc-14
x86_64                randconfig-075-20260701    gcc-14
x86_64                randconfig-076-20260701    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260701    gcc-13.4.0
xtensa                randconfig-002-20260701    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
