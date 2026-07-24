Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA93B7B84;
	Fri, 24 Jul 2026 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879509; cv=none; b=OpIZwwjaqyinyygrvWsKLa2wNHFhxV5REkTQtlobjwd0LhP/V1wfRGHQMWSbdXldEEf0zjcb8bfHi3b3wknQJcAl4OlSy6AXKNtTboBz2AgA/FqaM06V8o89jlYGDl0E3IZyAMbuzel/vaZS7tddZaP/pkOkYkPDGbBJhrKlVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879509; c=relaxed/simple;
	bh=KR71SONxCy4Zx/5ZktjV+uKQaIgICDFbzu74+JJOnTU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qZ+wNiUxjTq644iPC5T9PLnDvW60p9ycYAEVjkzgqhN/RSduqbpaaXNh9xZvuqieQ5ADUGetmw6VUeKwfnY8z1rnFv9P8UBdyZkJpec8SjtMrw6NaNG8jKNyHMMjQbdI9KlJH9YYxcgsWkKFuKWYUmv4wEVC6gtYcvh8GS8MIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=lTN43tHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XLd8kYTx; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="lTN43tHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XLd8kYTx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DDBF41D00273;
	Fri, 24 Jul 2026 03:51:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jul 2026 03:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784879503;
	 x=1784965903; bh=qmXKfjRoEk9VoQj8EPYCfLB6WI1Bbc2GfpG1mTKkUe4=; b=
	lTN43tHIzEkuc6spBCp+VOhS5TLDQMDfN3vuzN+0DjfKYsDohFCy4MZbnixtTXlo
	/FcnElFUIOhQNd+c+FNamH4V7+VEUAcc6ItDbH091SiTO/TB00wBYlbs6wOoGLIs
	5WXeMOGUXiFtU88DVrzANNB/2bVM4Hskk+mQ2htzFjkYDIGNDp6poCIl3tDpGqr6
	EIf0ixfvKkOKUgI+vALpn7QgbjJwrqyjjWIS5ShZ2/qNDHtY6IAb1LJ2JAnaHIAQ
	AnLVfk/PtonKyIz18lHJ2yGIsyOqI8uzRLQQZqgFM+mkhHtlZvFGlrxFNek1pAZ7
	G61N0R1P60hhrh5BHW9ogA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784879503; x=
	1784965903; bh=qmXKfjRoEk9VoQj8EPYCfLB6WI1Bbc2GfpG1mTKkUe4=; b=X
	Ld8kYTxR5/Ibf0+O64BBg+CvBkXFq+Mqo4gwLA69AeBXbo73U2RBw91488iWAHI0
	FYaO3agUsumJnpXVBj0X32eEigLF5hvWMVkQTS8VThNFBaksh8hEXzr26zQSeZRO
	oWaKFsAdBPQxABWPYBybnoRxbR67ygyzp/rc2QfBQbm84JKjlBxUsHdQgJdiQccK
	1nZ9s/QKh4P8ulrUn7UL7Jq0HaETQQEqkYXn2QD7tWsoVq52oHolnD9jX9OhDBet
	6MuxUTv3LPh9YdyCIxRWJQxTLgPQPEQZ2dBA5YqZdsrUfM8JBu0PjvCcGIQPrFwE
	QLWwL8fKibXDvB5rMrTMw==
X-ME-Sender: <xms:jxljauE6v-FwyGpMoTLGBzbeow83k-ZIKk4PUgBLAFvUe83K-7hDew>
    <xme:jxljaqILTS4gO3WTHUvaOH26klm8HDGVp2X5yiFFQUNjUbuuLJX_PIXLCWuoDMCGt
    uvythsBtfTA6P18mSW5p-ytB6noLx5VP4c7O3o0iIwSSGAmIZy_Tag>
X-ME-Proxy-Cause: dmFkZTFfV1uVr1onRcdg9sjdztfoO+bhrylk4ZxOgiyBV6oHS61cIF7sf3v+zxGjqFl+me
    RiZPAPoFONzPJhbHtNgLLxK/8bCzD2BbcmAY+qb7SQExhrH+ZJ7HBmgtQJRgVa4RXXcSDZ
    tN7Fvm3F7anXFLKgvKdpK6xN/1j39duvaUKBBx30h71VUD8L/6a9jJC9Bhbj0TeJ3YnRbM
    +wQrUlsgFeZKkWl5rxWy+6TvzCZqozWxtyTXCdrBlo+H2rO5QGxXV8/DtHIJLjD8p5zLnN
    9Wz8tF4QTMPVwRDeE+aGw6oft693lLHARjB+qJjc9+2IMbNjkC5JItr2owsGpuV3ankKKx
    1WN4Xnm3rvWBHYFUfChgPWyilb55veVsaZ4xcap+XDVrQGYB7IsYVJDmXkAc3xFAcN1ohe
    pDjM4UnrDhaZRx5rwytUcbZdaINPGO77zlhWDvdMep3a/GYDeIg5lGRyUIJ+KrPXzdzsgx
    167jbL/6H3vQLCwNYtZYbW0M7FVPOKR2XEFpj1gUt3E1V9fMGpFV25AOuCoEwxFeIDaRzP
    8ktkzE/gKknW1oxJMDCCfAA8vDhfE12tmXPBUywb4vqkoFtErF57vuT43Nqc47ECb63O/Z
    LeVvfQjsl1z+DRaGce5nAqD3iQ1FwAPsM8LdkNUuREgXY51FqrjQ/GZwItbQ
