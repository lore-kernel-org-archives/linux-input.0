Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD77313531
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309957; cv=none; b=VBdw6oXymW8BLfCyo9KDMw4JF9fNYgVrxC4HSubL31/4BM/yQxhgqlN/I29fDr8Od7uIzm9VsXw0jFT/tcj/qLW47fXn++TpQ4VzEgxu+/qnnlpOVfcMZrQFawkei5Z8mAAxXLjoxOF+I90GISt1aG+76oWCN4lB9eNEv8pFNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309957; c=relaxed/simple;
	bh=dVI7UEBq8pBXFbFcNaU/D9uCVDe9LSggGftOCg30Guc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TCC5jmuCTzgANkMRyFn9Xb7kajAGNefA2wFV2MshGm80e5nvfZEzs0Wna+iuiO3eHuT233ULiU6W5bhwBgh7Loi6NWX5mRROwF4d8OaG7tj7v2bWyOreaflwoNgHHBkaWmvoX+1DjAq7V4rpH5e7XzDMdFksZ5Erz3T8XO+6Hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6G0PLx8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6G0PLx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792309956; x=1823845956;
  h=date:from:to:cc:subject:message-id;
  bh=dVI7UEBq8pBXFbFcNaU/D9uCVDe9LSggGftOCg30Guc=;
  b=D6G0PLx8ormBZcrYJqnL7gMRUqK4l6yyKcA2k7uTKGABgkTbUDtq2HNu
   oZiUSabfXAhyPb6wo3I5m4/JkTW71DJ70xXi8pqwzUcN/hd1/PDZGSx0+
   VTm0KQNleBJ3L5qS/xdSm1Be+mI8ydTML79CYMAj8zFHed+tElHTQD8kU
   CihDaye4bvujL6GQkNPyYV+TO0caQtbrs+JIA9hTocyLipHoKzxnWNyWD
   YCNhMiozRpLd3LzgrZZsEVEha3VnLCxMf5dhfJWxVH+iCrxERccRTM1pp
   vGmC1wA5tbPfnYaozcWX6cB9Zl+qZvfxCXV+wJK699gwsYFZrDUrzgFlJ
   Q==;
X-CSE-ConnectionGUID: u2W7pQcTQimIZD0NL6CBiQ==
X-CSE-MsgGUID: Tq59kTW+R0iYYB2w8ecgdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="908844"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="908844"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 00:52:35 -0700
X-CSE-ConnectionGUID: 2udKituSQ4Ws4nyeUfJ7dg==
X-CSE-MsgGUID: Q7dvDcokRSa2+Eyk0ERqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="4115534"
Received: from igk-lkp-server01.igk.intel.com (HELO 3c253b998be3) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 18 Oct 2026 00:52:34 -0700
Received: from kbuild by 3c253b998be3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xILh1-000000004vy-3saq;
	Sun, 18 Oct 2026 07:52:31 +0000
Date: Sun, 18 Oct 2026 09:49:09 +0200
From: kernel test robot <lkp@intel.com>
To: Vicki Pfau <vi@endrift.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Silvan Jegen <s.jegen@gmail.com>
Subject: [hid:for-7.4/nintendo 2/5] ERROR: modpost:
 drivers/hid/hid-nintendo.ko: symbol 'hid_is_usb' undefined!
Message-ID: <202610171718.nPYn0LO3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/nintendo
head:   77c7155e2707ba5b1d56f3dc1acead48cf17f98d
commit: 9417132df63e5cd7230433af05198538e759f3ae [2/5] HID: nintendo: Add preliminary Switch 2 controller driver
config: parisc-randconfig-r2104-20261017 (https://download.01.org/0day-ci/archive/20261017/202610171718.nPYn0LO3-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261017/202610171718.nPYn0LO3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610171718.nPYn0LO3-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/hid/hid-nintendo.ko: symbol 'hid_is_usb' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
