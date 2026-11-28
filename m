Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795867655;
	b=ISFwQpaLERdqTzBhmDhFExhNKO6HxC9NIdXnjbhvWP1MerMHzczCA5OWUEeO8PKz2jg9
	 WQuGcj6asDSBSR5ZckyOfj5hH5dHMZVnbyS7CK0hGHuJtF6G/x1mvRbJC45diAiH2AdXd
	 95tE1I1eZvz7kerQweftq/LuNrvkMpn0Bq5CTd6ELmVJpf/rmprf+GGw+Som6q5Tg9Sb0
	 q8T7Cra7qCvHF2uR8CCQ0xbSkTkWfykkZrltygGx2yhQRlZ06PRfiri8IDwYsrLKW3GzC
	 GL8XNU28nWi0LZZEaVh0TTyRdluO5vMiShgULKyhUzFu3P3w5wJjK9gEMez3bOWdVzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867655;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=EfY77nMUd/XMRrZpdy8f9H1Yj7czG2fmNnfdOfTEh4A=;
	b=c5aD3NtoOWYhWaRU51C0iXFyZIzMqmDgwhGnotzjiTXs21Dbv/0gDW4HlRHjdC/qVUfp
	 Kx31i1pF/zRGfIkv+zzoDhbv4bc9O4gczU/PmbIYUvuXjEPVKUi9ySp1wj9QMWC9NepMb
	 kq5LZvlevkuNy+CQaSTGDDZ4p2ssLYI4Hnf8+9zR2wUrWrTGMqWRL7srer+noXFgf58En
	 7BtsjpRY936z6vp+IMqACvTmnEWd0Cv44YtRCrXoZXWF63S+QqzWVLom2oLkSZJCqhl3D
	 NM01GTKQFCSbiZ5FiGea0stcjov8V3uNpM08bFpLXhknY/EDKPunrWMJN6ThUHDll1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Lh6857Yw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA58606A31C;
	Sat, 28 Nov 2026 12:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=Lh6857Yw
ARC-Seal: i=1; a=rsa-sha256; t=1795867638; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h8JqIeVeUdIxnajW+PoP1/fgsxkRVOnptaU2i1dzjTjkCQsGd/19QRSKlHlreY1rlW3Fc1xfBzL2DpshSLlxX26nQ0V3dHa7TeUAbFjxMysNhNs1uMQTv/Svn8Dv8Bk7h0elkPDzkeonx+eqbouW1NLuBDvovvEHoKlH/7rxvDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795867638; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EfY77nMUd/XMRrZpdy8f9H1Yj7czG2fmNnfdOfTEh4A=; 
	b=AdRUKZLfG+pegqQGHdTN6Mrrq4dqaqUijEEeXpctjK/+rV+KSPGi2GtVdVdAOTUoqVUuUHTQe5Fyd2Rn260RS6GKmFuY+J/eKArzAqUlnZNbXnptkSl47Z4dbSh6jeQv7DIVDjE+AkuDe+sKV9FO5x+ZiWG3Ms/FAKrlcNrghiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=Lh6857YwkqpiHZcjCTepz2Fzr9AZuqv8nuqkQsfvJd3a43sFNnccuMGfi0ixaPDASIt4xUnM7y5wc9pOMCIAVxZZxKjoxiEb0oX/0ypPJufAUEDsgaz0OGlZGDMYcovJo0wmlyJL6PWm3yt8p76zOnCPSd4ORgvNOPFiiGTQLM8cw0hfavJQSMNJs6tuQCGwnhRoMSPXsccNpAksdcBCM4ulCDUrTBY5SKsiMeGOtJ9C4IZ+1Zi1yxpTRV1AOL5P2hn90WEIAhlZkv2555KEhVHnRC5gtTX9Mwk9aGbxq9IIkhosTRckMHaP5zdGqtLKXY32mrPbEjpYrTJEl3obrQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=EfY77nMUd/XMRrZpdy8f9H1Yj7czG2fmNnfdOfTEh4A=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795867635726937.8721215312081;
	Sat, 28 Nov 2026 04:07:15 -0800 (PST)
Message-ID: <cf6c5f79994e9b1aaa3aca7aac81b00581e89990.camel@rong.moe>
Subject: Re: [PATCH v3 2/2] HID: lenovo-legion: Add keyboard backlight
 driver for Legion Gen 10
From: Rong Zhang <i@rong.moe>
To: ciro.pedrini@gmail.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: David Cemin <dcemin@nvidia.com>, Werner Sembach
 <wse@tuxedocomputers.com>,  Aaron Erhardt <aer@tuxedocomputers.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
