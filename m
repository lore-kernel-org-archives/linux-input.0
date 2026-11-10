Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306508;
	b=d+yDSdxYS0BEfdjkkK0v3ADQgz+knSjual6rLtK+zq3rcjNLyS6Osojpf6x2PGP9zDlI
	 +phIFrTEA+6oiqWKJdRn4Fwr8SfryuU+EbEFeAttL7AHf88YXL7QnAMiOweFmwPqvfr7C
	 ZPwqmFt8UPx/rFCt+RXA779uc4W7JYPztqJZk+UVn0KxSBm4c3KgQ8jZ1XFo1ap1THeoG
	 x7MTnmMfVHQ6fkZSuY5jKdAqXXd/L/mgPFMx9zmX/AAQJH4hYB6OqcQ2krmzmXdhB34L+
	 ngp4Q1KRwa/BwP0vFUurhprOmEv3xNoK1TC8PY9cd/oCYLIgsurGrQwBCCARejAzPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306508;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=HkaABJlUBFE1WlDxnyKyqL6vTSupn5RQ93iYtmS2WVQ=;
	b=Z14QNSAkEwmOBsUMu3pmcVdmNH5X4nj4K583pH/TPdILwPyKh8a5fmV4axxN/gJDGVXE
	 XiYLIDww69/Py3GTovqaK+n8P6/7JDg2GsPmiGagFKZ76u2E0XejUpJwZhxzm0aOUGMaH
	 au/aHiuyvVMbK/w7mGBvGmMIRskLxwpqNb+8unKxF5ktYGe6FHPKeMXzAgcc6+Ywwp95Z
	 Qn+B5vp4gothiQJNlF/DOcH8/D87tvODRH1NBUk1hfwvob+kzUcLe5awYFN1lmXvaY1sl
	 zSbV/Q4iOX0pyOvLAddvdlcODayYG8zOdZ0b3+NaJ1ilfkRn7SjTM2MVibottDs6OVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDUqVEB3;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0D606A31C;
	Tue, 10 Nov 2026 10:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDUqVEB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794306507; x=1825842507;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BIYVT8u+FBuJH9KSUijAM3dtsAODDdOLunvohuh7mqM=;
  b=VDUqVEB3XypCCRgreS2iPTEM/djYjLeT/87FNUG4/+b1QO7w12TEKOBm
   dimkXxIu7VpApfSoNWFBV/srHbzqCfF5K0SqdUGBk5NOV0/DCVBTUKLJl
   gy7nm+rU/JMxE1VtFWxhMU8FIiTsi+UCDg3/g8S8zqAUDwzxWFAryUvYD
   4fVUNcu/LNVrHU/xaShMYX4Yp4i/vCUAdNLoymxJFiJ0B7pULHT6tSq11
   NzdJ9WvQQ+CmnBuHFGqowhCULrqw/gVzWOEe16iCgDiNNOvHdWV8G7PGK
   SYGisLiZCiVMGyMBr1L/WkuQ5/q4oEzr95aLDBeXgqtTuq0hDConcnkRY
   A==;
X-CSE-ConnectionGUID: NqhM8AGaR6KvqUg320kOzQ==
X-CSE-MsgGUID: ZTJH5inORG2sk4tUpJzdog==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3131006"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3131006"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:28:26 -0800
X-CSE-ConnectionGUID: X2L+khr2SJaS5Rr45zSfKQ==
X-CSE-MsgGUID: fhbooZFJScqNIRq1OX5Dig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9855156"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 02:28:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Nov 2026 12:28:18 +0200 (EET)
To: Ciro Pedrini <ciro.pedrini@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, Rong Zhang <i@rong.moe>, 
    Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    Werner Sembach <wse@tuxedocomputers.com>, 
    Aaron Erhardt <aer@tuxedocomputers.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] HID: lenovo-legion: Add keyboard lighting driver
 for Legion Gen 10
In-Reply-To: <20261109-legion-lighting-rfc-v1-2-a87e1db8c5e3@gmail.com>
Message-ID: <0ff29b9d-bfd5-4d89-0e78-05497312e390@linux.intel.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com> <20261109-legion-lighting-rfc-v1-2-a87e1db8c5e3@gmail.com>
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

On Mon, 9 Nov 2026, Ciro Pedrini via B4 Relay wrote:

> From: Ciro Pedrini <ciro.pedrini@gmail.com>
> 
> The keyboard and chassis lighting of the Legion Pro 7 16IAX10H is made of
> two USB devices:
> 
> - The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard
>   and carries a vendor protocol (feature report 0x07, 960 bytes): a
>   hardware brightness 0..9, and a switch selecting whether the LEDs show
>   the controller's own effects or follow the LampArray below. Both are
>   stored in the controller. Fn+Up and Fn+Down are handled by the
>   controller, which reports the new level on vendor input report 5.
> 
> - 048d:c193 interface 1 is a standard HID LampArray with 319 lamps (keys,
>   front strip, rear vents, lid logo). It only shows anything after the
>   controller hands the LEDs over, its colours are scaled by the
>   controller's brightness, and after resume from S3 it comes back reset,
>   in autonomous mode.
> 
> Bind both and expose one multicolor LED, <name>:rgb:kbd_backlight:
> brightness is the controller's, and the hotkeys reach userspace through
> brightness_hw_changed. A lighting_mode attribute selects "firmware" (the
> default: the controller's effects, the driver leaves the LEDs alone so a
> userspace tool may drive the LampArray through hidraw) or "color" (every
> lamp shows multi_intensity, restored after resume); writing a new colour
> switches to "color". The two devices are paired by their USB bus. The
> other interface of c193 is started as hid-generic would.
> 
> The controller's brightness can be 0 from the factory (it was on the test
> unit), which leaves every LED dark, LampArray included; the driver doesn't
> change it, the desktop shows the backlight as off and Fn+Up turns it on.
> 
> Tested on the 16IAX10H with 7.2 as a module: brightness from sysfs and
> KDE, the hotkeys' OSD, colours on every zone, suspend/resume in both
> modes, a userspace LampArray client in "firmware" mode, and unbinding
> back to hid-generic.
> 
> The driver and this changelog were prepared with Claude Code (Claude Opus

Hi,

Thanks for the patch.

Please don't include how things were prepared into changelog, but you can 
use the area below the first --- so it won't end up into the final commit 
message if you patch is applied (our tools will automatically cut the 
part below ---).

> 5.5), from measurements on the laptop (usbmon captures, the LampArray's
> own attributes) and analysis of the vendor's Windows software for
> interoperability; I reviewed and tested them.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
> ---
>  .../testing/sysfs-class-led-driver-lenovo-legion   |  20 +
>  MAINTAINERS                                        |   2 +
>  drivers/hid/Kconfig                                |  13 +
>  drivers/hid/Makefile                               |   1 +
>  drivers/hid/hid-ids.h                              |   2 +
>  drivers/hid/hid-lenovo-legion.c                    | 662 +++++++++++++++++++++
>  6 files changed, 700 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-lenovo-legion b/Documentation/ABI/testing/sysfs-class-led-driver-lenovo-legion
> new file mode 100644
> index 000000000000..3a543306006c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-lenovo-legion
> @@ -0,0 +1,20 @@
> +What:		/sys/class/leds/<led>/lighting_mode
> +Date:		November 2026
> +KernelVersion:	7.5
> +Contact:	Ciro Pedrini <ciro.pedrini@gmail.com>
> +Description:	(RW) Who drives the keyboard and chassis LEDs of a Lenovo
> +		Legion laptop whose lighting is an ITE keyboard controller
> +		plus a HID LampArray (e.g. Legion Pro 7 Gen 10):
> +
> +		- firmware: the keyboard controller's own effects (the
> +		  default). The driver doesn't touch the LEDs, so userspace
> +		  may drive the LampArray itself through hidraw.
> +		- color: every lamp shows the colour in multi_intensity.
> +
> +		Writing a new colour to multi_intensity also switches to
> +		"color". In both modes, brightness is the controller's
> +		hardware brightness (0..9).
> +
> +		Access: Read/Write
> +
> +		Valid values: firmware, color
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..b9762ad715f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15183,10 +15183,12 @@ M:	Derek J. Clark <derekjohn.clark@gmail.com>
>  M:	Mark Pearson <mpearson-lenovo@squebb.ca>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-led-driver-lenovo-legion
>  F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>  F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>  F:	drivers/hid/hid-lenovo-go-s.c
>  F:	drivers/hid/hid-lenovo-go.c
> +F:	drivers/hid/hid-lenovo-legion.c
>  F:	drivers/hid/hid-lenovo.c
>  
>  LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c435..cc060c58ed90 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -652,6 +652,19 @@ config HID_LENOVO_GO_S
>  	S. Say M here to compile this driver as a module. The module will be called
>  	hid-lenovo-go-s.
>  
> +config HID_LENOVO_LEGION
> +	tristate "Lenovo Legion laptop keyboard lighting"
> +	depends on USB_HID
> +	depends on LEDS_CLASS_MULTICOLOR
> +	help
> +	Support for the keyboard and chassis lighting of 2025 Lenovo Legion
> +	laptops (Legion Pro 7 Gen 10): the backlight brightness of the ITE
> +	keyboard controller and one colour for every lamp of its HID LampArray,
> +	as a multicolor kbd_backlight LED.
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
> index 91319aa6516d..83cb09ca51f5 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -773,6 +773,8 @@
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
>  #define I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720	0x837a
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
> +#define USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_LAMPS	0xc193
> +#define USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD	0xc197
>  #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD	0x8987
>  #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD	0x83db
>  #define USB_DEVICE_ID_ITE8595		0x8595
> diff --git a/drivers/hid/hid-lenovo-legion.c b/drivers/hid/hid-lenovo-legion.c
> new file mode 100644
> index 000000000000..923f03d4ed34
> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-legion.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID driver for the keyboard lighting of Lenovo Legion laptops (2025).
> + *
> + * Two USB devices form the lighting:
> + *
> + * - The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard and
> + *   carries Lenovo's vendor lighting protocol: feature report 0x07, 960 bytes,
> + *   request "07 op len_lo len_hi params...", answer read back with a
> + *   GET_FEATURE as "07 op len_lo len_hi value..." once the controller has
> + *   prepared it (up to ~50 ms). Brightness is op 0xCE (set) / 0xCD (get),
> + *   0..9. Op 0xAA selects who drives the LEDs: 01 the controller's own
> + *   effects, 00 the LampArray below. Both are stored in the controller. The
> + *   firmware handles Fn+Up / Fn+Down and reports the new level on vendor
> + *   input report 5: "05 02 B" (raised) / "05 03 B" (lowered).
> + *
> + * - "Lenovo Lighting" (048d:c193) interface 1 is a standard HID LampArray
> + *   covering every LED (keys, front strip, rear vents, lid logo). It only
> + *   shows anything once the controller hands the LEDs over (0xAA 00), its
> + *   colours are scaled by the controller's brightness, and after resume from
> + *   S3 it comes back reset, in autonomous mode.
> + *
> + * Userspace sees one multicolor LED: brightness is the controller's, the
> + * colour goes to every lamp. Its lighting_mode attribute says who drives the
> + * LEDs: "firmware" (the controller's own effects; the driver leaves the LEDs
> + * alone, so a userspace tool may drive the LampArray itself) or "color" (the
> + * driver shows multi_intensity on every lamp). It starts as "firmware";
> + * writing a new colour to multi_intensity switches to "color".
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/unaligned.h>
> +#include <linux/usb.h>
> +#include <linux/workqueue.h>
> +
> +#include "hid-ids.h"
> +
> +/* Keyboard controller, vendor protocol */
> +#define LEGION_REPORT_ID		0x07
> +#define LEGION_REPORT_SIZE		960
> +#define LEGION_ANSWER_DELAY_MS		100
> +
> +#define LEGION_OP_GET_BRIGHTNESS	0xcd
> +#define LEGION_OP_SET_BRIGHTNESS	0xce
> +#define LEGION_OP_LIGHTING_OWNER	0xaa
> +#define LEGION_OWNER_LAMPARRAY		0x00
> +#define LEGION_OWNER_FIRMWARE		0x01
> +#define LEGION_MAX_BRIGHTNESS		9
> +
> +#define LEGION_EVENT_REPORT_ID		0x05
> +#define LEGION_EVENT_BRIGHTNESS_UP	0x02
> +#define LEGION_EVENT_BRIGHTNESS_DOWN	0x03
> +
> +/* LampArray (HID Usage Tables, Lighting and Illumination page 0x59) */
> +#define LAMPARRAY_USAGE			0x00590001
> +#define LAMPARRAY_ATTRIBUTES_ID		0x01
> +#define LAMPARRAY_ATTRIBUTES_SIZE	23
> +#define LAMPARRAY_RANGE_UPDATE_ID	0x05
> +#define LAMPARRAY_RANGE_UPDATE_SIZE	10
> +#define LAMPARRAY_CONTROL_ID		0x06
> +#define LAMPARRAY_CONTROL_SIZE		2
> +#define LAMPARRAY_UPDATE_COMPLETE	0x01
> +
> +struct legion_lamps;
> +
> +struct legion_kbd {
> +	struct hid_device *hdev;
> +	struct usb_bus *bus;		/* pairs it with its LampArray */
> +	struct list_head node;		/* in legion_kbds */
> +	struct mutex lock;		/* one request/answer exchange at a time */
> +	u8 *buf;			/* LEGION_REPORT_SIZE, DMA-safe */
> +	struct led_classdev_mc mc;
> +	struct mc_subled subleds[3];
> +	struct work_struct hw_changed_work;
> +	unsigned int hw_brightness;	/* last level reported by the firmware */
> +	spinlock_t event_lock;		/* protects ready */

Why does bool need a spinlock? That sounds like overkill if it's all it 
protects.

> +	bool ready;			/* LED registered: events may notify it */
> +
> +	/* Protected by legion_pair_lock */
> +	struct legion_lamps *lamps;
> +	u8 rgb[3];			/* last colour seen in multi_intensity */
> +	bool color_set;			/* lighting_mode is "color" */
> +	bool lamparray_owns;		/* we switched the controller to 0xAA 00 */
> +};
> +
> +struct legion_lamps {
> +	struct hid_device *hdev;
> +	struct usb_bus *bus;
> +	struct list_head node;		/* in legion_lamps_list */
> +	struct mutex lock;		/* one report at a time */
> +	u8 *buf;			/* LAMPARRAY_ATTRIBUTES_SIZE, DMA-safe */
> +	u16 lamp_count;
> +
> +	struct legion_kbd *kbd;		/* protected by legion_pair_lock */
> +};
> +
> +static DEFINE_MUTEX(legion_pair_lock);

