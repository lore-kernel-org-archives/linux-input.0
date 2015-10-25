From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Sat, 24 Oct 2015 17:17:09 -0700
Message-ID: <20151025001709.GA27533@dtor-pixel>
References: <1441296841-16894-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32786 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbbJYDKQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Oct 2015 23:10:16 -0400
Received: by qkcy65 with SMTP id y65so97073671qkc.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2015 20:10:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441296841-16894-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hi David,

On Thu, Sep 03, 2015 at 06:14:01PM +0200, David Herrmann wrote:
> +static int bits_from_user(unsigned long *bits, unsigned int maxbit,
> +			  unsigned int maxlen, const void __user *p, int compat)
> +{
> +	int len;
> +
> +#if IS_ENABLED(CONFIG_COMPAT)
> +	if (compat) {
> +		if (maxlen % sizeof(compat_long_t))
> +			return -EINVAL;
> +		len = BITS_TO_LONGS_COMPAT(maxbit) * sizeof(compat_long_t);
> +	} else
> +#endif
> +	{
> +		if (maxlen % sizeof(long))
> +			return -EINVAL;
> +		len = BITS_TO_LONGS(maxbit) * sizeof(long);
> +	}
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
> +				return -EFAULT;
> +		if (i % 2)
> +			*((compat_long_t *) bits + i - 1) = 0;
> +	} else
> +#endif
> +		if (copy_from_user(bits, p, len))
> +			return -EFAULT;
> +
> +	return len;
> +}

I do not quite like how we sprinkle ifdefs throughout, I prefer the way
we have bits_to_user defined, even if it is more verbose.


