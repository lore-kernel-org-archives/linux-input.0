Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623489;
	b=CBVLZ5qEWdRE5964jiQVQrfwOpQyEbckLk85yrM/1Szci6cdMMKM5aCeoE/5HFwHAqx8
	 Gai0W9XxK42NX2b2GAgIVsJUDWLmaIyFoopKMkwzHpiHsXRirZMfIQcIM2yQkPEEMgoeK
	 zoNUdG6Ic2OOhGlSdZIGjvxeKx0F10qbAaXyN3E2rtNeT1xZsIGD6DoZBC0ph/0CtukJN
	 nalT6A2CHT2fDLKX4ZnYcSZ1A+UEl/eD3e1BIanZ0PmhwoY6MN+xbhGXcFERsD0KGElbx
	 6TwKcydA0zfK0obBcTtUI5L2l0/7+Qc/rkKBxjwf2eeBfG55x+izAczr1ULyzXUzuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623489;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WwWsoSs2J5qpWhNs56AVQmBfYke5YnSSuODOR4ultkM=;
	b=MRFYhvTFIMnQxVFY+wjgnTlCN5KOjP5EEoAc6UjzQhnmM/iftDnNBgNYfP4pMwgr4DBY
	 WHKKqaAwPyKZrzeE0hRQdK1DC/WN1rw2kxFGfxlwOqtxkt0yxQYn3yYgeCAkzjlwJHYy4
	 VPlaxrcW0sWcjpoCNaJtlhE43B1zYVMG2A/1sRnuRzFMK5388krk/jjvPWwUS9f2e11B0
	 wX31fsowpENnBdsadADWvqZvHHGlTxCdiPA2w7Kbg5sCTULqxsDkhc7DtFee312Ox6X+T
	 rJzLXo2QiQQduntFEEC3OmKlVu85LSAMmUYuXNdNhXnTw6L/nYHnkbh0+fGJ4qebcXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8vX9bEe;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC17606A321;
	Wed, 25 Nov 2026 16:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC17606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8vX9bEe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795623489; x=1827159489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9+tiGBNKlGAcbgLvr/9pQGLti36ZdFJyzGzi5HXaUoE=;
  b=c8vX9bEeLTML4tMpf8utLXlQtQCgMO3xiimgmpiezaNd8IrXXJ1P12dj
   qFATB0OFAU+yAEQqT3mjtspPec83HnaenJPf/8RqmwPS9yHItqPqeEW3/
   QLlYgMky46LwX+hW9ynshf32EdRRF6p4XKuvE6BPTchdmJgvTyee1thkm
   0ngw4A+PQR/wIgPdgPvteOVlJ1lFF3vugcWhS5EQAkRQlwGaCBoxisQHr
   exNLkDOeiNHJl2t2u58rot+8vVoPxHatRhJhmxeo79dygH0xEj1tfQOcQ
   NCIheQ2zlnRKOclJvxGmZ90ad21ELVXcd2jLncm7RmjO6I6uT5qSL2Qb+
   w==;
X-CSE-ConnectionGUID: 2Ebr634hQd6ffelAiVwd6Q==
X-CSE-MsgGUID: 3wariWPMSamUX0l4+6/p0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4498982"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4498982"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 08:07:03 -0800
X-CSE-ConnectionGUID: rs80A/RtRHmkmjDfIQjjAQ==
X-CSE-MsgGUID: DiFJ+MTDSaW9EKAtEObxag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12375211"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2026 08:03:58 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWFTP-00000001S0s-3iSt;
	Wed, 25 Nov 2026 16:03:55 +0000
Date: Thu, 26 Nov 2026 00:03:08 +0800
From: kernel test robot <lkp@intel.com>
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: Re: [PATCH v3 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Message-ID: <20261125235231.H9Nhpv9l-lkp@intel.com>
References: <tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07@qq.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07@qq.com>

Hi Hefei,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on dtor-input/next dtor-input/for-linus lee-backlight/for-backlight-next lee-backlight/for-backlight-fixes linus/master v7.4-rc4 next-20261124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hefei/dt-bindings-input-add-Jadard-JD9365TX-touchscreen-binding/20261125-101123
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07%40qq.com
patch subject: [PATCH v3 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20261125/20261125235231.H9Nhpv9l-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2012344e5da8e03ea4b8283ecd6fad6e13f09d64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125235231.H9Nhpv9l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125235231.H9Nhpv9l-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-viewe-jd9365tx.c:304:8: error: call to undeclared function 'of_drm_get_panel_orientation'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     304 |         ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
         |               ^
>> drivers/gpu/drm/panel/panel-viewe-jd9365tx.c:308:2: error: call to undeclared function 'drm_panel_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     308 |         drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
         |         ^
   2 errors generated.


vim +/drm_panel_init +308 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

   273	
   274	static int jd9365tx_probe(struct mipi_dsi_device *dsi)
   275	{
   276		struct device *dev = &dsi->dev;
   277		struct jd9365tx_panel *ctx;
   278		int ret;
   279	
   280		ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
   281		if (!ctx)
   282			return -ENOMEM;
   283	
   284		ctx->dsi = dsi;
   285		mipi_dsi_set_drvdata(dsi, ctx);
   286	
   287		dsi->lanes = 2;
   288		dsi->format = MIPI_DSI_FMT_RGB888;
   289		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
   290				  MIPI_DSI_MODE_LPM;
   291	
   292		ctx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
   293		if (IS_ERR(ctx->reset))
   294			return PTR_ERR(ctx->reset);
   295	
   296		ctx->vdd = devm_regulator_get(dev, "vdd");
   297		if (IS_ERR(ctx->vdd))
   298			return PTR_ERR(ctx->vdd);
   299	
   300		ctx->iovcc = devm_regulator_get(dev, "iovcc");
   301		if (IS_ERR(ctx->iovcc))
   302			return PTR_ERR(ctx->iovcc);
   303	
   304		ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
   305		if (ret)
   306			return ret;
   307	
 > 308		drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
   309		ctx->panel.prepare_prev_first = true;
   310	
   311		ret = drm_panel_of_backlight(&ctx->panel);
   312		if (ret)
   313			return ret;
   314	
   315		drm_panel_add(&ctx->panel);
   316	
   317		ret = mipi_dsi_attach(dsi);
   318		if (ret < 0) {
   319			drm_panel_remove(&ctx->panel);
   320			return ret;
   321		}
   322	
   323		return 0;
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