Needs an explaination what the lock protects.

> +static LIST_HEAD(legion_kbds);
> +static LIST_HEAD(legion_lamps_list);
> +
> +static struct usb_bus *legion_usb_bus(struct hid_device *hdev)
> +{
> +	return interface_to_usbdev(to_usb_interface(hdev->dev.parent))->bus;
> +}
> +
> +/* Keyboard controller -------------------------------------------------- */
> +
> +/*
> + * Send one request. When @answer is non-NULL, wait for the controller to
> + * prepare its answer and return its value byte (byte 4) there.
> + */
> +static int legion_exchange(struct legion_kbd *kbd, u8 op, const u8 *params,
> +			   u8 len, u8 *answer)
> +{
> +	struct hid_device *hdev = kbd->hdev;
> +	u8 *buf = kbd->buf;
> +	int ret;
> +
> +	lockdep_assert_held(&kbd->lock);
> +
> +	memset(buf, 0, LEGION_REPORT_SIZE);
> +	buf[0] = LEGION_REPORT_ID;
> +	buf[1] = op;
> +	buf[2] = len;			/* payload length, little endian */
> +	buf[3] = 0;

Why not a struct?

You seem to violate field boundaries with length field by processing 
things as bytes whereas you should be using proper endiannes type for it 
which is easy when you do this using a struct.

> +	memcpy(&buf[4], params, len);
> +
> +	ret = hid_hw_raw_request(hdev, LEGION_REPORT_ID, buf, LEGION_REPORT_SIZE,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret < 0)
> +		return ret;
> +	if (!answer)
> +		return 0;
> +
> +	msleep(LEGION_ANSWER_DELAY_MS);
> +
> +	memset(buf, 0, LEGION_REPORT_SIZE);
> +	ret = hid_hw_raw_request(hdev, LEGION_REPORT_ID, buf, LEGION_REPORT_SIZE,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret < 0)
> +		return ret;
> +	if (ret < 5 || buf[0] != LEGION_REPORT_ID || buf[1] != op) {
> +		hid_warn(hdev, "unexpected answer to 0x%02x: %*ph\n", op,
> +			 min(ret, 8), buf);
> +		return -EIO;
> +	}
> +
> +	*answer = buf[4];
> +	return 0;
> +}
> +
> +static int legion_set_owner(struct legion_kbd *kbd, u8 owner)
> +{
> +	const u8 params[2] = { owner, 0 };
> +	int ret;
> +
> +	mutex_lock(&kbd->lock);
> +	ret = legion_exchange(kbd, LEGION_OP_LIGHTING_OWNER, params,
> +			      sizeof(params), NULL);
> +	mutex_unlock(&kbd->lock);
> +
> +	return ret;
> +}
> +
> +/* LampArray ------------------------------------------------------------ */
> +
> +static int lamps_set_feature(struct legion_lamps *lamps, const u8 *data,
> +			     size_t size)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&lamps->lock);
> +
> +	memcpy(lamps->buf, data, size);
> +	ret = hid_hw_raw_request(lamps->hdev, data[0], lamps->buf, size,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int lamps_set_autonomous(struct legion_lamps *lamps, bool autonomous)
> +{
> +	const u8 report[LAMPARRAY_CONTROL_SIZE] = {
> +		LAMPARRAY_CONTROL_ID, autonomous,
> +	};
> +	int ret;
> +
> +	mutex_lock(&lamps->lock);
> +	ret = lamps_set_feature(lamps, report, sizeof(report));
> +	mutex_unlock(&lamps->lock);

Use guard() and drop ret.

> +
> +	return ret;
> +}
> +
> +/* Host control, then every lamp in one colour. */
> +static int lamps_set_color(struct legion_lamps *lamps, const u8 *rgb)
> +{
> +	u16 last = lamps->lamp_count - 1;
> +	const u8 control[LAMPARRAY_CONTROL_SIZE] = { LAMPARRAY_CONTROL_ID, 0 };
> +	const u8 update[LAMPARRAY_RANGE_UPDATE_SIZE] = {
> +		LAMPARRAY_RANGE_UPDATE_ID, LAMPARRAY_UPDATE_COMPLETE,
> +		0, 0,				/* first lamp */
> +		last & 0xff, last >> 8,		/* last lamp */

Adhoc endianness handling?

Here too a struct would make things much more obvious as the members would 
be named so you wouldn't need comments like that and could do proper 
endianness.

> +		rgb[0], rgb[1], rgb[2],
> +		1,				/* intensity: on */
> +	};
> +	int ret;
> +
> +	mutex_lock(&lamps->lock);
> +	ret = lamps_set_feature(lamps, control, sizeof(control));
> +	if (!ret)
> +		ret = lamps_set_feature(lamps, update, sizeof(update));

Use guard() to not complicate the code flow and return immediately on error.

> +	mutex_unlock(&lamps->lock);
> +
> +	return ret;
> +}
> +
> +/* With legion_pair_lock held: show kbd->rgb, handing the LEDs over first. */
> +static int legion_apply_color(struct legion_kbd *kbd)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&legion_pair_lock);
> +
> +	if (!kbd->lamps)
> +		return 0;	/* applied when the LampArray binds */
> +
> +	if (!kbd->lamparray_owns) {
> +		ret = legion_set_owner(kbd, LEGION_OWNER_LAMPARRAY);
> +		if (ret)
> +			return ret;
> +		kbd->lamparray_owns = true;
> +	}
> +
> +	return lamps_set_color(kbd->lamps, kbd->rgb);
> +}
> +
> +/* With legion_pair_lock held: give the LEDs back to the controller. */
> +static void legion_hand_back(struct legion_kbd *kbd)
> +{
> +	lockdep_assert_held(&legion_pair_lock);
> +
> +	if (!kbd->lamparray_owns)
> +		return;
> +
> +	if (kbd->lamps)
> +		lamps_set_autonomous(kbd->lamps, true);
> +	legion_set_owner(kbd, LEGION_OWNER_FIRMWARE);
> +	kbd->lamparray_owns = false;
> +}
> +
> +/* LED ------------------------------------------------------------------ */
> +
> +static int legion_brightness_set(struct led_classdev *led,
> +				 enum led_brightness value)
> +{
> +	struct led_classdev_mc *mc = lcdev_to_mccdev(led);
> +	struct legion_kbd *kbd = container_of(mc, struct legion_kbd, mc);
> +	u8 level = min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);

