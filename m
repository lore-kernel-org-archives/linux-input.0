Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8730DEAC
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722491; cv=none; b=si1J4tZ4vy3XO91BDl69t/elrtGjq8GOL3FglSkm9Flhv1EcFvS/8C7IZKw/ii/Ucii6ZHrmbPx9aFmpgzH4ryqQC0iEFVgL6kFtil3livtS2k0HsWOncn+a+uSEJIxKMS/Qz/HWGyg5PlKeM6h1He6wyqQnmJIi/wNODWHOdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722491; c=relaxed/simple;
	bh=022CtzuCYgQKuBmhMtlJd63b6/BfGbbIKTHJfIfKPR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1z8CurVmwF0ySy19FBWzNj4WAZxefJEvrBzoRxIPQHizib44Blvfqn9dnMY0eMKGCfwPdb2jTgnZrutLMyglB9ThWLjh+EYBZdm3Xu93CdGD3PX86s3Et8Chpc5GsrlgDQo6+tKrs5fAWG92lcZMEON81ZXV8I34g2UR+Kw2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiQ61x/2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiQ61x/2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so3304955b3a.2
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 19:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785722489; x=1786327289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzNZQnQ26DMRnAyduy+p6kI8g6zuK0Z3SnPpOgcKOwo=;
        b=fiQ61x/2q50i52w63NkKp3av2ivGKX70rPpIeoWOlDgLtkrr7A851AQpDvA0Noi/XN
         5dXSR53yioK42tQU25hqYfUz9rolkS3CDtHRrrgFgp1QURKYGyLywkUCtmMyqtcVnhIw
         l8rNkqkAm/1Ql76JDyTQKh4HaWvOcm62IThr2ZVmuNoSX9xF8Lf/QBhiRNZG4XogTBKV
         n2JQritIt+0WMK8R1+TJaShimyfn8VcxF5rHAcAz31sUeXxUByLT2/RNrjUewMAeRbKP
         3aWIMiFB3pLiFftJfekVTqeoWOerNrJb5pyEsjW/omDbCrEJS7Gl0ZZi2zMkWrIz9c5K
         b01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785722489; x=1786327289;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzNZQnQ26DMRnAyduy+p6kI8g6zuK0Z3SnPpOgcKOwo=;
        b=Ge9mdGOP/mWqj8wrX31hoXQF92hSbzcLAG9Qsx4jHREhbMeJ0rd8DiKz+Eev9OBFc/
         pvxveY/daD4iu9iBXI95qmZun0ZjBQ/ZKybytAH9F2s4mTf+suAOlsXzqEKgjrtSvjSO
         qqyoXXwSE+9lXXNaPsWXwt0gRL1gyxF7IvUaMxnWBUgccHwyGfdqNaOLxDyJCqSAliVE
         oF6DGs6l+IrrU2ZwPd/F/eSC7SsjGRg1gQe7hZJSlsMKBMpWi8piLtQ6L8jssLJt3lah
         wbp0no2M20zhBXg0tS1XQAcHb/loj1uqLpFN48NtpR9f8NYi0cKchmtS5t9DHTD9RHbL
         icqw==
X-Gm-Message-State: AOJu0YxZdS3n/vqJ5AgS/6KW6oof9VFJV6/o4JZ9+4URNhmUTbAK4BQP
	usUOXJWlHN5NZBnmw3TeRbbFSPOaXxFn+kJxWgp73ra12cYzaBie69R+
