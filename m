Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019614;
	b=XeWtLR0MKVRXT6zS9277FPsNnIR2rI9uMdKELelAL3S8JQiwIkod3YRJhS6NNZSE3vjc
	 wgqkDzBcpuWdCPPwkSXuABsEDth7/M+RWyzyCIOIQ9GIDaXAuzfVNNvt6zu/l5Ny0Reye
	 Y+65OBjA3ejjvyaOo7LaOWuvYY40qBbglXDDyPjptlJxLrQT7pXQdqPKANQ6jI5el16bI
	 n/4ywEKles2JV+ki9YkMR4EoF8SErkp8rZfy7X0uL4sCI7Xble+AmrwiSCbHLvT3EtlzE
	 Y7bItGa1MfNawIFvhjNCkZ7x1a+bC+ttLRfoxpmRpv6DlpYy4f2RrK0KL4wjJpyqf3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019614;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=aLycgPRWJ2JG0cxzTu+EAdwBiwxmFU1wy6+ndTeNbPA=;
	b=eUNl8KFW6hKMlCnNIKpbymdKvYfmpUkaqEH7aLS4+ngtotokK2MyWJ8OUI8rv8/wdS2M
	 IMDvwBymD9EfvLwQ5gOW8LkUL+vf1GMQgvmqNxWHMgD33ptFneDluxgg7DS+ru8XZEDFF
	 nlBB6t5GAFjo7MSVLnCPap3wxn2N5YB5/ndvmC8vHNutTxYIqt/nPmQLDyDOeHLoRzCfI
	 K+UFDqL0g0Eaawxc1DBpqTXkfcGOcLOeC4371xJ6eU6Yq9WMiXJ3VgepKllBVkHm2/ON7
	 nNsbkRHLVp4GcViDZc6P7bGKRprHLaVFq9Wmx7bcG83PwqB8/ADrqCGzzrXQN3YNMOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dClPxWPr;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C51606A31D;
	Mon, 26 Oct 2026 13:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C51606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dClPxWPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793019614; x=1824555614;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qDODWVgoL1IWxLL0zt9d9i/eSrOYk8bZzq8SoRG38j0=;
  b=dClPxWPrTjZ4iQX1xm5Y0BqFoTa6ybLCc4mlUn81ex9fkODtwujKZ77K
   pSoKh+y7gBGv3NjLv1ye6HD3mxY1DRMCGC+PP6/0SttnVlrolJi7HSWd0
   yiTkfCs/MTIXEQlc5dTtI9K1hcGqCVbpT0TmE3hRRyTNKIabPD452ySRi
   wte5Yfx96wkNyecfiYrivJsD1vU9wKcdP5/zq+YhnsGsAKKzPsfFAMx8V
   S7mu7SZFa/oefe8nDbrsrm02ai2pqKwtdV84m7/CQb98NfIN3gFcTu6kT
   ZlqLekuPU0k/G1Nyq6LAUO549cjxe3t6FtuWslgvqg8Wh0LGY6MZhUaSg
   Q==;
X-CSE-ConnectionGUID: tsnmzb6UQE6kx+2pMTMD7A==
X-CSE-MsgGUID: Vwrn7s+gTy67PLahijHIUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1776392"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1776392"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:00:13 -0700
X-CSE-ConnectionGUID: At6L9gueRR2N4T0zmFjrHQ==
X-CSE-MsgGUID: +XEWu6hVTRC6gLTqRPDXRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4270923"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:00:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 15:00:02 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org, 
    Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, 
    Mateusz Schwartz <matthew.schwartz@linux.dev>, 
    Denis Benato <benato.denis96@gmail.com>, 
    Jonathan LoBue <jlobue10@gmail.com>, 
    Khamunetri Clark <khamunetriclark@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
    Nathan Chancellor <nathan@kernel.org>, 
    =?ISO-8859-15?Q?Rebecca_Mara_M=FCller?= <rebecca.mara@posteo.de>, 
    Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 04/18] HID: asus: add joysticks inner and outer range
 configuration
