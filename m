Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FE1D555
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 04:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771474893; cv=none; b=a5bcTivDd9zQdOnkPFQ7EcucgxyefMhZwGOYbhrX2sb2E5yJFNJeWlUZUcby6D/k+NeomM+QuWmF3Sc4XYmOK1Plo4LFpZEW2X2GXIKTOFDI2XPEcC69tJxDkc/c0CP77jrTFdzdIOTWoEM6LUK9ag7mwM6/ubxUc1ZurM9bCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771474893; c=relaxed/simple;
	bh=/Fzizo3yusJUP2ovcIzutUgUDMEZwEl6ZxV/ZpzhJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVZV5/M4ZfwmysPHznOfJBt4Yz+0Ijtfltg9PjHOnWKKQBbt4SewAPV6XTCpFjuS2QAvr6FednnqxQXsMsQnE/kO3IM9gQPkBG3Z/4hrAplLD+yG7CfMu8ykbVjRMzoIvQ3rRJJSivcFoJQmNCHZunZdTjzZLbhmfvMeuiCAIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmCeiD1D; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmCeiD1D"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-66f3e7d9eccso318912eaf.1
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 20:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771474891; x=1772079691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDio/2GMwWj+Msmfl056o9NycQmZ+bkeO+GVRZjCPFo=;
        b=OmCeiD1DdBJ4XD/G3LY16K1Bfr+5Oe8d06c3WmdxUF8LgWHg+DjnhWMCywrObUrpaw
         pXGePLnpBmqD/jVRZ7ABKUg+WyeXWyGORP50BkUOYSi/pSrHMPQPUURPH0j9uLBZyi35
         ketntvedDOnWKHiYREpFoPJKU6vOxH94w0XVuk29Avt5BOcrsUp2/7wM7XB18kLDN1HN
         vnzxV2uvcSKg3fkweMZ2mmd5BSpCN9R3E+wqXF4EvlQrZ0jHXyzTIeiz9SyiI/Q99b4I
         Dc0tM3cdNpkgdZjDC361KvbIKoLK88kMMAIO8N8Yc15VBG0d2wSf075TnPh0mBc+M00u
         sHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771474891; x=1772079691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDio/2GMwWj+Msmfl056o9NycQmZ+bkeO+GVRZjCPFo=;
        b=Bmsnfr5Bi8AOCRnVr+Y6NOgQaA2+WfIzZrQWrZ75hiWYezrD76RL1CFG7ybHxsWw6D
         Ac1Yi0IbthIOTpJiLwyACzUwxCKKA6bt9A+qs900ztnS3bMnHVL9T+HoW2rtQSx5wh12
         rRyoApurv3zV+/+lYF+yejhZskRZ7ztMpkKExjY08KUpywGbwajq8a5dWKq9wCo6w6ZP
         OeaCEmIQiwBK9zCtbuW584+tdqSdS4utyrX10Ddl6hW5tHl1fpI0XLZ8dMSTKKymuNw+
         ykA4GBJDhIcVgvphHPLwp+Jd7UybhtB9D/cYyXnxvrGX8aNUvq3eZtP6xio7EuzjvR6M
         jyFw==
X-Forwarded-Encrypted: i=1; AJvYcCViRTeL6eXXXvIHzwBZZwn5c6neLYzGyy6mojl6QAKxrSGDkl3CEnphX3d3cBGDel73q3kw4N7WROlT3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXynPKjSA3JI3X6ucQWsGR6HPO2VRtAXRBhMJhpJUHc0JpYFAk
	BQwh9qnmUhIedyshynMGmCDR29u/TCfvF/JRVOMPJW21vtVJNL4Tu19rfNCoNw==
X-Gm-Gg: AZuq6aKWT/ICqrAIEUrOiR/Je6VgndFp9/IRWGTaulAq6/VLwQeYyvjbprT0xPaFQk1
	I2swYBK7XSkRg81RZ3K3AIbg7j6uNdFSKFB1cnyJLl37uRuoSCTWFXBeKRau/CysKcytRi999hL
	EhpyyC08xyYoG56N02CgGHqpLOhX19dNJLB16GjLSiTV7T+R72M1DWwCxfYZLpEdk+RrYgdo0St
	rNM1fRor+71Omln1gr6jJV9WzuW3Zrt3PSQlwrpm1jjxKy8LK3dTvJT5SWAQgWCtsAbqytvMYOi
	qG781JNdzCE2Q/K+nb9mmx47oXDnloeDZBSCvKshv8mRRSeWl/4G4zmSv6Mlfu3aazujUEq5QpX
	+mZJR9haNuWlKP8MviTIdHngHD5UbKBke6MSyPDz/O9C366OD8aO0cr8xo4Y1KD0Nn6crKamc5Z
	r/2lb4/OCskV/KcmGJx9iUB1qocBjEG3wJK2noG/GitQXPTX+lrTuko7hMLF/vO1SnwQzmtxtSK
	44=
X-Received: by 2002:a05:7022:2397:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-12759a87feemr1681224c88.38.1771469133294;
        Wed, 18 Feb 2026 18:45:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc9376sm23655808c88.16.2026.02.18.18.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:45:32 -0800 (PST)
Date: Wed, 18 Feb 2026 18:45:30 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liam Mitchell <mitchell.liam@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bcm5974: recover from failed mode switch
Message-ID: <aZZ5BlvP-u8I8V6a@google.com>
References: <20260213-bcm5974-reset-v2-1-1837851336b0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-bcm5974-reset-v2-1-1837851336b0@gmail.com>

Hi Liam,

On Fri, Feb 13, 2026 at 10:25:40AM +0100, Liam Mitchell wrote:
> Mode switches sent before control response are ignored.
> On receiving unknown 8-byte packets, assume that mode switch was ignored
> and reset by switching to normal mode, waiting then switching back to
> wellspring mode.
> 
> ---
> This patch addresses an issue where the bcm5974 driver switches modes
> before the device is ready, resulting in an unresponsive trackpad and
> "bcm5974: bad trackpad package, length: 8" repeated in logs.
> 
> Discussion of issue in the thread:
> https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/
> 
> This fix is conservative, avoiding changing existing mode-switch
> behavior because I cannot test all variations of hardware.
> 
> On receiving an unknown 8-byte packet, we assume the device is not in
> wellspring mode and schedule an asynchronous mode reset.
> 
> Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
> Link: https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/
> ---
> Changes in v2:
> - mutex_lock -> guard(mutex)
> - dprintk -> dev_err
> - msleep -> fsleep
> - removed 0 init
> - cancel_work_sync -> disable_delayed_work_sync
> - work_struct -> delayed_work

My apologies, I did not mean to request switch to delayed work, just to
switch to disable_work_sync().

I fixed this up on my side and applied.

Thanks.

-- 
Dmitry
