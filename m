Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4E28468E
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120209; cv=none; b=j1xW7fWEz7hjGAAcouNZEgejsNsUxopw39AFMP8rlPHv7gOyvqxcnAcMkeU00vsIjqliZK9rKmptendB5LdrfeR/L9MO/Ubz+tBiYQreBoEGiqHx3H5dnA5dCbG6qdSwrUBcDRH9mwreVlzhDlDyi/bRefavU7/O1QDpbZeTcao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120209; c=relaxed/simple;
	bh=lBOuzX4l01Q2yWEDul1sU6XJKR4kAa0JQYNHakDq5rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QRo0Sh2D3QhBYi499sKexoFsCQjSQtuv6OZR/pvB1xVQDUQzYC3ge/MA3rpPK8ofBTVtQnVKrLpx8OA5wHjG97MLT19soWFzO/ruxtCphjYP9WR0QZXg+tBXzv4gnhUhPr57f4rsJJjB4mHTK26m37anqk4KVHZ2kfJFzgjZAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=vVLkZu/o; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="vVLkZu/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120207; bh=lBOuzX4l01Q2yWEDul1sU6XJKR4kAa0JQYNHakDq5rk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vVLkZu/ouS2sRqrPdC7Fu23EFIIE2xZl878hGAugigt+MnK1Vbog2VEFGF01q2QDr
	 M4vDR2Jo5ILlsHzCINzkJAt/juO+lb/SdvUnDdrp2WJDRFqoUoZsenDnXH2/+4WoWw
	 AntpRm13yda++yu/X1Rirb/I7AxjOtwriPY9YdSVYBSdw78eFuc1Kcv2wNUKKD/Ptx
	 wqaTjPDPXP+L/1E9Vcg2d8xMOwweykGcVVOit6BBG0DbNeFWXo97LF/PTbFuj4Qq0w
	 QAi1Nghx78DpCwpxdwcoA+loBPNSLDZn42R1envIMXcHPUs9BiMXb6IvCDXTFtEAA5
	 92i66nIdstNVg==
Received: from [192.168.0.22] (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id BCB26A0AA;
	Mon, 09 Mar 2026 22:23:27 -0700 (PDT)
Message-ID: <bef55d2b-7f06-48ea-a827-da935f9a8b63@endrift.com>
Date: Mon, 9 Mar 2026 22:23:26 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] Input: xbox_gip - Add flight stick support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
References: <20260310052017.1289494-1-vi@endrift.com>
 <20260310052017.1289494-11-vi@endrift.com>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