Add include.

> +	u8 rgb[3];
> +	int i, ret;
> +
> +	mutex_lock(&kbd->lock);
> +	ret = legion_exchange(kbd, LEGION_OP_SET_BRIGHTNESS, &level, 1, NULL);
> +	mutex_unlock(&kbd->lock);
> +	if (ret)
> +		return ret;

Use scoped_guard and keep the error handling next to the call.

> +
> +	/* A multi_intensity write ends up here too: apply a changed colour. */
> +	for (i = 0; i < 3; i++)

Magic 3. Should this use ARRAY_SIZE()? Don't forget to add include for it 
if you use it.

> +		rgb[i] = READ_ONCE(mc->subled_info[i].intensity);

Add include.

> +
> +	mutex_lock(&legion_pair_lock);
> +	if (memcmp(rgb, kbd->rgb, sizeof(rgb))) {
> +		memcpy(kbd->rgb, rgb, sizeof(rgb));
> +		kbd->color_set = true;
> +		ret = legion_apply_color(kbd);

Use guard() and return immediately on error.

> +	}
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return ret;
> +}
> +
> +static enum led_brightness legion_brightness_get(struct led_classdev *led)
> +{
> +	struct led_classdev_mc *mc = lcdev_to_mccdev(led);
> +	struct legion_kbd *kbd = container_of(mc, struct legion_kbd, mc);

include.

> +	u8 zero = 0, value = 0;
> +	int ret;
> +
> +	mutex_lock(&kbd->lock);
> +	ret = legion_exchange(kbd, LEGION_OP_GET_BRIGHTNESS, &zero, 1, &value);

sizeof(zero)

> +	mutex_unlock(&kbd->lock);
> +
> +	if (ret)

You know the drill be now.

> +		return led->brightness;	/* keep the last known level */
> +
> +	return min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);
> +}
> +
> +static void legion_hw_changed_work(struct work_struct *work)
> +{
> +	struct legion_kbd *kbd = container_of(work, struct legion_kbd,
> +					      hw_changed_work);
> +
> +	led_classdev_notify_brightness_hw_changed(&kbd->mc.led_cdev,
> +						  READ_ONCE(kbd->hw_brightness));
> +}
> +
> +static int legion_raw_event(struct hid_device *hdev, struct hid_report *report,
> +			    u8 *data, int size)
> +{
> +	struct legion_kbd *kbd;
> +	unsigned long flags;
> +
> +	if (hdev->product != USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD)
> +		return 0;
> +
> +	kbd = hid_get_drvdata(hdev);
> +	if (!kbd || size < 3 || data[0] != LEGION_EVENT_REPORT_ID)

Magic 3.

> +		return 0;
> +
> +	if (data[1] != LEGION_EVENT_BRIGHTNESS_UP &&
> +	    data[1] != LEGION_EVENT_BRIGHTNESS_DOWN)
> +		return 0;
> +
> +	spin_lock_irqsave(&kbd->event_lock, flags);
> +	if (kbd->ready) {
> +		WRITE_ONCE(kbd->hw_brightness,
> +			   min_t(unsigned int, data[2], LEGION_MAX_BRIGHTNESS));
> +		schedule_work(&kbd->hw_changed_work);
> +	}
> +	spin_unlock_irqrestore(&kbd->event_lock, flags);
> +
> +	return 0;	/* let hid-core handle the report as usual */
> +}
> +
> +static struct legion_kbd *led_dev_to_kbd(struct device *dev)
> +{
> +	struct led_classdev *led = dev_get_drvdata(dev);
> +
> +	return container_of(lcdev_to_mccdev(led), struct legion_kbd, mc);
> +}
> +
> +static ssize_t lighting_mode_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct legion_kbd *kbd = led_dev_to_kbd(dev);
> +	bool color;
> +
> +	mutex_lock(&legion_pair_lock);
> +	color = kbd->color_set;
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return sysfs_emit(buf, "%s\n", color ? "color" : "firmware");

