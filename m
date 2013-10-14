From: Will Tommy <tommywill2011@gmail.com>
Subject: Re: [PATCH v2 1/2] Add an additional argument for decode routine,
 change secondary device name
Date: Mon, 14 Oct 2013 13:50:52 +0800
Message-ID: <CA+F6ckOfK25hhCxcJ5JRbzt+o1BKYvOynB1DQkPY+RSZrp8KFw@mail.gmail.com>
References: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
	<1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
	<CAJiQ=7D9ZBKJcGgYT+3se92t2zn6nzJ8645CzWdB2xh1S60+nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:51569 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3JNFux (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Oct 2013 01:50:53 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so3090125eek.22
        for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 22:50:52 -0700 (PDT)
In-Reply-To: <CAJiQ=7D9ZBKJcGgYT+3se92t2zn6nzJ8645CzWdB2xh1S60+nQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, yunkang.tang@cn.alps.com, linux-input@vger.kernel.org, david turvene <dturvene@dahetral.com>

Hi Kevin,

Thanks for your carefully review. It's amazing !

> So, assuming x_bits == y_bits == 8, and both x_map and y_map are in
> the range 0x00..0xff:
>
> y_bitmap.* lies in the range 0..7
> x_bitmap.* lies in the range 1..8
>
> Is that correct, or is x_bitmap off by one?

Hmm, it seems a bug of algorithm. Both x_bitmay&y_bitmap's range should be 0..7.
I'll fix it.

> I suspect that this whole function could be simplified a bit.
>
> Would it be possible to use ffs() and fls() instead of loops?
>
> Just a personal preference, but if you calculated X first and then Y,
> it may require fewer temporary variables and the alps_palm_bitmap
> struct could be removed.

Thanks for your proposal. I'll re-write this function in next submission.

> > +        box_middle_x = (priv->x_max * (x_bitmap.start_bit + x_bitmap.end_bit)) /
> > +                (2 * (priv->x_bits - 1));
> > +        box_middle_y = (priv->y_max * (y_bitmap.start_bit + y_bitmap.end_bit)) /
> > +                (2 * (priv->y_bits - 1));
> These lines look a bit long - suggest running through checkpatch.pl
>

Yes, they're longer than 80. However, in order not to let code hard to
be understood,
I decided not to split them. Anyway, since this function would be
re-written, there
would be no problem.

> I assume start_bit and end_bit can never be negative, because the code
> that calculates e.g. x_map will populate at most bits 0..(x_bits-1)?

Do you mean it's not good to define start_bit & end_bit as "int" since they have
no chance to be negative ? Actually, "unsigned char" is much better.

> Suggest something like:
>
> f->y_map = palm_low & (BIT(priv->y_bits) - 1);

> Likewise, maybe use:
>
> f->x_map = (palm_low >> priv->y_bits) & (BIT(priv->x_bits) - 1);
>
> (but double-check my math first)

> Would it be cleaner to just use a u64 for the palm data, instead of
> splitting into low/high?  (If so you'll probably want to compile-test
> a 32-bit kernel.)

> Aside from this clause, alps_process_touchpad_packet_v5() is virtually
> identical to alps_process_touchpad_packet_v3().  It would be good to
> find a way to reuse more of the code.

Okay, I'll take your advice and check the behavior on both 32-bit and 64-bit.

> This is strictly optional, but adding a comment indicating typical
> values for num_x_electrode and num_y_electrode could aid in
> understanding the math.

That's a good idea! I'll add them.

Tommy
