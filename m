Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023869;
	b=sTk9x5BTtOTm/0z3qjs186jV1+65fV88VlAKpHoGswbMNUqhTD20EPMS2jcS0ap+h74a
	 AR5DAw7+zYuXiyi0mY89oqLTJFtqzIic4k4zcCD8gOzUZKK7CjC70dRyl+aqThjKR9YzQ
	 V+2NYq1OkrfWfr7ejHbBg1oWsEPvmBOQow0DUDG4fjsK1wNmelyzjJFk7R0gBtRi7+b/k
	 /O0mlNTEepchk1twCbRti0NXE6xVIhNZB5tN2iu5kWdk4zRMhrBjvAHNoENJNRopTLi6c
	 OkV+1bzkK6CxdHCSzW0jhsaRNkOZ2VaLx0gK2/t24PRgVN0wXe8aADLF+lohjAIDdJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023869;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=UnF9Umi7bTFwSaXiudDUvPxuDto62GIl63BuS5+9tag=;
	b=tkvOuL3kNa/JAj5bYcqSKgmdMBmFrCTw1fhGMyFAQDtLML0M+QC7+ST9vSLuxUj7suFn
	 dsPzdoxDAPJYBEvLmb2+sk7jsLpku33ZJDgp6D8j9J/zBHiq7mjxDSA1RmOKNNeUidkfz
	 tofzVb/HOm44ivl/bC/nyO2lzQ0ksokt+k/QDcVyOgBbALglIpKgQPSf+EvkY3RRiQGYa
	 TMNAaTShKyjm3lbB+0CBXeMAx9drNolgyC7pbigosYC6hoJ91woBHhimYskzXt7a1bMLw
	 TWW06OLETeWq14l2XNwJhmlEI/UHR+4ZNuycDIkRN4Scp2BI/th2lA8fpTUuHnWt8GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNiCYiF7;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81B606A31B;
	Mon, 26 Oct 2026 14:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA81B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNiCYiF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793023869; x=1824559869;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OMAhJlk2Bs9m+1OgI6H4TjlxiYHOQU14uTu/fhAVplw=;
  b=fNiCYiF70Q398xfVk3wHw+kcOfdI5qtC+ll3aJCwK97UJ9l90rMtwwd0
   YqgKbFfeqR1Vi2rlQAbwJO/pEulmo2PNPg0qSQtayYxMDx60WbzE0a/8J
   wzuAfN5xFsDjlX2zdRLhuZ+W/qUtj2dSd3G6jzdmOMaLmxWF0cHaKt6my
   7R4+1SqnsmbUUuHdiLwp7JafgUxroEAkqfdRyXQiZJ7JperbQVT5LfovX
   mHDEUVpLUlrltGCdeq74KsQJ/2zN2fT2pwZw/670xm74pS341RgZVJtrC
   TGc4B2rjxRSPd7Ep5CtSOxfOZJO0YN2pHelRlGD1vYf16VCc1nfcSS88K
   Q==;
X-CSE-ConnectionGUID: qme/dxT1Q3a7nrUd515uTw==
X-CSE-MsgGUID: WRQ33hX7RbKzR+y69zlrWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1681999"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1681999"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:11:08 -0700
X-CSE-ConnectionGUID: IH0yvmwQSy69Rte5KWf+xQ==
X-CSE-MsgGUID: e4TMnKiLT6GpEEhQazhVbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4309219"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:11:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 16:10:58 +0200 (EET)
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
Subject: Re: [PATCH v11 14/18] HID: asus: expose XG Mobile identity and
 firmware information
In-Reply-To: <20261025235232.129945-15-denis.benato@linux.dev>
Message-ID: <c423253f-5bbb-24d8-9e45-649eec6c9f26@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-15-denis.benato@linux.dev>
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

