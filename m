Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E262C21D8
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376218; cv=none; b=ii5Lvdszv/meP4ClRJM/S5LPBstx8i/xS3E9g7a+kumV9V7SvxGfgqMaXusFBsFCmN02VpVKDi5efd8LSprZco121+TZv10f+7d28f25viOTvQXIPeh5mKoa0zG5AwhLJ8J9cr6pV2xJ5otbrkTn6HS03heFoOOBCjv3yPwo2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376218; c=relaxed/simple;
	bh=H1QjB49bt5h0upA1Xbf1QC3e5FoNEshQUGOCAoh4oUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpe/kyE47zc3L0EeUrgl2flfnwwnoleHomRz1pMjtNWoBvWEfegfFRZlzDb3T/QigVK3Ahv6Hr3JeOqKz+u0916CkuTNGv943BJNF4os5fz6jzdjbygAMqtcpR4jX+Uw85VLqgC16G5L36/XK7ueBWgZUp2V7wgm0GKB8zhOWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvoBM29J; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvoBM29J"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1363fe80fe8so13069154c88.0
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 21:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376216; x=1780981016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TsRuUL/uZrhCoMBNI6/YcNk5TRX9x4wv1DWEEr5Iuog=;
        b=jvoBM29JfDk4isbBlYvE6d+BD7bvmFmLlfEWPFLhKaCYnSke4K9ljHH7BNCgDwVM/H
         lSeY5Qht/cFL9O3p23IjdaWEiwapF1jxdaq8KWi6a4/MB6zc9xiuQmaGvlnKRA6yCmZ8
         LnWHWPRlhxDD6mbrHuMh5P6flKH6Y7p3E0aqXcHq/4hCLPFrpvwh4Ab12KB51BX05513
         8qiAyXWGFy305gfPl/wKUkuo/bu6ikjhq0SgVYk7lZCoU0GmxWAPTrMg62yJRjATDF+8
         /46M99Z4gmw8y//ROjtOj2p2HZ+76ev5Wcvi8zxfwbJkfHsAUGjL4gzxM0Jd506YzM9l
         Qysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376216; x=1780981016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsRuUL/uZrhCoMBNI6/YcNk5TRX9x4wv1DWEEr5Iuog=;
        b=pboZT3TMebvVLxpyAyBeH5aHZJ1dHlwkfb8bQ9sl6FuX52Xk/yX43ZpcOPYWhKggEi
         Li/oaH3IQn68IQxOFAyxvfwN1uQi8xfwjH43HpCsocNZs8jef8P1aCBPUgbkjUxZKv9+
         BXzQtf6EjrGBF/Mo+4bAWKm/edNhn4+O6CFiQx1gZvErXeAxmny5ESm/PpYmClvqCdy2
         iDqGGhcCY45ZBVZ9k505jHh0GvAbdnrIpOuNU5+aeSF3YOI13h16/kqqXeVhb3uQwq4a
         f68KdFRN1wwlhIQSjWknp37njfU8DD/QI4ICSm22fQ4VeV01fxmdZm++wv7ly7qz7FTn
         UJjg==
X-Gm-Message-State: AOJu0Yy5lBvzkIb6A6h+IlH1d4Iv+oEQCfnctZYSBrD/yy3UrsNDtJfh
	4/WgbSbi5omPUrr208IJNABjQ+mLPDLgJPtrBhW/IO+kELADZPbFChNc
X-Gm-Gg: Acq92OFxVlDrmFqoF51ZoiLYhNGF3LxnebdlzS9hW1OP0qihkyBVFjzy1TgRR7aBUQq
	qUFHDSPPuLRFH8mq+N+xbD0DPDuY8WRjY9CDFYxpfWD710dUl2EnpW9kbe/Vp7O1CzS63rdS/yE
	8wS69q7517jS+o1t0MS7xKLuKbO/jJoQEa1YLupxR5/lktriqFc57OsEO44OiAD/p9FNPv67oSn
	T+W6z/t/rCeVX/GFiLoSQLujtLqFwVkX5EZduuHj5kWGSTLMXSTH1trcTCXIb4wXg3q3djr4MTt
	FMDcAkTu1KGduZ3OsWceKB9s5BguWvuYMfKFeYY0zo7Mw9lu7eZBlQIpbWMc4aY8cBd3EGlosWE
	RqW2Hk2dGYrxaOyBeIIBdtR1CCtkNiyXWgWr1HU07ZlXM2rTOUfDyGMn9z4daIbZobFk4qf4Dtq
	s5vjqdk2lgZJR6LceG8rJsiMbVza0AtFglpeHMoBWOIsltJMNmURMUe4gLacsxDnehtvdXix/TA
	CY=
X-Received: by 2002:a05:693c:2c86:b0:2da:1874:f3bd with SMTP id 5a478bee46e88-304fa64c4d0mr6405442eec.16.1780376216103;
        Mon, 01 Jun 2026 21:56:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:50da:22ff:eb92:9530])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm11075883eec.18.2026.06.01.21.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:56:55 -0700 (PDT)
Date: Mon, 1 Jun 2026 21:56:51 -0700
From: dmitrytorokhov <dmitry.torokhov@gmail.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: linux-input <linux-input@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, ubuntu-kernel <ubuntu-kernel@lists.ubuntu.com>, 
	hasan6l <hasan6l@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add quirk for Daffodil DC253D touchpad
Message-ID: <ah5iH8TPFnpbyT8a@google.com>
References: <19e5047ead1.ce62bdb39017.6022546617731203250@zohomail.in>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e5047ead1.ce62bdb39017.6022546617731203250@zohomail.in>

Hi Ashwin,

On Fri, May 22, 2026 at 08:52:30PM +0530, Ashwin Gundarapu wrote:
> From ee16efae3c4371d37467c49c0cae6af808e1b625 Mon Sep 17 00:00:00 2001
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Fri, 22 May 2026 20:48:25 +0530
> Subject: [PATCH] Input: synaptics - add quirk for Daffodil DC253D touchpad
> 
> On the Daffodil DC253D laptop, the touchpad is incorrectly detected as
> a clickpad, causing the right button to be missing. Add a DMI quirk
> to clear the CLICKPAD bit for this device.

I wonder if the device can work on SMbus/RMI4 mode and if it behaves
better in RMI configuration?

> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2153983
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>  drivers/input/mouse/synaptics.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 26071128f43a..4ca85fb4ab70 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -534,9 +534,16 @@ static int synaptics_invert_y(int y)
>   * Apply quirk(s) if the hardware matches
>   */
>  static void synaptics_apply_quirks(struct psmouse *psmouse,
> -				   struct synaptics_device_info *info)
> +                                   struct synaptics_device_info *info)
>  {
> -	int i;
> +        int i;
> +
> +        /* Daffodil DC253D has a physical right button */
> +        if (dmi_match(DMI_SYS_VENDOR, "Daffodil Computers Ltd.") &&
> +            dmi_match(DMI_PRODUCT_NAME, "DC253D")) {
> +                info->ext_cap_0c &= ~BIT(20);  /* Clear CLICKPAD bit */
> +                psmouse_info(psmouse, "Force right button on Daffodil DC253D\n");
> +        }

The patch is whitespace-damaged.

>  
>  	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
>  		if (!psmouse_matches_pnp_id(psmouse,

Thanks.

-- 
Dmitry
