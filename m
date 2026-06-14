Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E432AAAB
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470624; cv=none; b=BE1aFVsQWh1TSyol1ey4Jy4ijSQQmzS/cECZXbUUQBy1O3Ts5gdMtXq0abBzCVqLllK3aUYh6TNrKWxwWCy8p92fgkISverzfwwwtdZ4kNff1WJWkz942cKE9qrSyU3llvYdy9m8xc04mg+rsNoZo8CGnJIU2TUnTAxy15KPhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470624; c=relaxed/simple;
	bh=+bi8XwCzuwIhibsEF8K9s8nePKLZJJ3bOGbQ9AVgJ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANcILgGP5sTLerSNl/2qk73RLjdv/3JQZyQPZOC9YsYaEhcWEiE+0AjHas/91fItlZWq4IdOyVI+I8oknx2P9BF2u79j02j1H0u9A4/NAoimrtT2hw9tlW2O6Fa4sYiDYtiF5/KAjOWmKLZnYzJAWBDIpKdpBXacui0NfYJCqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXUpFcjI; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXUpFcjI"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso6138651eec.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470623; x=1782075423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5fQgJl/JNDh0rlg6/DBaSueHDvPwrSzOEw4D/yzM6I=;
        b=KXUpFcjIZ/jFy0425QBnBgdBgC3zqCK10Hox0xjnGKe84qPAKziR/oJ5tzw68tUFsM
         416x9o6SgNax1G+zGYRML9D6Gz3JqHdGN0wUmSdeVn0aTsBGoT84c0do8+DQ9IKT72Nr
         zl58flh/utdLPeT6OQreduj+xALdweBtXKZpk/OnUz2Tc7065Znlrs+eiPyPpiYx52ON
         IkC5p5D/9C7Jfcs78kU+ZjpHUR8Y1BKSpaACkZ4vAzZr9ERPZO6w3qo1Qy7aUMK9CjXg
         OhINfCUFgpbO1W6rNvNUYi5X5owIG46YQ63lKMaO6oiTj3I/AKEqQ0Qp7aRXkSFNWl8S
         qvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470623; x=1782075423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5fQgJl/JNDh0rlg6/DBaSueHDvPwrSzOEw4D/yzM6I=;
        b=BtLa2lBar8ASlfY3+p1+mVm6h+YgIKdf6HRzysl+z9B5Q9StzJLh3Hk17rwt2SeDqs
         5vDKg3IYpGoZeTsjm28YG1/908rJVwG78VfRRtw4dMMPXIPQdiAftJkZTj5i/jnbyFjE
         hVzVFlEH0jFPQ1yKg4ir1KXNuz7qniefIFAPFugaKdlt7voivgNAGN2k5thnhw7UwxUk
         NPHSZYpRnvm2B1WuufQjE2idvNz5KFYCWRZ9csEw2JZcxWUNXVTa+xMdwwKs+a99SfyQ
         /IZQqNy6s09P3++4Z8vsOOfsZApqzjBAW64MMcbMKFGOZLOn5AuN4UyzfJJ2rjrqlxyb
         YGcA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vrc2rInooEkSWr+OkZegHoHgbkkd/U6BtDXU3tPloM36joXgURMR7ZdiAcXMwxvyDv/DXu0xVgokyFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxX86etHaS3dennmfC0gaSw5tA1euxzAzrzIE/EJXNTSa/puT7
	gZVU8DI4BeEhhCdtYqvm5Sdw70OOMeyGAr7mTkMT/2qkmqIIeTUEjTty
X-Gm-Gg: Acq92OGBZ9aHX3VB/foqsvStSS+0lOgaapxwjoMIP7MxyB8Lmw9j7hsVIeG9CgIc2c4
	qOF4T39QyNA1xkvHNXDHTebeo7gHjuZTNilVGmgBV3DhJqz4gCnyDM5ZtGeY56pReCNHd2J2qkl
	zU5dGNbFavzTfQcJQuIwfRVGwduVbF9d4/HY8u5aM8Lh4Gis2VuRtawaHVDy0DeSuONHlyt/fSG
	Pwn8ii4BrmAwmcXpfNMAazLAe8wdCEQ/CVAX0lLLvEL1PjIIbwbINfyX546wIcWUG+VgpNmb3xH
	nsAWZWrv+zStaOWZIHZjhkeb8KRiJQNs995nfQmsb0CuMZJvIhgIENyanbh5xfdUMfJwxJPSxwe
	aYASZh7EMlvB6mtKpm7Nj52OXALj8U23vwlCjZyfS5KZVk51deco1TR6np2vfhlB1Ts8GofC6ze
	YKvBd5e8N1uJL9sXiTU8HYObhlgv2VlTXnSzUVrlLsmSO/XzGANBAHJpt4dmjKBBMs
X-Received: by 2002:a05:7300:7fa2:b0:304:6448:dfea with SMTP id 5a478bee46e88-308200de778mr7033067eec.33.1781470622807;
        Sun, 14 Jun 2026 13:57:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5d91:5c26:602d:6a99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e489536sm12233295eec.2.2026.06.14.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 13:57:02 -0700 (PDT)
Date: Sun, 14 Jun 2026 13:56:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: Sasha Finkelstein <k@chaosmail.tech>, linux-kernel@vger.kernel.org, 
	Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, Sven Peter <sven@kernel.org>, asahi@lists.linux.dev, 
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2] Input: apple_z2 - bound the device-reported finger
 count
Message-ID: <ai8U0QiwpBH8qNS3@google.com>
References: <20260613-b4-disp-4ebcbd68-v2-1-0161acfbd688@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-b4-disp-4ebcbd68-v2-1-0161acfbd688@proton.me>

Hi Bryam,

On Sat, Jun 13, 2026 at 08:22:51PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> apple_z2_parse_touches() takes the finger count from the touch
> controller's report and loops over that many fixed-size finger records
> without ever checking the count against the length of the report:
> 
> 	nfingers = msg[APPLE_Z2_NUM_FINGERS_OFFSET];
> 	fingers = (struct apple_z2_finger *)(msg + APPLE_Z2_FINGERS_OFFSET);
> 	for (i = 0; i < nfingers; i++)
> 		/* read fingers[i] ... */
> 
> msg points into the fixed 4000-byte z2->rx_buf and nfingers is a single
> device-supplied byte, so it can be as large as 255.  A malicious,
> malfunctioning or counterfeit controller (or an interposer on the SPI
> bus) can report a large finger count in a short packet, making the loop
> read up to 255 * sizeof(struct apple_z2_finger) bytes starting 24 bytes
> into msg -- far past the 4000-byte buffer.  This is a controller-driven
> heap out-of-bounds read, and the finger fields that are read (position,
> pressure, touch and tool dimensions) are forwarded to userspace as input
> events, leaking adjacent kernel memory.
> 
> Bound the device-reported count to the number of finger records the
> report actually carries.

As Sashiko mentioned, if we do not trust hardware to send valid data we
should also validate that packet size supplied by the device is
reasonable.

Also I wonder why would we want to report some of fingers in case when
device sends bogus number of contacts? I'd drop such packet (maybe
logging ratelimited or "once" message).

You can ignore Sahiko's comment about __free(kfree) not handling error
pointers.

Thanks.

-- 
Dmitry
