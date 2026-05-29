Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628423B9D9A
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091088; cv=none; b=CUtUXG1a+lXYAohtTBDppmtoXTkqSK6N+rQQKAXe0qzZw87ecejc/Tk98Gq62FcL5eBGSh2DX8qk/0qQHThF5Z+9XN+ZA/y35HlvZlvTrUcIVCCVlx7E6NYeLPMzZWkdNoW/92zt4i1E+1dYKhcpsfmcNtNZwqynJrg9oRxdJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091088; c=relaxed/simple;
	bh=8YccHQpbrLbCjT6Gk5r3pmdOA2g4GZa0mWgJIHwZOUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIQg1ljc4W/CgjsjOQDMFrBfUoqhXtw29Zbcth3BT3XWcnLwvD8vhaZoPplOEH3rW2Aw7tPQQBBwTPK96sDva7xMjOY8u/GILXkCAnwmyMR2YUaKB3R1i0gf9YGmRmZVMtCoYhuun6xn7L0FoWs4BxUoSn3Pup/CQxaqLTsPoOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxw43X40; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxw43X40"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304d7f31215so2169081eec.1
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780091085; x=1780695885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSQQogjkjukCIt/ic8irOKvTJ/iFQGiGTec8jnQp53Y=;
        b=Sxw43X40cp8+0sQDGo4m/rj2J0fgFfIhkucjnQuzOzHkQaewaSdPZKRXo1vVWRA5Ju
         Auf9Pdvjl5rYVm0hZHyCF5BLLD1kdrpPRee0kGP4Tvj+RPxe4aGau+/Jq+CloWM42aTx
         1HwdOMN734UoDskeqvc+57W71IAeUwERufhiYhHRAHf+LZbKd4m+l6bSAa3MDTu7CN2f
         rn4piX/ERPrCmF83JH2s/h44NNZt8CpYG67pitZTzzKZsSKvwJR84A811weYC5IaDJ/q
         Cs2XelDnCm+jKM5L1hhV/Ehw8p3SKuz6SV8MdF1nBL96WFmiG4mbUdy0TgvJzY22BB7I
         X0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780091085; x=1780695885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSQQogjkjukCIt/ic8irOKvTJ/iFQGiGTec8jnQp53Y=;
        b=Llj4Cluxsnt5bd6KF3Vw3YeLwECwJwH888Sca7lpBaPbFVHxy8bzbs5bM0hoGUnZij
         h7hUh2triGQiPej4OtUXzEonzSSIwKUE3kXm7l3/XRDEq0hhqxHfWZtEdgtw752Gg/Zq
         j9Zc7ctgdCbfkMC+2GZuZLeSoasNFKbhFHWgVuhBdHzXNGFCWfGw833szZ0JDxSfE772
         Qt1rTXcYkxORl4fK9X4VIbJ36I/UUXEbrZ+bvp7pp/ClVjK0wA94aKKjjep45dSdw3SX
         QN2jYDPhFInh8X5GMsYvNiw+w96n8wfSLj7Q9zfWjIkxnR1q3OUBWKEkJLNrg9eqg6mE
         67Sw==
X-Forwarded-Encrypted: i=1; AFNElJ8JWux/13wa/zvzMud9JDQFX664o4gqFSFZMoggm7eiqdZL1Do3zVT1Jsqr0cTBItXg1dxKRBjAQDo2dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziFY7B3Lzxd+G/IT3oTXdPpG+EQlOA/VaGyGDNgqwlci5kpEBm
	sOW70hfexIdxrtgwHyynOwEATB5RXp5wFhdbH1zZ98MYoYG0T2F4s2GL
X-Gm-Gg: Acq92OEc5CrafqJjOXnAlxnReMOrqVebzLHuW0zm4EtqUnxyBSjT28dtOC7DWNHWn+r
	xBiOH1i/I8fgXgGbflvl+YyJyPATMEoCbI/lyMWv6cmbb057CIqenYS+MK6FI9UsDuDwEfHr++l
	B+YgpG8latLCsKOfcWRSrn/l7t5CH65S/kedt5J9TCPZxsRTZzgRcybzjPxmUjg5/raLPyyYHbI
	Cl9cV8+g2f7Dd4BXL6dkdekYj0ZvC5swU1Ngm60tgN4USKaidit/iKnUXi3iQJqdQa7WmPxWJXs
	qO9uwyJGUUS2dIxXzz0kwjNsXxAefLoID5WpdOaBv/NB1j2pUsmYz6aA1rAZiaUZyqKCUSfPzvr
	ITHOR/m9HbcCFB7TWsRRMwR9YQnNoqC8D7eviMLwfEpnHqDGyTCOaLC+SK8polog5Ehxq5YOwq8
	XfvxLnLBzYJgta+gZqeL+SFU1i2GXl7yoxDpmpMtLVWBKr9B9HSd2SxpLU9VzKgGJnL105csE3k
	ao=
