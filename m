Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399189;
	b=t8o5tDnX9rV/0hvQsQNVGyTUaJaJgu7DJ9XvwgzLU2mOBcg8H2bjqBrIWj6tYxtCUj+J
	 TGcMKgYB+XCJ8feYUMyNjWe3zy05fXnYuIR93XQb7g4DwIn3F+d+sx7kCY0eUz6F7fXta
	 S7wXLpnRXsCQeAiancVk8Z/mhA6U+E0+5+xJ2B1IjTUAE5e83Dlt2bUGZP3xNBqHXC/7V
	 f7yrh0MRom08ErjKrA5yqfwpjnI9z6J/eEpwjZ/5+NtitMR0QvbTAbX4IkX68FnL0zl/d
	 FHe+xyXGwHsfMr3X3j7fUNWO/nbNI9BYUSYuCzn2ur2vc3SKGje6ESlgjlOHWogOsAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399189;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=JLh3UxeSvAdeG/KWWx5ge/22lfbIqtPOr/f2gxOM+cc=;
	b=Ib25t1LXh08YXbf7XsA4llzjx7VMRydJIH+VBMBDg+loK/8n2rJJi7GzZrn2tMlTHdgK
	 n55tw0r+EzUUKNnPV9LHk2KaMGkduHF0bB8fT8gM7+u9BCllyaqPQEUDLHq4PgzDI/9VN
	 NVriT+JNVaw3q1hTHVLWC3ZnRXxfKlCB7hzJYfTC5YMp/LcZYAHvSfadaScJo53J7lnKO
	 5/3kSXYoB+PoIWGQt+xW8qUOJe8pJo5PUrZAtVrqdhY5JgeFxfa+K71OtS3L3jAzSVs8m
	 c/fRCqxs5FcGIbnV1mPx01vQLSUGUnsOFehacPmLFgYhTg+4NvdrFeaWGcd6PTsBqvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PGKYAgSJ;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1172606A32D;
	Wed, 11 Nov 2026 12:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1172606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PGKYAgSJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794399189; x=1825935189;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Yxtf0hRV4UQkQ6vFchIm03/BuNrHGbrsgGIuk3PfC/o=;
  b=PGKYAgSJex2C6vCSIQDk7agIWLJnUdDNBvnqp9/6hcDI94q+UEgOiAlv
   7vUVORZL/nsgk+zo1aKUMtAm/LqTb8iQKSNYZtKUaWPjsWp9JgrBwxHPz
   A9XhsI8HmqCbtzBL9GaZCs27J1FYv+8E3MyPAtbiwISc8ni5ps59FXOlJ
   2q2c0OSGaduoEtiEWsizhBBP6FKEZ4jUC4LnSkdTo4O1xI0S1IfcAbbNB
   IAra/WZhb/JA1MbPaUWByy3B1Hu8pUOeakVcjNe6WtnUlEycqANl08VQ5
   74WnJUb1RxdRuMkYoYRbtjrEUnN0DvCREpSRDynOtqCY1Mms3HH0bP0Sj
   Q==;
X-CSE-ConnectionGUID: hHmAUWiGTCyvLVH+JlcJYg==
X-CSE-MsgGUID: OQVeRlaBTvm94J5TbxHkpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3076539"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3076539"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:13:09 -0800
X-CSE-ConnectionGUID: /ikH9VojSLGqF7/2qI2FSw==
X-CSE-MsgGUID: XPaGxVQ7Qx+lvTcKP+Oa1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8720325"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:13:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Nov 2026 14:13:00 +0200 (EET)
To: Ciro Pedrini <ciro.pedrini@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, Rong Zhang <i@rong.moe>, 
    Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    Werner Sembach <wse@tuxedocomputers.com>, 
    Aaron Erhardt <aer@tuxedocomputers.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/2] HID: lenovo-legion: Add keyboard backlight driver
 for Legion Gen 10
In-Reply-To: <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com>
Message-ID: <3e8f3452-06c1-8194-2d76-524418f0194c@linux.intel.com>
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com> <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com>
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

On Tue, 10 Nov 2026, Ciro Pedrini via B4 Relay wrote:

