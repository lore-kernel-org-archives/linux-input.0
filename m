Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2135C1A2;
	Thu, 22 Jan 2026 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108670; cv=none; b=UPRMcS2YWdR9vI8DW0y48N+l4IItlSuZHWNo3+YYw3S/NmjozayByO8k1Mbg9gpAHwJYP62wKAixatBLr+ztYhN4LAe9WLkddyPhpxYxWL0zBIWaR7EclM4VPWm3IwWijhx1cv6nv4lUUsDbfx/T7CrOpmlbYQFDYGqKdcwdGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108670; c=relaxed/simple;
	bh=n86ZAtXaF72aEqg062RbmaPe/1zPSj1IQxbCNxuRtMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVUwDHQgZReMAXitNnIkn1kbpgLlQZ6zyk91xWM+9jVvn8+FTxKd0UgkOpgByWP1O3DzOODTc2zM231p1xRKT1xP8xf3YnO7HLfGtnl4/4XzRuvdKW52VPUPpurojgpsCB2iTof4H3FlUQcMf9LXivM1aQuu7TqIAckJ3qwnPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2C9mcnl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2C9mcnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769108663; x=1800644663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n86ZAtXaF72aEqg062RbmaPe/1zPSj1IQxbCNxuRtMQ=;
  b=n2C9mcnlZya1oMsosg/v5yQ01d9YnPbw0Enc9lsA3zsIFgP/lELG9PsB
   7TOs6WCzkMoMjwhS/CUsUmihtIa4XGR02BRVg70w1Vlgtbou2A9LRrxDD
   FMbyFqxNMMH8cZ3iVMPALVibQhDGVSZiM0s9hM/LmF4CpOZ9lOfhgb35+
   d3tlP8a4I9h58cJDXvKbHHicibBg4TCr0sOnU9dTwmZGiZNGmgrr1rUmQ
   NS9JNVuCp68qI3EhUiJsugWWRe6xSRzhjJS7FUeK3aMb3cFxTIFhNVbxU
   dC3FJGD8iwBSBiY0qf3+p+MljiroisgoEiKFmkdn5DkoCLF/A4TyavwrX
   g==;
X-CSE-ConnectionGUID: ihXzeyzySfGKi4JyN0HGmg==
X-CSE-MsgGUID: 9f+XsEnGSLq/hDUiSA6QUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81474258"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81474258"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:04:21 -0800
X-CSE-ConnectionGUID: JxUzm3YiTc2EDIiyh2KMBA==
X-CSE-MsgGUID: /6MxOfPjSbWqj6sGU8RiGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211317816"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Jan 2026 11:04:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vizyZ-00000000TCE-2cpy;
	Thu, 22 Jan 2026 19:04:15 +0000
Date: Fri, 23 Jan 2026 03:03:43 +0800
From: kernel test robot <lkp@intel.com>
To: AThomas63 <andrew.thomas@touchnetix.com>, dmitry.torokhov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.satterthwaite@touchnetix.com,
	andrew.thomas@touchnetix.com, m.felsch@pengutronix.de,
	kamel.bouhara@bootlin.com
Subject: Re: [PATCH 1/1] Adding support for aXiom touchscreen controller
Message-ID: <202601230252.ZlyhNYe2-lkp@intel.com>
References: <20260122124819.273188-2-andrew.thomas@touchnetix.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122124819.273188-2-andrew.thomas@touchnetix.com>

Hi AThomas63,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v6.19-rc6 next-20260122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AThomas63/Adding-support-for-aXiom-touchscreen-controller/20260122-212452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20260122124819.273188-2-andrew.thomas%40touchnetix.com
patch subject: [PATCH 1/1] Adding support for aXiom touchscreen controller
config: sh-randconfig-r072-20260123 (https://download.01.org/0day-ci/archive/20260123/202601230252.ZlyhNYe2-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.3.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601230252.ZlyhNYe2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601230252.ZlyhNYe2-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/touchscreen/axiom_core.c: In function 'axiom_unpack_device_info':
>> drivers/input/touchscreen/axiom_core.c:110:27: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     110 |         info->device_id = FIELD_GET(AX_DEV_ID_MASK, w);
         |                           ^~~~~~~~~


vim +/FIELD_GET +110 drivers/input/touchscreen/axiom_core.c

   103	
   104	static void axiom_unpack_device_info(const u8 *buf,
   105					     struct axiom_device_info *info)
   106	{
   107		u16 w;
   108	
   109		w = get_unaligned_le16(buf);
 > 110		info->device_id = FIELD_GET(AX_DEV_ID_MASK, w);
   111		info->mode = !!(w & AX_MODE);
   112	
   113		w = get_unaligned_le16(buf + 2);
   114		info->runtime_fw_rev_minor = FIELD_GET(AX_FW_REV_MINOR_MASK, w);
   115		info->runtime_fw_rev_major = FIELD_GET(AX_FW_REV_MAJOR_MASK, w);
   116	
   117		w = get_unaligned_le16(buf + 4);
   118		info->device_build_variant = FIELD_GET(AX_VARIANT_MASK, w);
   119		info->runtime_fw_status = !!(w & AX_FW_STATUS);
   120		info->tcp_revision = FIELD_GET(AX_TCP_REV_MASK, w);
   121	
   122		w = get_unaligned_le16(buf + 6);
   123		info->bootloader_fw_rev_minor = FIELD_GET(AX_BOOT_REV_MINOR_MASK, w);
   124		info->bootloader_fw_rev_major = FIELD_GET(AX_BOOT_REV_MAJOR_MASK, w);
   125	
   126		info->jedec_id = get_unaligned_le16(buf + 8);
   127	
   128		w = get_unaligned_le16(buf + 10);
   129		info->num_usages = FIELD_GET(AX_NUM_USAGES_MASK, w);
   130		info->silicon_revision = FIELD_GET(AX_SILICON_REV_MASK, w);
   131		info->runtime_fw_rev_patch = FIELD_GET(AX_RUNTIME_FW_PATCH_MASK, w);
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
