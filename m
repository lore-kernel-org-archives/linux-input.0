From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: wacom: Report ABS_MISC event for Cintiq Companion Hybrid
Date: Thu, 22 Jan 2015 19:56:54 -0500
Message-ID: <CAN+gG=EyM4+z_5TM3Syv06PMfX9geE+CUMcj8bdumfjTrf+9Jg@mail.gmail.com>
References: <1421970808-4098-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36678 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbbAWA4z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 19:56:55 -0500
Received: by mail-qg0-f42.google.com with SMTP id q107so4074224qgd.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2015 16:56:54 -0800 (PST)
In-Reply-To: <1421970808-4098-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Jan 22, 2015 at 6:53 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> It appears that the Cintiq Companion Hybrid does not send an ABS_MISC
> event to userspace when any of its ExpressKeys are pressed. This is not
> strictly necessary now that the pad exists on its own device, but
> should be fixed for consistency's sake.
>
> Traditionally both the stylus and pad shared the same device node, and
> xf86-input-wacom would use ABS_MISC for disambiguation. Not sending this
> causes the Hybrid to behave incorrectly with xf86-input-wacom beginning with
> its 8f44f3 commit.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> Question: I'd like to write a version of this patch which targets stable
> releases where the stylus and pad share the device node. How would I go
> about submitting one, since CCing this patch to stable won't quite do the
> trick (the patches would have to be against our old home under
> drivers/input/tablet...)

IIRC, once this one hits linus tree, you send an adapted version of
the same patch which refers this one.
Just add the hash of the final patch in Linus tree, and mention in the
subject prefix which stable releases you are targeting.

See for an example http://thread.gmane.org/gmane.linux.kernel.stable/120947

>
>  drivers/hid/wacom_wac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index a4ba8ca..f886149 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -783,6 +783,12 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
>                         input_report_key(input, BTN_7, (data[4] & 0x40));  /* Left   */
>                         input_report_key(input, BTN_8, (data[4] & 0x80));  /* Down   */
>                         input_report_key(input, BTN_0, (data[3] & 0x01));  /* Center */
> +
> +                       if (data[4] | (data[3] & 0x01)) {
> +                               input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
> +                       } else {
> +                               input_report_abs(input, ABS_MISC, 0);
> +                       }

I am not 100% sure, but in my memories, the ABS_MISC event was sent
before any buttons.
But maybe not.

Anyway, this is Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>                 } else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
>                         int i;
>
> --
> 2.2.1
>
