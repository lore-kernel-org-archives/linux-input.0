From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/4 v3] input: wacom - make sure touch_max is set for
 touch devices
Date: Fri, 15 Nov 2013 15:31:18 -0600
Message-ID: <CAGzDe_a_DAOE4m3fxzK-dsSogoDoMWX9zwwbmw7Gg_3Xp9bKQw@mail.gmail.com>
References: <1384545554-15472-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:41690 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab3KOVbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 16:31:20 -0500
Received: by mail-wg0-f47.google.com with SMTP id y10so3988845wgg.26
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 13:31:18 -0800 (PST)
In-Reply-To: <1384545554-15472-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <pingc@wacom.com>

On Fri, Nov 15, 2013 at 1:59 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Old single touch Tablet PCs do not have touch_max set at
> wacom_features. Since touch device at lease supports one
> finger, assign touch_max to 1 when touch usage is defined
> in its HID Descriptor and touch_max is not pre-defined.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

>
> Tested-by: Jason Gerecke <killertofu@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_sys.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index 8a90da1..3d71b60 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -304,7 +304,7 @@ static int wacom_parse_hid(struct usb_interface *intf,
>         struct usb_device *dev = interface_to_usbdev(intf);
>         char limit = 0;
>         /* result has to be defined as int for some devices */
> -       int result = 0;
> +       int result = 0, touch_max = 0;
>         int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0;
>         unsigned char *report;
>
> @@ -351,7 +351,8 @@ static int wacom_parse_hid(struct usb_interface *intf,
>                                 if (usage == WCM_DESKTOP) {
>                                         if (finger) {
>                                                 features->device_type = BTN_TOOL_FINGER;
> -
> +                                               /* touch device at least supports one touch point */
> +                                               touch_max = 1;
>                                                 switch (features->type) {
>                                                 case TABLETPC2FG:
>                                                         features->pktlen = WACOM_PKGLEN_TPC2FG;
> @@ -504,6 +505,8 @@ static int wacom_parse_hid(struct usb_interface *intf,
>         }
>
>   out:
> +       if (!features->touch_max && touch_max)
> +               features->touch_max = touch_max;
>         result = 0;
>         kfree(report);
>         return result;
> --
> 1.8.3.2
>