In-Reply-To: <20261025235232.129945-5-denis.benato@linux.dev>
Message-ID: <2bf5c5f8-185e-c322-dd76-ec182514c93c@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-5-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 25 Oct 2026, Denis Benato wrote:

> ROG Ally devices supports configuring joysticks inner and outer range:
> add sysfs attributes to allow userspace modifying the sensitivity
> of those controllers.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Luke Jones <luke@ljones.dev>
> ---
>  drivers/hid/hid-asus.c | 433 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 433 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 0471e6263c24..4dbca9402f1d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1039,6 +1039,358 @@ static struct device_attribute dev_attr_right_vibration_intensity =
>  static struct device_attribute dev_attr_right_vibration_intensity_range =
>  	__ATTR(intensity_range, 0444, right_vibration_intensity_range_show, NULL);
>  
> +/**
> + * ally_set_joystick_thresholds() - Generic function to set joystick ranges
> + * @ally: ally handheld structure
> + * @hdev: HID device
> + * @left_it: inner threshold (deadzone) of the left stick (0-50)
> + * @left_ot: outer threshold of the left stick (70-100)
> + * @right_it: inner threshold (deadzone) of the right stick (0-50)
> + * @right_ot: outer threshold of the right stick (70-100)
> + *
> + * This function sends the command to set both inner and outer threshold
> + * for the left and right joysticks.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ally_set_joystick_thresholds(struct ally_handheld *ally,
> +					struct hid_device *hdev,
> +					u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
> +{
> +	const u8 payload[] = { left_it, left_ot, right_it, right_ot };
> +	int ret;
> +
> +	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_JOYSTICK_DEADZONE, payload, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to set joystick ranges: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t left_joystick_inner_threshold_show(struct device *dev, struct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", cfg->left_deadzone);
> +}
> +
> +static ssize_t left_joystick_inner_threshold_store(struct device *dev,
> +						   struct device_attribute *attr,
> +						   const char *buf, size_t count)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	ret = kstrtou8(buf, 10, &value);
> +	if (ret || value > 50)
> +		return -EINVAL;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	ret = ally_set_joystick_thresholds(ally, hdev,
> +					   value,
> +					   cfg->left_outer_threshold,
> +					   cfg->right_deadzone,
> +					   cfg->right_outer_threshold);
> +	if (ret)
> +		return ret;
> +
> +	cfg->left_deadzone = value;
> +
> +	sysfs_notify(&dev->kobj, "left_joystick_axis", "inner_threshold");
> +
> +	return count;
> +}
> +
> +static ssize_t left_joystick_inner_threshold_range_show(struct device *dev,
> +							struct device_attribute *attr,
> +							char *buf)
> +{
> +	return sysfs_emit(buf, "0 50\n");
> +}
> +
> +static ssize_t left_joystick_outer_threshold_show(struct device *dev, struct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", cfg->left_outer_threshold);
> +}
> +
> +static ssize_t left_joystick_outer_threshold_store(struct device *dev,
> +						   struct device_attribute *attr,
> +						   const char *buf, size_t count)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	ret = kstrtou8(buf, 10, &value);
> +	if (ret || value < 70 || value > 100)
> +		return -EINVAL;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	ret = ally_set_joystick_thresholds(ally, hdev,
> +					   cfg->left_deadzone,
> +					   value,
> +					   cfg->right_deadzone,
> +					   cfg->right_outer_threshold);
> +	if (ret)
> +		return ret;
> +
> +	cfg->left_outer_threshold = value;
> +
> +	sysfs_notify(&dev->kobj, "left_joystick_axis", "outer_threshold");
> +
> +	return count;
> +}
> +
> +static ssize_t left_joystick_outer_threshold_range_show(struct device *dev,
> +							struct device_attribute *attr,
> +							char *buf)
> +{
> +	return sysfs_emit(buf, "70 100\n");
> +}
> +
> +static ssize_t right_joystick_inner_threshold_show(struct device *dev,
> +						   struct device_attribute *attr,
> +						   char *buf)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", cfg->right_deadzone);
> +}
> +
> +static ssize_t right_joystick_inner_threshold_store(struct device *dev,
> +						    struct device_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	ret = kstrtou8(buf, 10, &value);
> +	if (ret || value > 50)
> +		return -EINVAL;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	ret = ally_set_joystick_thresholds(ally, hdev,
> +					   cfg->left_deadzone,
> +					   cfg->left_outer_threshold,
> +					   value,
> +					   cfg->right_outer_threshold);
> +	if (ret)
> +		return ret;
> +
> +	cfg->right_deadzone = value;
> +
> +	sysfs_notify(&dev->kobj, "right_joystick_axis", "inner_threshold");
> +
> +	return count;
> +}
> +
> +static ssize_t right_joystick_inner_threshold_range_show(struct device *dev,
> +							 struct device_attribute *attr,
> +							 char *buf)
> +{
> +	return sysfs_emit(buf, "0 50\n");
> +}
> +
> +static ssize_t right_joystick_outer_threshold_show(struct device *dev,
> +						   struct device_attribute *attr,
> +						   char *buf)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%u\n", cfg->right_outer_threshold);
> +}
> +
> +static ssize_t right_joystick_outer_threshold_store(struct device *dev,
> +						    struct device_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	ret = kstrtou8(buf, 10, &value);
> +	if (ret || value < 70 || value > 100)

I'd prefer binding values that are not 0 or 100 with defines. You print 
the ranges with string literals and they are linked to checks here so 
the code should link those by using same define.

> +		return -EINVAL;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->user_cal_support)
> +		return -EOPNOTSUPP;
> +
> +	ret = ally_set_joystick_thresholds(ally, hdev,
> +					   cfg->left_deadzone,
> +					   cfg->left_outer_threshold,
> +					   cfg->right_deadzone,
> +					   value);
> +	if (ret)
> +		return ret;
> +
> +	cfg->right_outer_threshold = value;
> +
> +	sysfs_notify(&dev->kobj, "right_joystick_axis", "outer_threshold");
> +
> +	return count;
> +}
> +
> +static ssize_t right_joystick_outer_threshold_range_show(struct device *dev,
> +							 struct device_attribute *attr,
> +							 char *buf)
> +{
> +	return sysfs_emit(buf, "70 100\n");
> +}
> +
> +static struct device_attribute dev_attr_left_joystick_inner_threshold =
> +	__ATTR(inner_threshold, 0644, left_joystick_inner_threshold_show,
> +	       left_joystick_inner_threshold_store);
> +
> +static struct device_attribute dev_attr_left_joystick_inner_threshold_range =
> +	__ATTR(inner_threshold_range, 0444, left_joystick_inner_threshold_range_show, NULL);
> +
> +static struct device_attribute dev_attr_left_joystick_outer_threshold =
> +	__ATTR(outer_threshold, 0644, left_joystick_outer_threshold_show,
> +	       left_joystick_outer_threshold_store);
> +
> +static struct device_attribute dev_attr_left_joystick_outer_threshold_range =
> +	__ATTR(outer_threshold_range, 0444, left_joystick_outer_threshold_range_show, NULL);
> +
> +static struct device_attribute dev_attr_right_joystick_inner_threshold =
> +	__ATTR(inner_threshold, 0644, right_joystick_inner_threshold_show,
> +	       right_joystick_inner_threshold_store);
> +
> +static struct device_attribute dev_attr_right_joystick_inner_threshold_range =
> +	__ATTR(inner_threshold_range, 0444, right_joystick_inner_threshold_range_show, NULL);
> +
> +static struct device_attribute dev_attr_right_joystick_outer_threshold =
> +	__ATTR(outer_threshold, 0644, right_joystick_outer_threshold_show,
> +	       right_joystick_outer_threshold_store);
> +
> +static struct device_attribute dev_attr_right_joystick_outer_threshold_range =
> +	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_range_show, NULL);
> +
>  static struct attribute *ally_config_attrs[] = {
>  	&dev_attr_xbox_controller.attr,
>  	NULL
> @@ -1056,6 +1408,22 @@ static struct attribute *ally_right_vibration_attrs[] = {
>  	NULL
>  };
>  
> +static struct attribute *left_joystick_axis_attrs[] = {
> +	&dev_attr_left_joystick_inner_threshold.attr,
> +	&dev_attr_left_joystick_outer_threshold.attr,
> +	&dev_attr_left_joystick_inner_threshold_range.attr,
> +	&dev_attr_left_joystick_outer_threshold_range.attr,
> +	NULL
> +};
> +
> +static struct attribute *right_joystick_axis_attrs[] = {
> +	&dev_attr_right_joystick_inner_threshold.attr,
> +	&dev_attr_right_joystick_outer_threshold.attr,
> +	&dev_attr_right_joystick_inner_threshold_range.attr,
> +	&dev_attr_right_joystick_outer_threshold_range.attr,
> +	NULL
> +};
> +
>  static const struct attribute_group ally_attr_groups[] = {
>  	{
>  		.attrs = ally_config_attrs,
> @@ -1070,6 +1438,28 @@ static const struct attribute_group ally_attr_groups[] = {
>  	},
>  };
>  
> +/*
> + * The joystick and trigger range calibration attributes are tied to the
> + * user-calibration capability: their sysfs groups are registered only
> + * when the device supports configuring those parameters, and the show
> + * and store callbacks reject accesses with -EOPNOTSUPP regardless, in
> + * case the groups are registered for another supported feature.
> + */
> +static const struct attribute_group ally_left_joystick_axis_group = {
> +	.name = "left_joystick_axis",
> +	.attrs = left_joystick_axis_attrs,
> +};
> +
> +static const struct attribute_group ally_right_joystick_axis_group = {
> +	.name = "right_joystick_axis",
> +	.attrs = right_joystick_axis_attrs,
> +};
> +
> +static const struct attribute_group *const ally_cal_attr_groups[] = {
> +	&ally_left_joystick_axis_group,
> +	&ally_right_joystick_axis_group,
> +};
> +
>  /**
>   * ally_config_create() - Initialize configuration and create sysfs entries
>   * @hdev: HID device
> @@ -1130,6 +1520,25 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
>  		}
>  	}
>  
> +	/* Skip the calibration groups when the capability is missing. */
> +	if (cfg->user_cal_support) {
> +		int cal_i;
> +
> +		for (cal_i = 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups);
> +		     cal_i++) {
> +			ret = sysfs_create_group(&hdev->dev.kobj,
> +						 ally_cal_attr_groups[cal_i]);
> +			if (ret < 0) {
> +				hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +					ally_cal_attr_groups[cal_i]->name, ret);
> +				while (cal_i-- > 0)
> +					sysfs_remove_group(&hdev->dev.kobj,
> +							   ally_cal_attr_groups[cal_i]);
> +				goto ally_config_create_sysfs_err;
> +			}
> +		}
> +	}
> +
>  	cfg->initialized = true;
>  
>  	return cfg;
> @@ -1160,6 +1569,18 @@ static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
>  
>  	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
>  		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +
> +	/*
> +	 * The calibration groups are removed with the same gating used to
> +	 * create them, so a device without those capabilities does not
> +	 * trigger a "not found" warning.
> +	 */
> +	if (cfg->user_cal_support || cfg->anti_deadzone_support ||
> +	    cfg->resp_curve_support) {
> +		for (i = 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
> +			sysfs_remove_group(&hdev->dev.kobj,
> +					   ally_cal_attr_groups[i]);
> +	}
>  }
>  
>  /**
> @@ -1458,6 +1879,18 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
>  		hid_warn(hdev, "Failed to restore vibration intensity: %d\n",
>  			 ret);
>  
> +	if (cfg->user_cal_support) {
> +		ret = ally_set_joystick_thresholds(ally, hdev,
> +						   cfg->left_deadzone,
> +						   cfg->left_outer_threshold,
> +						   cfg->right_deadzone,
> +						   cfg->right_outer_threshold);
> +		if (ret < 0)
> +			hid_warn(hdev,
> +				 "Failed to restore joystick thresholds: %d\n",
> +				 ret);
> +	}
> +
>  	return 0;
>  }
>  
> 

-- 
 i.

