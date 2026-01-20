Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86563A0EA8
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938797; cv=none; b=g6MUh9uIfLR/ucnhSnrsdy/Ky8YRNWDy1Llik542W8KIXjlt4r4dXWKqEEavWJr57l+rFeaNyVhQ+Gh4ANcUgaf/Uj8rwygGxMSepxrCX95+Sq0qaU+RpV7yVzqQen+X6FnyjgEeynSQDNU0pWYdEDAIjO1zwXEjFznb4aNNcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938797; c=relaxed/simple;
	bh=hzlIGlYQi366/pUFdNolodFmxI59+xO3Up7iWwZOf0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0mgeE4VLWTGhbOTiBm7v/VLNUXPkoQmudCoEvgV1naRQOaMbWkPCjFdZR7alfjEaiBfGpn8agzLO5rV053CcVZ9dF+og6zSbCcDBsPgRCztwwtDL+RCHBNkbZyONRnQ/ikilyyHSRgb+T43r6YWP2CwwqCGTPtFAQ/CIrZ0+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV7uS9Z3; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV7uS9Z3"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so10790256eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938793; x=1769543593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FKSGoUPQXpk7imDzMvWC4kCJaezJl3fPb9J0kmFWLxE=;
        b=eV7uS9Z3/ESxSPdR4BMwFVQglCKVJeDCfGbDBnkC2NVKd+CuTESYZ/S1AJrxvoWzDy
         bg4MINHvtS7Y9uVRrH04jS9eLhHzYgUg+rbgpLU2/XHIdCLc7b6xjSwvM9K8peM2rRfa
         KPoXFn1VB/Jw2u6P5xrfNGOuZPiltCPOW+Kum82Fde+KnNdEF+Gg6Seijmdevi3btilt
         A60cDJXknpMnrIrg7PswXWQ9a5epiiURd6m8OsK2DK9Uo6pIT5QHUCP6b8TaXLHtm5c5
         kglQrqIDNi/tEzJc0Qo8Mvn0NyTcLFktFVDS+FYwSN9FzYtcfUHOank9IxG2XOHuuAkD
         Mm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938793; x=1769543593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKSGoUPQXpk7imDzMvWC4kCJaezJl3fPb9J0kmFWLxE=;
        b=FU84qEjEf+vYSIqde9SMJOhBUkWWZ4qLU2trl3vQ5KyA7vjNz6mgFEKyaXlYpxbMb9
         N0iKOV2XcQwB0fcS1BVLnufOo/+tL5j6g7NvjOGJjUI1fVsB9ZS0tosb5u9ciLZbsgNP
         RsiHYumEORpwwuQj4FwqicW3xXr2ZcN4rgE3rzeAQrAEHmLHv2McrDOHs6d/ku7UxJRE
         N6ps/JLZyYn2URp0Jl8HhIu362ZF23d5xybgO0/FPuCc09If0qPcFUxlFk5vdGfF2A20
         DBGRSl+SWlNh0H2wFfbrCo3BEgZPq+zPHe264bN8M0haNMstCmOyXYIuXRI1eiyAIuQK
         fQmg==
X-Forwarded-Encrypted: i=1; AJvYcCWs8t1oVddyfLIwKQyuhEETv7XFARuEKIFVJL54E46fD+/7+gqoKBVrPQrTp4zNOwFOEySm/x0PlvgwaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsQVApqmaQCewvETJaZwM9KgXC88zjSh2pfoX8iqUEt1BHs5X
	yljkVpJkeIUTpISmR67rL1V2svA0/GCj4Ey4yFeYPHPwc2DE+vu54ETe
X-Gm-Gg: AZuq6aIQErFQeuDtIQKinowPXT0tYFP12mI9ADhipAbmlyMtAfwyB4LzFikSJ+vHbjs
	9/lmHHuIAChWJCkWma4qbzFE+IHEV+gNGDgr7tnj/H/opMdIHumq/VqeozY75ATsAAvyrtGKw8/
	mkV6QSCqaUMK9xXpyLyNd+NhReWUjgcQaxgYnWO/Mx1J6xgG+Nk3vfj76Enfz9K5xcP8NWkjMRn
	xM1rI0VxiSWCUMbIBK5ZyMsAYGE4BKyG9H9bAIn/RdMJfZSNTg4ZzXdanHSQ1UG3dxUNtatgOPT
	mzq9u5PkAqchsPFVq4Xj/1iGeSxNCZmiaxid/hhZ2u7h/+dRNZOHYQhmK3UJC4yOyvW4Ox26CNb
	UrM2F2sSYTCfd0PgGGDzkRcC+T1fvnhaid0ywkpeGGeVzgxkzKQMC3u7XbvoWVhtHjoFe8XRFXO
	v91jhzwaarp/XlyH3BmmTSbhnOArQoYhIpI9/Y2CrfrmApvO5M6go6
X-Received: by 2002:a05:7300:23c7:b0:2ae:56dc:eb18 with SMTP id 5a478bee46e88-2b6b5002350mr13024649eec.21.1768938793431;
        Tue, 20 Jan 2026 11:53:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm18213930eec.23.2026.01.20.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:53:12 -0800 (PST)
Date: Tue, 20 Jan 2026 11:53:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: yedaya.ka@gmail.com
Cc: Kamil =?utf-8?B?R2/FgmRh?= <kamil.golda@protonmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3518
Message-ID: <g7lgjwenwdclj6etwae3jjunfxsgglbemv7jhmcy7hmcyzxxkj@bqolb5yjxbq3>
References: <20260118-touchscreen-patches-v3-0-1c6a729c5eb4@gmail.com>
 <20260118-touchscreen-patches-v3-1-1c6a729c5eb4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-touchscreen-patches-v3-1-1c6a729c5eb4@gmail.com>

On Sun, Jan 18, 2026 at 10:29:40PM +0200, Yedaya Katsman via B4 Relay wrote:
> From: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> Document FocalTech FT3518 support by adding the compatible.
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

Applied, thank you.

-- 
Dmitry