In-Reply-To: <20260310052017.1289494-11-vi@endrift.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 10:20 PM, Vicki Pfau wrote:
> This adds preliminary flight stick support, with a few caveats:
> 
> - Flight sticks support up to 64 extra buttons. This only exposes the first
>   50, as there isn't any good place to map the remainder.
> - Flight sticks support up to 12 extra axes. This picks a fairly abritrary
>   mapping for them, as there's again no good place to map them.
> 
> Flight sticks also have addressible LEDs, but I don't have a device that
> supports them so I can't test them yet.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
>  drivers/input/joystick/gip/Makefile           |   2 +-
>  drivers/input/joystick/gip/gip-core.c         |   4 +-
>  drivers/input/joystick/gip/gip-flight-stick.c | 179 ++++++++++++++++++
>  drivers/input/joystick/gip/gip.h              |   1 +
>  4 files changed, 184 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/input/joystick/gip/gip-flight-stick.c
> 
> diff --git a/drivers/input/joystick/gip/Makefile b/drivers/input/joystick/gip/Makefile
> index db6c9079c7e18..4de873f77a020 100644
> --- a/drivers/input/joystick/gip/Makefile
> +++ b/drivers/input/joystick/gip/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  obj-$(CONFIG_JOYSTICK_XBOX_GIP)	+= xbox-gip.o
> -xbox-gip-y := gip-arcade-stick.o gip-core.o gip-drivers.o gip-wheel.o
> +xbox-gip-y := gip-arcade-stick.o gip-core.o gip-drivers.o gip-flight-stick.o gip-wheel.o
> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
> index 773d7705b7be8..17e2be5cd2444 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
> @@ -11,9 +11,10 @@
>   * - Sending fragmented messages
>   * - Raw character device
>   * - Wheel force feedback
> - * - Flight stick support
>   * - More arcade stick testing
>   * - Arcade stick extra buttons
> + * - More flight stick testing
> + * - Flight stick LEDs
>   * - Split into driver-per-attachment GIP-as-a-bus approach drivers
>   *
>   * This driver is based on the Microsoft GIP spec at:
> @@ -319,6 +320,7 @@ static const struct gip_driver* base_drivers[] = {
>  	&gip_driver_arcade_stick,
>  	&gip_driver_trueforce_wheel,
>  	&gip_driver_wheel,
> +	&gip_driver_flight_stick,
>  	NULL /* Sentinel */
>  };
>  
> diff --git a/drivers/input/joystick/gip/gip-flight-stick.c b/drivers/input/joystick/gip/gip-flight-stick.c
> new file mode 100644
> index 0000000000000..c2b913a012d0e
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-flight-stick.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Drivers for GIP flight stick devices
> + *
> + * Copyright (c) 2025 Valve Software
> + *
> + * This driver is based on the Microsoft GIP spec at:
> + * https://aka.ms/gipdocs
> + * https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gipusb/e7c90904-5e21-426e-b9ad-d82adeee0dbc
> + */
> +#include "gip.h"
> +
> +/* FlightStick vendor messages */
> +#define GIP_CMD_DEVICE_CAPABILITIES	0x00
> +#define GIP_CMD_LED_CAPABILITIES	0x01
> +#define GIP_CMD_SET_LED_STATE		0x02
> +
> +/*
> + * The spec defines up to 64 extra buttons and 12 extra axes, but there's
> + * currently no good way to map all of them. For now, let's leave it as a much
> + * smaller number.and add more when we get a better way.
> + */
> +#define MAX_GIP_FLIGHT_STICK_BUTTONS 10
> +#define MAX_GIP_FLIGHT_STICK_AXES 1
> +
> +struct gip_flight_stick_capabilities_response {
> +	uint8_t extra_button_count;
> +	uint8_t extra_axis_count;
> +	uint8_t led_count;
> +	uint8_t max_global_led_gain;
> +};
> +
> +static const unsigned int gip_flight_stick_extra_buttons[] = {
> +	BTN_0,
> +	BTN_1,
> +	BTN_2,
> +	BTN_3,
> +	BTN_4,
> +	BTN_5,
> +	BTN_6,
> +	BTN_7,
> +	BTN_8,
> +	BTN_9,
> +};
> +
> +static const unsigned int gip_flight_stick_extra_axes[] = {
> +	ABS_RUDDER,
> +};
> +
> +static int gip_flight_stick_init(struct gip_attachment *attachment)
> +{
> +	int rc = gip_send_vendor_message(attachment, GIP_CMD_DEVICE_CAPABILITIES, 0, NULL, 0);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	return GIP_INIT_NO_INPUT;
> +}
> +
> +static int gip_setup_flight_stick_input(struct gip_attachment *attachment, struct input_dev* input)
> +{
> +	int i;
> +	int rc = gip_driver_navigation.setup_input(attachment, input);
> +
> +	if (rc)
> +		return rc;
> +
> +	input_set_capability(input, EV_KEY, BTN_TOP);
> +	input_set_capability(input, EV_KEY, BTN_TOP2);
> +	for (i = 0; i < attachment->extra_buttons && i < MAX_GIP_FLIGHT_STICK_BUTTONS; i++)
> +		input_set_capability(input, EV_KEY, BTN_0 + i);
> +	if (attachment->extra_buttons > MAX_GIP_FLIGHT_STICK_BUTTONS)
> +		dev_info(GIP_DEV(attachment),
> +			"Device has too many extra buttons, %i through %i ignored\n",
> +			MAX_GIP_FLIGHT_STICK_BUTTONS,
> +			attachment->extra_buttons + 1);
> +	input_set_abs_params(input, ABS_X, -32768, 32767, 0, 0);
> +	input_set_abs_params(input, ABS_Y, -32768, 32767, 0, 0);
> +	input_set_abs_params(input, ABS_Z, -32768, 32767, 0, 0);
> +	input_set_abs_params(input, ABS_THROTTLE, 0, 65535, 0, 0);
> +	for (i = 0; i < attachment->extra_axes && i < MAX_GIP_FLIGHT_STICK_AXES; i++)
> +		input_set_abs_params(input, gip_flight_stick_extra_axes[i], 0, 65535, 0, 0);
> +
> +	return 0;
> +}
> +
> +static int gip_handle_flight_stick_report(struct gip_attachment *attachment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	int32_t axis;
> +	int rc = gip_driver_navigation.handle_input_report(attachment, input, bytes, num_bytes);
> +	int i;
> +
> +	if (rc)
> +		return rc;
> +
> +	if (num_bytes < 19)
> +		return -EINVAL;
> +
> +	/* Fire 1 and 2 */
> +	input_report_key(input, BTN_TOP, bytes[2] & BIT(0));
> +	input_report_key(input, BTN_TOP2, bytes[2] & BIT(1));
> +
> +	for (i = 0; i < attachment->extra_buttons && i < MAX_GIP_FLIGHT_STICK_BUTTONS; i++) {
> +		input_report_key(input, gip_flight_stick_extra_buttons[i],
> +			bytes[i / 8 + 3] & BIT(i));
> +	}
> +
> +	/*
> +	 * Roll, pitch and yaw are signed. Throttle and any
> +	 * extra axes are unsigned. All values are full-range.
> +	 */
> +	axis = bytes[11];
> +	axis |= bytes[12] << 8;
> +	input_report_abs(input, ABS_X, (int16_t) axis);
> +
> +	axis = bytes[13];
> +	axis |= bytes[14] << 8;
> +	input_report_abs(input, ABS_Y, (int16_t) axis);
> +
> +	axis = bytes[15];
> +	axis |= bytes[16] << 8;
> +	input_report_abs(input, ABS_Z, (int16_t) axis);
> +
> +	axis = bytes[17];
> +	axis |= bytes[18] << 8;
> +	input_report_abs(input, ABS_THROTTLE, axis);
> +
> +	for (i = 0; i < attachment->extra_axes && i < MAX_GIP_FLIGHT_STICK_AXES; i++) {
> +		if (20 + i * 2 >= num_bytes)
> +			break;
> +
> +		axis = bytes[19 + i * 2];
> +		axis |= bytes[20 + i * 2] << 8;
> +		input_report_abs(input, gip_flight_stick_extra_axes[i], axis);
> +	}
> +
> +	return 0;
> +}
> +
> +static int gip_handle_flight_stick_cmd_device_capabilities(struct gip_attachment *attachment,
> +	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
> +{
> +	const struct gip_flight_stick_capabilities_response *response =
> +		(const struct gip_flight_stick_capabilities_response*)bytes;
> +	struct input_dev *input;
> +
> +	rcu_read_lock();
> +	input = rcu_dereference(attachment->input);
> +	rcu_read_unlock();
> +	if (input)
> +		return 0;
> +
> +	if (num_bytes < 4)
> +		return -EINVAL;
> +
> +	attachment->extra_axes = min(response->extra_axis_count, MAX_GIP_FLIGHT_STICK_AXES);
> +	attachment->extra_buttons = min(response->extra_button_count, MAX_GIP_FLIGHT_STICK_BUTTONS);
> +	return gip_setup_input_device(attachment);
> +}
> +
> +const struct gip_driver gip_driver_flight_stick = {
> +	.types = (const char* const[]) {
> +		"Windows.Xbox.Input.FlightStick",
> +		"Microsoft.Xbox.Input.FlightStick",
> +		NULL
> +	},
> +	.guid = GUID_INIT(0x03f1a011, 0xefe9, 0x4cc1, 0x96, 0x9c,
> +		0x38, 0xdc, 0x55, 0xf4, 0x04, 0xd0),
> +
> +	.probe = NULL,
> +	.remove = NULL,
> +	.init = gip_flight_stick_init,
> +	.setup_input = gip_setup_flight_stick_input,
> +	.handle_input_report = gip_handle_flight_stick_report,
> +	.vendor_handlers = {
> +		[GIP_CMD_DEVICE_CAPABILITIES] = gip_handle_flight_stick_cmd_device_capabilities,
> +	},
> +};
> diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
> index 3b5cab96dc0b7..6d70a69d99a39 100644
> --- a/drivers/input/joystick/gip/gip.h
> +++ b/drivers/input/joystick/gip/gip.h
> @@ -323,4 +323,5 @@ extern const struct gip_driver gip_driver_gamepad;
>  extern const struct gip_driver gip_driver_arcade_stick;
>  extern const struct gip_driver gip_driver_wheel;
>  extern const struct gip_driver gip_driver_trueforce_wheel;
> +extern const struct gip_driver gip_driver_flight_stick;
>  #endif

Shoot, I didn't mean to send this tenth patch. I don't consider it ready due to issues with evdev mapping of purely-numeric, unnamed inputs, but the other 9 should be.

Vicki
