Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399268;
	b=5Snd1eBQu1ywDuZ5E+vdVERXwY3NAFv1KUeMJqrTOfBIlsrI54DYKZ8TNSstUNYBIDcj
	 bb51fRChDU3f/Ek8Dny+O32VnlY3yXmUz5X9Xbj9lF4rKLRNwTnr5Ko5JZEswZnFLuykQ
	 rpl9G+r6urzcgd+KsDrvunYa7QGeV0oSewr+lrn4mVbDP3sSlRU3g1OLFVtycrhPeS0wW
	 oobVJdhhgrrQkTmG6KjGmRDUe3zfC62WnueSB6At589W8Jo71PkIa9ZtUfckbn9VX5gao
	 FJs67FcGlYyrLjbvCaE9gpu5s6mHDqEj/TS1oxzXC7XNAIEFQ17bRW4vuTPA+6XaBaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399268;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=linvlaNCCf5SRxkRFK7uD9eJnmWmUxVFfvuLb6bH3NI=;
	b=VGu+bkpMExKeriTmha+T+BZYqMfRbi8yD8OOqsu1SCDZ7YEUk1V7QzYc5IGndxh1eMic
	 URf8w+4P0/aXlpHoXvD3sqORf9COevFCmACkcdXYzdujsY6joXUn2aircOINhuTykihel
	 V82sOTa6yX30iCxnKr1iF3SIc4BenEWOKQHwvaeLwdwk+ghDW+xILQWxiPFTqrfRml9Bp
	 r2Hxgm0+3l6nSQjkNC+3BcEpCRfnZAGgRFj7QHtn9C/hQvMkge4NH3Dyv5yLqeoQisnjN
	 6COIU4IgVlTj2icX36H1R87ZmDkXOdO7Hcy9w+S0Pt06i9luX/ho4DAVKlf2e2MLGaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=VecoPJ+f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8C606A883;
	Wed, 11 Nov 2026 12:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA8C606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=VecoPJ+f
ARC-Seal: i=1; a=rsa-sha256; t=1794399253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MGqbIGbseewGVO46+ctMk3CQ1h4agdT9o7HTqhfAIQkMfIdkdqp1l3g8qRa0jHbkuWN3jB6Xb9bnpeh1AmKLXN6YeAOm7Oj7Ypl2gWgVkkKQ63c6muXoj4Kks+6NTMa/JDw0JofiCV967ZgzrmleVIHGDPrL9MN+5XJlGmeFWrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794399253; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=linvlaNCCf5SRxkRFK7uD9eJnmWmUxVFfvuLb6bH3NI=; 
	b=clf5VdU4zVqNt+UaJdytlL13GBvUF4l3Z1BZNCJNE6gpms/EqhdfGyGp6wliE62jxrIaGQwjY2qGL1nCXNtlIHLBm6D6pxoS0sdorThW0+dRlKIZDQSPoYnX7jlHgYnXVrRNJFFr3GBfPId4cKhf7cSBwJKP0bGRiG4ZM0HWGXo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=VecoPJ+fJDeqFX8v8IxSuZavHQVJoPMZUZtD90GVMVkzl9JMiqQlQyRp0+sZqjxEDms2+Jyh1PxhsoI9Cz+mV9wyIucxonWo8vd4mvzvxVD3d/q6peWbr5pug3c5XYXa5TQ7GeEaCuwesBmsyXDHggy6PazS3LG/4/xRUOV0EI03wHp+YvlVyTsxAZML8qzaCmhVKinkf3eQT1aVzVKbOWmLpnw4vPjHMyp6RrqOZKiKD0BCFdCAwQs3RGzFCt3hqizfGItF2OM5wsAYM5ihPxcLHCHSwZ3ZqtETUBga5iFuXC1ZZOu8VwvOZFquY/xc11j6eRZ7U644FtelUsfuIA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=linvlaNCCf5SRxkRFK7uD9eJnmWmUxVFfvuLb6bH3NI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794399251946685.9572231706311;
	Wed, 11 Nov 2026 04:14:11 -0800 (PST)
Message-ID: <9002537db845b7a0a900612fe3a4a3638f06cd37.camel@rong.moe>
Subject: Re: [PATCH v2 2/2] HID: lenovo-legion: Add keyboard backlight
 driver for Legion Gen 10
From: Rong Zhang <i@rong.moe>
To: ciro.pedrini@gmail.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt
	 <aer@tuxedocomputers.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com>
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
	 <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:09:33 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Ciro,

