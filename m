From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH v2] hid: Fix uninitialized variable "size" in hid-wiimote-debug
Date: Thu, 17 Jan 2013 22:07:46 +0100
Message-ID: <CANq1E4Q+1S+wZU=HOrJq+_CbbnzB++GJg_qgU=rb6K+Ozz23ZA@mail.gmail.com>
References: <1358456572-22851-1-git-send-email-sque@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:62838 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490Ab3AQVHr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 16:07:47 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so1176147eaa.8
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 13:07:46 -0800 (PST)
In-Reply-To: <1358456572-22851-1-git-send-email-sque@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Que <sque@chromium.org>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, msb@chromium.org

Hi Simon

On Thu, Jan 17, 2013 at 10:02 PM, Simon Que <sque@chromium.org> wrote:
> This variable is initialized conditionally, based on whether a wiimote
> call succeeds.  However, the logic is not obvious to the compiler so it
> throws a warning.  Eliminate the warning by initializing "size" to 0.
>
> The warning is:
> files/drivers/hid/hid-wiimote-debug.c:69:18: warning: 'size' may be used
> uninitialized in this function [-Wmaybe-uninitialized]

Thanks!

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

> Signed-off-by: Simon Que <sque@chromium.org>
> ---
>  drivers/hid/hid-wiimote-debug.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> index eec3291..90124ff 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -31,7 +31,7 @@ static ssize_t wiidebug_eeprom_read(struct file *f, char __user *u, size_t s,
>         unsigned long flags;
>         ssize_t ret;
>         char buf[16];
> -       __u16 size;
> +       __u16 size = 0;
>
>         if (s == 0)
>                 return -EINVAL;
> --
> 1.7.8.6
>