X-Received: by 2002:a05:7300:72c5:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-304fa628f82mr775971eec.22.1780091085290;
        Fri, 29 May 2026 14:44:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm2371685eec.19.2026.05.29.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 14:44:44 -0700 (PDT)
Date: Fri, 29 May 2026 14:44:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix NULL pointer dereference in
 wacom_intuos_pad()
Message-ID: <ahoH87pet5BUQwfD@google.com>
References: <20260523150101.611473-1-jinmo44.yang@gmail.com>
 <20260523150619.615565-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523150619.615565-1-jinmo44.yang@gmail.com>

On Sun, May 24, 2026 at 12:06:19AM +0900, Jinmo Yang wrote:
> wacom_intuos_pad() dereferences wacom->pad_input without a NULL check.
> When a Wacom tablet is created via UHID with parameters that route
> through wacom_bpt_irq() -> wacom_intuos_irq() -> wacom_intuos_pad(),
> but probe did not allocate pad_input, the call to
> wacom_report_numbered_buttons() passes a NULL input_dev, causing a
> general protection fault in input_get_drvdata().
> 
> Add a NULL check for pad_input at the top of wacom_intuos_pad() to
> bail out early when the pad input device was not set up.
> 
> The bug was found by syzkaller on linux-next 7.1.0-rc4 (next-20260522):
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000052
>   KASAN: null-ptr-deref in range [0x0000000000000290-0x0000000000000297]
>   RIP: 0010:input_get_drvdata include/linux/input.h:390 [inline]
>   RIP: 0010:wacom_report_numbered_buttons+0x37/0x210 drivers/hid/wacom_wac.c:4210
>   Call Trace:
>    wacom_intuos_pad drivers/hid/wacom_wac.c:643 [inline]
>    wacom_intuos_irq+0x29a/0x32b0 drivers/hid/wacom_wac.c:1042
>    wacom_bpt_irq drivers/hid/wacom_wac.c:3275 [inline]
>    wacom_wac_irq+0x12ed/0xaef0 drivers/hid/wacom_wac.c:3545
>    wacom_raw_event+0x677/0xa90 drivers/hid/wacom_sys.c:184
>    __hid_input_report.constprop.0+0x39a/0x4d0 drivers/hid/hid-core.c:2161
>    uhid_dev_input2 drivers/hid/uhid.c:618 [inline]
>    uhid_char_write+0xa8a/0xfa0 drivers/hid/uhid.c:776
> 
> Also confirmed on a Pixel 9 Pro (Android 16, kernel 6.1.124) where
> it causes an immediate kernel panic and reboot via /dev/uhid without
> requiring root privileges:
> 
>   KP: Oops: Fatal exception: comm:wacom_27qhdt
>   Reboot reason: 0xbaba - Kernel PANIC
> 
> Reproducer (unprivileged):
>   open("/dev/uhid", O_RDWR)
>   write(fd, UHID_CREATE2{vendor=0x056a, product=0x0020})
>   write(fd, UHID_INPUT2{report_id=0x0c, size=10})
> 
> Fixes: c7f0522a1ad1 ("HID: wacom: Slim down wacom_intuos_pad processing")
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85..251ddda3e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -515,7 +515,6 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	struct wacom_features *features = &wacom->features;
>  	unsigned char *data = wacom->data;
>  	struct input_dev *input = wacom->pad_input;
> -	int i;
>  	int buttons = 0, nbuttons = features->numbered_buttons;
>  	int keys = 0, nkeys = 0;
>  	int ring1 = 0, ring2 = 0;
> @@ -523,6 +522,10 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	bool prox = false;
>  	bool wrench = false, keyboard = false, mute_touch = false, menu = false,
>  	     info = false;
> +	int i;
> +
> +	if (!input)
> +		return 0;
>  
>  	/* pad packets. Works as a second tool and is always in prox */
>  	if (!(data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||

I think there are many more places in the driver where it used
wacom->pad_input without verifying that it exists.

Thanks.

-- 
Dmitry
