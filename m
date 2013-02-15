From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 1/2] Input: MT - do not apply filtering on emulated events
Date: Fri, 15 Feb 2013 11:47:14 -0800
Message-ID: <CAGS+omCbbD2-gi+9oN74QFh+kskTOYPqwbOcPORRCCyhVdPiTw@mail.gmail.com>
References: <1360956981-1112-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62558 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab3BOTrf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 14:47:35 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so469213qaj.5
        for <linux-input@vger.kernel.org>; Fri, 15 Feb 2013 11:47:34 -0800 (PST)
In-Reply-To: <1360956981-1112-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 15, 2013 at 11:36 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> The pointer emulation events are derived from contact values that
> have already been filtered, so send the emulated events as is.
>
> Reported-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Hi Henrik,
Brilliant!  Glad there is now such an easy fix for this.

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  drivers/input/input-mt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index 1abbc17..1b7f4d4 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -18,6 +18,7 @@ static void copy_abs(struct input_dev *dev, unsigned int dst, unsigned int src)
>  {
>         if (dev->absinfo && test_bit(src, dev->absbit)) {
>                 dev->absinfo[dst] = dev->absinfo[src];
> +               dev->absinfo[dst].fuzz = 0;
>                 dev->absbit[BIT_WORD(dst)] |= BIT_MASK(dst);
>         }
>  }
> --
> 1.8.1.2
