Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C02D7DDF
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916075; cv=none; b=HDX8/IHzdtrI2Q9giEz6+txfl0ZQ/PtIho7J0pekLhr/ajJmejPe1IuPt19U2ww1AH8owV8O37gOPOqlYFoelo5z+7bYS6Y7Jh7P+yHL4zrmezDL2m+y7yTkU4G24a2gWkwRLbVwOHyZK7r1R859ZztS9Df/T3t+H2sBJuL2uSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916075; c=relaxed/simple;
	bh=7VY5teto13loyiYWbSMGoNmsZYi+ieVBfxVrbdY6qL4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=anodPvrpD5F7RuxIranzZ3W+zOLwUtdGuA0fb1V5gUN0JVkD7PPW8gdf+HboeJ3q+0b8i3gNm4buX0CGRiehrUGLV0Skf7E+uyTw7Ud4RlEsxhv2oY8ivok1CvR3JL/9jKKwTZNuSE9TV7sbT8xx7KyHXT/oP+UjBVONw03A1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vhi2IdAj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vhi2IdAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772916072; x=1804452072;
  h=date:from:to:cc:subject:message-id;
  bh=7VY5teto13loyiYWbSMGoNmsZYi+ieVBfxVrbdY6qL4=;
  b=Vhi2IdAjX0ke7msT5Uozx+5U/VQm8QPTh8waF119/r6gQ9f7UO34uYaW
   bumSS+jy7TwLThpQv+ylbPreMA6bIGBTyY669ANFhBytj0De3LaDgFqvR
   wHcPQs1dVOYAIrr+pfxisbVmAwOuH3cE9nJ3WVXEILfJIMEE0WXnqkGQ3
   rcCtBQetDwsFIqw4mExizhinEExMiNkMWrInskhTi0UPOvqdvMyMqpnUi
   FCYbIT+LzNCUoSCaQ5TNeeB0GlO0iztc21ZVuf8IWd2YjqZLAr2vcbT4E
   9SZ8HC4lm95+GhjjCrlAsOwi9Tbdjin178VaOxNNEafHG8TnYlKI8hGwJ
   w==;
X-CSE-ConnectionGUID: R3bBNGugRoyFHV0pC8+W7g==
X-CSE-MsgGUID: c6oF+XHGRNGYH4M7g3XMdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73690661"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73690661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 12:41:11 -0800
X-CSE-ConnectionGUID: K4oSE/4KSNWjTZoWmgE4yQ==
X-CSE-MsgGUID: i5dGQ7+GRsORdF95cD4qnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="218559735"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2026 12:41:10 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyySQ-000000002cH-3dq9;
	Sat, 07 Mar 2026 20:41:06 +0000
Date: Sun, 08 Mar 2026 04:40:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [hid:for-7.1/lenovo 10/16]
 drivers/hid/hid-lenovo-go-s.c:164:73: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202603080451.lcXQ6ejg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 4325fdab5dbbfd467df6797e018c9dd0e5c3ae75 [10/16] HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver
config: arc-randconfig-r113-20260307 (https://download.01.org/0day-ci/archive/20260308/202603080451.lcXQ6ejg-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080451.lcXQ6ejg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080451.lcXQ6ejg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/hid-lenovo-go-s.c:164:73: sparse: sparse: Using plain integer as NULL pointer

vim +164 drivers/hid/hid-lenovo-go-s.c

   159	
   160	static void cfg_setup(struct work_struct *work)
   161	{
   162		int ret;
   163	
 > 164		ret = mcu_property_out(drvdata.hdev, GET_VERSION, FEATURE_NONE, 0, 0);
   165		if (ret) {
   166			dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU Version: %i\n", ret);
   167			return;
   168		}
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
