From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom - Mark Intuos5 pad as in-prox when touching buttons
Date: Sat, 22 Sep 2012 11:35:18 -0500
Message-ID: <CAGzDe_Zg0ReoAP6hrqBSap2mUFoBW0tvxEC6SnuazcsCpvmuOQ@mail.gmail.com>
References: <1347665405-2078-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54663 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab2IVQfU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Sep 2012 12:35:20 -0400
Received: by lbbgj3 with SMTP id gj3so5115343lbb.19
        for <linux-input@vger.kernel.org>; Sat, 22 Sep 2012 09:35:19 -0700 (PDT)
In-Reply-To: <1347665405-2078-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, pinglinux@gmail.com

On Fri, Sep 14, 2012 at 6:30 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> If the ExpressKeys on the Intuos5 are touched, they currently result
> an out-of-prox packet being sent even if the pad is already out of
> prox. This can cause some confusion in the X driver. To restore the
> expected semantics, we make being touched a sufficient condition to
> signal proximity.

Seems like easiest solution to prevent invalid event sequencies.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

>
> https://bugs.freedesktop.org/show_bug.cgi?id=54250
>
> Reported-by: Timo Aaltonen <tjaalton@ubuntu.com>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 532d067..9317109 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -606,7 +606,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
>                                 input_report_abs(input, ABS_WHEEL, 0);
>                         }
>
> -                       if (data[2] | (data[3] & 0x01) | data[4]) {
> +                       if (data[2] | (data[3] & 0x01) | data[4] | data[5]) {
>                                 input_report_key(input, wacom->tool[1], 1);
>                                 input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
>                         } else {
> --
> 1.7.12
>
