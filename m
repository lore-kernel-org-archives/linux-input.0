From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 1/1] Input: don't modify the id of ioctl-provided ff
 effect on upload failure
Date: Sat, 15 Mar 2014 13:13:42 +0100
Message-ID: <CADbOyBR94rnzyeHgNhuMAj8YE-wenLeT4Gisq=dMzw8K0mYzZg@mail.gmail.com>
References: <CADbOyBTf4fWhUveA7UgCP4EpLXAyrZCV-xs-wZ7HGyBwxhQFhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:49607 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbaCOMNn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 08:13:43 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so3945138veb.10
        for <linux-input@vger.kernel.org>; Sat, 15 Mar 2014 05:13:43 -0700 (PDT)
In-Reply-To: <CADbOyBTf4fWhUveA7UgCP4EpLXAyrZCV-xs-wZ7HGyBwxhQFhg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org, =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>

On Sun, Feb 23, 2014 at 3:18 PM, Elias Vanderstuyft <elias.vds@gmail.com> wrote:
> From: Elias Vanderstuyft <elias.vds@gmail.com>
>
> If a new (id == -1) ff effect was uploaded from userspace,
> ff-core.c::input_ff_upload() will have assigned
> a positive number to the new effect id.
> Currently, evdev.c::evdev_do_ioctl() will save this new id to userspace,
> regardless of whether the upload succeeded or not.
>
> On upload failure, this can be confusing because the dev->ff->effects[] array
> will not contain an element at the index of that new effect id.
>
> Note: Unfortunately applications should still expect changed effect id for
> quite some time.
>
> This has been discussed on:
> http://www.mail-archive.com/linux-input@vger.kernel.org/msg08513.html
> ("ff-core effect id handling in case of a failed effect upload")
>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Elias Vanderstuyft <elias.vds@gmail.com>
> ---
>  drivers/input/evdev.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/drivers/input/evdev.c     2014-02-23 14:21:19.980606615 +0100
> +++ b/drivers/input/evdev.c     2014-02-23 14:25:04.417118859 +0100
> @@ -954,11 +954,13 @@ static long evdev_do_ioctl(struct file *
>                         return -EFAULT;
>
>                 error = input_ff_upload(dev, &effect, file);
> +               if (error)
> +                       return error;
>
>                 if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
>                         return -EFAULT;
>
> -               return error;
> +               return 0;
>         }
>
>         /* Multi-number variable-length handlers */

This is a reminder that there have been no replies on this subject for
the last 3 weeks.
If there is something wrong with the format of this patch, please tell
me, I tried to follow the instructions on
http://www.kernel.org/doc/Documentation/SubmittingPatches , but it's
the first time I send a patch by myself, so I might have forgotten
something.
Did I forget to CC some people?

The reason I'm insisting on this, is because this change will be
perceivable to userspace developers, and the sooner this gets applied,
the less userland applications will have to circumvent this bug.


Best regards,

Elias
