Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372285;
	b=me5SEBbgydebBBouZVF6tvOMTt7gscXg2VImtnmlC+y+VWu2wiZ1NlVmuVk99savYpFH
	 m/abel19e4jMpDESuUjgdd1n58Uk9bQmY/x7m6E9y2A0+RrAGJzptVB1ISHP8uLuLSx7h
	 yyYbiIxaNNAdSpPYqA+0VEwSjr3CF47D26+SfxOvIk7fGuwhhkUyp8arFBMSR8Ed4l/yz
	 atcABJWTaexdBzau9y197YnYv4eNDhD/5Oh0ac3VcXlWCmOAAVLEH97xA+yTZGrdT9cCA
	 6YkfUzOQeIXMDCHUZedvsvFhNwNddVGLMSdn4BmXvGghl5cRSvfXcrvJvWX5U7xpptg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372285;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JOP1ZJqwLfWc47o5lNqp+A0FsHD1L/OHRPkyxgdQcJE=;
	b=A/4GrKcjxZ0kZPB3Mhr6f5y1RGOXv6xTytsOwkDAVRRlW4pCmtK1ua81mz7zlBrlH25n
	 mWgkDYOSBHlDpi0B0M3V6HcEJyoQWcoVwPta+I/RMyQPSBY4ms6UYO0IW02THlPrlXegJ
	 +KVrRxe78t766hJFoXYu4Y3EoBKXT1hoPGuFiSaifucPZEuzJKqF8Eu+NJCDT0sMVymyN
	 EXrBXDT4MVqzp0/f2BocBvj4UwhMnBUqJjmVXVYUX6tAVWvkEqxuRAj5/kiFHphFipenR
	 hwWgrUHk55AOMc22rR3gzY90I1oRdVspaXgzIlm3Lxu9AhpvBm1oEm6oTeOdwC8EQmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d8VUbISm;
	arc=none smtp.remote-ip=95.215.58.168
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240CA606A323
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 14:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240CA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d8VUbISm
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6i8AT+fxo0WX17wdckuy8y081PwuR5XnvWkB+83Gn/4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793372282; v=1; x=1793977082;
 b=d8VUbISmS5KtrNoKG1kHModaINhGERri+7kJzIluv22PQYvwAv50IH4dOVRoKTqsHzGB1LQn
 StLdlCOpoQ0KJiyNe8etlZ1R0FnAWwJXSjeA/hHE36X8tQZgExhcHdRiHpEvqIgB2+IEylsPB3a
 d/hoYjwanHSFbhUA1LxM3RUQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8557ae17c843d9d8;
	Fri, 30 Oct 2026 14:58:02 +0000
X-Mizu-Trace-ID: 8557ae17c843d9d8
X-Migadu-Flow: FLOW_OUT
Message-ID: <057607f9-64ee-4f90-aab1-a12542c7c755@linux.dev>
Date: Fri, 30 Oct 2026 15:58:01 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/18] HID: asus: add support for gamepad mode
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schwartz <matthew.schwartz@linux.dev>,
 Denis Benato <benato.denis96@gmail.com>, Jonathan LoBue
 <jlobue10@gmail.com>, Khamunetri Clark <khamunetriclark@gmail.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>,
 Hans de Goede <hansg@kernel.org>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-10-denis.benato@linux.dev>
 <5f908138-980f-2005-b319-38d89a1e59dc@linux.intel.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <5f908138-980f-2005-b319-38d89a1e59dc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/26/26 14:20, Ilpo Järvinen wrote:
