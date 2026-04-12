Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F8846F;
	Sun, 12 Apr 2026 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969670; cv=none; b=ovofAeBW6zh99RqXe8/5iRePLkEJWD7yXkzb5wi8bdT1QINBXZJwtjss2fWOxgrI7/+aKTZ5hRjnrPvmOGAhU9BTAKaMlPXPaRhvgBIO1xHNgUp5ITGe94/A5NPK5S0m+PSio4IaPsyQf5kzVkM80mlOfYHk4YlG2BmGVgZpQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969670; c=relaxed/simple;
	bh=ko+Np9Wl+y+M5hFm/qlqkUs6vzBVP2ZkZ/5kZlmYmnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL00tY0SuU/D9WKBORMkB+q03fbsrZLuGNynsexkej/T2G9jJFrjfyDkyt4kB68ve2GjiTjfyjxnZtwr09k1z7XSXwyOjq0zre4p82XzadzZ5ZIc4Hpqz7bqs3bqcGbV6P7+MMPZvvYNy0szttP4gI1TU9aMcp6O/Ad2H7UrtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8G6zVjy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8G6zVjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775969669; x=1807505669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ko+Np9Wl+y+M5hFm/qlqkUs6vzBVP2ZkZ/5kZlmYmnE=;
  b=E8G6zVjyfs7kJq8wWSdajsPQzJdbvOVq4BlyJHUoF/yy+zgjcKjSI7Hy
   TXujQkWcUI4GnF2yH2wWCjXbmOlEB3Rr4OY6S56hrreXVFi/3lrzotj00
   pv3jqpsHitJRWi+ueokiVnMQceh/2sgw0MEcK6W70ZgsA5cELw4DWrT++
   o7kqnY7W4fVMgY45Ydq8Kk8SLL5YIIbTXe+L9a7yZeAthViJ2vHoR/lBu
   9jJNf+SEtE12UkDKHtha31z+C8xsUwR02BrcYGd7N2CVP/W3XLB/C0rub
   4XvtudmrwNmmfslqVcBj2R+LN6nIbHm3RAruz5T3kxCgo//Oen0O26cew
   A==;
X-CSE-ConnectionGUID: HsBRjH79S4SWHd0BZMEKUA==
X-CSE-MsgGUID: tusbhHCKSbaUXo/qamheYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88385734"
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="88385734"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 21:54:28 -0700
X-CSE-ConnectionGUID: 0aEk/+J2R5OqeAqlivoI9g==
X-CSE-MsgGUID: 8KC92sWCRPClc+D/WbJH8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="225184915"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Apr 2026 21:54:25 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBmpz-000000001sj-1q69;
	Sun, 12 Apr 2026 04:54:23 +0000
Date: Sun, 12 Apr 2026 12:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolas Koesling <nikolas@koesling.info>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leo <leo@managarm.org>
Subject: Re: [PATCH v2] HID: pulsar: add driver for Pulsar gaming mice
Message-ID: <202604121253.ZYbxnPmo-lkp@intel.com>
References: <20260401185708.286359-1-nikolas@koesling.info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401185708.286359-1-nikolas@koesling.info>

Hi Nikolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.0-rc7]
[cannot apply to hid/for-next linus/master next-20260410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolas-Koesling/HID-pulsar-add-driver-for-Pulsar-gaming-mice/20260411-084544
base:   v7.0-rc7
patch link:    https://lore.kernel.org/r/20260401185708.286359-1-nikolas%40koesling.info
patch subject: [PATCH v2] HID: pulsar: add driver for Pulsar gaming mice
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260412/202604121253.ZYbxnPmo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260412/202604121253.ZYbxnPmo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604121253.ZYbxnPmo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hid/hid-pulsar.c: In function 'pulsar_init_work':
>> drivers/hid/hid-pulsar.c:601:27: warning: '%s' directive output may be truncated writing up to 127 bytes into a region of size 32 [-Wformat-truncation=]
     601 |                          "%s", hdev->name);
         |                           ^~
   drivers/hid/hid-pulsar.c:600:17: note: 'snprintf' output between 1 and 128 bytes into a destination of size 32
     600 |                 snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     601 |                          "%s", hdev->name);
         |                          ~~~~~~~~~~~~~~~~~
   drivers/hid/hid-pulsar.c:586:59: warning: '%s' directive output may be truncated writing up to 127 bytes into a region of size 32 [-Wformat-truncation=]
     586 |                          sizeof(drvdata->battery.model), "%s", hdev->name);
         |                                                           ^~
   drivers/hid/hid-pulsar.c:585:17: note: 'snprintf' output between 1 and 128 bytes into a destination of size 32
     585 |                 snprintf(drvdata->battery.model,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     586 |                          sizeof(drvdata->battery.model), "%s", hdev->name);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +601 drivers/hid/hid-pulsar.c

   553	
   554	static void pulsar_init_work(struct work_struct *work)
   555	{
   556		struct pulsar_data *drvdata;
   557		struct hid_device *hdev;
   558		struct power_supply_config psy_cfg;
   559		int ret;
   560		u8 data[DEV_INFO_LEN];
   561	
   562		drvdata = container_of(work, struct pulsar_data, init_work.work);
   563		hdev = drvdata->hdev;
   564	
   565		ret = read_device_info(drvdata, data);
   566		if (ret == -ETIMEDOUT) {
   567			if (drvdata->init_retries--) {
   568				hid_dbg(hdev,
   569					"device info read timed out, retrying (%u left)\n",
   570					drvdata->init_retries);
   571				schedule_delayed_work(&drvdata->init_work,
   572						      msecs_to_jiffies
   573						      (INIT_DELAY_MSEC));
   574				return;
   575			}
   576			hid_err(hdev, "device info read timed out, giving up\n");
   577			return;
   578		}
   579		if (ret < 0) {
   580			if (drvdata->type == TYPE_PULSAR) {
   581				hid_err(hdev, "failed to read device info: %d\n", ret);
   582				return;
   583			}
   584			hid_dbg(hdev, "failed to read device info: %d\n", ret);
   585			snprintf(drvdata->battery.model,
   586				 sizeof(drvdata->battery.model), "%s", hdev->name);
   587			goto register_battery;
   588		}
   589	
   590		hid_dbg(hdev, "device info: %*ph (%d)\n", DEV_INFO_LEN, data, ret);
   591	
   592		switch (drvdata->type) {
   593		case TYPE_PULSAR:
   594			model_pulsar(data, drvdata);
   595			break;
   596		case TYPE_ATK:
   597			model_atk(data, drvdata);
   598			break;
   599		default:
   600			snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
 > 601				 "%s", hdev->name);
   602		}
   603	
   604	register_battery:
   605		init_power_supply_desc(drvdata);
   606	
   607		psy_cfg = (struct power_supply_config) {.drv_data = drvdata };
   608		drvdata->battery.ps =
   609		    devm_power_supply_register(&hdev->dev, &drvdata->battery.desc,
   610					       &psy_cfg);
   611		if (IS_ERR(drvdata->battery.ps)) {
   612			hid_err(hdev, "failed to register battery: %ld\n",
   613				PTR_ERR(drvdata->battery.ps));
   614			drvdata->battery.ps = NULL;
   615			return;
   616		}
   617	
   618		atomic_set(&drvdata->device_verified, 1);
   619		hid_info(hdev, "device verified, battery registered\n");
   620	}
   621	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
