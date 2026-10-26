Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020856;
	b=qY8A+SA4FJHVQhvbq/4icQmN3GfBpfYg9ZxUVVO/n7Mh9FaZ8E+LwpMnPKTuS9H4Sa1T
	 x3jUt7mm56VYCEogJefIjTjR7aRKupP9YjZdxqEc95dKtBK8FpYdXLWG5Zr3TUzVOVLXT
	 fAgXtxZpoFnQKzun2K4MzCvY/JChtYqjGAOXULpL2mRLiVVEaIFlI3IT9tILZ2uS12wFQ
	 6UCeXFStsBcDbBGxF4/RBnWv/5T1G4UwRw8mCyed7XUFoclPTkufi3SiZbUUUi78Rzexu
	 4bUB/ykP7NaJmc1aQ9cC2tQkCqgdJrxRc/mLo1hDY4CULu9ivuKv6tPATFsE2mhTOpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020856;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=G+t5LI1oK9Rp/QuGiql4zUlrmxV3HSEfpw2XyLd1i0o=;
	b=xwSxpp28ifnS/PCUlk1cTuvU4y1clLMhb/B5vn7MMcDXVin8UbxcdyMnCu0jqxIuefz9
	 a69OXiD1bcqUK+xccuGZCTAcEW2FOcj6Ho9no3+b1kAViix3hoOueKZl4kg/J9pynFogu
	 vnZ8AXK44iPv8KIA5KOAbA5/NWoritAFx+zXeq3Xpyw+qnrXibNtQxe30TSbMmk9zaqgY
	 o9ZrwBHBoz90HdRlsKoVzi12ThqG7qPX/ZDTCy7P8wdKHcqqcT//FofpOoi0No2VMkA14
	 8Sn4qLjvfbZlIGc78y5LtYuzj959PjiD+X4P54nwWtObY9o5DJI0xU9IMSdcvj5aw1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W7S3lZ4n;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32820606A31A;
	Mon, 26 Oct 2026 13:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32820606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W7S3lZ4n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793020856; x=1824556856;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kgPxOnsQSOq9y4VzRLbWTcL9wCR+tTZD8Qaw7XVAdp4=;
  b=W7S3lZ4nLVy+X9SQQKard4ImFMUNXXaDqJz4ICbR4v0D2aE/qFdYY9rx
   mrAl5hAlvgTzyzmO6ayxQvTpjM1KejtqTxb/+KhARKsmhaybIAzKquLsS
   yudEQCFkU784JgEUj9OvUoYofZpHSRx/rlh/dzvWPzgr9Hj1SeBccMTcK
   uHE+pt7lc18zV83lksbCGA9oSkK1UWrczQ2qT+aaoS7oP0vm1D2/i33Tj
   l/rOTTfBz+3agE1R5n5tcdVWIWlcJ/mM/a8PIZwoB88BRNUt5PukjF057
   5lTajyURoKFHZI9ZrnDaFQISdrEy7cxQH8Ml3pQzLSjrH2UZbNvHuT7Yv
   g==;
X-CSE-ConnectionGUID: PwKOhL7SQzG2i1PTfB/1rg==
X-CSE-MsgGUID: k72EBVEVQQevpCZMpUMcog==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1697799"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1697799"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:20:55 -0700
X-CSE-ConnectionGUID: uIUpBazpSBq7gQMkPdPEGQ==
X-CSE-MsgGUID: lf++Tc8CTqeMD9RWBvKZ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4374535"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:20:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 15:20:45 +0200 (EET)
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
Subject: Re: [PATCH v11 09/18] HID: asus: add support for gamepad mode
In-Reply-To: <20261025235232.129945-10-denis.benato@linux.dev>
Message-ID: <5f908138-980f-2005-b319-38d89a1e59dc@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-10-denis.benato@linux.dev>
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

