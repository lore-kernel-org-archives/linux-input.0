From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 5/7] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Fri, 20 Feb 2015 10:04:04 -0500
Message-ID: <CAN+gG=HxwAA=f2a-vS6-voCRNQO-2pwnK64qz0L_b6-R2bScvQ@mail.gmail.com>
References: <1424443473.22910.17.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:46411 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbBTPEF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 10:04:05 -0500
In-Reply-To: <1424443473.22910.17.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Fri, Feb 20, 2015 at 9:44 AM, Bastien Nocera <hadess@hadess.net> wrote:
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  include/uapi/linux/input.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index b0a8130..affe40e 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -740,6 +740,16 @@ struct input_keymap_entry {
>  #define KEY_BRIGHTNESS_MIN             0x250   /* Set Brightness to Minimum */
>  #define KEY_BRIGHTNESS_MAX             0x251   /* Set Brightness to Maximum */
>
> +#define KEY_CLIPPING_TOOL              0x252   /* Screenshot clipping tool */
> +#define KEY_CLOUD                      0x253   /* Cloud Settings */
> +#define KEY_CAMERA_GESTURES            0x254   /* Toggle Camera gestures */
> +#define KEY_NEW_TAB                    0x255   /* Open a new tab */
> +#define KEY_MICUP                      0x256   /* Microphone Up */
> +#define KEY_MICDOWN                    0x257   /* Microphone Down */
> +#define KEY_MICCANCEL_MODE             0x258   /* Toggle Microphone cancellation mode */
> +#define KEY_CAMERA_ZOOM_MODE           0x259   /* Toggle camera zoom mode */
> +#define KEY_ROTATE_DISPLAY             0x25a   /* Rotate screen by 90 degrees */
> +

This one should be acked by Dmitry (in CC)

Cheers,
Benjamin

>  #define KEY_KBDINPUTASSIST_PREV                0x260
>  #define KEY_KBDINPUTASSIST_NEXT                0x261
>  #define KEY_KBDINPUTASSIST_PREVGROUP           0x262
> --
> 2.1.0
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe platform-driver-x86" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