In-Reply-To: <20261127-legion-lighting-rfc-v3-2-15c55d9f15b7@gmail.com>
References: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
		 <20261127-legion-lighting-rfc-v3-2-15c55d9f15b7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 20:01:03 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-4 
X-ZohoMailClient: External

Hi Ciro,

Thanks for working on this. I believe we are on the right way, but I
still have several concerns.

On Fri, 2026-11-27 at 01:11 +0000, Ciro Pedrini via B4 Relay wrote:
> From: Ciro Pedrini <ciro.pedrini@gmail.com>
>=20
> The keyboard backlight of the Lenovo Legion Pro 7 16IAX10H (2025) has no
> Linux support: on the test unit nothing ever lit, because the keyboard
> controller's brightness was 0 from the factory and nothing exposes it.
>=20
> The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard and
> carries a vendor protocol on feature report 0x07 (up to 960 bytes): a
> request, answered by reading the report back. Its hardware brightness,
> 0..9, is stored in the controller and applies to every LED of the machine
> (keys, front strip, rear vents, lid logo). The firmware handles Fn+Up and
> Fn+Down itself and reports the new level on vendor input report 5; it
> reports every other set there too, the host's and unchanged ones
> included.
>=20
> Expose the brightness as a kbd_backlight LED, legion::kbd_backlight, with
> brightness_hw_changed for the hotkeys so that desktops show their OSD.
> Only a change of the level is reported there, so the host's own sets and
> Fn+Space, which come back with the level already known, are not.
> Unregistering keeps the level (LED_RETAIN_AT_SHUTDOWN): switching it off
> would be stored by the controller.
>=20
> The colours stay the controller's own effects, which Fn+Space cycles. The
> machine's HID LampArray (048d:c193) is left to hid-generic, or to a
> generic LampArray driver.
>=20
> Tested on the 16IAX10H (83F5) with 7.3 as a module: brightness from sysfs
> and KDE, the hotkeys with KDE's OSD, suspend/resume, unbinding and
> rebinding.
>=20
> Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
> ---
> Prepared with Claude Code (Claude Opus 5.5) from measurements on the
> laptop (usbmon captures) and analysis of the vendor's Windows software
> for interoperability; I reviewed and tested it.
> ---
>  MAINTAINERS                     |   1 +
>  drivers/hid/Kconfig             |  12 ++
>  drivers/hid/Makefile            |   1 +
>  drivers/hid/hid-ids.h           |   1 +
>  drivers/hid/hid-lenovo-legion.c | 293 ++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 308 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba7650cb86b0..6c622b50ac9b 100644
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
> index 2481bc01c435..336be96dcd66 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -652,6 +652,18 @@ config HID_LENOVO_GO_S
>  =09S. Say M here to compile this driver as a module. The module will be =
called
>  =09hid-lenovo-go-s.
> =20
> +config HID_LENOVO_LEGION
> +=09tristate "Lenovo Legion laptop keyboard backlight"
> +=09depends on USB_HID
> +=09depends on LEDS_CLASS
> +=09help
> +=09Support for the LEDs of some Lenovo Legion laptops since 2025, with
> +=09the brightness changes initiated by predefined shortcuts (e.g.,
> +=09Fn+Up/Down) reported via brightness_hw_changed.
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
> index 000000000000..cfd42c52500f
> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-legion.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID driver for the keyboard backlight of Lenovo Legion laptops.
> + *
> + * The ITE 8258 keyboard controller (048d:c197) is the built-in keyboard=
 and
