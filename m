Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019413;
	b=alMPBqs65QWPcI0UNEmfJN3Pg+lHUtbo+o+YJ1F7XbsjUADrM/+f47wnRsp5S0okWr+R
	 u2URuzb2JryV2fXZRoF7pSJpc/9GIHqtN1OxvO1f57+kDwmiYhDRjFjVVGm0UeswuH6h4
	 L8n7Zkcr0dNNObFUXrUxrhsYrHLmLNiR8yU1gvUT51R1DUeIW6mbdvj1KuCK0N3QzQsAc
	 GI9vft4uZiHoa/Q5jg9OraAljBI/FNXr1LeL9Z5x8IeKZOsx2zpp5zRUQJxhN5J0wqqZq
	 +ppuyKpmmUkKN/eOGOxVMaj46YTtK6TpSM0so/0n1FERwM37SjjldQ3DS6M1nMjLPjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019413;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=GRi+tWERkJfjSowzdCKXeuEVtABzXWEiUUJZnKB402I=;
	b=uQTs20uOSbEx+7Rzv9m8HBr/ISDdkLowgsix8eEMcFaxCVUwu5bQ7NTGGHKgYYGAkGO6
	 eEA97lCfaA2XQ8NG6sZSr+8OcewI4G7UJh37IiOvB2Zf4AIobfvu5xBM9nbMRQk0IxrWt
	 mtzRXG9gTuXQeIe0hFEoLi8M7m9chIQr5M+xJrBJQe2pvlqD7gMiG1dnqr2jC8ILkVs/l
	 NhKMk5fEtv6qStfJSX3SjmoY8wXz/BKcXquTbN7xYH1AQfBMWG8NMi4MBo8a2aQ/If7Lg
	 8oLUt8DyTFMiqPNDIBB0Asc2EmBtvJud9BSH3Seu+OvoQexHbP/fQXRmww/PiOP31Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bziw85sf;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19238606A31E;
	Mon, 26 Oct 2026 12:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19238606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bziw85sf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793019413; x=1824555413;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NFQsK42sRkW0wn2cht6AnarPmQPBr6I34tJN06k+bAI=;
  b=bziw85sfe1pqnJCA1R17KecMwc6yAsLeeoOn9sO59e6FYENqDVCB+ycw
   sq+lopMPaa2hEKFK0BBR9/CG6tBaEsnRuKB1700I279+UGOjS3iakDG6u
   V4+HLsYS0aqYeAddsLuoQ3QLTZ3Xtl4sxKQP4GH299meK/EK/DrbItVrA
   d0LPGW3F5K/pDv/IDZRlr4bsk4nM/5iNNskwrEB1QUq7K+f05nQ/h/epp
   SGk6tiqE42lacbzl2bQHSamV6W7USReZayrnSfIUWbKoAxklYyDRFSWwm
   jGQSEuYUD8C2sdT/WW6w4l+/Op0K/Cfpz59GZXU3HIDAyVjc9RBMubqjv
   A==;
X-CSE-ConnectionGUID: p8q++2ohS7KYjU50L/L77w==
X-CSE-MsgGUID: lWfDQBE4SjWmUfS1nhezSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1585677"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1585677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 05:56:48 -0700
X-CSE-ConnectionGUID: YOBxY+R3Tw+c/mRq9QgUHQ==
X-CSE-MsgGUID: kBAI36eRTNmQm/0a5dt99g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4294721"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 05:56:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 14:56:36 +0200 (EET)
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
Subject: Re: [PATCH v11 02/18] HID: asus: add gamepad configuration
In-Reply-To: <20261025235232.129945-3-denis.benato@linux.dev>
Message-ID: <4b91c2d9-52c7-63d6-19af-842dcc2299cb@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-3-denis.benato@linux.dev>
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

