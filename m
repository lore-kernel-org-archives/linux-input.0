Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063045;
	b=tlgeMxWh7v+cROomIOHOJ0LRUtxSHOuJJhWE/iEzcXKnLH/XalOiWkeBGfhtxJvis0kA
	 JZczVFFHZTOJ9lk+zp/W+nXw1WKz9vQsGk510W2SyXS1o8Mio91AbXmzVODeWDIT4kTzv
	 Hqr6+RGiloDWjYW+hiwjJk/XDc1GqPeQeOmeTdYQkolHJb5ROMixFCmTXPWkWFFwo7u/H
	 gsPuO/LHyWq3ZUTu1AOsX7hZuF3Gq2BidhTrRE3xcX+QdSDG1ao68VvJBZ6k13ktkeZK6
	 C+g68a1V7D3cWp6TkEO2QmMMTUaDVfeVvvx7qDU8SeshxCseGBzls2kmspv+1bPI0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=avJfK9ypBt2H+1641GuxSMWS3Ix3bhB4BbXP3Vk7Io0=;
	b=V4KKpG7+v1AhN+24PTZrFqgFnMQJCH9F52F/QDRACofb+GWyS/hPkj0Bo7ORTbVU1IFN
	 fhS4+crFpNe5ion09hafnMhjidqzv0RBqzjq5mv+23z7KZk4fyW34WntorLygU63/1ZYG
	 8aJwnct9wjLUBdNM0Ok4kBsnp23ADhZ3IYxUQMYQlNLFmk21U850HxT8aCWgF1Fcynly8
	 x+H8npCneNv8j0HMLjpdLs05Jp5ImDlHHb5iOviq7+RzsLm/V+EVM6G73xrrktkNabwAr
	 em2pZAid+pFkpN/rTMPqGio73Q3lzo4IeURPu8XGJWKJWDl7x8Z6LmlgJp91jH5n8kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="BrUCgXd/";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990C606A31A
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 01:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8990C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BrUCgXd/
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1438d9363fbso464640c88.0
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793063045; x=1793667845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avJfK9ypBt2H+1641GuxSMWS3Ix3bhB4BbXP3Vk7Io0=;
        b=BrUCgXd/vMTFKCS+tslv3QI5iMM2mw/qFh1VQWsnDLDYy6bpucSGruGQUC5QV3jnCC
         2G+/qG1otv3a3TADIOQsyUMECVh5QYu9ARLAM+2uW8LZ6TSY7isyWL3wk+KIZrOMn0XI
         ewJce7Pj8wwqY9s/fHBQYH6OO9f29Hz0STqQDdzciiqeNPLFf5oOy9oMDnQnLh6vQ+Q4
         CIg8/yBLGLINaVy+zN5W1x/2BnQqoCe1EbSgqa/TO6B+YDsWkMmSQPP2QR3s1uF3rmhn
         K1jZYEFD/jIrLobGT4DnSJI6dfRwjYA3Gl1a9M5tO/KZYo3NStDgq7g5rsvVH1VXuoX4
         UtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793063045; x=1793667845;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avJfK9ypBt2H+1641GuxSMWS3Ix3bhB4BbXP3Vk7Io0=;
        b=BMNBQ1GTk1HPe1UPnEDyapQi2rib57ybWfMCQQysQ890zzBS5aCKcEL9uLk5oGu/0Q
         Y5qKKKiV6tPs1xVS0CByL0VexBDxtzOJsrM9hsQd+Z/0LnCA6oNVuWk+6EvvOXY4HNhv
         WEg/4HjuQLezcqMYkm4EEQSd4GzfVC4BNdyJLIMtStZqp03j+q3a3+psQ4FiW6NjwMvv
         7D4ioqFFpP3u1VHZRiTmZUf80tPcTXkR6CO3WZB43sBrrv/4WMug+i9+Wyl3yRKtf0jZ
         xopWA3jNvx0ekmLGRsyVZO4XC93abVtKj7LUUzNjWAazQuXLsbKCuXCn81+Bdxzk+qrA
         njww==
X-Gm-Message-State: AFq9FYK0g0hkbTzBVfRLB9l27kV+iYfRDnnaCDKSjQLJpsYAQQ+GtDVB
	YcJKfF9HS2UD3AW9rpfxAd+zzKKjBLlu9/csRVox4gDxAkKmBk9fD/J1
X-Gm-Gg: AYBFou0GjTU5OJR4hT1FtlUJDi7k4oDpLknF/QrRNINXiOi/H+WXx60eWPmErpWA3Qd
	bNVQkj/lcixiXnhcyGxAO9BVMs4zV9a4e2lpCoMkpcHwaBbVGXpGNb1XqBgUIZEqV6U5Uk/zgxe
	gt7vt1IUkweKmun2QWqaaUQJQR0guJ/nagui9koWaZoIg+7KTJw0NTuso+LxbpJmc58ALO2AbXD
	xht14ddmNUETQUOmGSHwvSmph3+3ulR+7SZy4cwGp2eeTwiTSNVeDWP+po/E3DR8+od0YMUtCig
	uvKe7gmocg+JlpD1yed0u1RsZ1ts2E+LBkwAD3bI5YgiERffXiqZyVfOVuWReFQtocUtiBmqku0
	OiZWWNQ/y1QqChbEvCCD6MtEdhKNUHytjvK10T92JSt2qIaDOm6rp0vG5FsUHpov9n78+VZy0Xd
	mnZUFc+VFVlcm4Wo1s+qGqvkZdKukhBjoHlZSPjLphr53HW6Fkq031ErosUM0aSKe0Jsu64rgoi
	nyvEXXGus/3QCCv44ySc5guqEVCEgqcyLIsBCkl3pQ3LF36NZqExNUHZ8uHnGxdVZdeLo4B9yny
	CX7LwTnQUBmQfV2vq8kjytapfjkCquONq5bx9ovzeiM=
X-Received: by 2002:a05:701b:2094:20b0:166:f097:6f10 with SMTP id a92af1059eb24-1a3c84c2d6amr1621178c88.11.1793063044277;
        Mon, 26 Oct 2026 18:04:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2dc1:2e1d:6b4d:5a9a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a14383b02sm937423eec.14.2026.10.26.18.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:04:03 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:04:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH] Input: applespi - validate ACPI property buffer length
Message-ID: <at_4L4QXfXikGrAy@google.com>
References: <20261027002919.3589149-1-tristan@talencesecurity.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027002919.3589149-1-tristan@talencesecurity.com>

Hi Tristan,

On Tue, Oct 27, 2026 at 12:29:19AM +0000, Tristan Madani wrote:
> applespi_get_spi_settings() reads three ACPI _DSD properties
> (spiCSDelay, resetA2RUsec, resetRecUsec) as u64 values from their
> buffer pointers without verifying that the buffer is at least 8
> bytes long.  If a firmware implementation provides a shorter buffer,
> the u64 dereference reads beyond the allocated object.
> 
> Add buffer length checks before each u64 dereference.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Cc: stable@vger.kernel.org

This makes sense but we somewhat trust system firmware so why is this
needed in stable?

> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Why is the difference with From: ?

Thanks.

-- 
Dmitry