> + * carries Lenovo's vendor lighting protocol on feature report 0x07 (up =
to
> + * 960 bytes): a request (struct legion_msg), answered by reading the re=
port
> + * back with a GET_FEATURE. Requests and answers may be shorter than the
> + * report; the answer is ready as soon as the request has been sent.
> + *
> + * The backlight brightness is op 0xCE (set) / 0xCD (get), 0..9, stored =
in the
> + * controller; it applies to every LED of the machine (keys, front strip=
, rear
> + * vents, lid logo). The firmware handles Fn+Up / Fn+Down itself and rep=
orts
> + * the new level on vendor input report 5 (struct legion_event). It repo=
rts
> + * every other set the same way, also the host's and unchanged levels.
> + *
> + * The colours are the controller's own effects. The LEDs can also be ha=
nded
> + * to the HID LampArray of the "Lenovo Lighting" device (048d:c193), whi=
ch
> + * this driver leaves to others.
> + */
> +
> +#include <linux/build_bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/leds.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include <asm/byteorder.h>
> +#include <asm/rwonce.h>
> +
> +#include "hid-ids.h"
> +
> +#define LEGION_REPORT_ID=09=090x07
> +
> +#define LEGION_OP_GET_BRIGHTNESS=090xcd
> +#define LEGION_OP_SET_BRIGHTNESS=090xce
> +#define LEGION_MAX_BRIGHTNESS=09=099
> +
> +#define LEGION_EVENT_REPORT_ID=09=090x05
> +#define LEGION_EVENT_BRIGHTNESS=09=090x02=09/* set by the host, Fn+Up, F=
n+Space */
> +#define LEGION_EVENT_BRIGHTNESS_DOWN=090x03=09/* Fn+Down */
> +
> +/* Request, and its answer: the value is params[0]. */
> +struct legion_msg {
> +=09u8 report_id;
> +=09u8 op;
> +=09__le16 len;=09=09=09/* of params */
> +=09u8 params[];
> +} __packed;
> +
> +#define LEGION_REPORT_PARAM_SIZE=09956
> +#define LEGION_REPORT_SIZE=09=09960
> +static_assert(struct_size_t(struct legion_msg, params, LEGION_REPORT_PAR=
AM_SIZE) =3D=3D
> +=09      LEGION_REPORT_SIZE);
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
> +=09struct led_classdev led;
> +=09u8 level;=09=09=09/* last level set, read or reported */
> +};
> +
> +/*
> + * Send one request. When @answer is non-NULL, read the controller's ans=
wer
> + * and return its value there.
> + */
> +static int legion_raw_command(struct legion_kbd *kbd, u8 op, const u8 *p=
arams,
> +=09=09=09      size_t len, u8 *answer)
> +{
> +=09size_t get_size =3D struct_size_t(struct legion_msg, params, 1);
> +=09size_t set_size =3D struct_size_t(struct legion_msg, params, len);
> +=09struct hid_device *hdev =3D kbd->hdev;
> +=09int ret;
> +
> +=09if (len > LEGION_REPORT_PARAM_SIZE)
> +=09=09return -EINVAL;
> +
> +=09/* Not on the stack: usbhid passes the buffer to the USB core for DMA=
. */

Whoops, missed that.

> +=09struct legion_msg *msg __free(kfree) =3D
> +=09=09kzalloc_flex(*msg, params, max(len, 1));
> +=09if (!msg)
> +=09=09return -ENOMEM;
> +
> +=09msg->report_id =3D LEGION_REPORT_ID;
> +=09msg->op =3D op;
> +=09msg->len =3D cpu_to_le16(len);
> +=09memcpy(msg->params, params, len);
> +
> +=09guard(mutex)(&kbd->lock);

Since you need to serialize SET_REPORT and GET_REPORT anyway, we can use
a preallocated buffer as v2 did. Sorry for the confusion.

> +
> +=09ret =3D hid_hw_raw_request(hdev, LEGION_REPORT_ID, (u8 *)msg, set_siz=
e,
> +=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +=09if (ret < 0)
> +=09=09return ret;
> +=09if (!answer)
> +=09=09return 0;
> +
> +=09memset(msg, 0, get_size);

I am not sure why this is required.

> +=09ret =3D hid_hw_raw_request(hdev, LEGION_REPORT_ID, (u8 *)msg, get_siz=
e,
> +=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +=09if (ret < 0)
> +=09=09return ret;
> +=09if (ret < get_size || msg->report_id !=3D LEGION_REPORT_ID ||
> +=09    msg->op !=3D op) {
> +=09=09hid_dbg(hdev, "unexpected answer to 0x%02x\n", op);
> +=09=09return -EIO;
> +=09}
> +
> +=09*answer =3D msg->params[0];
> +=09return 0;
> +}
> +
> +static int legion_simple_command(struct legion_kbd *kbd, u8 op, u8 param=
,
> +=09=09=09=09 u8 *answer)
> +{
> +=09return legion_raw_command(kbd, op, &param, sizeof(param), answer);
> +}
> +
> +static int legion_brightness_set(struct led_classdev *led,
> +=09=09=09=09 enum led_brightness value)
> +{
> +=09struct legion_kbd *kbd =3D container_of(led, struct legion_kbd, led);
> +=09u8 old =3D READ_ONCE(kbd->level);
> +=09int ret;
> +
> +=09if (value > led->max_brightness)
> +=09=09return -EINVAL;
> +
> +=09/* Before sending: the report of this set may come before we return. =
*/
> +=09WRITE_ONCE(kbd->level, value);
> +=09ret =3D legion_simple_command(kbd, LEGION_OP_SET_BRIGHTNESS, value, N=
ULL);
> +=09if (ret)
> +=09=09WRITE_ONCE(kbd->level, old);

This is very fragile. Could you serialize legion_brightness_{set,get}()
and legion_raw_event() with kbd->lock, rather than deferring the
serialization to legion_raw_command()? Note that in this manner you'll
need to add a lockdep assertion to the latter.

Thanks,
Rong

> +
> +=09return ret;
> +}
> +
> +static enum led_brightness legion_brightness_get(struct led_classdev *le=
d)
> +{
> +=09struct legion_kbd *kbd =3D container_of(led, struct legion_kbd, led);
> +=09u8 value;
> +=09int ret;
> +
> +=09ret =3D legion_simple_command(kbd, LEGION_OP_GET_BRIGHTNESS, 0, &valu=
e);
> +=09if (ret) {
> +=09=09hid_dbg(kbd->hdev, "reading the brightness failed: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09if (value > led->max_brightness) {
> +=09=09hid_dbg(kbd->hdev, "brightness out of range: %u\n", value);
> +=09=09return -EIO;
> +=09}
> +
> +=09WRITE_ONCE(kbd->level, value);
> +=09return value;
> +}
> +
> +static int legion_raw_event(struct hid_device *hdev, struct hid_report *=
report,
> +=09=09=09    u8 *data, int size)
> +{
> +=09const struct legion_event *ev =3D (const struct legion_event *)data;
> +=09struct legion_kbd *kbd =3D hid_get_drvdata(hdev);
> +
> +=09if (size < sizeof(*ev) || ev->report_id !=3D LEGION_EVENT_REPORT_ID)
> +=09=09return 0;
> +
> +=09if (ev->event !=3D LEGION_EVENT_BRIGHTNESS &&
> +=09    ev->event !=3D LEGION_EVENT_BRIGHTNESS_DOWN)
> +=09=09return 0;
> +
> +=09if (ev->level > kbd->led.max_brightness) {
> +=09=09hid_dbg(hdev, "brightness event out of range: %u\n", ev->level);
> +=09=09return 0;
> +=09}
> +
> +=09/*
> +=09 * Only a change of the level is the hardware's own: the host's sets
> +=09 * and Fn+Space are reported too, with the level already known.
> +=09 */
> +=09if (ev->level =3D=3D READ_ONCE(kbd->level))
> +=09=09return 0;
> +=09WRITE_ONCE(kbd->level, ev->level);
> +
> +=09/*
> +=09 * hid-core calls this only after probe() has returned and not once
> +=09 * remove() has started, so the LED is registered.
> +=09 */
> +=09led_classdev_notify_brightness_hw_changed(&kbd->led, ev->level);
> +
> +=09return 0;=09/* let hid-core handle the report as usual */
> +}
> +
> +static void legion_stop(void *data)
> +{
> +=09struct hid_device *hdev =3D data;
> +
> +=09hid_hw_close(hdev);
> +=09hid_hw_stop(hdev);
> +}
> +
> +static int legion_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
> +=09struct legion_kbd *kbd;
> +=09int ret;
> +
> +=09/*
> +=09 * Keep the input devices hid-generic creates for this keyboard (whic=
h
> +=09 * sets the same quirk): without it the keyboard, its consumer keys a=
nd
> +=09 * its radio button would become one input device.
> +=09 */
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
> +=09if (ret) {
> +=09=09hid_hw_stop(hdev);
> +=09=09return ret;
> +=09}
> +
> +=09ret =3D devm_add_action_or_reset(&hdev->dev, legion_stop, hdev);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09kbd->led.name =3D "legion::kbd_backlight";
> +=09kbd->led.max_brightness =3D LEGION_MAX_BRIGHTNESS;
> +=09kbd->led.brightness_set_blocking =3D legion_brightness_set;
> +=09kbd->led.brightness_get =3D legion_brightness_get;
> +=09kbd->led.flags =3D LED_RETAIN_AT_SHUTDOWN | LED_BRIGHT_HW_CHANGED;
> +
> +=09return devm_led_classdev_register(&hdev->dev, &kbd->led);
> +}
> +
> +static void legion_remove(struct hid_device *hdev)
> +{
> +=09/*
> +=09 * Done via devm, the LED first. Without .remove, hid-core would stop
> +=09 * the device before releasing devm resources: before the LED is gone=
,
> +=09 * and twice.
> +=09 */
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
> +MODULE_DESCRIPTION("Keyboard backlight of Lenovo Legion laptops");
> +MODULE_LICENSE("GPL");