> From: Ciro Pedrini <ciro.pedrini@gmail.com>
> 
> The keyboard backlight of the Lenovo Legion Pro 7 16IAX10H (2025) has no
> Linux support: on the test unit nothing ever lit, because the keyboard
> controller's brightness was 0 from the factory and nothing exposes it.
> 
> The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard and
> carries a vendor protocol on feature report 0x07 (960 bytes): a request,
> answered by reading the report back once the controller has prepared it.
> Its hardware brightness, 0..9, is stored in the controller and applies to
> every LED of the machine (keys, front strip, rear vents, lid logo). The
> firmware handles Fn+Up and Fn+Down itself and reports the new level on
> vendor input report 5.
> 
> Expose the brightness as a kbd_backlight LED, legion::kbd_backlight, with
> brightness_hw_changed for the hotkeys so that desktops show their OSD.
> Unregistering keeps the level (LED_RETAIN_AT_SHUTDOWN): switching it off
> would be stored by the controller.
> 
> The colours stay the controller's own effects, which Fn+Space cycles. The
> machine's HID LampArray (048d:c193) is left to hid-generic, or to a
> generic LampArray driver.
> 
> Tested on the 16IAX10H (83F5) with 7.2 as a module: brightness from sysfs
> and KDE, the hotkeys with KDE's OSD, suspend/resume, unbinding and
> rebinding, and a userspace LampArray client alongside the driver.
> 
> Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>

Thanks for the update, this one looks much cleaner already. :-)