> Add the base configuration structures for the gamepad configuration,
> detect capabilities and initialize the device in a known state.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Luke Jones <luke@ljones.dev>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 419 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 418 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 9e6796bbbdcb..6d1007433daa 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/cleanup.h>
> +#include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/hid.h>
>  #include <linux/jiffies.h>
> @@ -34,6 +35,7 @@
>  #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
>  #include <linux/power_supply.h>
>  #include <linux/stddef.h>
> +#include <linux/sysfs.h>
>  #include <linux/leds.h>
>  #include <linux/unaligned.h>
>  
> @@ -183,6 +185,45 @@ struct asus_touchpad_info {
>  	int report_size;
>  };
>  
> +struct ally_config {
> +	/* Must be locked if the data is being changed */
> +	struct mutex config_mutex;
> +	bool initialized;
> +
> +	/* Device capabilities flags */
> +	bool is_ally_x;
> +	bool xbox_controller_support;
> +	bool user_cal_support;
> +	bool turbo_support;
> +	bool resp_curve_support;
> +	bool dir_to_btn_support;
> +	bool gyro_support;
> +	bool anti_deadzone_support;
> +
> +	/* Current settings */
> +	bool xbox_controller_enabled;
> +	u8 gamepad_mode;
> +	u8 left_deadzone;
> +	u8 left_outer_threshold;
> +	u8 right_deadzone;
> +	u8 right_outer_threshold;
> +	u8 left_anti_deadzone;
> +	u8 right_anti_deadzone;
> +	u8 left_trigger_min;
> +	u8 left_trigger_max;
> +	u8 right_trigger_min;
> +	u8 right_trigger_max;
> +};
> +
> +/*
> + * The Ally configuration is allocated when the controller first appears and
> + * is released only on module removal: the embedded controller can disappear
> + * and re-enumerate at any time (it powers off during suspend when powersave
> + * is enabled), and on re-probe the driver must re-apply the recorded
> + * configuration instead of factory defaults.
> + */
> +static struct ally_config *ally_config;
> +
>  struct ally_handheld {
>  	/* All read/write to IN interfaces must lock */
>  	struct mutex intf_mutex;
> @@ -215,6 +256,8 @@ struct ally_handheld {
>  	unsigned long cad_last_event_time;
>  
>  	struct delayed_work resume_work;
> +
> +	struct ally_config *config;
>  };
>  
>  struct asus_drvdata {
> @@ -661,6 +704,276 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
>  	return hidbuf;
>  }
>  
> +/**
> + * ally_check_capability() - Check if a specific capability is supported
> + * @hdev: HID device
> + * @ally: ally handheld structure
> + * @check_cmd: capability command code to query
> + *
> + * Return: true if the capability is supported, false otherwise
> + */
> +static bool ally_check_capability(struct hid_device *hdev, struct ally_handheld *ally,
> +				  enum ally_command_codes check_cmd)
> +{
> +	u8 payload[] = { 0x00 };
> +	int ret;
> +
> +	u8 *buf __free(kfree) = ally_alloc_cmd(check_cmd, payload, sizeof(payload));
> +	if (!buf) {
> +		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
> +		return false;
> +	}
> +
> +	ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to check capability 0x%02x: %d\n", check_cmd, ret);
> +		return false;
> +	}
> +
> +	return buf[1] == HID_ALLY_FEATURE_CODE_PAGE && buf[2] == check_cmd &&
> +	       buf[4] == 0x01;
> +}
> +
> +static int ally_detect_capabilities(struct hid_device *hdev, struct ally_handheld *ally,
> +				    struct ally_config *cfg)
> +{
> +	if (!hdev || !cfg || !ally)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &cfg->config_mutex) {

guard() would enough.

> +		cfg->is_ally_x = (hdev->product == USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X);
> +
> +		cfg->xbox_controller_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_XBOX_SUPPORT);
> +		cfg->user_cal_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_USER_CAL_SUPPORT);
> +		cfg->turbo_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_TURBO_SUPPORT);
> +		cfg->resp_curve_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_RESP_CURVE_SUPPORT);
> +		cfg->dir_to_btn_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_DIR_TO_BTN_SUPPORT);
> +		cfg->gyro_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_GYRO_TO_JOYSTICK);
> +		cfg->anti_deadzone_support =
> +			ally_check_capability(hdev, ally, CMD_CHECK_ANTI_DEADZONE);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ally_set_xbox_controller(struct hid_device *hdev,
> +				    struct ally_handheld *ally,
> +				    struct ally_config *cfg, bool enabled)
> +{
> +	u8 payload[] = { enabled ? 0x01 : 0x00 };

Oh okay, now I see the other 0x00 I commented in the other patch meant 
"disable".

> +	int ret;
> +
> +	if (!cfg || !cfg->xbox_controller_support)
> +		return -EOPNOTSUPP;
> +
> +	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_XBOX_CONTROLLER, payload, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to set Xbox controller mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cfg->xbox_controller_enabled = enabled;
> +	return 0;
> +}
> +
> +/**
> + * ally_get_config() - Get the configuration of the Ally device
> + * @ally: ally handheld structure
> + *
> + * Fetch the configuration published by hid_asus_ally_probe() under
> + * ally_data_lock: the pointer is also cleared by hid_asus_ally_remove(),
> + * so reading it without the lock would race with interface removal.
> + *
> + * The returned configuration outlives the sysfs callbacks using it: it is
> + * allocated once on the ally probe path and released only on module
> + * removal, when every sysfs attribute referencing it is gone.
> + *
> + * Return: the ally config, or NULL if no configuration is published
> + */
> +static struct ally_config *ally_get_config(struct ally_handheld *ally)
> +{
> +	struct ally_config *cfg;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	cfg = ally->config;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	return cfg;
> +}
> +
> +static ssize_t xbox_controller_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *ally = drvdata->rog_ally;
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

