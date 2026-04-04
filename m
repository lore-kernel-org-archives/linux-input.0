Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5D313E3B
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279221; cv=none; b=hXvS056V5vxbxwSISY+B0P2wFwSlH3qX4I3X8PaEEmvHfjsztgNCLGvu9y5qG7td0Kwgyl/zV4no2q/zlGi3ym37Uxj6P3CAwneOG6JJUCStoR1CtwlYgjc2BkHt1vgVP7+t+JOho2O5gltiiy86mL4MAxCjbZF1hinnaz3mUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279221; c=relaxed/simple;
	bh=EiBW9kEnHFu1jf2vPto5Gwcw1F9n96f2G4E+e9HCzvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj7rdtuw562kMe/iq4dpQ5fg4H32+ZRfKaxPNeOpXknbWq3VHdg/tYEQ1mx4qC8D0MprVzl4Polr5zx6WvQ49Gb1WFLkR9tHmkf8UnXPWjOyVx914LxvuNZAZW+f43HiDGRHs1V7KJ0Qw5cORTzMUXu4ZDgS0X07uQKgvN9x07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DilBSzCw; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DilBSzCw"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c54c68db4dso4796052eec.0
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775279220; x=1775884020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QdcFR3Pkv3XFST3ixEnlgAlNS6XkgPU1eyPzpLLlH6E=;
        b=DilBSzCwGGMaFrtfD9nN0z031aBHAqd/nSl2nV+IWpBABqK5mpcrElamtRgnsFHf98
         /AplNbhicRWaxrlKNBaAZiz1g+dP8ePqCcvoF1tRM/2J1PeAmmQijOgQ7rWRYeux9zHs
         9PqEgcMaY8uCwrhhUWi+wGZA96aWCFkJCVgU7eIseIeor3IovHecAW19enB9OXyRX6aO
         0EjegYWUBEMhZAmy8eezwmdVJ968oAvnxR6T/DQEHYB3ixGeAEAxAk20SgUK7dcxZ+lY
         4A8OZt0jhbCqiiXmfga9Vg21X6EFanIqSPWAyljzNngXGUVTEAm0WfxtOtdZ8TWCFKzF
         HTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279220; x=1775884020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdcFR3Pkv3XFST3ixEnlgAlNS6XkgPU1eyPzpLLlH6E=;
        b=qcylcji+Wnlu5F3WTc98OsTJn0BmgPVM37NMTtcQKOZSXRkMu64vW1axbbgAsJLjlN
         zNgIrHdcH/a1IcrgO6nwtRVUX+eSAx+pSnavKKtAspfNzVPt6/yC2yyFs5HDeNfWi8B1
         ZaWUoj4eocxeGqBb6XouSEb754S0DgDDamFVYYBNNqZdOADJebu6LQXfBYUwRLWRrmF9
         Td9LGot8Gxxpwi7tECzG4ySpxhKwHW0SDtMFDHd/3/TYcPwg/2k2Tbpe52Hsy7H3c/83
         7IHPtGZRh3viirPbElxl3M/mQm6S4egPXO89C/zF/lIUisZJY9Rx1W7Hc53xY9XVkmB3
         wFWA==
X-Forwarded-Encrypted: i=1; AJvYcCXdgwZg1xx6j8u7G5Byc+MdHBkj8nfhJZErSOLGrlFUpYfrbWJ157JJuOGWLfNBoVDgNz8Wm3VXmM7cmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eFAiwrdxqvgVfll8TF6WQLYwV40EmsX6DIwgAyJoGAMkiE2W
	fsKYyjfnj/L4jFI16iIyl2Exdx3Z2SRYbcxKC4Ucf0F2mdo7ECZKZ8w2
X-Gm-Gg: AeBDietmIaTVuS9A3h2D/nm7VWjIoL8XnfjbOkCMSEHEOnOzbE8x+U++g+p8ig+hzcf
	MOXnxRG8PyLaEjqBL1IE+naUOcVGX6YFSAKZMP/Zp9+94lftGA58syKQqvNDoSbW6iAHoBMgb7k
	jVVl+mLkTEchs1a+2JqLotVQWHVfNeucFJdWtXVwx2zd46ZVyZYHPT087Ga0ohU8mAiHe6ciZe5
	R46HSCpmbkCK/NPnd4v07tZuBSBSgSTy5lDL5vIfYDArUEeVGbeK37CKOSTY0P0yNeHJlJ9Xek2
	8OSe9gRJQLwEsa691kP+hTY6NRteruAVkfo2tm28SPZtwi+6T0Vyn8qvGt2aoR/xoSvDMOq4vIx
	Gda/JGBe6xGvoykO/+0d2SYUDEPdEZD9TrYxnQFkjUGaMeSg1IgPBWnapWRJxApTgVVHN4YkgFV
	InJIhMX/xq424SnTOuwKUj29OTYC/YTR+iBM39vFNzbRP/a6ZWlG1I+BCjPk9SGQaTTqjFgUr4E
	6Y=
X-Received: by 2002:a05:7300:ac83:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2cbfc6586bamr2901381eec.29.1775279219644;
        Fri, 03 Apr 2026 22:06:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2357:9278:e4dd:85f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm9766866eec.14.2026.04.03.22.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 22:06:59 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:06:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Lode Willems <me@lodewillems.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xpad: Add RedOctane Games vendor id
Message-ID: <adCb-7uNtq90McnN@google.com>
References: <20260311213106.271577-2-sanjay.govind9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311213106.271577-2-sanjay.govind9@gmail.com>

On Thu, Mar 12, 2026 at 10:31:04AM +1300, Sanjay Govind wrote:
> Add vendor ID for RedOctane Games to xpad
> 
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index bf4accf3f581..e97ff270d978 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -585,6 +585,7 @@ static const struct usb_device_id xpad_table[] = {
>  	XPAD_XBOX360_VENDOR(0x3651),		/* CRKD Controllers */
>  	XPAD_XBOXONE_VENDOR(0x366c),		/* ByoWave controllers */
>  	XPAD_XBOX360_VENDOR(0x37d7),		/* Flydigi Controllers */
> +	XPAD_XBOX360_VENDOR(0x3958),		/* RedOctane Games Controllers */
>  	XPAD_XBOX360_VENDOR(0x413d),		/* Black Shark Green Ghost Controller */
>  	{ }
>  };

Don't we also need to add some entries to the xpad_device table?

Thanks.

-- 
Dmitry