> +
>  static int str_to_user(const char *str, unsigned int maxlen, void __user *p)
>  {
>  	int len;
> @@ -854,6 +953,86 @@ static int evdev_revoke(struct evdev *evdev, struct evdev_client *client,
>  	return 0;
>  }
>  
> +/* must be called with evdev-mutex held */
> +static int evdev_set_mask(struct evdev_client *client,
> +			  unsigned int type,
> +			  const void __user *codes,
> +			  u32 codes_size,
> +			  int compat)
> +{
> +	unsigned long flags, *mask, *oldmask;
> +	size_t cnt, size, min;
> +	int error;
> +
> +	/* we allow unknown types and 'codes_size > size' for forward-compat */
> +	cnt = evdev_get_mask_cnt(type);
> +	if (!cnt)
> +		return 0;
> +
> +	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
> +	min = min_t(size_t, codes_size, size);
> +
> +	mask = kzalloc(size, GFP_KERNEL);
> +	if (!mask)
> +		return -ENOMEM;
> +
> +	error = bits_from_user(mask, cnt - 1, min, codes, compat);

I do not think we need to calculate and pass min here: bits_from_user()
will limit the output for us already.

Does it still work if you apply the patch below?

Thanks!

-- 
Dmitry

Input: evdev - mask api misc changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evdev.c |  148 +++++++++++++++++++++++++++++--------------------
 1 file changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 83d699f..ce35ea3 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -685,7 +685,46 @@ static int bits_to_user(unsigned long *bits, unsigned int maxbit,
 
 	return len;
 }
+
+static int bits_from_user(unsigned long *bits, unsigned int maxbit,
+			  unsigned int maxlen, const void __user *p, int compat)
+{
+	int len, i;
+
+	if (compat) {
+		if (maxlen % sizeof(compat_long_t))
+			return -EINVAL;
+
+		len = BITS_TO_LONGS_COMPAT(maxbit) * sizeof(compat_long_t);
+		if (len > maxlen)
+			len = maxlen;
+
+		for (i = 0; i < len / sizeof(compat_long_t); i++)
+			if (copy_from_user((compat_long_t *) bits +
+						i + 1 - ((i % 2) << 1),
+					   (compat_long_t __user *) p + i,
+					   sizeof(compat_long_t)))
+				return -EFAULT;
+		if (i % 2)
+			*((compat_long_t *) bits + i - 1) = 0;
+
+	} else {
+		if (maxlen % sizeof(long))
+			return -EINVAL;
+
+		len = BITS_TO_LONGS(maxbit) * sizeof(long);
+		if (len > maxlen)
+			len = maxlen;
+
+		if (copy_from_user(p, bits, len))
+			return -EFAULT;
+	}
+
+	return len;
+}
+
 #else
+
 static int bits_to_user(unsigned long *bits, unsigned int maxbit,
 			unsigned int maxlen, void __user *p, int compat)
 {
@@ -698,6 +737,24 @@ static int bits_to_user(unsigned long *bits, unsigned int maxbit,
 
 	return copy_to_user(p, bits, len) ? -EFAULT : len;
 }
+
+static int bits_from_user(unsigned long *bits, unsigned int maxbit,
+			  unsigned int maxlen, const void __user *p, int compat)
+{
+	size_t chunk_size = compat ? sizeof(compat_long_t) : sizeof(long);
+	int len;
+
+	if (maxlen % chunk_size)
+		return -EINVAL;
+
+	len = compat ? BITS_TO_LONGS_COMPAT(maxbit) : BITS_TO_LONGS(maxbit);
+	len *= chunk_size;
+	if (len > maxlen)
+		len = maxlen;
+
+	return copy_from_user(bits, p, len) ? -EFAULT : len;
+}
+
 #endif /* __BIG_ENDIAN */
 
 #else
@@ -713,49 +770,23 @@ static int bits_to_user(unsigned long *bits, unsigned int maxbit,
 	return copy_to_user(p, bits, len) ? -EFAULT : len;
 }
 
-#endif /* CONFIG_COMPAT */
-
 static int bits_from_user(unsigned long *bits, unsigned int maxbit,
 			  unsigned int maxlen, const void __user *p, int compat)
 {
 	int len;
 
-#if IS_ENABLED(CONFIG_COMPAT)
-	if (compat) {
-		if (maxlen % sizeof(compat_long_t))
-			return -EINVAL;
-		len = BITS_TO_LONGS_COMPAT(maxbit) * sizeof(compat_long_t);
-	} else
-#endif
-	{
-		if (maxlen % sizeof(long))
-			return -EINVAL;
-		len = BITS_TO_LONGS(maxbit) * sizeof(long);
-	}
+	if (maxlen % sizeof(long))
+		return -EINVAL;
 
+	len = BITS_TO_LONGS(maxbit) * sizeof(long);
 	if (len > maxlen)
 		len = maxlen;
 
-#if IS_ENABLED(CONFIG_COMPAT) && defined(__BIG_ENDIAN)
-	if (compat) {
-		int i;
-
-		for (i = 0; i < len / sizeof(compat_long_t); i++)
-			if (copy_from_user((compat_long_t *) bits +
-						i + 1 - ((i % 2) << 1),
-					   (compat_long_t __user *) p + i,
-					   sizeof(compat_long_t)))
-				return -EFAULT;
-		if (i % 2)
-			*((compat_long_t *) bits + i - 1) = 0;
-	} else
-#endif
-		if (copy_from_user(bits, p, len))
-			return -EFAULT;
-
-	return len;
+	return copy_from_user(bits, p, len) ? -EFAULT : len;
 }
 
+#endif /* CONFIG_COMPAT */
+
 static int str_to_user(const char *str, unsigned int maxlen, void __user *p)
 {
 	int len;
@@ -956,7 +987,7 @@ static int evdev_set_mask(struct evdev_client *client,
 			  int compat)
 {
 	unsigned long flags, *mask, *oldmask;
-	size_t cnt, size, min;
+	size_t cnt;
 	int error;
 
 	/* we allow unknown types and 'codes_size > size' for forward-compat */
@@ -964,14 +995,11 @@ static int evdev_set_mask(struct evdev_client *client,
 	if (!cnt)
 		return 0;
 
-	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
-	min = min_t(size_t, codes_size, size);
-
-	mask = kzalloc(size, GFP_KERNEL);
+	mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
 	if (!mask)
 		return -ENOMEM;
 
-	error = bits_from_user(mask, cnt - 1, min, codes, compat);
+	error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
 	if (error < 0) {
 		kfree(mask);
 		return error;
@@ -995,35 +1023,33 @@ static int evdev_get_mask(struct evdev_client *client,
 			  int compat)
 {
 	unsigned long *mask;
-	size_t cnt, size, min, i;
-	u8 __user *out;
+	size_t cnt, size, xfer_size;
+	int i;
 	int error;
 
 	/* we allow unknown types and 'codes_size > size' for forward-compat */
 	cnt = evdev_get_mask_cnt(type);
 	size = sizeof(unsigned long) * BITS_TO_LONGS(cnt);
-	min = min_t(size_t, codes_size, size);
+	xfer_size = min_t(size_t, codes_size, size);
 
 	if (cnt > 0) {
 		mask = client->evmasks[type];
 		if (mask) {
-			error = bits_to_user(mask, cnt - 1, min, codes, compat);
+			error = bits_to_user(mask, cnt - 1,
+					     xfer_size, codes, compat);
 			if (error < 0)
 				return error;
 		} else {
 			/* fake mask with all bits set */
-			out = (u8 __user*)codes;
-			for (i = 0; i < min; ++i)
-				if (put_user((u8)0xff,  out + i))
+			for (i = 0; i < xfer_size; i++)
+				if (put_user(0xffU, (u8 __user *)codes + i))
 					return -EFAULT;
 		}
 	}
 
-	codes = (u8*)codes + min;
-	codes_size -= min;
-
-	if (codes_size > 0 && clear_user(codes, codes_size))
-		return -EFAULT;
+	if (xfer_size < codes_size)
+		if (clear_user(codes + xfer_size, codes_size - xfer_size))
+			return -EFAULT;
 
 	return 0;
 }
@@ -1097,27 +1123,29 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		else
 			return evdev_revoke(evdev, client, file);
 
-	case EVIOCGMASK:
+	case EVIOCGMASK: {
+		void __user *codes_ptr;
+
 		if (copy_from_user(&mask, p, sizeof(mask)))
 			return -EFAULT;
 
+		codes_ptr = (void __user *)(unsigned long)mask.codes_ptr;
 		return evdev_get_mask(client,
-				      mask.type,
-				      (void __user*)
-				      (unsigned long)mask.codes_ptr,
-				      mask.codes_size,
+				      mask.type, codes_ptr, mask.codes_size,
 				      compat_mode);
+	}
+
+	case EVIOCSMASK: {
+		const void __user *codes_ptr;
 
-	case EVIOCSMASK:
 		if (copy_from_user(&mask, p, sizeof(mask)))
 			return -EFAULT;
 
+		codes_ptr = (const void __user *)(unsigned long)mask.codes_ptr;
 		return evdev_set_mask(client,
-				      mask.type,
-				      (const void __user*)
-				      (unsigned long)mask.codes_ptr,
-				      mask.codes_size,
+				      mask.type, codes_ptr, mask.codes_size,
 				      compat_mode);
+	}
 
 	case EVIOCSCLOCKID:
 		if (copy_from_user(&i, p, sizeof(unsigned int)))
