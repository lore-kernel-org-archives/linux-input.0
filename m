Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE7440A25
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309962; cv=none; b=mRn10rfSieVx3QDvK/bFmNfsAKmoODasQnd0EXVp7Oc4fafaOGYvzIcRPGsBDahw4qdy233n5+kOfBQyr5K1JMSuF3TJ0ixMGPgGCsj8xjKqWJZxNrKXyWaaGoUVpox0r41uF61szuX59GqhFVP9P8CdcUKkCaioLeonfsyfnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309962; c=relaxed/simple;
	bh=aq+tMqX4EUSiOX5q84UcsPqiezJpPRbByiXS1jJ7lLU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XaUIEvyHj8qjzZ3b0za4Fr/qO16eBWcZTKYt2ymhCXJENPeYfC50qqKD9U337ayqvrKIH/H+hx5nb6sOfFYcSuxXFbmiznwRAxGSoEGhu6e/QUsZntj0LDuVpBnKOzFiiP0ebxWioeATko0lQu39/pQY8QH3pWYvWwkG9eW/Fx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvYntrKg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvYntrKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792309960; x=1823845960;
  h=date:from:to:cc:subject:message-id;
  bh=aq+tMqX4EUSiOX5q84UcsPqiezJpPRbByiXS1jJ7lLU=;
  b=DvYntrKg4P/zxARrl3jia/5afyIsfIxO6+qzHa4QwOovDr7bXjKj33xc
   tSzq2WtbgKenNI1o8NhQDKXak25PaS+gNVkUKW0EZujNVOagBD/mp+Tl0
   /L2+y4KSNK2qqjPwC5Y/vasM4EjrpcjHb4Nv1r32Jchos5BYsHyxND0G+
   kisazjLE2Iy99QiXYLTS3Rwqm9ikbSsRcmGx+tKcA/P8QMUoCHxjk1SAS
   IQYG571TDNtP3jiU5ehw4t7nFCnX7y0hzsl1CQRB+48cxRQ0Ok6u0CC7U
   zYpu2yk8Wc7OBSJ9rPQLYlggdjV37vzr5rLrw46Rn2t+xhkrEXqfOi3+m
   w==;
X-CSE-ConnectionGUID: nfPz/LkdTmSspt1sY2wBZw==
X-CSE-MsgGUID: Ya+5tcOTT56WVDKIyOPqSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="916682"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="916682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 00:52:39 -0700
X-CSE-ConnectionGUID: UuR6G7KuS52YB4iPfdpUgw==
X-CSE-MsgGUID: ZhDUdKqCQZa4nwBLQj1qYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2340800"
Received: from igk-lkp-server01.igk.intel.com (HELO 3c253b998be3) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 18 Oct 2026 00:52:34 -0700
Received: from kbuild by 3c253b998be3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xILh1-000000004w1-44Er;
	Sun, 18 Oct 2026 07:52:31 +0000
