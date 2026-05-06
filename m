Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79953B6361
	for <linux-input@vger.kernel.org>; Wed,  6 May 2026 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105455; cv=none; b=i6qcoJvYnGlizdMiy5A6x/pveV7g2qGSBFouT8pJLNcOzjOGgnLtegfppQdFn2iOebrmKYTDLJUF/vZu94wLvK6YykxZMiAKX3WZ3ohaSOsLmRsD5Egz0U4cwGsw00YymjpXSnX/xBvFDDQZuxHxWAZyTnlfHR/7vjEIxitRD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105455; c=relaxed/simple;
	bh=cP5aorz2z6SOKw0hUfjE1H96etsMeIHH/TsTA0iDCrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLGHeZDz3GpTfXgj5O9uJKgQMNGQpfjcfp6ZH5j0qv4CNDsS8gWcLNSxd1uxN+4of4nfLjBIus26J32JWtH1DDwS4koeg965SBB8EwUgO4+cuoDLTJLt9IK3WhXWxZpmwuXX0HViEqI0B+xt0ltHNJaGka6GjYi1UGnxHMJY51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fcMog522; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fcMog522"
Message-ID: <06a559d6-c3e2-4649-91d9-73b02337bf79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778105441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBwSKppbDL7BPs/37rQPxa1AHlWXdLGOYH5wWKRtdPs=;
	b=fcMog5225KsuV6mDfFidAbCeBCFhZ5qNI6RkJD/Hr6S1QI2Z0KXIB42cmeSmDfRJitcDhZ
	yXq8wL4FNdfRFUVHeT6JU4dzRHW2UQkPGgkMgKPJ4aB4O9eNTwRWnMM3qrv7OocAz1ZPly
	ALMlBHl8Yw8mbKv1Rv8pe59kVnn63LI=
Date: Thu, 7 May 2026 00:10:27 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] platform/x86: asus-armoury: add fn_lock firmware
 attribute
To: =?UTF-8?Q?Marcus_Gren=C3=A4ngen?= <marcus@grenangen.se>,
 platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 luke@ljones.dev, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 jikos@kernel.org, bentiss@kernel.org, corentin.chary@gmail.com
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
 <20260506193326.5862-1-marcus@grenangen.se>
 <20260506193326.5862-4-marcus@grenangen.se>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260506193326.5862-4-marcus@grenangen.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/6/26 21:33, Marcus Grenängen wrote:
> Add a fn_lock attribute to the asus-armoury firmware-attributes interface,
> allowing userspace to read and set the Fn-lock state (whether F1-F12 keys
> are primary or media/system keys are primary).
>
> On most ASUS laptops fn-lock is backed by WMI DEVID 0x00100023 and the
> attribute uses armoury_get/set_devstate() as normal. On platforms where
> the WMI DEVS call is a no-op (fnlock_use_hid quirk, e.g. ProArt P16), the
> store path calls asus_hid_fnlock_notify() to send the feature report
> directly to the N-Key keyboard via hid-asus. The show path returns
> -EOPNOTSUPP on such platforms as the hardware provides no readback.
>
> The fnlock_use_hid flag is detected at init time via dmi_match() on
> DMI_PRODUCT_FAMILY. A direct DMI check is used rather than reading the
> asus-nb-wmi quirk flag because asus-armoury and asus-nb-wmi are both
> loadable modules at the same init level, so the asus_ref pointer set by
> asus-wmi may not yet be valid when asus-armoury initialises.
>
> Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
> ---
>  drivers/platform/x86/asus-armoury.c | 69 +++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 5b0987ccc270..9d7646eff944 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -93,6 +93,7 @@ struct asus_armoury_priv {
>  
>  	u32 mini_led_dev_id;
>  	u32 gpu_mux_dev_id;
> +	bool fnlock_use_hid;
>  };
>  
>  static struct asus_armoury_priv asus_armoury = {
> @@ -778,6 +779,58 @@ ASUS_ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
>  ASUS_ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
>  				  "Read the base TGP value");
>  
> +/*
> + * fn_lock: toggle whether Fn key is locked (F1-F12 primary) or unlocked
> + * (media/system keys primary).
> + *
> + * On most ASUS laptops this is backed by WMI DEVID 0x00100023. On some
> + * platforms (e.g. ProArt P16) that DEVS call is a no-op and the state must
> + * be sent as a HID feature report to the N-Key keyboard via hid-asus.
> + */
> +static ssize_t fn_lock_current_value_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	u32 result;
> +	int err;
> +
> +	if (asus_armoury.fnlock_use_hid)
> +		return -EOPNOTSUPP;
> +
> +	err = armoury_get_devstate(attr, &result, ASUS_WMI_DEVID_FNLOCK);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%u\n", result & 1);
> +}
> +
> +static ssize_t fn_lock_current_value_store(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	bool enable;
> +	int err;
> +
> +	err = kstrtobool(buf, &enable);
> +	if (err)
> +		return err;
> +
> +	if (asus_armoury.fnlock_use_hid) {
> +		err = asus_hid_fnlock_notify(enable);
Doing this would introduce a dependency from asus-armoury to hid-asus,
let's not do that.

Instead only show this attribute if it's actually doing something,
you can check it from asus-wmi: asus-armoury already depends on it.

Edit: you are actually already registering this only if fnlock_use_hid is
true, so the else looks dead code to me.

I think there is something not right here.
> +		if (err)
> +			return err;
> +	} else {
> +		err = armoury_set_devstate(attr, enable ? 1 : 0, NULL,
> +					   ASUS_WMI_DEVID_FNLOCK);
> +		if (err)
> +			return err;
> +	}
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +	return count;
> +}
> +
> +ASUS_ATTR_GROUP_BOOL(fn_lock, "fn_lock", "Set the Fn-lock state");
> +
>  /* If an attribute does not require any special case handling add it here */
>  static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> @@ -926,6 +979,16 @@ static int asus_fw_attr_add(void)
>  		}
>  	}
>  
> +	if (asus_armoury.fnlock_use_hid ||
> +	    armoury_has_devstate(ASUS_WMI_DEVID_FNLOCK)) {
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &fn_lock_attr_group);
> +		if (err) {
> +			pr_err("Failed to create sysfs-group for fn_lock\n");
> +			goto err_remove_gpu_mux_group;
> +		}
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
>  		if (!armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
>  			continue;
> @@ -963,6 +1026,8 @@ static int asus_fw_attr_add(void)
>  			sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
>  					   armoury_attr_groups[i].attr_group);
>  	}
> +	sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &fn_lock_attr_group);
> +err_remove_gpu_mux_group:
>  	if (asus_armoury.gpu_mux_dev_id)
>  		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
>  err_remove_mini_led_group:
> @@ -1121,6 +1186,8 @@ static int __init asus_fw_init(void)
>  
>  	init_rog_tunables();
>  
> +	asus_armoury.fnlock_use_hid = dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16");
Perhaps you can reuse something from asus-wmi instead of re-doing the dmi_match again
in this driver.
> +
>  	/* Must always be last step to ensure data is available */
>  	return asus_fw_attr_add();
>  }
> @@ -1138,6 +1205,8 @@ static void __exit asus_fw_exit(void)
>  	if (asus_armoury.gpu_mux_dev_id)
>  		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
>  
> +	sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &fn_lock_attr_group);
Not guarded the same way as the sysfs_create_group therefore will trigger
on hardware that doesn't need this.
> +
>  	if (asus_armoury.mini_led_dev_id)
>  		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mode_attr_group);
>  
