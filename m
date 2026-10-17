Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B541D12C
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792221987; cv=none; b=Iw0T4WCI10JXhmmgK8Nw/NvQJ0fAr5T8I/YHXNCNsHSTvnb1mdnOm/bFxRQDGIgPoz4bJ1JcGPT/MEwGcSHk3fox6rMNP8b3nXUbv1DFB4a622JkGRWZ7CX/kif0mZFz1NOs0NOuZ0ld5gLhWK2vJK7CjTyx49pANe+PlntcTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792221987; c=relaxed/simple;
	bh=lnMeAXlry1aZlxCDb+2etqxYGeKJ/0txGAKdnEuivDI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SDEgo9RVSuTegogsA1YfhD3m0T9J24rNs9LLxZB54N7PjweYmRf1AMRTKly86MGqEMdh4CKpiYVTCtViph9Q6R2TYaoA45hh7lY2qToo9AOS7ULx3O8UxGtZagj37Vq6d7FdwMbHXSKy5DegrQbJRbmpQYfxOtaIi4MRmLEjZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma9xEett; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma9xEett"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792221986; x=1823757986;
  h=date:from:to:cc:subject:message-id;
  bh=lnMeAXlry1aZlxCDb+2etqxYGeKJ/0txGAKdnEuivDI=;
  b=Ma9xEett148xLg644Nzq5hzpE9A92qWfnvXW7lFU64Zr9bDaGGuf0Xfm
   v9Ykrx3iNaM67BixZD3gT+YimDzBAFH5IvUabTRm5kMVNqWSPMA+jWzGw
   TjWcDQXYzyRwSl76zbbPdNWTNE1nytKBGtC0BhLsyHi/JGRhphQxcG+by
   jd7Ol4/OMrPFPqsgzd9SXFlW2D1EvMg3UPowze+O1PNos22s944SWJ8Lu
   P2eY9gksRj/97Ro8SImxCBEaRFFAQl5/0ViVbHtJiTG0zUjQGnq29bVPq
   QJ3MEBFwud68vEWM/cRpXPn0lWNws8jZt6hHf9Rd1VeBTE38omy0yuJkk
   w==;
X-CSE-ConnectionGUID: gEj9YqSPQjyQs7NefiWwHw==
X-CSE-MsgGUID: aqrtLhs+T/qz84QNefvlIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="886703"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="886703"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 00:26:25 -0700
X-CSE-ConnectionGUID: m/rbEBHGRFeDyiRNArVOzA==
X-CSE-MsgGUID: SzARRh2RRpWMazLa33piww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2101418"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2026 00:26:23 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHyo8-00000000JBa-0UCV;
	Sat, 17 Oct 2026 07:26:20 +0000
Date: Sat, 17 Oct 2026 15:25:50 +0800
From: kernel test robot <lkp@intel.com>
To: Vicki Pfau <vi@endrift.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Silvan Jegen <s.jegen@gmail.com>
Subject: [hid:for-7.4/nintendo 2/5]
 drivers/hid/hid-nintendo.c:3993:undefined reference to `hid_is_usb'
Message-ID: <202610171559.gZ0QBMFv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/nintendo
head:   77c7155e2707ba5b1d56f3dc1acead48cf17f98d
commit: 9417132df63e5cd7230433af05198538e759f3ae [2/5] HID: nintendo: Add preliminary Switch 2 controller driver
config: i386-randconfig-1001-20261016 (https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261017/202610171559.gZ0QBMFv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610171559.gZ0QBMFv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/hid/hid-nintendo.o: in function `switch2_probe':
>> drivers/hid/hid-nintendo.c:3993:(.text+0x6cd7): undefined reference to `hid_is_usb'


vim +3993 drivers/hid/hid-nintendo.c

  3985	
  3986	static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id)
  3987	{
  3988		struct switch2_controller *ns2;
  3989		struct usb_device *udev;
  3990		char phys[64];
  3991		int ret;
  3992	
> 3993		if (!hid_is_usb(hdev))
  3994			return -ENODEV;
  3995	
  3996		udev = hid_to_usb_dev(hdev);
  3997		if (usb_make_path(udev, phys, sizeof(phys)) < 0)
  3998			return -EINVAL;
  3999	
  4000		ret = hid_parse(hdev);
  4001		if (ret) {
  4002			hid_err(hdev, "parse failed %d\n", ret);
  4003			return ret;
  4004		}
  4005	
  4006		ns2 = switch2_get_controller(phys);
  4007		if (IS_ERR(ns2))
  4008			return PTR_ERR(ns2);
  4009	
  4010		mutex_lock(&ns2->lock);
  4011		if (ns2->hdev) {
  4012			mutex_unlock(&ns2->lock);
  4013			hid_err(hdev,
  4014				"Second hdev tried to claim same controller, first=%p vs second=%p\n",
  4015				ns2->hdev, hdev);
  4016			kref_put(&ns2->refcount, switch2_kref_put);
  4017			return -EBUSY;
  4018		}
  4019		ns2->hdev = hdev;
  4020		hid_set_drvdata(hdev, ns2);
  4021	
  4022		switch (hdev->product | (hdev->vendor << 16)) {
  4023		default:
  4024			strscpy(ns2->name, hdev->name, sizeof(ns2->name));
  4025			break;
  4026		/* Some controllers have slightly wrong names so we override them */
  4027		case USB_DEVICE_ID_NINTENDO_NS2_JOYCONR | (USB_VENDOR_ID_NINTENDO << 16):
  4028			/* Missing the "2" in the name */
  4029			strscpy(ns2->name, "Nintendo Joy-Con 2 (R)", sizeof(ns2->name));
  4030			break;
  4031		case USB_DEVICE_ID_NINTENDO_NS2_GCCON | (USB_VENDOR_ID_NINTENDO << 16):
  4032			/* Has "Nintendo" in the name twice */
  4033			strscpy(ns2->name, "Nintendo GameCube Controller", sizeof(ns2->name));
  4034			break;
  4035		}
  4036	
  4037		ns2->player_id = U32_MAX;
  4038		ret = ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
  4039		if (ret < 0)
  4040			hid_warn(hdev, "Failed to allocate player ID, skipping; ret=%d\n", ret);
  4041		else
  4042			ns2->player_id = ret;
  4043	
  4044		ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
  4045		if (ret) {
  4046			hid_err(hdev, "hw_start failed %d\n", ret);
  4047			goto err_cleanup;
  4048		}
  4049	
  4050		ret = hid_hw_open(hdev);
  4051		if (ret) {
  4052			hid_err(hdev, "hw_open failed %d\n", ret);
  4053			goto err_stop;
  4054		}
  4055	
  4056		ret = 0;
  4057		if (ns2->cfg)
  4058			ret = switch2_init_controller(ns2);
  4059	
  4060		if (!ret) {
  4061			mutex_unlock(&ns2->lock);
  4062			return 0;
  4063		}
  4064	
  4065		hid_hw_close(hdev);
  4066	err_stop:
  4067		hid_hw_stop(hdev);
  4068	err_cleanup:
  4069		ida_free(&nintendo_player_id_allocator, ns2->player_id);
  4070		ns2->hdev = NULL;
  4071		mutex_unlock(&ns2->lock);
  4072		switch2_controller_put(ns2);
  4073		kref_put(&ns2->refcount, switch2_kref_put);
  4074	
  4075		return ret;
  4076	}
  4077	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
