From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/7] input: atmel_mxt_ts: allow to read/display
 MXT_GEN_MESSAGE_T5 object
Date: Fri, 8 Feb 2013 15:45:34 -0800
Message-ID: <CAGS+omCPowRC0ut0vgzMZOwqjU3PmEkZznhUSdJE48bHq80b4w@mail.gmail.com>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net> <1360246668-2291-3-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:45813 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947349Ab3BHXp5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Feb 2013 18:45:57 -0500
Received: by mail-qe0-f53.google.com with SMTP id 1so1908888qee.40
        for <linux-input@vger.kernel.org>; Fri, 08 Feb 2013 15:45:56 -0800 (PST)
In-Reply-To: <1360246668-2291-3-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

On Thu, Feb 7, 2013 at 6:17 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>
> From: Peter Meerwald <p.meerwald@bct-electronic.com>

Hi Peter,

Hmm.  Why do you want to read T5?

We specifically removed T5 from the readble list in this patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=55d6867fe659f4783e57db7b2ae0bb04e4ac816e

T5 is the message processor object.  Reading it will only have two
outcomes, neither of which is particularly useful:
1) the message count decrements, and a valid message will be lost
2) an invalid message will be read (reportid == 0xff)

Thanks!
-Daniel

>
> Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> b/drivers/input/touchscreen/atmel_mxt_ts.c
> index fc52dc5..63a82bb 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -251,6 +251,7 @@ struct mxt_data {
>  static bool mxt_object_readable(unsigned int type)
>  {
>         switch (type) {
> +       case MXT_GEN_MESSAGE_T5:
>         case MXT_GEN_COMMAND_T6:
>         case MXT_GEN_POWER_T7:
>         case MXT_GEN_ACQUIRE_T8:
> --
> 1.7.9.5
>
