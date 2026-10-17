Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C03C4B79
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208497; cv=none; b=fIqvvCd/fIMMCo6bC8o2wYaZ+gM/CerOYWXy9hpo+5wGX0UDTts4Msq8jnVjcRhgMU7Ae85PreIDF6/tt5vxAhSokOCv1RwfLzIN4ZYH48XHYVZLjm6PeJy7ccP8cIp4l94ezg1cnagcgsDR/EnJscPFl54lYKW9HFT4kZlf6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208497; c=relaxed/simple;
	bh=qyviMIZY4ox7umtLx3YrZA+B6VQau3wATqVWB10qNSc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qOgnFj5FQcvJM/8UfVJWYWugZfxiFYhkFrxaogZ4uoZURwXY1SJVB1wjOowSOTGo0sEifUuAKjquXXk+g7kAkYUQI0NrKAxUmdyKs1+NLKit+rntheDpQsc+AniKCYl7MzSiZSrTuGMDzPDEikNeSMZ4hpnLVb53ItGTBj0X7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpefkYKO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpefkYKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792208495; x=1823744495;
  h=date:from:to:cc:subject:message-id;
  bh=qyviMIZY4ox7umtLx3YrZA+B6VQau3wATqVWB10qNSc=;
  b=mpefkYKOQBr8z5bNWWlZBUdgWjSXRBAH8NJzg5aGVf79Htpj7PYvGX4K
   tabJqZyfqg91DRUCUOOjPfQo+3hYaRzTqU/lY+MojgfdF34n2rvkMEh5K
   V6LD07z2xA8b/H2yu/w91m1LoYr5EfcKMddokDtwRygtc59iE7Mdx6B3i
   9f1uZPlJsbrb2Hazh9G9DCAiFheLxo8sKU6CwIoDFOkQ+EMe5AYhLKVAI
   8yJKcbVxHygBojIhzZKl0qjZjhxWGj7Dr2aaYu32gcFlz1TdgHIDj+tRe
   G6JDpyvpMZmbVYM4219qAz1jqAxtGKmpHuZmYb3hhnDYDUleVpM/aTdSb
   A==;
X-CSE-ConnectionGUID: 4VOje+C4SB6TefyuSy3M7A==
X-CSE-MsgGUID: 8kiUp1E0SM+Cyj1YbdwGkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="890943"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="890943"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 20:41:34 -0700
X-CSE-ConnectionGUID: XwiZvE6HQeqgerIp46znLA==
X-CSE-MsgGUID: g6e74HY5Q5yieBwoT0sZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="3924062"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 20:41:33 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHvIX-00000000J1A-49FC;
	Sat, 17 Oct 2026 03:41:29 +0000
Date: Sat, 17 Oct 2026 11:41:25 +0800
From: kernel test robot <lkp@intel.com>
To: Vicki Pfau <vi@endrift.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Silvan Jegen <s.jegen@gmail.com>
Subject: [hid:for-7.4/nintendo 2/5] ld.lld: error: undefined symbol:
 hid_is_usb
Message-ID: <202610171134.itp4VPif-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/nintendo
head:   77c7155e2707ba5b1d56f3dc1acead48cf17f98d
commit: 9417132df63e5cd7230433af05198538e759f3ae [2/5] HID: nintendo: Add preliminary Switch 2 controller driver
config: i386-randconfig-1005-20261016 (https://download.01.org/0day-ci/archive/20261017/202610171134.itp4VPif-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261017/202610171134.itp4VPif-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610171134.itp4VPif-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: hid_is_usb
   >>> referenced by hid-nintendo.c:3993 (drivers/hid/hid-nintendo.c:3993)
   >>>               drivers/hid/hid-nintendo.o:(nintendo_hid_probe) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
