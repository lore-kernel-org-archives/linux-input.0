Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615634;
	b=mlYD1Q50an6LWze4n/y04kGBD1w04T9Aig+SiVh3lkB4zRtbd5JM8k8l4D/6NSmxV/rv
	 Vpk8XfJg06lnJIWOH7hCIwHGDGZXjAOy3IDOqck2kMks61wg1BEaFeUIQfXIE9KtHu0GU
	 Hi/PiLs6+RWNr/1MtcIkbaGhDZ3D/56uYWv+DLepvo11CJ/6YBfAxXC5saxS+nY501L+P
	 yN4zUOD/GgZ4fsqwtCmjHleHBSws6Pl8TnUinAbiNoooh1tdyHesrIpownrDC2ABhRbwb
	 OO/PZJMQU1OLwi6/qgbsYmKcW5KbvPD59fmu/ebMYSNBCNNJudEA4Z3FuHXlXneqojw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615634;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xMl4eFxWkUzn+CMJ78m+0k/IisCIkzxv7Xzb0Xdv1Ik=;
	b=S0PxhBJHYywGUDKr4INpt/gNlvnI8wXvI7wDJ/PVdRXIqTKs/mx6ccUeo04eNKWnzR3e
	 rN2bAzWfVkN1zhyLQYnWBT6M/iZxvbBYqOBgFw15Uo97B1yxZjdTsofBTvI6/1JZnd98U
	 rigOhmiUk8mceA00joSfD64exZbPho4TJTTMl9nwtBaYd4GJl8nV5l+ojg62bkKYdG0uZ
	 Xr8ZEmFpCH15J7PCn09MuCAC7b545U4QdkXIdqa7In9baTHLmr0bjs4P5aqOgyVZlnK5p
	 lsDSSDu4RRzc6PyWLtWKBYAX3fxluNKglOAKRFmOCymXM8tCixB5fwmPF7UvGgayByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6v++aS9;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DF606A323;
	Wed, 25 Nov 2026 14:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083DF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6v++aS9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795615634; x=1827151634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KeYOf75Z/8+vjZolThFV16xZ7f4fxMRhbKAxsweSYkM=;
  b=X6v++aS9PERupo+CSYs6URyFfVUc3z0lBq11qkOGDVOl2OsKSA15wQjJ
   aflxUosMg27iAYKNKZ+aXeGTQA3s67Hdveo2Ce32ySnAv84vpc4t96QqU
   beWbjl1UKecabXdtmVJvStC3DCTRYuWXg0gMr9nxVyE8NuzIo3gKhxM9V
   nCrEL+4HYMsQ0FXuqkHLf9lJY7SvYqB2bxsiFwx9YokWlXTmjoUOCC1EN
   jtwCBWbiP4+S+UW1iqgedff0ggLKk10tiV+f10GzYc8rm7zGJJMvommqc
   sw3stYB/5KC20o5sLo3wlRilNhnJAlVnyvwlXubXFyOUFDYKzXoGzjHA/
   w==;
X-CSE-ConnectionGUID: bJT/f532RwSHb2UT7brjlw==
X-CSE-MsgGUID: edfxgYq5QseckzvrYh+N+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4486628"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4486628"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:07:13 -0800
X-CSE-ConnectionGUID: GPuoG+ptSeGdvPSSmoXnIw==
X-CSE-MsgGUID: l4qBFp6CTraX+JlcpmsW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11873266"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Nov 2026 06:07:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWDeO-00000001Rnq-2t50;
	Wed, 25 Nov 2026 14:07:08 +0000
Date: Wed, 25 Nov 2026 22:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, conor@kernel.org, Hefei <3066883572@qq.com>
Subject: Re: [PATCH v3 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Message-ID: <20261125220244.8Pj15HWb-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20261125/20261125220244.8Pj15HWb-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125220244.8Pj15HWb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125220244.8Pj15HWb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-viewe-jd9365tx.c: In function 'jd9365tx_probe':
   drivers/gpu/drm/panel/panel-viewe-jd9365tx.c:304:15: error: implicit declaration of function 'of_drm_get_panel_orientation' [-Werror=implicit-function-declaration]
     304 |         ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-viewe-jd9365tx.c:308:9: error: implicit declaration of function 'drm_panel_init'; did you mean 'drm_panel_put'? [-Werror=implicit-function-declaration]
     308 |         drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
         |         ^~~~~~~~~~~~~~
         |         drm_panel_put
   cc1: some warnings being treated as errors


vim +308 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

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
