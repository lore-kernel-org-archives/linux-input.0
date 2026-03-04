Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1937F8A7
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600360; cv=none; b=I/upAzaBx6XpO54eteeHeyOlHjDdwAxZsX8xxQ+iuDRZozOvPLcQyiyI5MIcK8Urb4QgrmfaMiYwBlovj/irwXrI9oAKT8ojioJNdooFjsdxSzJGmTNnqB4DUe4uz0ugQZw4vQl6tv4hLENuoVA8eDO/I7eDg5lUwNjC/USMl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600360; c=relaxed/simple;
	bh=c9k7scsOyjwJL115qPITjXPKn1naMllV55DtGe609T0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UFbv/8+JZ/bouRPhZIjOchc5mlVJSQ0t8wvpTteF/jM70cAY/6Y9jP3s79jVD3EK7UAyqzuckzmxR/EfdRoCCgAuOr5cTpTOO4CqneD2jQa/7gc6sYsa8djM7QLexjQ0Iq2EbayqEm/BarKGDa3yGvXZ1k1SF5NSSiikRDpnpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKNno7Dz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKNno7Dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772600358; x=1804136358;
  h=date:from:to:cc:subject:message-id;
  bh=c9k7scsOyjwJL115qPITjXPKn1naMllV55DtGe609T0=;
  b=IKNno7Dz/PNPyVL5iR0s+BzN+opv82qGi0yQAAyOD6aV9484uThidIoc
   cduNnzeW1Ay+TMerbT9zxJRzoMcUW67ico/7v1E/NdEu3dB9Oa0kgT45v
   JTxSe6b7Zv0SDwNbGnvEY28r4Vb9aD4IAdqqmIH3US6cqW34eRuiQhOzF
   JnF7a7x8wBvpGJvyslh1B4/1PtX2Ds2ZX3PX9E5SL3TVQMxwLFRzGEryM
   f3EmnciU6v71A1O0esjvMhQ1juBJOXAn43vQGJ+Dvp2w44Ip+coOVJCDU
   BUku608ZQITEiZS2Pj9gJMeed6XLxjmchOldNSmrhKo4SG2ea9oVi7jr6
   w==;
X-CSE-ConnectionGUID: DqQvsggRSE6/XFrAYVd1sQ==
X-CSE-MsgGUID: GYcUJ9eLQ/ij0jz4ql8Ttw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73569234"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73569234"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 20:59:17 -0800
X-CSE-ConnectionGUID: D3phG/lWQMCkRWy7LoJSIg==
X-CSE-MsgGUID: rvpF7B9rSOye2HF6vw5ZjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="248705363"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 20:59:15 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxeKG-000000003Gn-18Is;
	Wed, 04 Mar 2026 04:59:12 +0000
Date: Wed, 04 Mar 2026 12:58:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 14/16] mips-linux-ld:
 drivers/hid/hid-lenovo-go-s.o:(.data.rgb_enabled+0x0): multiple definition of
 `rgb_enabled'; drivers/hid/hid-lenovo-go.o:(.data.rgb_enabled+0x0): first
 defined here
Message-ID: <202603041208.Jh3JVNU2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 550752e2c153663c3a374b048535654073007c90 [14/16] HID: hid-lenovo-go-s: Add RGB LED control interface
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260304/202603041208.Jh3JVNU2-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603041208.Jh3JVNU2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603041208.Jh3JVNU2-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips-linux-ld: drivers/hid/hid-lenovo-go-s.o:(.bss.drvdata+0x0): multiple definition of `drvdata'; drivers/hid/hid-lenovo-go.o:(.bss.drvdata+0x0): first defined here
>> mips-linux-ld: drivers/hid/hid-lenovo-go-s.o:(.data.rgb_enabled+0x0): multiple definition of `rgb_enabled'; drivers/hid/hid-lenovo-go.o:(.data.rgb_enabled+0x0): first defined here
   mips-linux-ld: drivers/hid/hid-lenovo-go-s.o:(.data.gamepad_mode+0x0): multiple definition of `gamepad_mode'; drivers/hid/hid-lenovo-go.o:(.data.gamepad_mode+0x0): first defined here
   mips-linux-ld: drivers/hid/hid-lenovo-go-s.o:(.data.touchpad_enabled+0x0): multiple definition of `touchpad_enabled'; drivers/hid/hid-lenovo-go.o:(.data.touchpad_enabled+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