X-Gm-Gg: AR+sD12pbDGzWgpFZ084Zb7tU4WvAUEf8JVMwKySzAY9EydnYB06ogpzKuBR6W/5/N/
	yLQvaspY0r+xf2lDUZScZYY6DJ3VHChAfhG2u6J5CQgJxtBFYC/0wRuhG5j5iLtThRkkVT41QFl
	6CAI/31SSb7A6l4G8hPgff3IE4r0IUX2Ch2KvMdelcV/K3T8XZEvjcv7ugNejWQc8ThvfSD+RXX
	tS2BhZba0/+li0er+66hp7bTWD2eVHD5loK9MyLiqcSlEG1CSD5IQpcr2imF2iEh4CNpTEeUkFH
	a66s73dHo7N2JbVt2aXzPxVEbr/+DevTqZTNgxzqrc4Rc2pvLv6PIAQ4khDN1N1lpywO7/rfERi
	psyVJJ/TId1inM2rLw5n4k8qntV3BIElNGQ2Hcnx+awdURsjBm6FeoARbU/AJib0CmCdV8ejDoL
	Fn82k1YxYxxV7md92MREEKqB/OXDHdkwBDl8grJP3++FyEFpQ+kD6JOTs5+hVE1/3ii38/6IMYi
	3EzM7SrlaC1FdsiL2QYeNDmDPlHTQ==
X-Received: by 2002:a05:6a21:69c:b0:3c3:83e8:c211 with SMTP id adf61e73a8af0-3c92a901f54mr8377503637.63.1785722488848;
        Sun, 02 Aug 2026 19:01:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm51119156eec.28.2026.08.02.19.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:01:28 -0700 (PDT)
Date: Sun, 2 Aug 2026 19:01:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dongxu Su <hj117@sz-huijia.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] Input: xpad - add Voyetra Turtle Beach PC Rematch
 Gamepad
Message-ID: <am_2UxUjAciSMByi@google.com>
References: <178572174191.26980.4407731925140715976@sz-huijia.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178572174191.26980.4407731925140715976@sz-huijia.com>

Hi Dongxu,

On Mon, Aug 03, 2026 at 09:49:01AM +0800, Dongxu Su wrote:
> 
> Add support for the Voyetra Turtle Beach PC Rematch Gamepad,
> a triple-mode (wired, 2.4G wireless, Bluetooth) PC game controller.
> 
> The VID 0x10F5 is already in the XPAD_XBOXONE_VENDOR whitelist
> (covering the GIP mode PIDs 0x6015 and 0x6016), but XInput support
> was missing.
> 
> Add XPAD_XBOX360_VENDOR(0x10F5) to xpad_table to enable XInput mode
> (both wired and wireless), and add xpad_device entries for all four
> PIDs to give them human-readable names:
>   - 0x6013: XInput wired (XTYPE_XBOX360)
>   - 0x6014: XInput wireless 2.4G (XTYPE_XBOX360W)
>   - 0x6015: GIP wired (XTYPE_XBOXONE)
>   - 0x6016: GIP wireless 2.4G (XTYPE_XBOXONE)
> 
> Signed-off-by: Dongxu Su <hj117@sz-huijia.com>

What has changed from v1?

> ---
>  drivers/input/joystick/xpad.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f36..7f593fc 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -267,6 +267,10 @@ static const struct xpad_device {
>  	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
>  	{ 0x10f5, 0x7005, "Turtle Beach Recon Controller", 0, XTYPE_XBOXONE },
>  	{ 0x10f5, 0x7008, "Turtle Beach Recon Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
> +	{ 0x10f5, 0x6013, "PC Rematch Gamepad", 0, XTYPE_XBOX360 },
> +	{ 0x10f5, 0x6014, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOX360W },
> +	{ 0x10f5, 0x6015, "PC Rematch Gamepad", 0, XTYPE_XBOXONE },
> +	{ 0x10f5, 0x6016, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOXONE },
>  	{ 0x10f5, 0x7073, "Turtle Beach Stealth Ultra Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
>  	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
>  	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
> @@ -522,6 +526,7 @@ static const struct usb_device_id xpad_table[] = {
>  	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori controllers */
>  	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries controllers */
>  	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
> +	XPAD_XBOX360_VENDOR(0x10f5),		/* Turtle Beach Controllers */
>  	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
>  	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
>  	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */

Thanks.

-- 
Dmitry
