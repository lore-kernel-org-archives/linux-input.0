Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B2480967
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990629; cv=pass; b=nr2i+Ja1JcEWJAgTpPHXD0M0xF5dYcSq4R1qL9phf7dYERmX672b0ekFouT8qJh4ur2FAKp+qRlQRQ1Ef3v4ovIoVpIufKxdOw+X7tXFGLTly3FIN18hfNe+HC9uUHBjWlT0AKaXAJu4Xds5V8WYKjH+RzC/Y9W89yD5KSscOYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990629; c=relaxed/simple;
	bh=FB2RoDWHRP5TG5kB/5M7XrFIp8sR/BsgKWGfpjGsJ7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGIrjg1fG6Yr7+WsCpyasKv459+1qycJAj5uqayy0B2y7i4UIwbsrlLMej1ucflVFvyS3yWImyw48DQZIS7EzLSNbjhYzPxtVZMW5gD5rAkUVIfBVDHIZbtNgFSb+qzlQslPxuVnTb5XoqYU4xud+MAyQ/ffibrAKgOstW9p0fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzl3OPmN; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzl3OPmN"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47c7b282d73so2101279b6e.3
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 07:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990627; cv=none;
        d=google.com; s=arc-20240605;
        b=MNMr4hzM6Y3UEFlAyfK2MGfMUPCzFRgc31Zl1/Z/zxDb+/S+ki5BNcIJzYXZlPFyon
         Z9yU8h6gNQYo7gVTRppEkRAmxuUNFzMHAqm9zk/xM6ca3lBmRKYrfFbj//zoJCYV/xvv
         vAEpqQjZ/KvdYHlMnLh83wulrimtRQCofy3Vzo4Ev/z5EPEyHvpLp5y4kknCStU5dGVd
         JLqjsJ/6M5jOwIaxNOX6lI/gBMezqYCFfCvikqBim8f6hIKdo7lVI9+CT7go2PNXq7+3
         u91RfQGx5rMbY+wnspeixSkeM+8xeqjGlFaFunba7NozzGqKgpX2/XtXODtUUgATNrBr
         ljlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FB2RoDWHRP5TG5kB/5M7XrFIp8sR/BsgKWGfpjGsJ7Q=;
        fh=AAu1zBi1/G8loXzjnWwjPsY9amLO9lpqAHgdwV3Tsog=;
        b=IJlUFvM1VsydWO8QN4VEXQwSCYdKuUA3YdcX64Wmp0iDT/WBdhHIPmBhX9gbl0bS1l
         VtRxaMv7NDf1VOdktbHjJ/mt9bRV+DcsSSp9R4tGKahQr+irmwcQ59hopNfMTYxs+FSH
         87AFhVWYQktj7pLIIEd1xBwaLDZLytze52++rZxYUM0ToQbIdHVd2y1vBU+XNX86bvV4
         dMZOVWQTB5wiy/ojrD4w+svDLRGseB7dDwDUkIBtUoPxnGDtITPrKbqR8L9Dk521wRPS
         I5XkMPy1Yiqi06zfNkuar2BKIM2I4Veg9Opp4s6xrgfQlkFD6XIn2wTNM8CusPj2c+09
         ySRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777990627; x=1778595427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FB2RoDWHRP5TG5kB/5M7XrFIp8sR/BsgKWGfpjGsJ7Q=;
        b=Pzl3OPmNbRFXefl9IcOnZA7H9fMzRofk5oQ+2HSS1vsO9iD9sJrjwwbXTK5YieAQMF
         CaJ1+dTVLk6GYf8mryxwZegBd+xDZq6ZC9yBqF6/6K34p625kz6Q2ARKA2cZ29CWbUpd
         FLHdSBHl5xAKp7GGfHvxDWtedmG2JKpCX0aBvTzk5EiYUopWd09qkD+oh8NwgFmnCMGj
         ZAc5rE85g8uC++QPdij++lKYb1Ibe4ycdaTLUkd5dZq1HbSh2pUCV57EenppwJxsetWX
         MRh3sY/2kfJegNqkrCa+UGe3Yp6OdgVbd7Cj743W3oeiKU2Cisf4pv42h+GaU8M10Eew
         Wflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990627; x=1778595427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB2RoDWHRP5TG5kB/5M7XrFIp8sR/BsgKWGfpjGsJ7Q=;
        b=aafxbSUICvXE0RxAa7ebjPJ/Lzx3vULKlljny04Q41INV0y8FI5CHi8GP4+vcu8OL1
         1Xyg9IevwHXvyP1y6TWTMKqBw90S16C+oR6Lij1yO6Zmssrwgd2mijzd7X0uCdZxQ0Hi
         U8zUu9tT0gy08evLBDKwQ2TRUoUfz06+ZMhcNLoSCyCSGk69R6KCLqrZ2SbR+iM21VQk
         KC3W62AdhZ65uLx4eFzvLmhl8t5GKzEN0DbCAqLky2yd9H0UyVTplieg0NtGXSbw+I6Y
         +PvoeLS3qzv2GsEqmzhTpVYXHURs9kbCpPWQRc6UmEmAViHIGVcefHIRk9R8fXuqXDGx
         Qeag==
