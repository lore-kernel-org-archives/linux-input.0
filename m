Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CF3ACA70
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497093; cv=none; b=hCzaz0oJqWX6z+ZR4wlubdA8BGmmYDS/IJKzspsNJBltFI7QLRHz98R3l9iCGaPYS4PT1qq3fR5Wth5Z+kmc3SAshIfG4ste2akDS4GSUvocN29eLkVcHKfAs/PR+6lNl8qkW3ZUhwXJc8vThNh9L0S9MC2WxsUvK9eBEZKwpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497093; c=relaxed/simple;
	bh=z8Z1tyj67EUk3MPWIIyBdJ9mDywQyZFhUBgWKJ6O/tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beIIxfMwH4FV/d4B3ChJRkWOSv4RF2vBbrpKDPf2/hmpeHTVe9w6TCgTixeQRorImujo3nv0gZPXLafGyP5/4Fo33Kr0CxZLAO0ZFL15XMpYqsfcg7Boeh3pnCUIBOjnzwANbSC0l5pkTfndPrA/XuVU/z6Rw0LYOivSbxzDin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjO6SoIV; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjO6SoIV"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13809223fd4so1547188c88.1
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782497090; x=1783101890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OkBWcuqiVi2Oi1XLIlP1/KWmn1hoQRfpnxlYVW+DUo=;
        b=DjO6SoIVRMwfzcHDgztNS6tA7OkI26dS+7b6KgetWxgzpBUsSUGBd2X0y8CXE7fe/r
         ZcAmbyivySHEVrAY8nERtUZSlMBOxbYhUnQ6LcoTbczxNp/3h1aeHwsiE3TNpRFNYMDV
         3HLDENGV5WlVnQBAZT1hiQCetjifaN+xjdQ+spVBSG0ClREh/XJYakf7H/Z82MfSsyYx
         DTr/p61gIY9GnBGa59dMwQmrSkk6Jay65mJRDAJV1bwbhZyyVVfURiZnlYWLZoU08ZqL
         VhqmPdZYpzIBBjzr0D9NwSrTxDHI1RkqgI+ZTyXT3bKMInXBIcVdq8R/FuPd0j8OXLbu
         e2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782497090; x=1783101890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OkBWcuqiVi2Oi1XLIlP1/KWmn1hoQRfpnxlYVW+DUo=;
        b=gEzXmiHY/jwNEm4nprRjpAK4HoZH5Z0pXhZtrc7vQo0OVx7zCU3dJFbkM9nvKPwUKg
         X+zmBdwVAAAuLS7uNqmrtg+3IHc/7nktU3pV2bm/0R+tGLMyxiRvl1TTYVx0hSFPOc8r
         sgWKXs2TM1OLIFVV24ak3fwI8f2nwvVXcMoZmTrlZtYnAM8oh+SUCeOZubQiOTM+xYP6
         Z8MhkUuS/IR8PfQHZRsdE6CzYpisvQXqv6X6685fajNh9IqvKHgRAoS/8/+Fqj69CxkG
         dSH/5ysk9StHCD56nCx492m45wsPze56qzl536f3HCqKJsOR/0+eIVzQyh2jGnlUGaOS
         o4bw==
X-Gm-Message-State: AOJu0Yy+vyznJgg7vzaZcV1hxdJqY9NPDfGzmIUsFSOWcx6xIFBMi+Ld
	DtS7X5FqgKVTzMBaB0TacC2IO9vO2+XH9ldrc1+aS/7JbuRHT8hJGnnf
X-Gm-Gg: AfdE7clab1pqq6xMMCxhZUN01HKu6HbZMha9/sXEptWotEraKJ6cGwfiSAZlqnIyxa9
	QsaqiWDH7vSE2P0WyjRlfsa2iKDMa4QwgmoGslt4zgGIdUv36e+tsyZDVdIuH8RASK7dVEbWlzn
	SVL92Pr4Gp2FuQAAt6iyx7B567nVMU7OFls93YZdR04CvMGTmtQYYy1QkIR8hN3SAKGM0hFs/dI
	/l89pxcknZvzcg5hYH4rBQwW/uwuMl4gpaBaPIlhbuRQBWMNbVVy0Afwh+HtriWJU6ThFosfwlg
	G59LSJDM4prh6eAcqRESBM0KcamZ3f/E81or8ZfxM7KrAePw+ZS9MaC4EGsa/14aekLdGfBR3Zp
	Wl2eLJBdfkVpyuza4HREQJIjV+MfCHhKCKEYD18u3QRfhP8V+gH8zrPHhNoraZulHfoHJN0F3I7
	cP6+DeRJ/LCHDpIYYDsSkZeVdMCC3WgOuslOhKE9zIbmrmEniV1+tBHw==
X-Received: by 2002:a05:7022:e0e:b0:139:c724:79e5 with SMTP id a92af1059eb24-139dbac7a8cmr6184561c88.35.1782497089694;
        Fri, 26 Jun 2026 11:04:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f318e7sm20302489c88.3.2026.06.26.11.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:04:49 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:04:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shashwat Agrawal <shashwatagrawal473@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - enable InterTouch on Dell Inspiron
 3521
Message-ID: <aj6_LZufV_eKSdaJ@google.com>
References: <20260626130051.2574-1-shashwatagrawal473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626130051.2574-1-shashwatagrawal473@gmail.com>

On Fri, Jun 26, 2026 at 06:30:51PM +0530, Shashwat Agrawal wrote:
> The Synaptics touchpad on Dell Inspiron 3521 (PNP ID DLL0597) advertises
> InterTouch / SMBus support, but is not on the SMBus passlist, so the
> driver falls back to PS/2 and logs a hint to try
> psmouse.synaptics_intertouch=1.
> 
> Add DLL0597 to smbus_pnp_ids so InterTouch is enabled automatically on
> this model (and other Dells that reuse the same PNP ID).
> 
> Hardware: Dell Inc. Inspiron 3521 (board 06RYX8, BIOS A07),
> Synaptics fw 8.1 / board id 2382, firmware_id "PNP: DLL0597 PNP0f13".
> 
> Signed-off-by: Shashwat Agrawal <shashwatagrawal473@gmail.com>

Applied, thank you.

-- 
Dmitry