> From: Denis Benato <benato.denis96@gmail.com>
> 
> The identity query also reports the mainboard part number, the serial
> number and the part number of the station, and the 0xCE 0x03 query
> answers with an 8-byte binary blob followed by "tag, length, data"
> fields where GEN holds the station generation and VER the firmware
> version.
> 
> Collect this information at probe time and expose it read-only on the
> HID device:
> 
>   /sys/bus/hid/devices/<bus>:<addr>.<intf>/xgm_model             (PRO)
>   .../xgm_serial                                              (SN)
>   .../xgm_mainboard                                           (MB)
>   .../xgm_part_number                                         (PNUM)
>   .../xgm_firmware_version                                    (VER)
>   .../xgm_generation                                          (GEN)
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 176 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e751bf163434..f438cad13264 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -185,6 +185,8 @@ struct asus_xgm_info {
>  	char serial[ASUS_XGM_INFO_LEN];
>  	char model[ASUS_XGM_INFO_LEN];
>  	char part_number[ASUS_XGM_INFO_LEN];
> +	char firmware_version[ASUS_XGM_INFO_LEN];
> +	char generation[ASUS_XGM_INFO_LEN];
>  };
>  
>  struct asus_touchpad_info {
> @@ -6204,6 +6206,148 @@ static bool asus_xgm_is_supported_model(const struct asus_xgm_info *info)
>  	return false;
>  }
>  
> +/**
> + * asus_xgm_tlv_str() - Extract a "tag, length, data" field
> + * @dst: destination buffer
> + * @dst_len: size of @dst, including the trailing NUL
> + * @buf: answer of a version query
> + * @len: size of @buf
> + * @tag: three characters tag to look for
> + *
> + * The version query answers with an 8-byte binary blob followed by
> + * "tag, length, data" fields, where GEN holds the station generation and
> + * VER the firmware version.
> + *
> + * Return: 0 on success, -ENOENT if @tag is missing or its data does not
> + * fit @dst

.

> + */
> +static int asus_xgm_tlv_str(char *dst, size_t dst_len, const u8 *buf,
> +			    size_t len, const char *tag)
> +{
> +	size_t i;
> +	u8 n;
> +
> +	for (i = 3; i + 4 <= len; i++) {
> +		if (memcmp(buf + i, tag, 3))
> +			continue;
> +
> +		n = buf[i + 3];
> +		if (i + 4 + n > len || n >= dst_len)
> +			return -ENOENT;
> +
> +		memcpy(dst, buf + i + 4, n);

Many magic numbers in this function making it pretty unreadable without 
lots of thinking. Replacing the literals with named defines would improve 
readability a lot.

> +		dst[n] = '\0';
> +
> +		return 0;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/**
> + * asus_xgm_get_version() - Query the firmware version of a station
> + * @hdev: HID device
> + * @info: identity structure whose generation and firmware_version fields
> + * get filled in
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int asus_xgm_get_version(struct hid_device *hdev,
> +				struct asus_xgm_info *info)
> +{
> +	size_t len = asus_report_len(hdev, FEATURE_KBD_LED_REPORT_ID2);
> +	int ret;
> +
> +	if (!len)
> +		return -EINVAL;
> +
> +	u8 *buf __free(kfree) = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = asus_xgm_query(hdev, ASUS_XGM_QUERY_VERSION, buf, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (len < 4 || buf[1] != ASUS_XGM_CMD_QUERY ||
> +	    buf[2] != ASUS_XGM_QUERY_VERSION)
> +		return -ENODEV;
> +
> +	asus_xgm_tlv_str(info->generation, sizeof(info->generation),
> +			 buf, len, "GEN");
> +	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
> +			 buf, len, "VER");
> +
> +	return 0;
> +}
> +
> +/**
> + * asus_xgm_drvdata() - Get the drvdata behind an XG Mobile attribute
> + * @dev: HID device the attribute is attached to
> + *
> + * Return: the asus_drvdata of @dev
> + */
> +static struct asus_drvdata *asus_xgm_drvdata(struct device *dev)
> +{
> +	return hid_get_drvdata(to_hid_device(dev));
> +}
> +
> +static ssize_t xgm_model_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->model);
> +}
> +static DEVICE_ATTR_RO(xgm_model);
> +
> +static ssize_t xgm_serial_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->serial);
> +}
> +static DEVICE_ATTR_RO(xgm_serial);
> +
> +static ssize_t xgm_mainboard_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->mainboard);
> +}
> +static DEVICE_ATTR_RO(xgm_mainboard);
> +
> +static ssize_t xgm_part_number_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->part_number);
> +}
> +static DEVICE_ATTR_RO(xgm_part_number);
> +
> +static ssize_t xgm_firmware_version_show(struct device *dev,
> +					 struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->firmware_version);
> +}
> +static DEVICE_ATTR_RO(xgm_firmware_version);
> +
> +static ssize_t xgm_generation_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", asus_xgm_drvdata(dev)->xgm_info->generation);
> +}
> +static DEVICE_ATTR_RO(xgm_generation);
> +
> +static struct attribute *asus_xgm_attrs[] = {
> +	&dev_attr_xgm_model.attr,
> +	&dev_attr_xgm_serial.attr,
> +	&dev_attr_xgm_mainboard.attr,
> +	&dev_attr_xgm_part_number.attr,
> +	&dev_attr_xgm_firmware_version.attr,
> +	&dev_attr_xgm_generation.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group asus_xgm_attr_group = {
> +	.attrs = asus_xgm_attrs,
> +};
> +
>  static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
>  {
>  	const u8 buf[] = { FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00 };
> @@ -6499,9 +6643,29 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>  
>  	drvdata->xgm_info = info;
>  
> +	ret = asus_xgm_get_version(hdev, info);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to query XG Mobile version: %d\n", ret);
> +	else
> +		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
> +			 info->firmware_version, info->generation);
> +
> +	/*
> +	 * The attribute group is not devm-managed: a creation failure is
> +	 * fatal and unwound through asus_xgm_init_err, while on the unbind
> +	 * path the removal is gated on xgm_info exactly like the creation.
> +	 */
> +	ret = sysfs_create_group(&hdev->dev.kobj, &asus_xgm_attr_group);
> +	if (ret) {
> +		hid_err(hdev, "Failed to create XG Mobile attributes: %d\n", ret);
> +		goto asus_xgm_init_err;
> +	}
> +
>  	drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
> -	if (drvdata->xgm_led == NULL)
> -		return -ENOMEM;
> +	if (!drvdata->xgm_led) {
> +		ret = -ENOMEM;
> +		goto asus_xgm_init_err;
> +	}
>  
>  	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
>  			      info->model);
> @@ -6533,6 +6697,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>  
>  	return 0;
>  asus_xgm_init_err:
> +	sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
> +	drvdata->xgm_info = NULL;
>  	drvdata->xgm_led = NULL;
>  	return ret;
>  }
> @@ -6750,6 +6916,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> +	if (drvdata->xgm_info)
> +		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
> +
>  	if (drvdata->xgm_led)
>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
>  
> @@ -6768,6 +6937,9 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> +	if (drvdata->xgm_info)
> +		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
> +
>  	if (drvdata->xgm_led)
>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
>  
> 

-- 
 i.

