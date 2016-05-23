From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom_w8001 - Ignore bogus idx values in interrupt
Date: Sun, 22 May 2016 22:21:45 -0700
Message-ID: <CAF8JNhLzEKmQ-D-o6TYkerJ+=PfLYdHKpB40yU3ohP=sp00ozQ@mail.gmail.com>
References: <1463967746-15336-1-git-send-email-christopherarges@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33654 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbcEWFWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 01:22:06 -0400
In-Reply-To: <1463967746-15336-1-git-send-email-christopherarges@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris J Arges <christopherarges@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Chris,

On Sun, May 22, 2016 at 6:42 PM, Chris J Arges
<christopherarges@gmail.com> wrote:
> I've noticed crashes when using my x60t using a coreboot bios. When using
> the pen I can produce a crash simply by tapping a few times. This
> generates an event which has an idx of 0xc. This in turn crashes the
> machine because the array access is greater than W8001_MAX_LENGTH. This
> patch checks for bogus values and filters them in order to prevent crashes.

Thank you for submitting a patch in addition to reporting the issue.

> Signed-off-by: Chris J Arges <christopherarges@gmail.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index bab3c6a..c858200 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -283,6 +283,15 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
>         unsigned char tmp;
>
>         w8001->data[w8001->idx] = data;
> +
> +       /* ignore bogus idx values */
> +       if (w8001->idx >= W8001_MAX_LENGTH) {
> +               pr_info("w8001: ignored interrupt: data 0x%02x idx %d\n", data,
> +                       w8001->idx);
> +               w8001->idx = 0;
> +               return IRQ_HANDLED;
> +       }
> +

I don't have an x60t system to test with. I wonder if your system
supports two finger touch or not. We at least have a bug in the code
since W8001_MAX_LENGTH should be 13 instead of 11. How come no one had
encountered that issue before?

I'm going to email a patch to the list. Please test it and let us know
your result. Maybe we still need your patch if your device doesn't
support two finger touch or the idx=0xc can't be fixed by
W8001_MAX_LENGTH=13.

Thanks,

Ping

>         switch (w8001->idx++) {
>         case 0:
>                 if ((data & W8001_LEAD_MASK) != W8001_LEAD_BYTE) {
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