Since ally_get_config() gave up the lock, is dereferencing cfg safe?

> +	if (!cfg->xbox_controller_support)
> +		return -EOPNOTSUPP;
> +
> +	return sysfs_emit(buf, "%d\n", cfg->xbox_controller_enabled ? 1 : 0);
> +}
> +
> +static ssize_t xbox_controller_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	struct ally_handheld *ally = drvdata->rog_ally;
> +	struct ally_config *cfg;
> +	bool enabled;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	ret = kstrtobool(buf, &enabled);

Include?

> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->xbox_controller_support)
> +		return -EOPNOTSUPP;
> +
> +	ret = ally_set_xbox_controller(hdev, ally, cfg, enabled);
> +	if (ret < 0)
> +		return ret;
> +
> +	sysfs_notify(&dev->kobj, NULL, "xbox_controller");
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(xbox_controller);
> +
> +static struct attribute *ally_config_attrs[] = {
> +	&dev_attr_xbox_controller.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ally_attr_groups[] = {
> +	{
> +		.attrs = ally_config_attrs,
> +	},
> +};
> +
> +/**
> + * ally_config_create() - Initialize configuration and create sysfs entries
> + * @hdev: HID device
> + * @ally: non-NULL ally device data with uninitialized config pointer
> + *
> + * Return: valid pointer on success, error pointer on failure
> + */
> +static struct ally_config *ally_config_create(struct hid_device *hdev, struct ally_handheld *ally)
> +{
> +	struct ally_config *cfg;
> +	unsigned long flags;
> +	int ret, sysfs_i;
> +
> +	/*
> +	 * Allocate the configuration only once and keep it until module
> +	 * removal: the controller can disappear and re-enumerate while
> +	 * suspended, and the recorded settings must survive that to be
> +	 * re-applied when the controller comes back.
> +	 */
> +	if (!ally_config) {
> +		ally_config = kzalloc_obj(*ally_config, GFP_KERNEL);
> +		if (!ally_config)
> +			return ERR_PTR(-ENOMEM);
> +
> +		mutex_init(&ally_config->config_mutex);

Where's the pairing mutex_destroy()... Though I suggest using 
devm_mutex_init() + error handling if viable instead so you don't need to 
care about destroy.

> +	}
> +
> +	cfg = ally_config;
> +
> +	ret = ally_detect_capabilities(hdev, ally, cfg);
> +	if (ret < 0) {
> +		hid_err(hdev, "Failed to detect Ally capabilities: %d\n", ret);
> +		goto ally_config_create_err;
> +	}
> +
> +	if (!cfg->initialized) {
> +		cfg->gamepad_mode = 0x01;
> +		cfg->xbox_controller_enabled = true;
> +		cfg->left_deadzone = 10;
> +		cfg->left_outer_threshold = 90;
> +		cfg->right_deadzone = 10;
> +		cfg->right_outer_threshold = 90;
> +	}
> +
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	ally->config = cfg;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
> +		ret = sysfs_create_group(&hdev->dev.kobj,
> +					 &ally_attr_groups[sysfs_i]);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
> +				ally_attr_groups[sysfs_i].name ?: "", ret);
> +			goto ally_config_create_sysfs_err;
> +		}
> +	}

