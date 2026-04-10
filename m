Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8643E3D88
	for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844674; cv=none; b=Is36ucVMypcnvPU389rrZKHjazAjKgqlKH1qSrHJItU99v2sD5ObHiI7jL7B9MRm1i0G5s3Pesv0dyT/uygS6mSLlv0fJKuq/Jx/niAvZTA02Kf/mqKr+NjWVjR9UIvnCyo1bYtEDNU/0yY4SWOv23zNZegDANJxS8ynrkQ0BS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844674; c=relaxed/simple;
	bh=o+sRuMQMoIrz0nU46qaFqSGl53FPeisF7BoEaxpxUjY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uukVR9Nre0EZP1oEGIQk+4GhIuvXIEtvF3zTfJ2dbQbHXvf5CLjKEUUID5eSc3HxX3qrWqmlFR5V9dnIFHMkH7+5n8QbVHYAjxhj9yCYrGN/gauxfK6TXoT3Grt5qg6uUSEA32XwhHcywszZ/yberLDdRIJLCF4AiP/EPtt4sdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZPEEEeu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZPEEEeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775844673; x=1807380673;
  h=date:from:to:cc:subject:message-id;
  bh=o+sRuMQMoIrz0nU46qaFqSGl53FPeisF7BoEaxpxUjY=;
  b=RZPEEEeuTzOQJiRd2+rBOIQ+f+eMJss5C0GE3siHOuytgLq3pnaHNSnk
   SN1HUiM1EzyGmZHZVOhAde+AWdmV4pghaJ6V4+vKfQq8/wNgohVvyKs3p
   fi4c51GG25059ZII3a/vi7a1SqZnKPWeo5Gana13TVHHMT0ucQsMRT/Fx
   hrlkm1ihnl5qtUfyPMcBOnFAtfzaEnTi8BTK3TI8c5g7OdLnbctO7HsZe
   7h8eiqMJB+/l7OpmWhwRB+k2NeM0ZpYm6ZFc6gXpjlOpxTeBuCPAXeD5o
   eFR7F4fia9t5VfG4KC8Jk87vZGRs4vUMoW1r/joJbrp3qEfq6UGV4WXY4
   w==;
X-CSE-ConnectionGUID: BbJ6xygMR9uFRtZ5IKe4rA==
X-CSE-MsgGUID: YtAY3A1XTxmm7+crd0KifQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="80732085"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="80732085"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:11:13 -0700
X-CSE-ConnectionGUID: b54w1jbFRLS4UWthL6CrDA==
X-CSE-MsgGUID: REK24vaSSZaxDGdj3wr+Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="229039481"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Apr 2026 11:11:13 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBGJy-000000004By-0SJO;
	Fri, 10 Apr 2026 18:11:10 +0000
Date: Sat, 11 Apr 2026 02:10:27 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 875115b82c295277b81b6dfee7debc725f44e854
Message-ID: <202604110221.KRyyMOMS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: 875115b82c295277b81b6dfee7debc725f44e854  Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

elapsed time: 730m

configs tested: 55
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