> ROG Ally devices can emulate either a mouse+keyboard (desktop mode)
> or an gamepad device (xbox360 controller in ROG ally and a custom
> DInput device on newer models): add support for switching the current
> controller mode.
> 
> Signed-off-by: Luke Jones <luke@ljones.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 158 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index a3a21a1493aa..fae5f36a9fa6 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -198,6 +198,11 @@ struct ally_joystick_resp_curve {
>  	struct ally_joystick_resp_curve_param entry_4;
>  } __packed;
>  
> +enum ally_gamepad_mode_index {
> +	ALLY_GAMEPAD_MODE_GAMEPAD = 0x01,
> +	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
> +};
> +
>  struct ally_config {
>  	/* Must be locked if the data is being changed */
>  	struct mutex config_mutex;
> @@ -411,6 +416,15 @@ enum ally_command_codes {
>  /* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
>  #define ALLY_FF_MAX_INTENSITY 100
>  
> +static const char *const ally_gamepad_mode_text[] = {
> +	"gamepad", "desktop"

So this paired with ally_gamepad_mode, because ally_gamepad_mode_index is 
off-by-one?

> +};
> +
> +static const u8 ally_gamepad_mode[] = {
> +	ALLY_GAMEPAD_MODE_GAMEPAD,
> +	ALLY_GAMEPAD_MODE_KEYBOARD

Almost duplicate of _index variant?

Couldn't you use [xx] = style initializers with ally_gamepad_mode_text[] 
instead?

> +};
> +
>  static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
>  	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
>  };
> @@ -930,6 +944,137 @@ static ssize_t xbox_controller_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(xbox_controller);
>  
> +/**
> + * ally_set_gamepad_mode() - Set the gamepad operating mode
> + * @ally: ally handheld structure
> + * @hdev: HID device
> + * @mode: gamepad mode to set
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *hdev, u8 mode)
> +{
> +	u8 payload[] = { mode };
> +	int ret;
> +
> +	if (mode < ALLY_GAMEPAD_MODE_GAMEPAD ||
> +	    mode > ALLY_GAMEPAD_MODE_KEYBOARD) {
> +		hid_err(hdev, "Invalid gamepad mode: %u\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_GAMEPAD_MODE, payload, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to set gamepad mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t gamepad_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 mode_byte;
> +	int i;
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
> +	mode_byte = cfg->gamepad_mode;
> +
> +	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode); i++) {
> +		if (ally_gamepad_mode[i] == mode_byte)
> +			return sysfs_emit(buf, "%s\n", ally_gamepad_mode_text[i]);
> +	}
> +
> +	/*
> +	 * The recorded mode only comes from the table above: an unknown
> +	 * byte means memory corruption, not a userspace-visible value.
> +	 */
> +	return -EIO;
> +}
> +
> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	u8 mode_byte;
> +	int mode;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	mode = sysfs_match_string(ally_gamepad_mode_text, buf);
> +	if (mode < 0) {
> +		hid_err(hdev, "Unknown gamepad mode\n");
> +		return mode;
> +	}
> +
> +	/* Convert the index of the text mode array to the byte
> +	 * that will be accepted by the ally MCU.
> +	 */
> +	mode_byte = ally_gamepad_mode[mode];
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	ret = ally_set_gamepad_mode(ally, hdev, mode_byte);
> +	if (ret < 0)
> +		return ret;
> +
> +	cfg->gamepad_mode = mode_byte;
> +
> +	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
> +
> +	sysfs_notify(&dev->kobj, NULL, "gamepad_mode");
> +
> +	return count;
> +}
> +
> +static ssize_t gamepad_mode_index_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	int i;
> +	ssize_t len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode_text); i++) {
> +		if (!ally_gamepad_mode_text[i] || ally_gamepad_mode_text[i][0] == '\0')

[i][0] == '\0' is not true for anything??

> +			continue;
> +		len += sysfs_emit_at(buf, len, "%s ", ally_gamepad_mode_text[i]);
> +	}
> +
> +	/* Replace the last space with a newline */
> +	if (len > 0)
> +		buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(gamepad_mode);
> +static DEVICE_ATTR_RO(gamepad_mode_index);
> +
>  /**
>   * ally_set_vibration_intensity() - Set vibration intensity values
>   * @ally: ally handheld structure
> @@ -2217,6 +2362,8 @@ static struct device_attribute dev_attr_right_response_curve_index =
>  
>  static struct attribute *ally_config_attrs[] = {
>  	&dev_attr_xbox_controller.attr,
> +	&dev_attr_gamepad_mode.attr,
> +	&dev_attr_gamepad_mode_index.attr,
>  	NULL
>  };
>  
> @@ -2356,7 +2503,7 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
>  	}
>  
>  	if (!cfg->initialized) {
> -		cfg->gamepad_mode = 0x01;
> +		cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
>  		cfg->xbox_controller_enabled = true;
>  		cfg->left_deadzone = 10;
>  		cfg->left_outer_threshold = 90;
> @@ -2926,6 +3073,15 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
>  				 ret);
>  	}
>  
> +	/*
> +	 * An MCU reset switches the gamepad mode back to its default:
> +	 * send the recorded one first, so that every other setting
> +	 * restored below is applied on top of the expected mode.
> +	 */
> +	ret = ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to restore gamepad mode: %d\n", ret);
> +
>  	/*
>  	 * The MCU does not keep the vibration intensity across a reset:
>  	 * send the recorded values again, whichever interface probed.
> 

-- 
 i.

