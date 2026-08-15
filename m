Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C8331EB0
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838296; cv=none; b=EEC5dZyS8JTZbThcU8IEzdIacDKu7D+AASnHgPwNQg6+bUFemv6bvpm8ctTUSfs+Uidu9bFgpuby0i/Dq0WdhCmWIFKwFpSqAyWYxc6orliVe/cufogasvwHkqOnDoXq5zOtUUX0ORSOY2rfSUg//0v1Hx2iUdzxZDmytw0PWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838296; c=relaxed/simple;
	bh=tdPeeP96/nN7AErlQXIrSGiL8pqeR+ZZkAfKxKZEMWM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YGGKHy3X20ZXtobpL25rLZwWc+njSTzJaqKjuWBw2J0CHI49YxKDE6JWGcMDdcI/X3XBfaJlSHfVls5tHBFb49uhlDjBYv1C6M2ajd0HXpvFk1NXvTj7g88zJ0moJqmkf4SHfj9DYKjjc6bhPgmJwVuGotxYWXczKIx4deoPTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck8PPIT/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck8PPIT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786838295; x=1818374295;
  h=date:from:to:cc:subject:message-id;
  bh=tdPeeP96/nN7AErlQXIrSGiL8pqeR+ZZkAfKxKZEMWM=;
  b=ck8PPIT/AL9y/+8Ud7x+o3607ApjDPprvAZbmQ/E+hME+uhFzYRu+IDe
   MQXhIu+8x3/Sca6EfmHGNDG+kL0i0SQ3whcTuenGywYdjkrFy7eme/Z8N
   prlaiQ/yIFc6FM550cJDIGjCpsd6Iq2GS7+nD4+64cKRgwj+T5+L0O3qA
   hM6RLbXrCSjfDobHPXkl8oACdlOwFdeRNm9umvEeUKXoGNCjPRSQa0dEe
   EpCCZZK2me7RwCGxrohezQh4vVUjAlKkQv/zvvK5DIkOH3RmeB0wrbV9D
   4zgbkXtMzdrPsGF9buvxX/s31wvESzVNDrbu5Iis8wD5X6iGqgym+UxDo
   g==;
X-CSE-ConnectionGUID: 1zsnGbGgQjGcdf4uPYRPGA==
X-CSE-MsgGUID: R1hRQoztRf6YK9LrAgq/eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87286822"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="87286822"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 16:58:14 -0700
X-CSE-ConnectionGUID: p5MKi/i/RKSIbw1aIanmzw==
X-CSE-MsgGUID: cckhBQHjSKCwYcmUWAxPsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="261910038"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Aug 2026 16:58:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvOGQ-00000000cX4-0ny0;
	Sat, 15 Aug 2026 23:58:10 +0000
Date: Sun, 16 Aug 2026 07:58:09 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 9a29ee801f525bcad71fea021bfe2a030885c8df
Message-ID: <202608160757.ceE0fxQK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: 9a29ee801f525bcad71fea021bfe2a030885c8df  Input: rmi4 - use platform data instead of query, when available

elapsed time: 770m

configs tested: 16
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-16.1.0
alpha           allyesconfig    gcc-16.1.0
alpha              defconfig    gcc-16.1.0
arc             allmodconfig    gcc-16.1.0
arc             allyesconfig    gcc-16.1.0
csky            allmodconfig    gcc-16.1.0
i386            allmodconfig    gcc-14
loongarch          defconfig    clang-24
nios2           allmodconfig    gcc-11.5.0
nios2            allnoconfig    gcc-11.5.0
parisc          allmodconfig    gcc-16.1.0
parisc          allyesconfig    gcc-16.1.0
parisc             defconfig    gcc-16.1.0
powerpc     bamboo_defconfig    clang-21
sh                 defconfig    gcc-16.1.0
sh         rsk7264_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