On Tue, 2026-11-10 at 20:29 +0000, Ciro Pedrini via B4 Relay wrote:
> From: Ciro Pedrini <ciro.pedrini@gmail.com>
>=20
> The keyboard backlight of the Lenovo Legion Pro 7 16IAX10H (2025) has no
> Linux support: on the test unit nothing ever lit, because the keyboard
> controller's brightness was 0 from the factory and nothing exposes it.
>=20
> The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard and
> carries a vendor protocol on feature report 0x07 (960 bytes): a request,
> answered by reading the report back once the controller has prepared it.
> Its hardware brightness, 0..9, is stored in the controller and applies to
> every LED of the machine (keys, front strip, rear vents, lid logo).
>=20

I don't know if it's appropriate to represent so many things with the
name "legion::kbd_backlight".

>  The
> firmware handles Fn+Up and Fn+Down itself and reports the new level on
> vendor input report 5.
>=20
> Expose the brightness as a kbd_backlight LED, legion::kbd_backlight, with
> brightness_hw_changed for the hotkeys so that desktops show their OSD.
> Unregistering keeps the level (LED_RETAIN_AT_SHUTDOWN): switching it off
> would be stored by the controller.
>=20
> The colours stay the controller's own effects, which Fn+Space cycles.=C2=
=A0
>=20

Just curious, can the software select which effect to use, or listen to
an event when Fn+Space is pressed?

> The
> machine's HID LampArray (048d:c193) is left to hid-generic, or to a
> generic LampArray driver.
>=20
> Tested on the 16IAX10H (83F5) with 7.2 as a module: brightness from sysfs
> and KDE, the hotkeys with KDE's OSD, suspend/resume, unbinding and
> rebinding, and a userspace LampArray client alongside the driver.
>=20
> Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
> ---
> Prepared with Claude Code (Claude Opus 5.5) from measurements on the
> laptop (usbmon captures) and analysis of the vendor's Windows software
> for interoperability; I reviewed and tested it.
> ---
>  MAINTAINERS                     |   1 +
>  drivers/hid/Kconfig             |  13 ++
>  drivers/hid/Makefile            |   1 +
>  drivers/hid/hid-ids.h           |   1 +
>  drivers/hid/hid-lenovo-legion.c | 261 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 277 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..843906a1f9d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15187,6 +15187,7 @@ F:=09Documentation/ABI/testing/sysfs-driver-hid-l=
enovo-go
>  F:=09Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>  F:=09drivers/hid/hid-lenovo-go-s.c
>  F:=09drivers/hid/hid-lenovo-go.c
> +F:=09drivers/hid/hid-lenovo-legion.c
>  F:=09drivers/hid/hid-lenovo.c
> =20
>  LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c435..55d25afddb69 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -652,6 +652,19 @@ config HID_LENOVO_GO_S
>  =09S. Say M here to compile this driver as a module. The module will be =
called
>  =09hid-lenovo-go-s.
> =20
> +config HID_LENOVO_LEGION
> +=09tristate "Lenovo Legion laptop keyboard backlight"
> +=09depends on USB_HID
> +=09depends on LEDS_CLASS
> +=09help
> +=09Support for the keyboard backlight of 2025 Lenovo Legion laptops
> +=09(Legion Pro 7 Gen 10): the hardware brightness of the ITE keyboard
> +=09controller as a kbd_backlight LED, with the Fn+Up/Down changes
> +=09reported to userspace.

Try not to mention too many hardware details in case it becomes
inapplicable for future devices. Instead, focus on the functionality. It
should be something like:

   Support for the LEDs of some Lenovo Legion laptops since 2025, with
   the brightness changes initiated by predefined shortcuts (e.g.,
   Fn+Up/Down) reported via brightness_hw_changed.