X-ME-Proxy: <xmx:jxljaknIHVqji5AZO1_89QE-6qem1v-A3MUVBJzRsCyZ9luXEOKipw>
    <xmx:jxljauz7G6ECbvY3pXVJp3gamnj74wOwizGgV8ffTwwoSGva26h0DA>
    <xmx:jxljahrC2LCwFkf6yoeKUIip5lfltQkZl1uo1GAZ6Rvi4OsiizZBUQ>
    <xmx:jxljal4FdIV8bVMnBvNNsuXxTgk6cUCu6IzydqHswUsE4fQ0FnTH0A>
    <xmx:jxljamUM7Wa8qq_ilusIkGhRUSHHFat4iMLF-LG8E23keBRNrn1tFL6F>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 274A91EA006B; Fri, 24 Jul 2026 03:51:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkQsyRZvKaKJ
Date: Fri, 24 Jul 2026 09:51:21 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Peter Hutterer" <peter.hutterer@who-t.net>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1ed3a0b5-db39-4a82-b549-0ed7e2cf89c2@app.fastmail.com>
In-Reply-To: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in phys paths
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Peter!

On Fri, Jul 17, 2026, at 6:49 AM, Peter Hutterer wrote:
> There is no good reason to support those, no physical device will ever
> produce those. Allowing \n in phys previously triggered CVE-2026-50292
> in libinput - there the PHYS udev property value was used as part of
> another udev property value. The linebreak then caused the property
> to be split across two lines, allowing uinput devices to inject
> malicious properties. While the bug is squarely inlibinput's court
> there still isn't a good reason for control characters in uinput/uhid.
>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/hid/uhid.c          |  1 +
>  drivers/input/misc/uinput.c |  1 +
>  include/linux/input.h       | 15 +++++++++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 37b60c3aaf66..baf1fe8290f7 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -513,16 +513,17 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>  		ret = PTR_ERR(hid);
>  		goto err_free;
>  	}
> 
>  	BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
>  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
>  	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
>  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> +	input_sanitize_phys(hid->phys);
>  	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
>  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
> 
>  	hid->ll_driver = &uhid_hid_driver;
>  	hid->bus = ev->u.create2.bus;
>  	hid->vendor = ev->u.create2.vendor;
>  	hid->product = ev->u.create2.product;
>  	hid->version = ev->u.create2.version;
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index d32fa4b508fc..70fe4f3e73bf 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -998,16 +998,17 @@ static long uinput_ioctl_handler(struct file 
> *file, unsigned int cmd,
> 
>  		phys = strndup_user(p, 1024);
>  		if (IS_ERR(phys)) {
>  			retval = PTR_ERR(phys);
>  			goto out;
>  		}
> 
>  		kfree(udev->dev->phys);
> +		input_sanitize_phys(phys);
>  		udev->dev->phys = phys;
>  		goto out;
> 
>  	case UI_BEGIN_FF_UPLOAD:
>  		retval = uinput_ff_upload_from_user(p, &ff_up);
>  		if (retval)
>  			goto out;
> 
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 76f7aa226202..6c182f5c783f 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -527,16 +527,31 @@ int input_set_keycode(struct input_dev *dev,
> 
>  bool input_match_device_id(const struct input_dev *dev,
>  			   const struct input_device_id *id);
> 
>  void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
> 
>  bool input_device_enabled(struct input_dev *dev);
> 
> +/**
> + * input_sanitize_phys - replace invalid characters in a phys string
> + * @phys: the phys path to sanitize (modified in place)
> + *
> + * Replaces any control characters and non-ASCII characters with '?'.
> + **/
> +static inline void input_sanitize_phys(char *phys)
> +{
> +	char *p;
> +
> +	for (p = phys; *p; p++)
> +		if (*p < 0x20 || *p > 0x7e)
> +			*p = '?';
> +}
> +

Reviewed-by: David Rheinsberg <david@readahead.eu>

I would also be fine to just reject them in uinput, but I guess this is the less intrusive option.

Thanks a lot!
David

>  extern const struct class input_class;
> 
>  /**
>   * struct ff_device - force-feedback part of an input device
>   * @upload: Called to upload an new effect into device
>   * @erase: Called to erase an effect from device
>   * @playback: Called to request device to start playing specified effect
>   * @set_gain: Called to set specified gain
>
> ---
> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
> change-id: 20260717-wip-uinput-sanitize-phys-abb6cf40e577
>
> Best regards,
> -- 
> Peter Hutterer <peter.hutterer@who-t.net>
