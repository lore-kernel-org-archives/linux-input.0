From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] uhid: Pad short UHID_CREATE writes from compat tasks
Date: Tue, 26 Nov 2013 13:45:54 +0100
Message-ID: <CANq1E4SaeEYx+mH+rD8_TPbc3zUBSUTw5KNmpZi9+vaYZdERrw@mail.gmail.com>
References: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46423 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3KZMp6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 07:45:58 -0500
Received: by mail-la0-f46.google.com with SMTP id eh20so4140345lab.19
        for <linux-input@vger.kernel.org>; Tue, 26 Nov 2013 04:45:54 -0800 (PST)
In-Reply-To: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: David Herrmann <dh.herrmann@googlemail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Tue, Nov 26, 2013 at 8:02 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> Short event writes are normally padded with zeroes, but the compat
> fixup for UHID_CREATE didn't ensure this.  This appears to allow an
> information leak.
>
> Compile-tested only.
>
> Fixes: befde0226a59 ('HID: uhid: make creating devices work on 64/32 systems')
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: stable@vger.kernel.org
> ---
> I have no familiarity with uhid so I haven't written a test for this.
> It looks like it would be possible to write a UHID_CREATE event that
> only covers fields up to rd_size, and the following data on the heap
> would be copied to the HID device metadata and be readable that way.
>
> Ben.
>
>  drivers/hid/uhid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 5bf2fb7..579a7115 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -298,6 +298,9 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
>                                 kfree(compat);
>                                 return -EFAULT;
>                         }
> +                       if (len < sizeof(*compat))
> +                               memset((char *)buffer + len, 0,
> +                                      sizeof(*compat) - len);

This should be "compat", not "buffer".

Anyhow, nice catch! But the better fix imho is to use kzalloc() for
the "compat" object. This isn't performance-critical and we can avoid
any other off-by-one bug or future conversion errors. And besides,
it's far easier to read than this memset().

Thanks
David

>                         /* Shuffle the data over to proper structure */
>                         event->type = type;
>
> --
> Ben Hutchings
> Usenet is essentially a HUGE group of people passing notes in class.
>                       - Rachel Kadel, `A Quick Guide to Newsgroup Etiquette'