Date: Sun, 18 Oct 2026 09:49:23 +0200
From: kernel test robot <lkp@intel.com>
To: Ping Cheng <ping.cheng@wacom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Lee Jones <lee@kernel.org>
Subject: [hid:for-7.4/wacom 8/8] drivers/hid/wacom_wac.c:4430:71:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202610180015.KsRqmoTE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.4/wacom
head:   97ce491bcef2d231b8d51cee8e579183319a5ba4
commit: 97ce491bcef2d231b8d51cee8e579183319a5ba4 [8/8] HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
config: arm64-randconfig-r2300-20261017 (https://download.01.org/0day-ci/archive/20261018/202610180015.KsRqmoTE-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 8a679464f19c426ef76aad9f4587b703dd3e584d)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261018/202610180015.KsRqmoTE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610180015.KsRqmoTE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/wacom_wac.c:4430:71: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct input_dev *dev @@     got struct input_dev [noderef] __rcu *touch_input @@
   drivers/hid/wacom_wac.c:4430:71: sparse:     expected struct input_dev *dev
   drivers/hid/wacom_wac.c:4430:71: sparse:     got struct input_dev [noderef] __rcu *touch_input

vim +4430 drivers/hid/wacom_wac.c

  4250	
  4251	int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
  4252					   struct wacom_wac *wacom_wac)
  4253	{
  4254		struct wacom_features *features = &wacom_wac->features;
  4255	
  4256		if ((features->type == HID_GENERIC) && features->numbered_buttons > 0)
  4257			features->device_type |= WACOM_DEVICETYPE_PAD;
  4258	
  4259		if (!(features->device_type & WACOM_DEVICETYPE_PAD))
  4260			return -ENODEV;
  4261	
  4262		if (features->type == REMOTE && input_dev == wacom_wac->pad_input)
  4263			return -ENODEV;
  4264	
  4265		input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
  4266	
  4267		/* kept for making legacy xf86-input-wacom working with the wheels */
  4268		__set_bit(ABS_MISC, input_dev->absbit);
  4269	
  4270		/* kept for making legacy xf86-input-wacom accepting the pad */
  4271		if (!(input_dev->absinfo && (input_dev->absinfo[ABS_X].minimum ||
  4272		      input_dev->absinfo[ABS_X].maximum)))
  4273			input_set_abs_params(input_dev, ABS_X, 0, 1, 0, 0);
  4274		if (!(input_dev->absinfo && (input_dev->absinfo[ABS_Y].minimum ||
  4275		      input_dev->absinfo[ABS_Y].maximum)))
  4276			input_set_abs_params(input_dev, ABS_Y, 0, 1, 0, 0);
  4277	
  4278		/* kept for making udev and libwacom accepting the pad */
  4279		__set_bit(BTN_STYLUS, input_dev->keybit);
  4280	
  4281		wacom_setup_numbered_buttons(input_dev, features->numbered_buttons);
  4282	
  4283		switch (features->type) {
  4284	
  4285		case CINTIQ_HYBRID:
  4286		case CINTIQ_COMPANION_2:
  4287		case DTK:
  4288		case DTUS:
  4289		case GRAPHIRE_BT:
  4290			break;
  4291	
  4292		case WACOM_MO:
  4293			__set_bit(BTN_BACK, input_dev->keybit);
  4294			__set_bit(BTN_LEFT, input_dev->keybit);
  4295			__set_bit(BTN_FORWARD, input_dev->keybit);
  4296			__set_bit(BTN_RIGHT, input_dev->keybit);
  4297			input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
  4298			break;
  4299	
  4300		case WACOM_G4:
  4301			__set_bit(BTN_BACK, input_dev->keybit);
  4302			__set_bit(BTN_FORWARD, input_dev->keybit);
  4303			input_set_capability(input_dev, EV_REL, REL_WHEEL);
  4304			break;
  4305	
  4306		case WACOM_24HD:
  4307			__set_bit(KEY_PROG1, input_dev->keybit);
  4308			__set_bit(KEY_PROG2, input_dev->keybit);
  4309			__set_bit(KEY_PROG3, input_dev->keybit);
  4310	
  4311			__set_bit(KEY_ONSCREEN_KEYBOARD, input_dev->keybit);
  4312			__set_bit(KEY_INFO, input_dev->keybit);
  4313	
  4314			if (!features->oPid)
  4315				__set_bit(KEY_BUTTONCONFIG, input_dev->keybit);
  4316	
  4317			input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
  4318			input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
  4319			break;
  4320	
  4321		case WACOM_27QHD:
  4322			__set_bit(KEY_PROG1, input_dev->keybit);
  4323			__set_bit(KEY_PROG2, input_dev->keybit);
  4324			__set_bit(KEY_PROG3, input_dev->keybit);
  4325	
  4326			__set_bit(KEY_ONSCREEN_KEYBOARD, input_dev->keybit);
  4327			__set_bit(KEY_BUTTONCONFIG, input_dev->keybit);
  4328	
  4329			if (!features->oPid)
  4330				__set_bit(KEY_CONTROLPANEL, input_dev->keybit);
  4331			input_set_abs_params(input_dev, ABS_X, -2048, 2048, 0, 0);
  4332			input_abs_set_res(input_dev, ABS_X, 1024); /* points/g */
  4333			input_set_abs_params(input_dev, ABS_Y, -2048, 2048, 0, 0);
  4334			input_abs_set_res(input_dev, ABS_Y, 1024);
  4335			input_set_abs_params(input_dev, ABS_Z, -2048, 2048, 0, 0);
  4336			input_abs_set_res(input_dev, ABS_Z, 1024);
  4337			__set_bit(INPUT_PROP_ACCELEROMETER, input_dev->propbit);
  4338			break;
  4339	
  4340		case WACOM_22HD:
  4341			__set_bit(KEY_PROG1, input_dev->keybit);
  4342			__set_bit(KEY_PROG2, input_dev->keybit);
  4343			__set_bit(KEY_PROG3, input_dev->keybit);
  4344	
  4345			__set_bit(KEY_BUTTONCONFIG, input_dev->keybit);
  4346			__set_bit(KEY_INFO, input_dev->keybit);
  4347			fallthrough;
  4348	
  4349		case WACOM_21UX2:
  4350		case WACOM_BEE:
  4351		case CINTIQ:
  4352			input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
  4353			input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
  4354			break;
  4355	
  4356		case WACOM_13HD:
  4357			input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
  4358			break;
  4359	
  4360		case INTUOS3:
  4361		case INTUOS3L:
  4362			input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
  4363			fallthrough;
  4364	
  4365		case INTUOS3S:
  4366			input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
  4367			break;
  4368	
  4369		case INTUOS5:
  4370		case INTUOS5L:
  4371		case INTUOSPM:
  4372		case INTUOSPL:
  4373		case INTUOS5S:
  4374		case INTUOSPS:
  4375		case INTUOSP2_BT:
  4376		case INTUOSP2S_BT:
  4377			input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
  4378			break;
  4379	
  4380		case INTUOS4WL:
  4381			/*
  4382			 * For Bluetooth devices, the udev rule does not work correctly
  4383			 * for pads unless we add a stylus capability, which forces
  4384			 * ID_INPUT_TABLET to be set.
  4385			 */
  4386			__set_bit(BTN_STYLUS, input_dev->keybit);
  4387			fallthrough;
  4388	
  4389		case INTUOS4:
  4390		case INTUOS4L:
  4391		case INTUOS4S:
  4392			input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
  4393			break;
  4394	
  4395		case INTUOSHT:
  4396		case BAMBOO_PT:
  4397		case BAMBOO_TOUCH:
  4398		case INTUOSHT2:
  4399			__clear_bit(ABS_MISC, input_dev->absbit);
  4400	
  4401			__set_bit(BTN_LEFT, input_dev->keybit);
  4402			__set_bit(BTN_FORWARD, input_dev->keybit);
  4403			__set_bit(BTN_BACK, input_dev->keybit);
  4404			__set_bit(BTN_RIGHT, input_dev->keybit);
  4405	
  4406			break;
  4407	
  4408		case REMOTE:
  4409			input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
  4410			input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
  4411			break;
  4412	
  4413		case INTUOSHT3_BT:
  4414			break;
  4415	
  4416		case HID_GENERIC:
  4417			if (wacom_wac->shared) {
  4418				/*
  4419				 * The setup of touch switch capability can only be done
  4420				 * here for those devices, such as Cintiq Pro 13 and 16,
  4421				 * that have touch input registered before stylus and pad
  4422				 * inputs.
  4423				 *
  4424				 * There are two ways of reporting inputs from firmware:
  4425				 * stylus first or touch first. This path covers the touch
  4426				 * input first case.
  4427				 */
  4428				if (wacom_wac->has_mute_touch_switch &&
  4429				    wacom_wac->shared->touch_input) {
> 4430					input_set_capability(wacom_wac->shared->touch_input,
  4431					    EV_SW, SW_MUTE_DEVICE);
  4432				}
  4433			}
  4434			break;
  4435	
  4436		default:
  4437			/* no pad supported */
  4438			return -ENODEV;
  4439		}
  4440		return 0;
  4441	}
  4442	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
