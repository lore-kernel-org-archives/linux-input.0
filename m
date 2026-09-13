Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494F34027B
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789343021; cv=none; b=LsBjMYOXQDTCHDqMb7R4BJPcKec23EHRxKwJO+gfWha8Kf5eXe6XGJzRlZBnuOCU5oDcSQlbhZaZxD2iC+B3D/lVligHU7rKo5kNpAPXE4x6lY8HPZkqANmjK5jh8uwm1npF7aV0BLHFtGhsKqHcBAjD5Mn3v+sANm348lwpXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789343021; c=relaxed/simple;
	bh=TGGP5vDECq/Xl/WfGYZwIHMNEj0w4xAP7L0OAvtyAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkx8MLrZt/qUSY0JJglS4m9U39OeqpWqlLqP8987QvKngZM4+XWcBGNh+uabwAij/thCi1v1u7OKISYq3jO5UhkoIAEqLnvF0FGCvaRgVNj21J2jh4MaDY0GNt6NMQw5rQGsdtkmpHzBG2tNJ8UwVZ5FiUN7P0D+BApmI03IJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdeyyKq4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdeyyKq4"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc147d86bebso3006896a12.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789343019; x=1789947819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7YpDiMYBWbrGICLnZR7JkaBnJhbaNiNwzWG6cuCu/dw=;
        b=sdeyyKq4kOEP6CEFfX8urJ5Nkt3LJzefneVZ/qHWXVjbM7Esm0BI0aoUbOo3U8FqU2
         ND55thupTvfbvtnBChcoBfWvF+OtenvSWrfJehJEjH4/v6ns8Po504ikkKA7Lu6J7zyf
         opKP4ps1EFZ6ZC3t0PtXWriz4c9yUCHO8tqC/QY5dySw3OU4sgWHXDHson54SvTIPfwf
         yG88m3Z8bKHRvFzKEPxNJ/N3t9AakEx5f76ikwk9kmSWOiw3xCa0+yyQ6c6NwT+DbrH7
         t0WqZFWTxNZDEgEqzEsAtWLlvJZb1sgLmDpjpmW0XC7oGCoVW/Drks6GFyBuIgaEbb+R
         /c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789343019; x=1789947819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YpDiMYBWbrGICLnZR7JkaBnJhbaNiNwzWG6cuCu/dw=;
        b=mS1IGKZvmlhIF2+BUemb7KTVcfuISJb7vDWraBYlRFZGtcFl/Qlasebu0J5B0+CAgd
         9waVKB5VZcRkytUcp0MsNt33ogixZcESnYtiymy5nKEP4Gqv/swDm5zXWiEMd7w0ysG1
         a37b7+or164VEjb+h+LWgOn/ZInBkBOnavQfUAfouZdtILq0WPRMZPfUlzKeQYvNsVQ2
         1WOvsOomuE1m0rxHanVC5m1LgIMgxjH3/6tzZvmEZXY2pxbVVNrpieNF+TadD1u36OZU
         UTHbl7x1PLIawFMWtgwL33XQIaybnA5W89AY+UQiA2fEb5/1p0rhpK8n0XgmkJzV5KxS
         7Mhg==
X-Gm-Message-State: AFuF++ntI+F/vswfwWG0ypDajOCCuBYIMhWe38fMfIHhwdMrs8vIAzD+
	B8INfdMIsnJ+brI8q76tiix0efQPty9q5H+3UrgfylIPK0b8Wu+RWiv0
X-Gm-Gg: AYBFou256wnhIEp76WJT3lhy+GvRRNIaS+tIkcZjr0vWPJURcnsfctQgm4KuwT0Ykvr
	QpsTkeTg9eP1JkWwwtyk9AYKE07MACrnlf54S+5wsemxRN7bTifi6HIM6YGjCfg2QsXvn+yazc9
	RjiquCYeW3PJQq3iC31xz2vj7szsbvjOw0yrFUvF+VmS5GUO07c1tNGAO5XxHtxKsUuQw7BPy+b
	aJVTBrWJktP9rK1h2Pva/9OHtvEANcZKu0AOwq29YmJV+s3j0T7GQyAbpvxDPeLwG07e/mJce2h
	d08ENMBg8Br+0ZX5TWxjpqfotr1R6GMPfzASPUsm7SKtfqxLuTnApiOV3qp981AXEiq7LI8F1jV
	t+ERmiLeyrw7MHr0n/iPyOnk1C+sX6QU/Bnico8fwySWh2zY5iWaP6clwHsKqY8khWPGA8wUM6J
	b8O3LzF16BzpUtANRMGK76vBBo7jOxZY5T5Rw2ROe4LVCbTE1B1zUoDvesz2Ry+Ol5VcUPNxixw
	Jp8SzCBIgLGK5RiubvnP/Redu5CFPV2OdsqmJKJBF5d5f/KQy4=
X-Received: by 2002:a05:6a21:710c:b0:3d3:aed2:6f20 with SMTP id adf61e73a8af0-3db26f09602mr5089042637.20.1789343019541;
        Sun, 13 Sep 2026 16:43:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm9666678eec.27.2026.09.13.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 16:43:38 -0700 (PDT)
Date: Sun, 13 Sep 2026 16:43:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	stable@vger.kernel.org, Sergey Lebedev <lsa.uz@pm.me>
Subject: Re: [PATCH v3 1/2] Input: soc_button_array - fix MS Surface Pro 11
 probe failure
Message-ID: <aqc1GgNdo-CccQpD@google.com>
References: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 11:39:33AM +0200, Hans de Goede wrote:
> On the MS Surface Pro 11 soc_button_array probing races with the GPIO
> driver probing. If soc_button_array wins the race then gpiod_get() returns
> EPROBE_DEFER, which should normally take care of retrying later, but
> the soc_button_array code deliberately ignores EPROBE_DEFER causing it
> to fail its probe() which causes the volume and power buttons to now work.
> 
> The ignoring of EPROBE_DEFER is there to deal with a problem specific to
> older Bay Trail (BYT) and Cherry Trail (CHT) tablets which often use this
> driver. Modify the error handling to only ignore EPROBE_DEFER on BYT and
> CHT platforms and propagate EPROBE_DEFER normally on other platforms.
> 
> Fixes: bcf059578980 ("Input: soc_button_array - partial revert of support for newer surface devices")
> Cc: stable@vger.kernel.org
> Reported-by: Sergey Lebedev <lsa.uz@pm.me>
> Closes: https://lore.kernel.org/lkml/20260830141355.55898-1-lsa.uz@pm.me/
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied the lot, thank you.

-- 
Dmitry