> +
> +=09Say M here to compile this driver as a module. The module will be cal=
led
> +=09hid-lenovo-legion.
> +
>  config HID_LETSKETCH
>  =09tristate "Letsketch WP9620N tablets"
>  =09depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 43a8eb0f389b..713bb1c89861 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_HID_LCPOWER)=09+=3D hid-lcpower.o
>  obj-$(CONFIG_HID_LENOVO)=09+=3D hid-lenovo.o
>  obj-$(CONFIG_HID_LENOVO_GO)=09+=3D hid-lenovo-go.o
>  obj-$(CONFIG_HID_LENOVO_GO_S)=09+=3D hid-lenovo-go-s.o
> +obj-$(CONFIG_HID_LENOVO_LEGION)=09+=3D hid-lenovo-legion.o
>  obj-$(CONFIG_HID_LETSKETCH)=09+=3D hid-letsketch.o
>  obj-$(CONFIG_HID_LOGITECH)=09+=3D hid-logitech.o
>  obj-$(CONFIG_HID_LOGITECH)=09+=3D hid-lg-g15.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 91319aa6516d..992b9b147e95 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -773,6 +773,7 @@
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
>  #define I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720=090x837a
>  #define USB_DEVICE_ID_ITE_LENOVO_YOGA900=090x8396
> +#define USB_DEVICE_ID_ITE_LENOVO_LEGION_GEN10_KBD=090xc197
>  #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD=090x8987
>  #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD=090x83db
>  #define USB_DEVICE_ID_ITE8595=09=090x8595
> diff --git a/drivers/hid/hid-lenovo-legion.c b/drivers/hid/hid-lenovo-leg=
ion.c
> new file mode 100644
> index 000000000000..6d0b4adc6f49
> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-legion.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID driver for the keyboard backlight of Lenovo Legion laptops (2025)=
.
> + *
> + * The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard=
 and
> + * carries Lenovo's vendor lighting protocol: feature report 0x07, 960 b=
ytes,
> + * a request (struct legion_msg) answered by reading the report back wit=
h a
> + * GET_FEATURE once the controller has prepared it (up to ~50 ms).
> + *
> + * The backlight brightness is op 0xCE (set) / 0xCD (get), 0..9, stored =
in the
> + * controller; it applies to every LED of the machine (keys, front strip=
, rear
> + * vents, lid logo). The firmware handles Fn+Up / Fn+Down itself and rep=
orts
> + * the new level on vendor input report 5 (struct legion_event).
> + *
> + * The colours are the controller's own effects. The LEDs can also be ha=
nded
> + * to the HID LampArray of the "Lenovo Lighting" device (048d:c193), whi=
ch
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
> +#define LEGION_REPORT_ID=09=090x07
> +#define LEGION_REPORT_SIZE=09=09960

Move it below struct legion_msg {}...

> +#define LEGION_ANSWER_DELAY_MS=09=09100
> +
> +#define LEGION_OP_GET_BRIGHTNESS=090xcd
> +#define LEGION_OP_SET_BRIGHTNESS=090xce
> +#define LEGION_MAX_BRIGHTNESS=09=099
> +
> +#define LEGION_EVENT_REPORT_ID=09=090x05
> +#define LEGION_EVENT_BRIGHTNESS_UP=090x02
> +#define LEGION_EVENT_BRIGHTNESS_DOWN=090x03
> +
> +/* Request, and its answer: the value is params[0]. */
> +struct legion_msg {
> +=09u8 report_id;
> +=09u8 op;
> +=09__le16 len;=09=09=09/* of params */
> +=09u8 params[];
> +} __packed;

#define LEGION_REPORT_PARAM_SIZE=09956
#define LEGION_REPORT_SIZE=09=09960

static_assert(struct_size_t(struct legion_msg, params, LEGION_REPORT_PARAM_=
SIZE) =3D=3D
=09      LEGION_REPORT_SIZE);

> +
> +struct legion_event {
> +=09u8 report_id;
> +=09u8 event;
> +=09u8 level;=09=09=09/* brightness after the change */
> +} __packed;
> +
> +struct legion_kbd {
> +=09struct hid_device *hdev;
> +=09struct mutex lock;=09=09/* one request/answer exchange at a time */
> +=09struct legion_msg *msg;=09=09/* LEGION_REPORT_SIZE, DMA-safe */
> +=09struct led_classdev led;
> +};
> +
> +/*
> + * Send one request. When @answer is non-NULL, wait for the controller t=
o
> + * prepare its answer and return its value there.
> + */
> +static int legion_exchange(struct legion_kbd *kbd, u8 op, const u8 *para=
ms,
> +=09=09=09   u16 len, u8 *answer)

Weird naming. Why not call it legion_raw_command()?

