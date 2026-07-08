Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D13D76
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468873; cv=none; b=ePH01MLCHTvNyQmZhDeu4oPbmpJ5X2OIoCDBG0HqF28ScPqeTR2rkDuoOplLrv+NSWjwZ24In1iDo3UEbMMif0C8kCwGzKxcX5lyterZv77k93mrZAqoL8DtVAamFTqJWLwYGLUCti2I53AYoRfmfjtWef1GikQXwAqNdiZuXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468873; c=relaxed/simple;
	bh=2/jF216f3tfsa1/CqL25eVUFqszUIwWkj26VPrncqss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwWof1/rUJffTA80vfMuzHOTlPHZ3CcB55dT6z9g641Vvbj4ieNFNwxmGtBWObs8ivVsa55RNj/zQYkwr4B97ZLY4ZnL9u+2u4UNR0/fBV0v+4NthYQzuUFFgZ+BUgG6pkXwK34JXZDvSXTYY/vsNY5SNYM+hfL01vowiYtRGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=W2H/m0W8; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="W2H/m0W8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783468871; bh=2/jF216f3tfsa1/CqL25eVUFqszUIwWkj26VPrncqss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W2H/m0W8nNOBNQXS/tIFEQ4QHHMbo6LJz2QoUwH1jgtBGJoInpTrKzMKeNDtHasC8
	 PSMbr8HMQNzBd5t/hAkeBbhB7NrrHnqUfbB/94ixNah2ki1dmBlgektMqMJCOoLhO8
	 1KhEwj5WwTFL6TuZXJCsERZDeDYEFWfXSE8OCAaRwoU8W9JwvRePyHZMXiqIpcw5I1
	 amlTCEvvtoTJE5C7VzxruHkxJhaPrDCWsq2teOEf/klsc77dS21yxYYby3y8HY0Y/n
	 ZFE8c+FhUyv00lV47yudZoeuiIChvQpVGXEnmHC4WCMV+27bg550tIPsyUiGAik4LX
	 zcvpYKuhc8Yjw==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id B6547A05C;
	Tue, 07 Jul 2026 17:01:10 -0700 (PDT)
Message-ID: <76e69c15-ff03-4aa7-a01c-05824790147f@endrift.com>
Date: Tue, 7 Jul 2026 17:01:08 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
To: Silvan Jegen <s.jegen@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
References: <20260702214704.1859350-1-vi@endrift.com>
 <20260702214704.1859350-3-vi@endrift.com>
 <39MSC7NQF6IO8.2E4BHGFFF82H4@homearch.localdomain>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <39MSC7NQF6IO8.2E4BHGFFF82H4@homearch.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Silvan,