> ---
> Prepared with Claude Code (Claude Opus 5.5) from measurements on the
> laptop (usbmon captures) and analysis of the vendor's Windows software
> for interoperability; I reviewed and tested it.
> ---
>  MAINTAINERS                     |   1 +
>  drivers/hid/Kconfig             |  13 ++
>  drivers/hid/Makefile            |   1 +
>  drivers/hid/hid-ids.h           |   1 +
>  drivers/hid/hid-lenovo-legion.c | 261 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 277 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..843906a1f9d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15187,6 +15187,7 @@ F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>  F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>  F:	drivers/hid/hid-lenovo-go-s.c
>  F:	drivers/hid/hid-lenovo-go.c
> +F:	drivers/hid/hid-lenovo-legion.c
>  F:	drivers/hid/hid-lenovo.c
>  
>  LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c435..55d25afddb69 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -652,6 +652,19 @@ config HID_LENOVO_GO_S
>  	S. Say M here to compile this driver as a module. The module will be called
>  	hid-lenovo-go-s.
>  
> +config HID_LENOVO_LEGION
> +	tristate "Lenovo Legion laptop keyboard backlight"
> +	depends on USB_HID
> +	depends on LEDS_CLASS
> +	help
> +	Support for the keyboard backlight of 2025 Lenovo Legion laptops
> +	(Legion Pro 7 Gen 10): the hardware brightness of the ITE keyboard
> +	controller as a kbd_backlight LED, with the Fn+Up/Down changes
> +	reported to userspace.
> +
> +	Say M here to compile this driver as a module. The module will be called
> +	hid-lenovo-legion.
> +
>  config HID_LETSKETCH
>  	tristate "Letsketch WP9620N tablets"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 43a8eb0f389b..713bb1c89861 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_HID_LCPOWER)	+= hid-lcpower.o
>  obj-$(CONFIG_HID_LENOVO)	+= hid-lenovo.o
>  obj-$(CONFIG_HID_LENOVO_GO)	+= hid-lenovo-go.o
>  obj-$(CONFIG_HID_LENOVO_GO_S)	+= hid-lenovo-go-s.o
> +obj-$(CONFIG_HID_LENOVO_LEGION)	+= hid-lenovo-legion.o
>  obj-$(CONFIG_HID_LETSKETCH)	+= hid-letsketch.o
>  obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
>  obj-$(CONFIG_HID_LOGITECH)	+= hid-lg-g15.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 91319aa6516d..992b9b147e95 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -773,6 +773,7 @@
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
>  #define I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720	0x837a
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
> +#define USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD	0xc197
>  #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD	0x8987
>  #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD	0x83db
>  #define USB_DEVICE_ID_ITE8595		0x8595
> diff --git a/drivers/hid/hid-lenovo-legion.c b/drivers/hid/hid-lenovo-legion.c
> new file mode 100644
> index 000000000000..6d0b4adc6f49
> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-legion.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID driver for the keyboard backlight of Lenovo Legion laptops (2025).
> + *
> + * The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard and
> + * carries Lenovo's vendor lighting protocol: feature report 0x07, 960 bytes,
> + * a request (struct legion_msg) answered by reading the report back with a
> + * GET_FEATURE once the controller has prepared it (up to ~50 ms).
> + *
> + * The backlight brightness is op 0xCE (set) / 0xCD (get), 0..9, stored in the
> + * controller; it applies to every LED of the machine (keys, front strip, rear
> + * vents, lid logo). The firmware handles Fn+Up / Fn+Down itself and reports
> + * the new level on vendor input report 5 (struct legion_event).
> + *
> + * The colours are the controller's own effects. The LEDs can also be handed
> + * to the HID LampArray of the "Lenovo Lighting" device (048d:c193), which
> + * this driver leaves to others.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/compiler.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/leds.h>
> +#include <linux/lockdep.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include <asm/byteorder.h>
> +
> +#include "hid-ids.h"
> +
> +#define LEGION_REPORT_ID		0x07
> +#define LEGION_REPORT_SIZE		960
> +#define LEGION_ANSWER_DELAY_MS		100
> +
> +#define LEGION_OP_GET_BRIGHTNESS	0xcd
> +#define LEGION_OP_SET_BRIGHTNESS	0xce
> +#define LEGION_MAX_BRIGHTNESS		9
> +
> +#define LEGION_EVENT_REPORT_ID		0x05
> +#define LEGION_EVENT_BRIGHTNESS_UP	0x02
> +#define LEGION_EVENT_BRIGHTNESS_DOWN	0x03
> +
> +/* Request, and its answer: the value is params[0]. */
> +struct legion_msg {
> +	u8 report_id;
> +	u8 op;
> +	__le16 len;			/* of params */
> +	u8 params[];
> +} __packed;
> +
> +struct legion_event {
> +	u8 report_id;
> +	u8 event;
> +	u8 level;			/* brightness after the change */
> +} __packed;
> +
> +struct legion_kbd {
> +	struct hid_device *hdev;
> +	struct mutex lock;		/* one request/answer exchange at a time */
> +	struct legion_msg *msg;		/* LEGION_REPORT_SIZE, DMA-safe */
> +	struct led_classdev led;
> +};
> +
> +/*
> + * Send one request. When @answer is non-NULL, wait for the controller to
> + * prepare its answer and return its value there.
> + */
> +static int legion_exchange(struct legion_kbd *kbd, u8 op, const u8 *params,
> +			   u16 len, u8 *answer)
> +{
> +	struct hid_device *hdev = kbd->hdev;
> +	struct legion_msg *msg = kbd->msg;
> +	int ret;
> +
> +	lockdep_assert_held(&kbd->lock);
> +
> +	memset(msg, 0, LEGION_REPORT_SIZE);
> +	msg->report_id = LEGION_REPORT_ID;
> +	msg->op = op;
> +	msg->len = cpu_to_le16(len);
> +	memcpy(msg->params, params, len);
> +
> +	ret = hid_hw_raw_request(hdev, LEGION_REPORT_ID, (u8 *)msg,
> +				 LEGION_REPORT_SIZE, HID_FEATURE_REPORT,
> +				 HID_REQ_SET_REPORT);
> +	if (ret < 0)
> +		return ret;
> +	if (!answer)
> +		return 0;
> +
> +	msleep(LEGION_ANSWER_DELAY_MS);
> +
> +	memset(msg, 0, LEGION_REPORT_SIZE);
> +	ret = hid_hw_raw_request(hdev, LEGION_REPORT_ID, (u8 *)msg,
> +				 LEGION_REPORT_SIZE, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);
> +	if (ret < 0)
> +		return ret;
> +	if (ret <= (int)sizeof(*msg) || msg->report_id != LEGION_REPORT_ID ||

Just remove this cast. It was probably added by llm and doesn't look 
helpful to make those types compatible, everyone even remotely familiar 
with the code will know sizeof() for that struct fits to int anyway.

> +	    msg->op != op) {
> +		hid_warn(hdev, "unexpected answer to 0x%02x: %*ph\n", op,
> +			 min(ret, 8), msg);

Printing data like this looks more like debug level stuff. I don't 
see benefit for normal user from it (non-debug level messages are for 
consumption by normal users so code and too cryptic stuff should be 
avoided).

> +		return -EIO;
> +	}
> +
> +	*answer = msg->params[0];
> +	return 0;
> +}
> +
> +static int legion_brightness_set(struct led_classdev *led,
> +				 enum led_brightness value)
> +{
> +	struct legion_kbd *kbd = container_of(led, struct legion_kbd, led);
> +	u8 level = min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);
> +
> +	guard(mutex)(&kbd->lock);
> +	return legion_exchange(kbd, LEGION_OP_SET_BRIGHTNESS, &level,
> +			       sizeof(level), NULL);
> +}
> +
> +static enum led_brightness legion_brightness_get(struct led_classdev *led)
> +{
> +	struct legion_kbd *kbd = container_of(led, struct legion_kbd, led);
> +	u8 zero = 0, value;
> +	int ret;
> +
> +	guard(mutex)(&kbd->lock);
> +	ret = legion_exchange(kbd, LEGION_OP_GET_BRIGHTNESS, &zero,
> +			      sizeof(zero), &value);
> +	if (ret)
> +		return led->brightness;	/* keep the last known level */
> +
> +	return min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);
> +}
> +
> +static int legion_raw_event(struct hid_device *hdev, struct hid_report *report,
> +			    u8 *data, int size)
> +{
> +	const struct legion_event *ev = (const struct legion_event *)data;
> +	struct legion_kbd *kbd = hid_get_drvdata(hdev);
> +	unsigned int level;
> +
> +	if (size < (int)sizeof(*ev) || ev->report_id != LEGION_EVENT_REPORT_ID)

Remove cast.

> +		return 0;
> +
> +	if (ev->event != LEGION_EVENT_BRIGHTNESS_UP &&
> +	    ev->event != LEGION_EVENT_BRIGHTNESS_DOWN)
> +		return 0;
> +
> +	/*
> +	 * hid-core calls this only after probe() has returned and not once
> +	 * remove() has started, so the LED is registered. The controller has
> +	 * already changed the level: keep led_cdev.brightness in step with it.
> +	 */
> +	level = min_t(unsigned int, ev->level, LEGION_MAX_BRIGHTNESS);
> +	WRITE_ONCE(kbd->led.brightness, level);

Please add include for this. Either rwonce.h or barrier.h, it currently 
comes through compiler.h but I don't see anything that would technically 
require "compiler" to include "rwonce" so it's not a "guaranteed" include 
path in my eye.

> +	led_classdev_notify_brightness_hw_changed(&kbd->led, level);
> +
> +	return 0;	/* let hid-core handle the report as usual */
> +}
> +
> +static int legion_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	struct legion_kbd *kbd;
> +	int ret;
> +
> +	/* As hid-generic: one input device per application collection. */
> +	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
> +
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	kbd = devm_kzalloc_obj(&hdev->dev, *kbd);
> +	if (!kbd)
> +		return -ENOMEM;
> +
> +	kbd->msg = devm_kzalloc(&hdev->dev, LEGION_REPORT_SIZE, GFP_KERNEL);
> +	if (!kbd->msg)
> +		return -ENOMEM;
> +
> +	ret = devm_mutex_init(&hdev->dev, &kbd->lock);
> +	if (ret)
> +		return ret;
> +
> +	kbd->hdev = hdev;
> +	hid_set_drvdata(hdev, kbd);
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	/* Keep the interrupt endpoint polled so hotkey reports always arrive. */
> +	ret = hid_hw_open(hdev);
> +	if (ret)
> +		goto err_stop;
> +
> +	kbd->led.name = "legion::kbd_backlight";
> +	kbd->led.max_brightness = LEGION_MAX_BRIGHTNESS;
> +	kbd->led.brightness_set_blocking = legion_brightness_set;
> +	kbd->led.brightness_get = legion_brightness_get;
> +	/*
> +	 * LED_RETAIN_AT_SHUTDOWN: unregistering (unload, unbind) must not
> +	 * switch the backlight off, the controller would store 0.
> +	 * LED_BRIGHT_HW_CHANGED: Fn+Up/Down are reported to userspace.
> +	 */

