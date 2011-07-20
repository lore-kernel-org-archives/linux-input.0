From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: synaptics - set minimum coordinates as reported by firmware
Date: Wed, 20 Jul 2011 19:20:40 +0800
Message-ID: <CAGS+omBkpcVU29e4mK-HK838EiGhjbicuUkE8+yY2auQ01ZibQ@mail.gmail.com>
References: <20110707065705.GH7658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:41276 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1GTLVC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 07:21:02 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p6KBL1ZX023046
	for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 04:21:01 -0700
Received: from iym1 (iym1.prod.google.com [10.241.52.1])
	by wpaz29.hot.corp.google.com with ESMTP id p6KBK4VZ026786
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 04:21:00 -0700
Received: by iym1 with SMTP id 1so264579iym.1
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 04:21:00 -0700 (PDT)
In-Reply-To: <20110707065705.GH7658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Sorry, I fear I am too late, but...

On Thu, Jul 7, 2011 at 2:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Newer Synaptics firmware allows to query minimum coordinates reported=
 by
> the device, let's use this data.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/mouse/synaptics.c | =A0 56 +++++++++++++++++++++++++=
+-------------
> =A0drivers/input/mouse/synaptics.h | =A0 =A08 ++++--
> =A02 files changed, 43 insertions(+), 21 deletions(-)

[...snip...]

> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/sy=
naptics.h
> index b8025b0..a4394e1 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -19,7 +19,8 @@
> =A0#define SYN_QUE_RESOLUTION =A0 =A0 =A0 =A0 =A0 =A0 0x08
> =A0#define SYN_QUE_EXT_CAPAB =A0 =A0 =A0 =A0 =A0 =A0 =A00x09
> =A0#define SYN_QUE_EXT_CAPAB_0C =A0 =A0 =A0 =A0 =A0 0x0c
> -#define SYN_QUE_EXT_DIMENSIONS =A0 =A0 =A0 =A0 0x0d
> +#define SYN_QUE_EXT_MAX_COORDS =A0 =A0 =A0 =A0 0x0d
> +#define SYN_QUE_EXT_MIN_COORDS =A0 =A0 =A0 =A0 0x0f
>
> =A0/* synatics modes */
> =A0#define SYN_BIT_ABSOLUTE_MODE =A0 =A0 =A0 =A0 =A0(1 << 7)
> @@ -73,10 +74,12 @@
> =A0* 2 =A0 0x04 =A0 =A0reduced filtering =A0 =A0 =A0 firmware does le=
ss filtering on
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 position data, driver should watch
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 for noise.
> + * 2 =A0 0x20 =A0 =A0report min =A0 =A0 =A0 =A0 =A0 =A0 =A0query 0x0=
f gives min coord reported
> =A0*/
> =A0#define SYN_CAP_CLICKPAD(ex0c) =A0 =A0 =A0 =A0 ((ex0c) & 0x100000)=
 /* 1-button ClickPad */
> =A0#define SYN_CAP_CLICKPAD2BTN(ex0c) =A0 =A0 ((ex0c) & 0x000100) /* =
2-button ClickPad */
> =A0#define SYN_CAP_MAX_DIMENSIONS(ex0c) =A0 ((ex0c) & 0x020000)
> +#define SYN_CAP_MIN_DIMENSIONS(ex0c) =A0 ((ex0c) & 0x000200)

I believe "Byte 2, 0x20" is actually 0x002000, not 0x000200.
It would appear that the documentation is inconsistent with
implementation; and, the implementation conflicts with the heretofore
unused "deluxe LED controls" bit.

Thanks,
-Daniel

> =A0#define SYN_CAP_ADV_GESTURE(ex0c) =A0 =A0 =A0((ex0c) & 0x080000)
> =A0#define SYN_CAP_REDUCED_FILTERING(ex0c) =A0 =A0 =A0 =A0((ex0c) & 0=
x000400)
>
> @@ -134,7 +137,8 @@ struct synaptics_data {
> =A0 =A0 =A0 =A0unsigned long int ext_cap_0c; =A0 =A0 =A0 =A0 =A0 /* E=
xt Caps from 0x0c query */
> =A0 =A0 =A0 =A0unsigned long int identity; =A0 =A0 =A0 =A0 =A0 =A0 /*=
 Identification */
> =A0 =A0 =A0 =A0unsigned int x_res, y_res; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* X/Y resolution in units/mm */
> - =A0 =A0 =A0 unsigned int x_max, y_max; =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* Max dimensions (from FW) */
> + =A0 =A0 =A0 unsigned int x_max, y_max; =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* Max coordinates (from FW) */
> + =A0 =A0 =A0 unsigned int x_min, y_min; =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* Min coordinates (from FW) */
>
> =A0 =A0 =A0 =A0unsigned char pkt_type; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* packet type - old, new, etc */
> =A0 =A0 =A0 =A0unsigned char mode; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* current mode byte */
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