Could .dev_groups be used? (I've not tried to figure out all the related 
code.)

> +
> +	cfg->initialized = true;
> +
> +	return cfg;
> +ally_config_create_sysfs_err:
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	ally->config = NULL;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	/* The sysfs groups are not devm-managed: undo the created ones. */
> +	while (sysfs_i-- > 0)
> +		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[sysfs_i]);
> +
> +ally_config_create_err:
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * ally_config_remove() - Clean up configuration resources
> + * @hdev: HID device
> + * @cfg: ally config to clean up, may be NULL
> + */
> +static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
> +{
> +	int i;
> +
> +	if (!cfg || !cfg->initialized)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> +		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +}
> +
>  /**
>   * ally_gamepad_check_ready() - Wait for the gamepad MCU to report ready
>   * @ally: ally handheld structure
> @@ -922,6 +1235,7 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
>  
>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
>  {
> +	struct ally_config *cfg;
>  	int ret;
>  
>  	/* Failure at this point is non-critical */
> @@ -930,6 +1244,21 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
>  	if (ret < 0)
>  		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
>  
> +	cfg = ally_get_config(ally);
> +	if (!cfg)
> +		return 0;
> +
> +	/* The MCU may have just been reset: restore the cached state. */
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (cfg->xbox_controller_support) {
> +		ret = ally_set_xbox_controller(hdev, ally, cfg,
> +					       cfg->xbox_controller_enabled);
> +		if (ret < 0)
> +			hid_warn(hdev, "Failed to apply Xbox controller mode: %d\n",
> +				 ret);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1005,11 +1334,16 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>  	unsigned long flags;
>  	int ret, ep = ally_get_endpoint_address(hdev);
>  	struct usb_device *udev;
> +	struct asus_drvdata *drvdata;
> +	struct ally_config *ally_cfg;
>  	struct hid_input *hidinput;
>  
>  	if (ep < 0)
>  		return ERR_PTR(ep);
>  
> +	if (!hid_is_usb(hdev))
> +		return ERR_PTR(-ENODEV);
> +
>  	/*
>  	 * The ROG Ally controller is integrated into a handheld PC, so at
>  	 * most one device can exist and the shared global state relies on
> @@ -1021,6 +1355,7 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>  	 * power when powersave is enabled) is still accepted.
>  	 */
>  	udev = interface_to_usbdev(to_usb_interface(hdev->dev.parent));
> +	drvdata = hid_get_drvdata(hdev);
>  
>  	spin_lock_irqsave(&ally_data_lock, flags);
>  	if (ally_drvdata.udev && ally_drvdata.udev != udev) {
> @@ -1084,8 +1419,40 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
>  
> +		/*
> +		 * Publish the shared state before the configuration creates
> +		 * its attributes: their callbacks fetch drvdata->rog_ally
> +		 * first, and the files must work from the moment they exist.
> +		 * Cleared again on the failure paths below.
> +		 */
> +		drvdata->rog_ally = &ally_drvdata;
> +
> +		ally_cfg = ally_config_create(hdev, &ally_drvdata);
> +		if (IS_ERR(ally_cfg)) {
> +			hid_err(hdev, "Failed to create Ally cfg: %ld\n",
> +				PTR_ERR(ally_cfg));
> +			drvdata->rog_ally = NULL;
> +			ally_probe_release_role(ep);
> +			ally_put_udev_if_orphaned();
> +			return ERR_PTR(PTR_ERR(ally_cfg));
> +		}
> +
>  		ret = hid_asus_ally_init(hdev, &ally_drvdata);
>  		if (ret < 0) {
> +			/*
> +			 * Roll the configuration back like
> +			 * hid_asus_ally_remove() does: unpublish it under
> +			 * the lock first, so no sysfs callback can find it
> +			 * while ally_config_remove() removes the groups that
> +			 * were created.
> +			 */
> +			spin_lock_irqsave(&ally_data_lock, flags);
> +			ally_drvdata.config = NULL;
> +			spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +			ally_config_remove(hdev, ally_cfg);

I suspect there's a race... No idea why you had to take the spin lock if 
there isn't anything that could race with this.

> +
> +			drvdata->rog_ally = NULL;
>  			ally_probe_release_role(ep);
>  			ally_put_udev_if_orphaned();
>  			return ERR_PTR(ret);
> @@ -1132,7 +1499,9 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>  static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *ally)
>  {
>  	struct input_dev *x_input = NULL;
> +	struct ally_config *cfg = NULL;
>  	unsigned long flags;
> +	bool owns_cfg;
>  
>  	if (!ally)
>  		return;
> @@ -1162,8 +1531,25 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
>  		ally->keyboard_input = NULL;
>  		ally->keyboard_hdev = NULL;
>  	}
> +
> +	owns_cfg = ally->cfg_hdev == hdev;
> +	if (owns_cfg) {
> +		cfg = ally->config;
> +		ally->cfg_hdev = NULL;
> +		ally->config = NULL;
> +	}
> +
>  	spin_unlock_irqrestore(&ally_data_lock, flags);
>  
> +	/*
> +	 * The config teardown removes sysfs groups and takes sleeping locks:
> +	 * it must not run under ally_data_lock. The config pointer has been
> +	 * unpublished above, so no new sysfs callback can find it while the
> +	 * groups are being removed.
> +	 */
> +	if (owns_cfg)
> +		ally_config_remove(hdev, cfg);
> +
>  	if (x_input)
>  		input_unregister_device(x_input);
>  
> @@ -1190,6 +1576,16 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handh
>  	if (ep != HID_ALLY_INTF_CFG_IN)
>  		return 0;
>  
> +	/*
> +	 * This function assumes the asus-specific initialization
> +	 * to have been performed already at this point.
> +	 */
> +	ret = ally_gamepad_check_ready(ally, hdev);
> +	if (ret < 0) {
> +		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = hid_asus_ally_init(hdev, ally);
>  	if (ret < 0)
>  		return ret;
> @@ -2878,7 +3274,28 @@ static struct hid_driver asus_driver = {
>  	.event			= asus_event,
>  	.raw_event		= asus_raw_event
>  };
> -module_hid_driver(asus_driver);
> +
> +static int __init asus_init(void)
> +{
> +	return hid_register_driver(&asus_driver);
> +}
> +
> +/*
> + * The Ally configuration is not tied to any device lifetime: interface
> + * removal keeps it so that it can be re-applied on re-probe. Release it
> + * only when the module itself is removed, once no sysfs attribute can
> + * reach it anymore.
> + */
> +static void __exit asus_exit(void)
> +{
> +	hid_unregister_driver(&asus_driver);
> +
> +	kfree(ally_config);
> +	ally_config = NULL;
> +}
> +
> +module_init(asus_init);
> +module_exit(asus_exit);
>  
>  MODULE_IMPORT_NS("ASUS_WMI");
>  MODULE_LICENSE("GPL");
> 

-- 
 i.