This only documents what these flags are so why a driver needs such a 
comment?

> +	kbd->led.flags = LED_RETAIN_AT_SHUTDOWN | LED_BRIGHT_HW_CHANGED;
> +
> +	/*
> +	 * Not devm: the LED must be gone before remove() stops the device,
> +	 * devm would release it only after that.
> +	 */

Yeah, mixing devm and non-devm can result in this kind of ordering problem 
(sometimes one can get away with it, e.g., freeing allocated space later 
is normally a non-issue but for other things it does break things like 
this).

But could you solve this with devm_add_action_or_reset() (for hid 
teardown) and use devm for everything?

> +	ret = led_classdev_register(&hdev->dev, &kbd->led);
> +	if (ret)
> +		goto err_close;
> +
> +	return 0;
> +
> +err_close:
> +	hid_hw_close(hdev);
> +err_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}
> +
> +static void legion_remove(struct hid_device *hdev)
> +{
> +	struct legion_kbd *kbd = hid_get_drvdata(hdev);
> +
> +	/* hid-core no longer calls legion_raw_event(): the LED can go. */
> +	led_classdev_unregister(&kbd->led);
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id legion_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, legion_devices);
> +
> +static struct hid_driver legion_driver = {
> +	.name = "hid-lenovo-legion",
> +	.id_table = legion_devices,
> +	.probe = legion_probe,
> +	.remove = legion_remove,
> +	.raw_event = legion_raw_event,
> +};
> +module_hid_driver(legion_driver);
> +
> +MODULE_AUTHOR("Ciro Pedrini <ciro.pedrini@gmail.com>");
> +MODULE_DESCRIPTION("Keyboard backlight of Lenovo Legion laptops (2025)");

I don't think we should put year into this, it will just become obsolete 
pretty fast like all time bound reference. :-)

IMO it's fine even if this wouldn't cover all "Lenovo Legion" laptops 
without explicitly stating that it only is for part of them.

-- 
 i.

