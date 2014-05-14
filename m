From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/2] Input: wacom: Add support for 0x116 sensor on Win8
 Panasonic CF-H2
Date: Wed, 14 May 2014 11:27:27 -0700
Message-ID: <CAF8JNhLNR3STcRcQumUN1SchreX=kVPGA5BSpGm5PH15rMV9Pg@mail.gmail.com>
References: <1399685417-2063-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:63668 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaENS12 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 14:27:28 -0400
Received: by mail-la0-f54.google.com with SMTP id pv20so1732556lab.41
        for <linux-input@vger.kernel.org>; Wed, 14 May 2014 11:27:27 -0700 (PDT)
In-Reply-To: <1399685417-2063-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, May 9, 2014 at 6:30 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> The Win8 version of the Panasonic CF-H2 includes a new Wacom device.
> The pen interface appears to use the same protocol as before, but the
> touch interface has been tweaked to send Win8-compatible reports.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 8 ++++++++
>  drivers/input/tablet/wacom_wac.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index a4d8f1d..e4566c3 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1107,6 +1107,10 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
>                         prox = data[0] & 0x01;
>                         x = get_unaligned_le16(&data[1]);
>                         y = get_unaligned_le16(&data[3]);
> +               } else if (len == WACOM_PKGLEN_TPC1FG_B) {
> +                       prox = data[2] & 0x01;
> +                       x = le16_to_cpup((__le16 *)&data[3]);
> +                       y = le16_to_cpup((__le16 *)&data[5]);

Above two lines should use get_unaligned_le16() instead.
wacom_mt_touch() needs some cleanup too.

Except that, the whole patchset looks good to me.

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

>                 } else {
>                         prox = data[1] & 0x01;
>                         x = le16_to_cpup((__le16 *)&data[2]);
> @@ -2298,6 +2302,9 @@ static const struct wacom_features wacom_features_0x10E =
>  static const struct wacom_features wacom_features_0x10F =
>         { "Wacom ISDv4 10F",      WACOM_PKGLEN_MTTPC,     27760, 15694,  255,
>           0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0x116 =
> +       { "Wacom ISDv4 116",      WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
> +         0, TABLETPCE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x4001 =
>         { "Wacom ISDv4 4001",      WACOM_PKGLEN_MTTPC,     26202, 16325,  255,
>           0, MTTPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> @@ -2512,6 +2519,7 @@ const struct usb_device_id wacom_ids[] = {
>         { USB_DEVICE_WACOM(0x10D) },
>         { USB_DEVICE_WACOM(0x10E) },
>         { USB_DEVICE_WACOM(0x10F) },
> +       { USB_DEVICE_WACOM(0x116) },
>         { USB_DEVICE_WACOM(0x300) },
>         { USB_DEVICE_WACOM(0x301) },
>         { USB_DEVICE_DETAILED(0x302, USB_CLASS_HID, 0, 0) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index 9f947c3..adf73cb 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -22,6 +22,7 @@
>  #define WACOM_PKGLEN_BBFUN      9
>  #define WACOM_PKGLEN_INTUOS    10
>  #define WACOM_PKGLEN_TPC1FG     5
> +#define WACOM_PKGLEN_TPC1FG_B  10
>  #define WACOM_PKGLEN_TPC2FG    14
>  #define WACOM_PKGLEN_BBTOUCH   20
>  #define WACOM_PKGLEN_BBTOUCH3  64
> --
> 1.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
