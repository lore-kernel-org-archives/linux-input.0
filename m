From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v3] Input: evdev - add event-mask API
Date: Wed, 12 Nov 2014 13:41:34 +0100
Message-ID: <CANq1E4SGnOcPbKaUKzg4zVYSCE+TMJmrvDXPgAm2Gj=4Zu-PTA@mail.gmail.com>
References: <1415121143-1675-1-git-send-email-dh.herrmann@gmail.com>
	<20141112074020.GA4325@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:60165 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbaKLMlf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 07:41:35 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so3058468iga.2
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2014 04:41:35 -0800 (PST)
In-Reply-To: <20141112074020.GA4325@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

Hi

On Wed, Nov 12, 2014 at 8:40 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Tue, Nov 04, 2014 at 06:12:23PM +0100, David Herrmann wrote:
>> +static int bits_from_user(unsigned long *bits, unsigned int maxbit,
>> +                       unsigned int maxlen, const void __user *p, int compat)
>> +{
>> +     int len;
>> +
>> +#if IS_ENABLED(CONFIG_COMPAT)
>> +     if (compat)
>
> I think this can be written as:
>         if (IS_ENABLED(CONFIG_COMPAT) && compat)

BITS_TO_LONGS_COMPAT is only defined if CONFIG_COMPAT is. We'd rely on
compiler-optimizations (dead code elimination) if we'd do that change.
I'm not really fond of making -O0 compiles fail, but there're several
places in the kernel that do. Your call ;)

>> +             len = BITS_TO_LONGS_COMPAT(maxbit) * sizeof(compat_long_t);
>> +     else
>> +#endif
>> +             len = BITS_TO_LONGS(maxbit) * sizeof(long);
>> +
>> +     if (len > maxlen)
>> +             len = maxlen;
>> +
>> +#if IS_ENABLED(CONFIG_COMPAT) && defined(__BIG_ENDIAN)
>> +     if (compat) {
>> +             int i;
>> +
>> +             for (i = 0; i < len / sizeof(compat_long_t); i++)
>> +                     if (copy_from_user((compat_long_t *) bits +
>> +                                             i + 1 - ((i % 2) << 1),
>> +                                        (compat_long_t __user *) p + i,
>> +                                        sizeof(compat_long_t)))
>
> Unfortunately this is not quite enough, you need to also zero out the
> upper bits of the last partial if userspace did not supply multiple of
> 64 bits.
>
> Frankly, bitmask APIs that we have in input are god-awful on big endian:
> they do not work if usespace uses quantities less than long (or compat
> long). I think we'll have to enforce it in the code.

Right, I relied on the caller of bits_from_user() to initialize it to
zero and make it long-aligned. I can move it into that helper.

>> +             } else {
>> +                     /* fake mask with all bits set */
>> +                     out = (u8 __user*)codes;
>> +                     for (i = 0; i < min; ++i) {
>> +                             if (put_user((u8)0xff,  out + i))
>> +                                     return -EFAULT;
>
> I wonder if we should not replace this with access_ok() + straight
> memset instead of doing byte-by-byte copy.

I'm actually not very familiar with the details of copy_to_user().
That's why I went with put_user(). I can look into it, but if you know
it well, I am open for suggestions.

Thanks
David