> +{
> +=09struct hid_device *hdev =3D kbd->hdev;
> +=09struct legion_msg *msg =3D kbd->msg;
> +=09int ret;
> +
> +=09lockdep_assert_held(&kbd->lock);

if (len > LEGION_REPORT_PARAM_SIZE)
=09...

> +
> +=09memset(msg, 0, LEGION_REPORT_SIZE);
> +=09msg->report_id =3D LEGION_REPORT_ID;
> +=09msg->op =3D op;
> +=09msg->len =3D cpu_to_le16(len);
> +=09memcpy(msg->params, params, len);
> +
> +=09ret =3D hid_hw_raw_request(hdev, LEGION_REPORT_ID, (u8 *)msg,
> +=09=09=09=09 LEGION_REPORT_SIZE, HID_FEATURE_REPORT,
> +=09=09=09=09 HID_REQ_SET_REPORT);

I wonder, what if we set the report with a short report size, say,
struct_size(msg, params, len)? Could the device handle it properly in
this case? If so, there is a chance that we don't need to sleep for 100ms
later (I guess the device is processing too much data, causing the
massive delay).

> +=09if (ret < 0)
> +=09=09return ret;
> +=09if (!answer)
> +=09=09return 0;
> +
> +=09msleep(LEGION_ANSWER_DELAY_MS);

What a cursed device! 100ms sounds quite horrible.

Fortunately this code path is unreachable in brightness_set_blocking(),
or else we could be in trouble (holding triggers_list_lock for too long)
when removing a trigger.

This is just my random thought. Nothing needs to be fixed here.

> +
> +=09memset(msg, 0, LEGION_REPORT_SIZE);
> +=09ret =3D hid_hw_raw_request(hdev, LEGION_REPORT_ID, (u8 *)msg,
> +=09=09=09=09 LEGION_REPORT_SIZE, HID_FEATURE_REPORT,
> +=09=09=09=09 HID_REQ_GET_REPORT);
> +=09if (ret < 0)
> +=09=09return ret;
> +=09if (ret <=3D (int)sizeof(*msg) || msg->report_id !=3D LEGION_REPORT_I=
D ||
> +=09    msg->op !=3D op) {
> +=09=09hid_warn(hdev, "unexpected answer to 0x%02x: %*ph\n", op,
> +=09=09=09 min(ret, 8), msg);
> +=09=09return -EIO;
> +=09}
> +
> +=09*answer =3D msg->params[0];

Ditto, what if we get the report with struct_size(msg, params, 1)?

> +=09return 0;
> +}

Since it's frequently used with len=3D=3D1, let's add a additional wrapper
like:

   static int legion_simple_command(struct legion_kbd *kbd, u8 op, u8 param=
, u8 *answer)

so that we can simplify the following code.

> +
> +static int legion_brightness_set(struct led_classdev *led,
> +=09=09=09=09 enum led_brightness value)
> +{
> +=09struct legion_kbd *kbd =3D container_of(led, struct legion_kbd, led);
> +=09u8 level =3D min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);

An insane value should cause -EINVAL. Why clamp it?

Besides, don't check LEGION_MAX_BRIGHTNESS, but check led->max_brightness
instead. The latter is scalable when adding support for other devices.

> +
> +=09guard(mutex)(&kbd->lock);
> +=09return legion_exchange(kbd, LEGION_OP_SET_BRIGHTNESS, &level,
> +=09=09=09       sizeof(level), NULL);
> +}
> +
> +static enum led_brightness legion_brightness_get(struct led_classdev *le=
d)
> +{
> +=09struct legion_kbd *kbd =3D container_of(led, struct legion_kbd, led);
> +=09u8 zero =3D 0, value;
> +=09int ret;
> +
> +=09guard(mutex)(&kbd->lock);
> +=09ret =3D legion_exchange(kbd, LEGION_OP_GET_BRIGHTNESS, &zero,
> +=09=09=09      sizeof(zero), &value);
> +=09if (ret)
> +=09=09return led->brightness;=09/* keep the last known level */

Please return the error as is. The LED core has already done the same
thing for you.

> +
> +=09return min_t(unsigned int, value, LEGION_MAX_BRIGHTNESS);

An insane value should cause an error, too.

Meanwhile, I'd prefer to add a dev_warn() when ret is an error or when
value is out of range, so that we can identify faulty devices.

> +}
> +
> +static int legion_raw_event(struct hid_device *hdev, struct hid_report *=
report,
> +=09=09=09    u8 *data, int size)
> +{
> +=09const struct legion_event *ev =3D (const struct legion_event *)data;
> +=09struct legion_kbd *kbd =3D hid_get_drvdata(hdev);
> +=09unsigned int level;
> +
> +=09if (size < (int)sizeof(*ev) || ev->report_id !=3D LEGION_EVENT_REPORT=
_ID)
> +=09=09return 0;
> +
> +=09if (ev->event !=3D LEGION_EVENT_BRIGHTNESS_UP &&
> +=09    ev->event !=3D LEGION_EVENT_BRIGHTNESS_DOWN)
> +=09=09return 0;
> +
> +=09/*
> +=09 * hid-core calls this only after probe() has returned and not once
> +=09 * remove() has started, so the LED is registered. The controller has
> +=09 * already changed the level: keep led_cdev.brightness in step with i=
t.
> +=09 */
> +=09level =3D min_t(unsigned int, ev->level, LEGION_MAX_BRIGHTNESS);

Don't clamp. Either ignore insane values silently or add a dev_warn(),
then return early.

> +=09WRITE_ONCE(kbd->led.brightness, level);

Usually this is needless as long as the driver provides brightness_get().

> +=09led_classdev_notify_brightness_hw_changed(&kbd->led, level);
> +
> +=09return 0;=09/* let hid-core handle the report as usual */
> +}
> +
> +static int legion_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
> +=09struct legion_kbd *kbd;
> +=09int ret;
> +
> +=09/* As hid-generic: one input device per application collection. */

