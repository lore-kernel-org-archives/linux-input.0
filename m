From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Add Wacom product id
Date: Tue, 28 Aug 2012 12:02:58 -0700
Message-ID: <CAF8JNhJW+H+YQM85TV6B6Cxwp594iONU3f-Y-2mcGBq8LTsrrw@mail.gmail.com>
References: <1346176298-3189-1-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37845 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab2H1TDA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Aug 2012 15:03:00 -0400
Received: by lbbgj3 with SMTP id gj3so3488970lbb.19
        for <linux-input@vger.kernel.org>; Tue, 28 Aug 2012 12:02:59 -0700 (PDT)
In-Reply-To: <1346176298-3189-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-input@vger.kernel.org

On Tue, Aug 28, 2012 at 10:51 AM, srinivas pandruvada
<srinivas.pandruvada@intel.com> wrote:
> Added 0x00EF as product id for the Wacom drivers.
>
> Change-Id: Iacdefbd317395309ecb7972f56413829a9c62e1f
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>

Hi Srinivas,

0xEF was added in June 12, 2012 along with 0xED. It is under Linus' kernel tree.

Ping

> ---
>  drivers/input/tablet/wacom_wac.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 58426d0..479dfa7 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1800,6 +1800,9 @@ static const struct wacom_features wacom_features_0xE6 =
>  static const struct wacom_features wacom_features_0xEC =
>         { "Wacom ISDv4 EC",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
>           0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0xEF =
> +       { "Wacom ISDv4 EF",       WACOM_PKGLEN_GRAPHIRE,  25710, 14500,  255,
> +         0, TABLETPC,    WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x47 =
>         { "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023,
>           31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> @@ -1973,6 +1976,7 @@ const struct usb_device_id wacom_ids[] = {
>         { USB_DEVICE_WACOM(0xE3) },
>         { USB_DEVICE_WACOM(0xE6) },
>         { USB_DEVICE_WACOM(0xEC) },
> +       { USB_DEVICE_WACOM(0xEF) },
>         { USB_DEVICE_WACOM(0x47) },
>         { USB_DEVICE_WACOM(0xF4) },
>         { USB_DEVICE_LENOVO(0x6004) },
> --
> 1.7.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