On 7/5/26 7:13 AM, Silvan Jegen wrote:
> Heyhey!
> 
> Just one comment below.
> 
> Vicki Pfau <vi@endrift.com> wrote:
>> This adds rumble support for both the "HD Rumble" linear resonant actuator
>> type as used in the Joy-Cons and Pro Controller, as well as the eccentric
>> rotating mass type used in the GameCube controller. Note that since there's
>> currently no API for exposing full control of LRAs with evdev, it only
>> simulates a basic rumble for now.
>>
>> Signed-off-by: Vicki Pfau <vi@endrift.com>
>> ---
>>  drivers/hid/Kconfig        |   8 +-
>>  drivers/hid/hid-nintendo.c | 211 ++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 213 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 19c77c323ec9..851eed76c236 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -859,10 +859,10 @@ config NINTENDO_FF
>>  	depends on HID_NINTENDO
>>  	select INPUT_FF_MEMLESS
>>  	help
>> -	Say Y here if you have a Nintendo Switch controller and want to enable
>> -	force feedback support for it. This works for both joy-cons, the pro
>> -	controller, and the NSO N64 controller. For the pro controller, both
>> -	rumble motors can be controlled individually.
>> +	Say Y here if you have a Nintendo Switch or Switch 2 controller and want
>> +	to enable force feedback support for it. This works for Joy-Cons, the Pro
>> +	Controllers, and the NSO N64 and GameCube controller. For the Pro
>> +	Controller, both rumble motors can be controlled individually.
>>  
>>  config HID_NTI
>>  	tristate "NTI keyboard adapters"
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index e21c36921832..a36f4fd9a1da 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
>> @@ -37,6 +37,7 @@
>>  #include <linux/unaligned.h>
>>  #include <linux/delay.h>
>>  #include <linux/device.h>
>> +#include <linux/devm-helpers.h>
>>  #include <linux/kernel.h>
>>  #include <linux/hid.h>
>>  #include <linux/idr.h>
>> @@ -2989,6 +2990,7 @@ enum switch2_init_step {
>>  	NS2_INIT_READ_USER_SECONDARY_CALIB,
>>  	NS2_INIT_SET_FEATURE_MASK,
>>  	NS2_INIT_ENABLE_FEATURES,
>> +	NS2_INIT_ENABLE_RUMBLE,
>>  	NS2_INIT_GRIP_BUTTONS,
>>  	NS2_INIT_REPORT_FORMAT,
>>  	NS2_INIT_INPUT,
>> @@ -3020,6 +3022,18 @@ struct switch2_stick_calibration {
>>  	struct switch2_axis_calibration y;
>>  };
>>  
>> +struct switch2_hd_rumble {
>> +	uint16_t hi_freq : 10;
>> +	uint16_t hi_amp : 10;
>> +	uint16_t lo_freq : 10;
>> +	uint16_t lo_amp : 10;
>> +} __packed;
>> +
>> +struct switch2_erm_rumble {
>> +	uint16_t error;
>> +	uint16_t amplitude;
>> +};
>> +
>>  struct switch2_controller {
>>  	struct hid_device *hdev;
>>  	struct switch2_cfg_intf *cfg;
>> @@ -3043,8 +3057,45 @@ struct switch2_controller {
>>  
>>  	uint32_t player_id;
>>  	struct led_classdev *leds;
>> +
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +	spinlock_t rumble_lock;
>> +	uint8_t rumble_seq;
>> +	union {
>> +		struct switch2_hd_rumble hd;
>> +		struct switch2_erm_rumble sd;
>> +	} rumble;
>> +	uint64_t last_rumble_work;
>> +	struct delayed_work rumble_work;
>> +	uint8_t *rumble_buffer;
>> +#endif
>>  };
>>  
>> +enum gc_rumble {
>> +	GC_RUMBLE_OFF = 0,
>> +	GC_RUMBLE_ON = 1,
>> +	GC_RUMBLE_STOP = 2,
>> +};
>> +
>> +/*
>> + * The highest rumble level for "HD Rumble" is strong enough to potentially damage the controller,
>> + * and also leaves your hands feeling like melted jelly, so we set a semi-arbitrary scaling factor
>> + * to artificially limit the maximum for safety and comfort. It is currently unknown if the Switch
>> + * 2 itself does something similar, but it's quite likely.
>> + *
>> + * This value must be between 0 and 1024, otherwise the math below will overflow.
>> + */
>> +#define RUMBLE_MAX 450u
>> +
>> +/*
>> + * Semi-arbitrary values used to simulate the "rumble" sensation of an eccentric rotating
>> + * mass type haptic motor on the Switch 2 controllers' linear resonant actuator type haptics.
>> + *
>> + * The units used are unknown, but the values must be between 0 and 1023.
>> + */
>> +#define RUMBLE_HI_FREQ 0x187
>> +#define RUMBLE_LO_FREQ 0x112
>> +
>>  static DEFINE_MUTEX(switch2_controllers_lock);
>>  static LIST_HEAD(switch2_controllers);
>>  
>> @@ -3136,7 +3187,7 @@ static const uint8_t switch2_init_cmd_data[] = {
>>  static const uint8_t switch2_one_data[] = { 0x01, 0x00, 0x00, 0x00 };
>>  
>>  static const uint8_t switch2_feature_mask[] = {
>> -	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU,
>> +	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU | NS2_FEATURE_RUMBLE,
>>  	0x00, 0x00, 0x00
>>  };
>>  
>> @@ -3209,6 +3260,125 @@ static void switch2_kref_put(struct kref *refcount)
>>  	kfree(ns2);
>>  }
>>  
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +static void switch2_encode_rumble(struct switch2_hd_rumble *rumble, uint8_t buffer[5])
>> +{
>> +	buffer[0] = rumble->hi_freq;
>> +	buffer[1] = (rumble->hi_freq >> 8) | (rumble->hi_amp << 2);
>> +	buffer[2] = (rumble->hi_amp >> 6) | (rumble->lo_freq << 4);
>> +	buffer[3] = (rumble->lo_freq >> 4) | (rumble->lo_amp << 6);
>> +	buffer[4] = rumble->lo_amp >> 2;
>> +}
>> +
>> +static int switch2_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
>> +{
>> +	struct switch2_controller *ns2 = input_get_drvdata(dev);
> 
> We might want to check ns2 for NULL here (like we do in
> switch2_player_led_brightness_set).

Good call.

> 
> Cheers,
> Silvan
> 
>> +	unsigned long flags;
>> +
>> +	if (effect->type != FF_RUMBLE)
>> +		return 0;
>> +
>> +	spin_lock_irqsave(&ns2->rumble_lock, flags);
>> +	if (ns2->ctlr_type == NS2_CTLR_TYPE_GC) {
>> +		ns2->rumble.sd.amplitude = max(effect->u.rumble.strong_magnitude,
>> +			(uint16_t) (effect->u.rumble.weak_magnitude >> 1));
>> +	} else {
>> +		ns2->rumble.hd.hi_freq = RUMBLE_HI_FREQ;
>> +		ns2->rumble.hd.lo_freq = RUMBLE_LO_FREQ;
>> +		ns2->rumble.hd.hi_amp = effect->u.rumble.weak_magnitude * RUMBLE_MAX >> 16;
>> +		ns2->rumble.hd.lo_amp = effect->u.rumble.strong_magnitude * RUMBLE_MAX >> 16;
>> +	}
>> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
>> +
>> +	schedule_delayed_work(&ns2->rumble_work, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static void switch2_rumble_work(struct work_struct *work)
>> +{
>> +	struct switch2_controller *ns2 = container_of(to_delayed_work(work),
>> +						      struct switch2_controller, rumble_work);
>> +	unsigned long flags;
>> +	bool active;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&ns2->rumble_lock, flags);
>> +	ns2->rumble_buffer[0x1] = 0x50 | ns2->rumble_seq;
>> +	if (ns2->ctlr_type == NS2_CTLR_TYPE_GC) {
>> +		ns2->rumble_buffer[0] = 3;
>> +		if (ns2->rumble.sd.amplitude == 0) {
>> +			ns2->rumble_buffer[2] = GC_RUMBLE_STOP;
>> +			ns2->rumble.sd.error = 0;
>> +			active = false;
>> +		} else {
>> +			if (ns2->rumble.sd.error < ns2->rumble.sd.amplitude) {
>> +				ns2->rumble_buffer[2] = GC_RUMBLE_ON;
>> +				ns2->rumble.sd.error += U16_MAX - ns2->rumble.sd.amplitude;
>> +			} else {
>> +				ns2->rumble_buffer[2] = GC_RUMBLE_OFF;
>> +				ns2->rumble.sd.error -= ns2->rumble.sd.amplitude;
>> +			}
>> +			active = true;
>> +		}
>> +	} else {
>> +		ns2->rumble_buffer[0] = 1;
>> +		switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x2]);
>> +		active = ns2->rumble.hd.hi_amp || ns2->rumble.hd.lo_amp;
>> +		if (ns2->ctlr_type == NS2_CTLR_TYPE_PRO) {
>> +			/*
>> +			 * The Pro Controller contains separate LRAs on each
>> +			 * side that can be controlled individually.
>> +			 */
>> +			ns2->rumble_buffer[0] = 2;
>> +			ns2->rumble_buffer[0x11] = 0x50 | ns2->rumble_seq;
>> +			switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x12]);
>> +		}
>> +	}
>> +	ns2->rumble_seq = (ns2->rumble_seq + 1) & 0xF;
>> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
>> +
>> +	if (active) {
>> +		unsigned long interval = msecs_to_jiffies(4);
>> +		uint64_t current_jiffies = get_jiffies_64();
>> +
>> +		if (!ns2->last_rumble_work)
>> +			ns2->last_rumble_work = current_jiffies;
>> +		else
>> +			ns2->last_rumble_work += interval;
>> +
>> +		/* Reschedule a little early to make sure the buffer never underruns */
>> +		interval -= msecs_to_jiffies(2);
>> +		if (ns2->last_rumble_work + interval >= current_jiffies)
>> +			schedule_delayed_work(&ns2->rumble_work,
>> +				ns2->last_rumble_work + interval - current_jiffies);
>> +		else
>> +			schedule_delayed_work(&ns2->rumble_work, 0);
>> +	} else {
>> +		ns2->last_rumble_work = 0;
>> +	}
>> +
>> +	mutex_lock(&ns2->lock);
>> +	if (!ns2->hdev) {
>> +		cancel_delayed_work(&ns2->rumble_work);
>> +	} else {
>> +		ret = hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
>> +		/*
>> +		 * Don't log on ENODEV, ESHUTDOWN, or EPROTO, which can happen
>> +		 * mid-hotplug. Also cancel any further work on ENODEV or
>> +		 * ESHUTDOWN as they're clear indications that the endpoint
>> +		 * is dead.
>> +		 */
>> +		if (ret == -ENODEV || ret == -ESHUTDOWN)
>> +			cancel_delayed_work(&ns2->rumble_work);
>> +		else if (ret < 0 && ret != -EPROTO)
>> +			hid_warn_ratelimited(ns2->hdev,
>> +				"Failed to send output report ret=%d\n", ret);
>> +	}
>> +	mutex_unlock(&ns2->lock);
>> +}
>> +#endif
>> +
>>  static int switch2_set_leds(struct switch2_controller *ns2)
>>  {
>>  	int i;
>> @@ -3332,6 +3502,26 @@ static int switch2_init_input(struct switch2_controller *ns2)
>>  		return -EINVAL;
>>  	}
>>  
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +	ns2->rumble_buffer = devm_kzalloc(&input->dev, 64, GFP_KERNEL);
>> +	if (!ns2->rumble_buffer) {
>> +		input_free_device(input);
>> +		return -ENOMEM;
>> +	}
>> +	ret = devm_delayed_work_autocancel(&input->dev, &ns2->rumble_work, switch2_rumble_work);
>> +	if (ret < 0) {
>> +		input_free_device(input);
>> +		return ret;
>> +	}
>> +
>> +	input_set_capability(input, EV_FF, FF_RUMBLE);
>> +	ret = input_ff_create_memless(input, NULL, switch2_play_effect);
>> +	if (ret) {
>> +		input_free_device(input);
>> +		return ret;
>> +	}
>> +#endif
>> +
>>  	hid_info(ns2->hdev, "Firmware version %u.%u.%u (type %i)\n", ns2->version.major,
>>  		ns2->version.minor, ns2->version.patch, ns2->version.ctlr_type);
>>  	if (ns2->version.dsp_type >= 0)
>> @@ -3765,7 +3955,16 @@ int switch2_init_controller(struct switch2_controller *ns2)
>>  		return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_SET_MASK,
>>  			switch2_feature_mask, sizeof(switch2_feature_mask), ns2->cfg);
>>  	case NS2_INIT_ENABLE_FEATURES:
>> -		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG);
>> +		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS |
>> +			NS2_FEATURE_ANALOG | NS2_FEATURE_RUMBLE);
>> +	case NS2_INIT_ENABLE_RUMBLE:
>> +		/*
>> +		 * It is unclear what this packet is supposed to be for, but it
>> +		 * appears to be needed for rumble to work reliably. The reply
>> +		 * data indicates it might be a query of some sort, but we
>> +		 * ignore the reply so long as it doesn't return an error.
>> +		 */
>> +		return ns2->cfg->send_command(0x11, 1, NULL, 0, ns2->cfg);
>>  	case NS2_INIT_GRIP_BUTTONS:
>>  		if (!switch2_ctlr_is_joycon(ns2->ctlr_type)) {
>>  			switch2_init_step_done(ns2, ns2->init_step);
>> @@ -3878,6 +4077,10 @@ int switch2_receive_command(struct switch2_controller *ns2,
>>  			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
>>  		}
>>  		break;
>> +	case 0x11:
>> +		if (header->subcommand == 1)
>> +			switch2_init_step_done(ns2, NS2_INIT_ENABLE_RUMBLE);
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> @@ -3997,6 +4200,10 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
>>  	else
>>  		ns2->player_id = ret;
>>  
>> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
>> +	spin_lock_init(&ns2->rumble_lock);
>> +#endif
>> +
>>  	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>>  	if (ret) {
>>  		hid_err(hdev, "hw_start failed %d\n", ret);
> 
> 

Vicki