Typical LLM tautology. Please explain why the driver needs this instead
of repeating what the flag does.

> +=09hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> +
> +=09ret =3D hid_parse(hdev);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09kbd =3D devm_kzalloc_obj(&hdev->dev, *kbd);
> +=09if (!kbd)
> +=09=09return -ENOMEM;
> +
> +=09kbd->msg =3D devm_kzalloc(&hdev->dev, LEGION_REPORT_SIZE, GFP_KERNEL)=
;
> +=09if (!kbd->msg)
> +=09=09return -ENOMEM;
> +
> +=09ret =3D devm_mutex_init(&hdev->dev, &kbd->lock);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09kbd->hdev =3D hdev;
> +=09hid_set_drvdata(hdev, kbd);
> +
> +=09ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Keep the interrupt endpoint polled so hotkey reports always arrive=
. */
> +=09ret =3D hid_hw_open(hdev);
> +=09if (ret)
> +=09=09goto err_stop;
> +
> +=09kbd->led.name =3D "legion::kbd_backlight";
> +=09kbd->led.max_brightness =3D LEGION_MAX_BRIGHTNESS;
> +=09kbd->led.brightness_set_blocking =3D legion_brightness_set;
> +=09kbd->led.brightness_get =3D legion_brightness_get;
> +=09/*
> +=09 * LED_RETAIN_AT_SHUTDOWN: unregistering (unload, unbind) must not
> +=09 * switch the backlight off, the controller would store 0.
> +=09 * LED_BRIGHT_HW_CHANGED: Fn+Up/Down are reported to userspace.
> +=09 */

Usually you don't need the comment. The intent is very obvious.

> +=09kbd->led.flags =3D LED_RETAIN_AT_SHUTDOWN | LED_BRIGHT_HW_CHANGED;
> +
> +=09/*
> +=09 * Not devm: the LED must be gone before remove() stops the device,
> +=09 * devm would release it only after that.
> +=09 */

Why? The comment doesn't answer anything at all.

A lot of HID drivers have been using devm to manage LEDs for long, and
there are also some drivers manually call led_classdev_unregister() after
hid_hw_stop().

> +=09ret =3D led_classdev_register(&hdev->dev, &kbd->led);
> +=09if (ret)
> +=09=09goto err_close;
> +
> +=09return 0;
> +
> +err_close:
> +=09hid_hw_close(hdev);
> +err_stop:
> +=09hid_hw_stop(hdev);
> +=09return ret;
> +}
> +
> +static void legion_remove(struct hid_device *hdev)
> +{
> +=09struct legion_kbd *kbd =3D hid_get_drvdata(hdev);
> +
> +=09/* hid-core no longer calls legion_raw_event(): the LED can go. */
> +=09led_classdev_unregister(&kbd->led);
> +=09hid_hw_close(hdev);
> +=09hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id legion_devices[] =3D {
> +=09{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_LENOVO_LEGION_G=
EN10_KBD) },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(hid, legion_devices);
> +
> +static struct hid_driver legion_driver =3D {
> +=09.name =3D "hid-lenovo-legion",
> +=09.id_table =3D legion_devices,
> +=09.probe =3D legion_probe,
> +=09.remove =3D legion_remove,
> +=09.raw_event =3D legion_raw_event,
> +};
> +module_hid_driver(legion_driver);
> +
> +MODULE_AUTHOR("Ciro Pedrini <ciro.pedrini@gmail.com>");
> +MODULE_DESCRIPTION("Keyboard backlight of Lenovo Legion laptops (2025)")=
;

s/ (2025)//

Thanks,
Rong

> +MODULE_LICENSE("GPL");