> On Sun, 25 Oct 2026, Denis Benato wrote:
>
>> ROG Ally devices can emulate either a mouse+keyboard (desktop mode)
>> or an gamepad device (xbox360 controller in ROG ally and a custom
>> DInput device on newer models): add support for switching the current
>> controller mode.
>>
>> Signed-off-by: Luke Jones <luke@ljones.dev>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> ---
>>  drivers/hid/hid-asus.c | 158 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 157 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index a3a21a1493aa..fae5f36a9fa6 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -198,6 +198,11 @@ struct ally_joystick_resp_curve {
>>  	struct ally_joystick_resp_curve_param entry_4;
>>  } __packed;
>>  
>> +enum ally_gamepad_mode_index {
>> +	ALLY_GAMEPAD_MODE_GAMEPAD = 0x01,
>> +	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
>> +};
>> +
>>  struct ally_config {
>>  	/* Must be locked if the data is being changed */
>>  	struct mutex config_mutex;
>> @@ -411,6 +416,15 @@ enum ally_command_codes {
>>  /* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
>>  #define ALLY_FF_MAX_INTENSITY 100
>>  
>> +static const char *const ally_gamepad_mode_text[] = {
>> +	"gamepad", "desktop"
> So this paired with ally_gamepad_mode, because ally_gamepad_mode_index is 
> off-by-one?
>
>> +};
>> +
>> +static const u8 ally_gamepad_mode[] = {
>> +	ALLY_GAMEPAD_MODE_GAMEPAD,
>> +	ALLY_GAMEPAD_MODE_KEYBOARD
> Almost duplicate of _index variant?
>
> Couldn't you use [xx] = style initializers with ally_gamepad_mode_text[] 
> instead?

Yes, I could and it's what Luke did, but this would make the search
asymmetric and more difficult so I decided this made other parts
easier to understand.

Also I don't like treating enums as int and vice-versa because
it can introduce over time subtle bugs...

And I wanted something that made it easier in the future to
add more modes since I know there is at least one more: "bios".

But that requires more time and the benefits of it are unclear
so I focused on how to make it easier to extend this in a clear way.

>> +};
>> +
>>  static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
>>  	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
>>  };
>> @@ -930,6 +944,137 @@ static ssize_t xbox_controller_store(struct device *dev,
>>  
>>  static DEVICE_ATTR_RW(xbox_controller);
>>  
>> +/**
>> + * ally_set_gamepad_mode() - Set the gamepad operating mode
>> + * @ally: ally handheld structure
>> + * @hdev: HID device
>> + * @mode: gamepad mode to set
>> + *
>> + * Return: 0 on success, negative errno on failure
>> + */
>> +static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *hdev, u8 mode)
>> +{
>> +	u8 payload[] = { mode };
>> +	int ret;
>> +
>> +	if (mode < ALLY_GAMEPAD_MODE_GAMEPAD ||
>> +	    mode > ALLY_GAMEPAD_MODE_KEYBOARD) {
>> +		hid_err(hdev, "Invalid gamepad mode: %u\n", mode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_GAMEPAD_MODE, payload, sizeof(payload));
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
>> +	if (ret < 0) {
>> +		hid_err(hdev, "Failed to set gamepad mode: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t gamepad_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct hid_device *hdev = to_hid_device(dev);
>> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +	struct ally_handheld *ally = drvdata->rog_ally;
>> +	struct ally_config *cfg;
>> +	u8 mode_byte;
>> +	int i;
>> +
>> +	if (!ally)
>> +		return -ENODEV;
>> +
>> +	cfg = ally_get_config(ally);
>> +	if (!cfg)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&cfg->config_mutex);
>> +
>> +	mode_byte = cfg->gamepad_mode;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode); i++) {
>> +		if (ally_gamepad_mode[i] == mode_byte)
>> +			return sysfs_emit(buf, "%s\n", ally_gamepad_mode_text[i]);
>> +	}
>> +
>> +	/*
>> +	 * The recorded mode only comes from the table above: an unknown
>> +	 * byte means memory corruption, not a userspace-visible value.
>> +	 */
>> +	return -EIO;
>> +}
>> +
>> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct hid_device *hdev = to_hid_device(dev);
>> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +	struct ally_handheld *ally = drvdata->rog_ally;
>> +	struct ally_config *cfg;
>> +	u8 mode_byte;
>> +	int mode;
>> +	int ret;
>> +
>> +	if (!ally)
>> +		return -ENODEV;
>> +
>> +	cfg = ally_get_config(ally);
>> +	if (!cfg)
>> +		return -ENODEV;
>> +
>> +	mode = sysfs_match_string(ally_gamepad_mode_text, buf);
>> +	if (mode < 0) {
>> +		hid_err(hdev, "Unknown gamepad mode\n");
>> +		return mode;
>> +	}
>> +
>> +	/* Convert the index of the text mode array to the byte
>> +	 * that will be accepted by the ally MCU.
>> +	 */
>> +	mode_byte = ally_gamepad_mode[mode];
>> +
>> +	guard(mutex)(&cfg->config_mutex);
>> +
>> +	ret = ally_set_gamepad_mode(ally, hdev, mode_byte);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	cfg->gamepad_mode = mode_byte;
>> +
>> +	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
>> +
>> +	sysfs_notify(&dev->kobj, NULL, "gamepad_mode");
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t gamepad_mode_index_show(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	int i;
>> +	ssize_t len = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode_text); i++) {
>> +		if (!ally_gamepad_mode_text[i] || ally_gamepad_mode_text[i][0] == '\0')
> [i][0] == '\0' is not true for anything??
>
>> +			continue;
>> +		len += sysfs_emit_at(buf, len, "%s ", ally_gamepad_mode_text[i]);
>> +	}
>> +
>> +	/* Replace the last space with a newline */
>> +	if (len > 0)
>> +		buf[len - 1] = '\n';
>> +
>> +	return len;
>> +}
>> +
>> +static DEVICE_ATTR_RW(gamepad_mode);
>> +static DEVICE_ATTR_RO(gamepad_mode_index);
>> +
>>  /**
>>   * ally_set_vibration_intensity() - Set vibration intensity values
>>   * @ally: ally handheld structure
>> @@ -2217,6 +2362,8 @@ static struct device_attribute dev_attr_right_response_curve_index =
>>  
>>  static struct attribute *ally_config_attrs[] = {
>>  	&dev_attr_xbox_controller.attr,
>> +	&dev_attr_gamepad_mode.attr,
>> +	&dev_attr_gamepad_mode_index.attr,
>>  	NULL
>>  };
>>  
>> @@ -2356,7 +2503,7 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
>>  	}
>>  
>>  	if (!cfg->initialized) {
>> -		cfg->gamepad_mode = 0x01;
>> +		cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
>>  		cfg->xbox_controller_enabled = true;
>>  		cfg->left_deadzone = 10;
>>  		cfg->left_outer_threshold = 90;
>> @@ -2926,6 +3073,15 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
>>  				 ret);
>>  	}
>>  
>> +	/*
>> +	 * An MCU reset switches the gamepad mode back to its default:
>> +	 * send the recorded one first, so that every other setting
>> +	 * restored below is applied on top of the expected mode.
>> +	 */
>> +	ret = ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);
>> +	if (ret < 0)
>> +		hid_warn(hdev, "Failed to restore gamepad mode: %d\n", ret);
>> +
>>  	/*
>>  	 * The MCU does not keep the vibration intensity across a reset:
>>  	 * send the recorded values again, whichever interface probed.
>>