Use guard drop bool color.

> +}
> +
> +static ssize_t lighting_mode_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct legion_kbd *kbd = led_dev_to_kbd(dev);
> +	struct led_classdev_mc *mc = &kbd->mc;
> +	int i, ret = 0;
> +
> +	mutex_lock(&legion_pair_lock);
> +	if (sysfs_streq(buf, "color")) {
> +		for (i = 0; i < 3; i++)

ARRAY_SIZE()

> +			kbd->rgb[i] = READ_ONCE(mc->subled_info[i].intensity);
> +		kbd->color_set = true;
> +		ret = legion_apply_color(kbd);

Use guard and return immediately after error to not complicate code flow.

> +	} else if (sysfs_streq(buf, "firmware")) {
> +		kbd->color_set = false;
> +		legion_hand_back(kbd);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return ret ? ret : count;
> +}
> +static DEVICE_ATTR_RW(lighting_mode);
> +
> +static struct attribute *legion_led_attrs[] = {
> +	&dev_attr_lighting_mode.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(legion_led);
> +
> +/* Probe and remove ----------------------------------------------------- */
> +
> +static int legion_kbd_probe(struct hid_device *hdev)
> +{
> +	struct legion_kbd *kbd;
> +	struct legion_lamps *lamps;
> +	int i, ret;
> +
> +	kbd = devm_kzalloc(&hdev->dev, sizeof(*kbd), GFP_KERNEL);
> +	if (!kbd)
> +		return -ENOMEM;
> +
> +	kbd->buf = devm_kzalloc(&hdev->dev, LEGION_REPORT_SIZE, GFP_KERNEL);
> +	if (!kbd->buf)
> +		return -ENOMEM;
> +
> +	kbd->hdev = hdev;
> +	kbd->bus = legion_usb_bus(hdev);
> +	mutex_init(&kbd->lock);

devm_mutex_init() + don't forget error handling as it can fail.

> +	spin_lock_init(&kbd->event_lock);
> +	INIT_WORK(&kbd->hw_changed_work, legion_hw_changed_work);

Can't the work be managed with devm_ ?

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
> +	for (i = 0; i < 3; i++) {

ARRAY_SIZE()

> +		kbd->subleds[i].color_index = LED_COLOR_ID_RED + i;
> +		kbd->subleds[i].intensity = 255;
> +		kbd->subleds[i].max_intensity = 255;
> +		kbd->rgb[i] = 255;
> +	}
> +	kbd->mc.subled_info = kbd->subleds;
> +	kbd->mc.num_colors = 3;
> +	kbd->mc.led_cdev.name = "legion:rgb:kbd_backlight";
> +	kbd->mc.led_cdev.color = LED_COLOR_ID_RGB;
> +	kbd->mc.led_cdev.max_brightness = LEGION_MAX_BRIGHTNESS;
> +	kbd->mc.led_cdev.brightness_set_blocking = legion_brightness_set;
> +	kbd->mc.led_cdev.brightness_get = legion_brightness_get;
> +	/*
> +	 * LED_RETAIN_AT_SHUTDOWN: unregistering (unload, unbind) must not
> +	 * switch the backlight off, the controller would store 0.
> +	 * LED_BRIGHT_HW_CHANGED: Fn+Up/Down are reported to userspace.
> +	 */
> +	kbd->mc.led_cdev.flags = LED_RETAIN_AT_SHUTDOWN | LED_BRIGHT_HW_CHANGED;
> +
> +	ret = led_classdev_multicolor_register(&hdev->dev, &kbd->mc);
> +	if (ret)
> +		goto err_close;
> +
> +	/* Added afterwards: the multicolor class replaces led_cdev.groups. */
> +	ret = device_add_groups(kbd->mc.led_cdev.dev, legion_led_groups);
> +	if (ret)
> +		goto err_unregister;
> +
> +	spin_lock_irq(&kbd->event_lock);
> +	kbd->ready = true;
> +	spin_unlock_irq(&kbd->event_lock);

spinlock looks overkill for this.

> +
> +	mutex_lock(&legion_pair_lock);
> +	list_add(&kbd->node, &legion_kbds);
> +	list_for_each_entry(lamps, &legion_lamps_list, node) {
> +		if (lamps->bus == kbd->bus && !lamps->kbd) {
> +			lamps->kbd = kbd;
> +			kbd->lamps = lamps;
> +			hid_info(hdev, "paired with %s\n", dev_name(&lamps->hdev->dev));
> +			break;
> +		}
> +	}
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return 0;
> +
> +err_unregister:
> +	led_classdev_multicolor_unregister(&kbd->mc);
> +err_close:
> +	hid_hw_close(hdev);
> +err_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}
> +
> +static void legion_kbd_remove(struct hid_device *hdev)
> +{
> +	struct legion_kbd *kbd = hid_get_drvdata(hdev);
> +
> +	/* No new notifications, then wait for a pending one, then the LED. */
> +	spin_lock_irq(&kbd->event_lock);
> +	kbd->ready = false;
> +	spin_unlock_irq(&kbd->event_lock);

This protects nothing, assuming your comment on the lock protecting only 
ready is correct.

The racing reader side might have already reading ready and unlocked. So 
what does this lock actually protect for real?

> +	cancel_work_sync(&kbd->hw_changed_work);
> +	device_remove_groups(kbd->mc.led_cdev.dev, legion_led_groups);
> +	led_classdev_multicolor_unregister(&kbd->mc);
> +
> +	mutex_lock(&legion_pair_lock);
> +	legion_hand_back(kbd);
> +	if (kbd->lamps)
> +		kbd->lamps->kbd = NULL;
> +	list_del(&kbd->node);
> +	mutex_unlock(&legion_pair_lock);
> +
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}
> +
> +static int legion_lamps_probe(struct hid_device *hdev)
> +{
> +	struct legion_lamps *lamps;
> +	struct legion_kbd *kbd;
> +	int ret;
> +
> +	lamps = devm_kzalloc(&hdev->dev, sizeof(*lamps), GFP_KERNEL);
> +	if (!lamps)
> +		return -ENOMEM;
> +
> +	lamps->buf = devm_kzalloc(&hdev->dev, LAMPARRAY_ATTRIBUTES_SIZE,
> +				  GFP_KERNEL);
> +	if (!lamps->buf)
> +		return -ENOMEM;
> +
> +	lamps->hdev = hdev;
> +	lamps->bus = legion_usb_bus(hdev);
> +	mutex_init(&lamps->lock);

devm_mutex_init()

> +	hid_set_drvdata(hdev, lamps);
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = hid_hw_raw_request(hdev, LAMPARRAY_ATTRIBUTES_ID, lamps->buf,
> +				 LAMPARRAY_ATTRIBUTES_SIZE, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);
> +	if (ret < 3 || lamps->buf[0] != LAMPARRAY_ATTRIBUTES_ID) {
> +		hid_err(hdev, "can't read the LampArray attributes: %d\n", ret);
> +		ret = ret < 0 ? ret : -EIO;
> +		goto err_stop;
> +	}
> +	lamps->lamp_count = get_unaligned_le16(&lamps->buf[1]);
> +	if (!lamps->lamp_count) {
> +		ret = -ENODEV;
> +		goto err_stop;
> +	}
> +	hid_info(hdev, "LampArray with %u lamps\n", lamps->lamp_count);
> +
> +	mutex_lock(&legion_pair_lock);
> +	list_add(&lamps->node, &legion_lamps_list);
> +	list_for_each_entry(kbd, &legion_kbds, node) {
> +		if (kbd->bus == lamps->bus && !kbd->lamps) {
> +			kbd->lamps = lamps;
> +			lamps->kbd = kbd;
> +			hid_info(hdev, "paired with %s\n", dev_name(&kbd->hdev->dev));
> +			if (kbd->color_set)
> +				legion_apply_color(kbd);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return 0;
> +
> +err_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}
> +
> +static void legion_lamps_remove(struct hid_device *hdev)
> +{
> +	struct legion_lamps *lamps = hid_get_drvdata(hdev);
> +
> +	mutex_lock(&legion_pair_lock);
> +	if (lamps->kbd) {
> +		if (lamps->kbd->lamparray_owns)
> +			lamps_set_autonomous(lamps, true);
> +		lamps->kbd->lamps = NULL;
> +	}
> +	list_del(&lamps->node);
> +	mutex_unlock(&legion_pair_lock);
> +
> +	hid_hw_stop(hdev);
> +}
> +
> +/* Resumed after a USB reset: the LampArray is back in autonomous mode. */
> +static int legion_reset_resume(struct hid_device *hdev)
> +{
> +	struct legion_lamps *lamps = hid_get_drvdata(hdev);
> +
> +	if (hdev->product != USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_LAMPS || !lamps)
> +		return 0;
> +
> +	mutex_lock(&legion_pair_lock);
> +	if (lamps->kbd && lamps->kbd->lamparray_owns)
> +		lamps_set_color(lamps, lamps->kbd->rgb);
> +	mutex_unlock(&legion_pair_lock);
> +
> +	return 0;
> +}
> +
> +static bool legion_is_lamparray(struct hid_device *hdev)
> +{
> +	return hdev->maxcollection > 0 &&
> +	       hdev->collection[0].usage == LAMPARRAY_USAGE;
> +}
> +
> +static int legion_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	if (!hid_is_usb(hdev))
> +		return -ENODEV;
> +
> +	/* As hid-generic: one input device per application collection. */
> +	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
> +
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	if (id->product == USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD)
> +		return legion_kbd_probe(hdev);
> +
> +	if (legion_is_lamparray(hdev))
> +		return legion_lamps_probe(hdev);
> +
> +	/* Other interfaces of c193: exactly what hid-generic would do. */
> +	hid_set_drvdata(hdev, NULL);
> +	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +}
> +
> +static void legion_remove(struct hid_device *hdev)
> +{
> +	if (hdev->product == USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD)
> +		legion_kbd_remove(hdev);
> +	else if (hid_get_drvdata(hdev))
> +		legion_lamps_remove(hdev);
> +	else
> +		hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id legion_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_LAMPS) },
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
> +	.reset_resume = pm_ptr(legion_reset_resume),
> +};
> +module_hid_driver(legion_driver);
> +
> +MODULE_AUTHOR("Ciro Pedrini <ciro.pedrini@gmail.com>");
> +MODULE_DESCRIPTION("Keyboard lighting of Lenovo Legion laptops (2025)");
> +MODULE_LICENSE("GPL");
> 
> 

-- 
 i.

