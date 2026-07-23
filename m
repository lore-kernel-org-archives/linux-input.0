Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3533F38E
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828751; cv=none; b=qqv0rEjfkubMsPYXpn5s8Ld6zp4PyjdfSWsYKlJjAdUpbMaBcSpqXuh4ZjKKL33C7qQkh/lG/ijpLtvJjGHi8IAb2C2lo+7CG6Tc0PbPyv2q2+ZEIBbkUOgIENfZKj+DHOO6GtspPGbd9NpwzlnSIBW7RVqgoazccokbIvx00Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828751; c=relaxed/simple;
	bh=KZY5Per6gqC//uqwYOs8Lx6+Xn/30uRA+CAzdNfsmCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiYcDFO2X4Lbo1+iJoRC2oVq0q3Pt/f7TXDHvrV0XlsR6H3NtsvKkuEqfzvmtgS92/4gTibo6O37cpH+xYuVkBMJ0Y/TblBtcBvBbpGxpLXrei/smrrtGxd3i6FzVigCShBA1o5yWhR+aeZ/5neglWq4LtgwY4hFQh7vxE6gCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pML5cErP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pML5cErP"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c96c92c0980so633801a12.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828747; x=1785433547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2O4xFuAHBp+wc0jU7apiTfSbaN5z+iCv3LYdHU3FUCI=;
        b=pML5cErPOAAtVMKfuUfPf8PEO/flUn9Y51MYDcpFUFYnvZlsUVemqVvoVTPuJ0htZt
         uoKAWgDbOry4V/7Y6iXSRRa6ASi0r7KH/yAYiK4pFMy5vUE26Pb2XnhDQzql/cxfm4b6
         yn81KjB3h5Yyu2Tz9bjiE1vDeWxYb/tm270TNG3RYrMgQF/nBMPKlW6NSXsubmM00hUR
         UhxxRxplljfmm7c9foraJEN9RH2Tg1khZGnxw8V7Wofv4Ws5N5q8rzoIl1BjddqA9Gan
         inmwP8GVqRFiCFjW3xWHXrHKimVaodgYKhqiurqX6OfBg7QR8G2zNo2iiczTaluHGl+U
         DrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828747; x=1785433547;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2O4xFuAHBp+wc0jU7apiTfSbaN5z+iCv3LYdHU3FUCI=;
        b=ZBfwO1T6F5qlBpGvkFjR0HalleeBmewMeUKaMpIJvN6sQAZJpJW25sAGhxgxT4Go93
         qRQgjAooFOiWlpnH1hk2DDxvprbOeBZtlsIzyt9lektzAVo7NgJP83mGoh39Zku2uFIV
         dcULGnr6NqHFGTln7PwPWFUCoHB8w+QmmZ7sSR1cPtHbOIlJuNgPMiedoBHqFL7TlUPS
         ZuQ2db+w+NHYFNplOqa+4c3wSmGz0ttyrkgKoGg8WvmTnVR35XwNPc3ERX0a+/4I1TwV
         wGEQ3JfLhTX3QDraUjS5Hn6F+2cqbEdWrouRhgWjuKpSjfwXkvrSVG9ZBbmB7sySdAx7
         tvsw==
X-Forwarded-Encrypted: i=1; AHgh+RrFMNwWhP6psyqfLm9ukpQrcZraOq9VmU6vApA4LwY6tTCHWHXzax6zzjSLvk71TD0BzDSUjQQ7g8u8iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+a77tYzlpkX7UsCsJ3x6qk9KpsZ9DBjILuOA0NxhZarbG9Ypd
	eK+0vKIKdWA4DKvy1P6iwhLGgRjjjKFVmU5pOzf+7WnE/ic9/Vjj/jHW
X-Gm-Gg: AR+sD11+mU/2ppD8+B278rrzIoU7/EVBD6D5R6I494zaK7vICWqbDyxlKWQKJqAwho9
	ly86xUZ0oOCWdVDQADdRwm9i8vX5SdndvOjmpk8tiNsvlcjqgHTrlLqbk3/qKfBiR3TEJbQxArT
	tb9PUcpQo7/bCl319q4jT6K+VCdgRwehkEeniDsDre8b2gJnHJs/Qzf2vvWYXky8OTrkcbE927e
	3staOcNTA6NcpnamYyntDh7Di2tem+EEPjl9gVpEeu6+dO6JnRQC2px4QGR6AAoLHfr1X42N51Y
	8tpG+AVjQ3O1O2aJO5KhW8v2rYVbggXKgfS7VImXbMKcg8DcGu9bftlRZI781Ro20Yy59lXKaKx
	tqM2VG6MPe3JEU2VRNAxnlqLJE0EOV94L1/Els+AroN6WIlLGc5uaPCkpoBQXiH2QIEgBqAauO9
	05sTza1ijggZA3/gUc0IPJ2YGVjKEvVOKPlCtP5zlPTA==
X-Received: by 2002:a05:6a20:e292:b0:3c3:7fff:ba72 with SMTP id adf61e73a8af0-3c44b2b9706mr4676613637.70.1784828747494;
        Thu, 23 Jul 2026 10:45:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f5d:dfe5:9bb9:71ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm23572393eec.27.2026.07.23.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:45:46 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:45:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Hamamdjian <azkali.limited@gmail.com>, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/4] Input: edt-ft5x06 - ignore contacts with an
 out-of-range slot id
Message-ID: <amJSt_g5We0R-eJo@google.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
 <20260723-b4-ft5426-v1-1-d4b4e32be042@gmail.com>
 <20260723114100.D6D641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723114100.D6D641F000E9@smtp.kernel.org>

On Thu, Jul 23, 2026 at 11:40:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unbalanced `disable_irq()` calls when suspending and resuming in factory mode lead to a permanently disabled touchscreen.

This is obviously not caused by your series but might be real, need to
check...

> - [High] Stack-allocated buffers are passed to `regmap_bulk_read()` and `i2c_transfer()`, which can cause memory corruption or panics if the underlying I2C host controller driver uses DMA.

Sashiko hallucinates here. I added I2C prompt to teach it that I2C is
generally safe wrt on-stack buffers, but I am not sure if it will trace
it to regmap.

Thanks.

-- 
Dmitry