X-Forwarded-Encrypted: i=1; AFNElJ9I4PUTQWLp4uo0KrsTUMA4Y3++2qSL6ehXJ96IzDEqzAA2RnzySjrk3zSeIjA22JSwgmlFVj9A5MOewA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRN6hQPBCKKx330MIgj9JwgtPjrinyLzEM0R0YEXJxCYEf6ox
	49x6DLYIEf1nl9YeV3ZxBdYmkJPEEaOmC5CGI+uSNftF7NVCgotCiWx/Tgr/88NfvygCEKdapiR
	njcTwPNyhc+LrZGiY2rY/HABr5Holwdw=
X-Gm-Gg: AeBDietkPRp0OxOrBCnvOhsM4C+JIe7eS0gfS05rW1bc46KEigzBdZ/5M+sssVieG/G
	ExwOd0RFkiTYk1ZgEk+4KQvgs23Dq28Xprb+1IbtXpR4yajsjlTA5w13jP3kGQb3jQNwCKm1TKC
	UT5CG5lvA0nH2iWMfJqJ2OyVg6uvxD0uzM8VBboWMQA3bHUSYT6gE6KqpPU+PVlL2jGkU0JleQF
	kSlt9G+4ohiVLAQulIRSKPEj4RrYfm4Yb21pcji1izZts1YOov8m3/YP0WfCjcbexPxYAqtZMTM
	S9GroexIampQXswVEcJWwqYW/SQ=
X-Received: by 2002:a05:6808:f8c:b0:47c:374:20cc with SMTP id
 5614622812f47-47c892445ccmr6953376b6e.27.1777990626486; Tue, 05 May 2026
 07:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503072643.2774762-7-jye836@gmail.com> <202605050414.YJmW3t4y-lkp@intel.com>
In-Reply-To: <202605050414.YJmW3t4y-lkp@intel.com>
From: James Ye <jye836@gmail.com>
Date: Wed, 6 May 2026 00:16:53 +1000
X-Gm-Features: AVHnY4IHW_EApghA23w0AimDU8GeJhlp8R6o_CN6px5MGNoaZm9YKYzSqzJ4U4c
Message-ID: <CAEV1_7HRUhPHorhKoaC5a1f7-hyLpDWrLG29XHfc4SmeffpmpA@mail.gmail.com>
Subject: Re: [PATCH 6/6] leds: led-class: mark classdev as unregistering early
To: kernel test robot <lkp@intel.com>
Cc: jikos@kernel.org, bentiss@kernel.org, lee@kernel.org, pavel@kernel.org, 
	oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	denis.benato@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 12:24, kernel test robot <lkp@intel.com> wrote:
>
> Hi James,
>
> kernel test robot noticed the following build errors:

This is due to CONFIG_HID_BATTERY_STRENGTH being turned off, I will
fix it in the next version.
