From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: evdev - add event-mask API
Date: Tue, 11 Nov 2014 23:40:20 -0800
Message-ID: <20141112074020.GA4325@dtor-ws>
References: <1415121143-1675-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:56153 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaKLHkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 02:40:24 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl2so2472366igb.10
        for <linux-input@vger.kernel.org>; Tue, 11 Nov 2014 23:40:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1415121143-1675-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>

Hi David,

On Tue, Nov 04, 2014 at 06:12:23PM +0100, David Herrmann wrote:
> +static int bits_from_user(unsigned long *bits, unsigned int maxbit,
> +			  unsigned int maxlen, const void __user *p, int compat)
> +{
> +	int len;
> +
> +#if IS_ENABLED(CONFIG_COMPAT)
> +	if (compat)

I think this can be written as:
	if (IS_ENABLED(CONFIG_COMPAT) && compat)

> +		len = BITS_TO_LONGS_COMPAT(maxbit) * sizeof(compat_long_t);
> +	else
> +#endif
> +		len = BITS_TO_LONGS(maxbit) * sizeof(long);
> +
> +	if (len > maxlen)
> +		len = maxlen;
> +
> +#if IS_ENABLED(CONFIG_COMPAT) && defined(__BIG_ENDIAN)
> +	if (compat) {
> +		int i;
> +
> +		for (i = 0; i < len / sizeof(compat_long_t); i++)
> +			if (copy_from_user((compat_long_t *) bits +
> +						i + 1 - ((i % 2) << 1),
> +					   (compat_long_t __user *) p + i,
> +					   sizeof(compat_long_t)))

Unfortunately this is not quite enough, you need to also zero out the
upper bits of the last partial if userspace did not supply multiple of
64 bits.

Frankly, bitmask APIs that we have in input are god-awful on big endian:
they do not work if usespace uses quantities less than long (or compat
long). I think we'll have to enforce it in the code.

> +		} else {
> +			/* fake mask with all bits set */
> +			out = (u8 __user*)codes;
> +			for (i = 0; i < min; ++i) {
> +				if (put_user((u8)0xff,  out + i))
> +					return -EFAULT;

I wonder if we should not replace this with access_ok() + straight
memset instead of doing byte-by-byte copy.

Thanks.

-- 
Dmitry
