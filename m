From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Sun, 25 Oct 2015 14:01:03 -0700
Message-ID: <20151025210103.GA30741@dtor-pixel>
References: <1441296841-16894-1-git-send-email-dh.herrmann@gmail.com>
 <20151025001709.GA27533@dtor-pixel>
 <CANq1E4QAzg5hAstqLv3tr5pmwB_Gm_UA31mJ8m0tQGwFiH8AuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35537 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbJYVBK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2015 17:01:10 -0400
Received: by pasz6 with SMTP id z6so166413075pas.2
        for <linux-input@vger.kernel.org>; Sun, 25 Oct 2015 14:01:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4QAzg5hAstqLv3tr5pmwB_Gm_UA31mJ8m0tQGwFiH8AuA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Sun, Oct 25, 2015 at 10:00:17AM +0100, David Herrmann wrote:
> Hi
> 
> On Sun, Oct 25, 2015 at 2:17 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi David,
> >
> > On Thu, Sep 03, 2015 at 06:14:01PM +0200, David Herrmann wrote:
> >> +static int bits_from_user(unsigned long *bits, unsigned int maxbit,
> >> +                       unsigned int maxlen, const void __user *p, int compat)
> >> +{
> >> +     int len;
> >> +
> >> +#if IS_ENABLED(CONFIG_COMPAT)
> >> +     if (compat) {
> >> +             if (maxlen % sizeof(compat_long_t))
> >> +                     return -EINVAL;
> >> +             len = BITS_TO_LONGS_COMPAT(maxbit) * sizeof(compat_long_t);
> >> +     } else
> >> +#endif
> >> +     {
> >> +             if (maxlen % sizeof(long))
> >> +                     return -EINVAL;
> >> +             len = BITS_TO_LONGS(maxbit) * sizeof(long);
> >> +     }
> >> +
> >> +     if (len > maxlen)
> >> +             len = maxlen;
> >> +
> >> +#if IS_ENABLED(CONFIG_COMPAT) && defined(__BIG_ENDIAN)
> >> +     if (compat) {
> >> +             int i;
> >> +
> >> +             for (i = 0; i < len / sizeof(compat_long_t); i++)
> >> +                     if (copy_from_user((compat_long_t *) bits +
> >> +                                             i + 1 - ((i % 2) << 1),
> >> +                                        (compat_long_t __user *) p + i,
> >> +                                        sizeof(compat_long_t)))
> >> +                             return -EFAULT;
> >> +             if (i % 2)
> >> +                     *((compat_long_t *) bits + i - 1) = 0;
> >> +     } else
> >> +#endif
> >> +             if (copy_from_user(bits, p, len))
> >> +                     return -EFAULT;
> >> +
> >> +     return len;
> >> +}
> >
> > I do not quite like how we sprinkle ifdefs throughout, I prefer the way
> > we have bits_to_user defined, even if it is more verbose.
> 
> Makes sense.
> 
> >> +
> >>  static int str_to_user(const char *str, unsigned int maxlen, void __user *p)
> >>  {
> >>       int len;
> >> @@ -854,6 +953,86 @@ static int evdev_revoke(struct evdev *evdev, struct evdev_client *client,
> >>       return 0;
> >>  }
> >>
> >> +/* must be called with evdev-mutex held */
> >> +static int evdev_set_mask(struct evdev_client *client,
> >> +                       unsigned int type,
> >> +                       const void __user *codes,
> >> +                       u32 codes_size,
> >> +                       int compat)
> >> +{
> >> +     unsigned long flags, *mask, *oldmask;
> >> +     size_t cnt, size, min;
> >> +     int error;
> >> +
> >> +     /* we allow unknown types and 'codes_size > size' for forward-compat */
> >> +     cnt = evdev_get_mask_cnt(type);
> >> +     if (!cnt)
> >> +             return 0;
> >> +
> >> +     size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
> >> +     min = min_t(size_t, codes_size, size);
> >> +
> >> +     mask = kzalloc(size, GFP_KERNEL);
> >> +     if (!mask)
> >> +             return -ENOMEM;
> >> +
> >> +     error = bits_from_user(mask, cnt - 1, min, codes, compat);
> >
> > I do not think we need to calculate and pass min here: bits_from_user()
> > will limit the output for us already.
> >
> > Does it still work if you apply the patch below?
> 
> One comment on void*-arithmetic below. Otherwise, this is reviewed and
> tested by me.

Yeah, I am not concerned about using this extension - it is used in
kernel quite often I think and it actually makes sense to me.

Thank you for giving it a spin, I'll fold into original patch and apply.

-- 
Dmitry
