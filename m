Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88147CA8C
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936578; cv=none; b=l5Y/O6pw2w/QWHJcXevcryIBnwdJ4MYyTBgsRqe8JNBFy2wSns7GkKXwFYflCocdT2lPNXqReZy9ritovHjahGcBwsmtUqgK37W0izPUxVVTo5TvRtXbbtLHiBrUsDEvULi5hCTRvP9g7Dn+RYZ1y1wKpyKPca0mbZIvqA0nAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936578; c=relaxed/simple;
	bh=zq1/aw2rzNVAiRX3dG7S0FIaSXrYCkGPyRirT0DKjo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h28ymKFchaDtJjZXZGdgP89YZFRp6XAQ6UFhrC1cXSYbE/2rhGJ2b6jS3uYAoluRRQDBR2JYaqsiIMcZjK/ROUjwWq6vJfGGWZp2cR6tnQsRF6/i3cbY19RenZJHx54qlN0GoMEvivrfS8FnT5rVDqRAkvdRjOn/FMd+PvvfZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYlKKMrt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYlKKMrt"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2114786b3a.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936571; x=1785541371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WIvddm/SoVY0JsjcwTl95nJ9aWsgQES49WF7YDGAcvw=;
        b=SYlKKMrt2HJ55cCy7poivcZI4+TaYB7DOm9qFL8eX1GXIiFar2HDA3LdoAL2jBOPRO
         Zt76s4YDb1Swf8TfMLtkuwKbunz7yl+TxxpYo+ehTYcfdjMIiFWsoJ4dff4FKNP//DqV
         gyi0m7EoHaB1i0eVMBk6yZboHaMm2ogcqYqx6CykGVq04EC2B1xzgK3/WOGlzOx50+up
         XNy8ckT5oS0YK5Q480Um/gkUnyJAw6SZY2CtfHegc5Fr/WtPYkEDyu0G9PBJeprgUK7x
         4jP515go5S+R6o3gYlJk0UBH9cO/cvaWtIIZMFMQ250UNBHvZrA1w4EIYQCKXFt/G/u4
         +PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936571; x=1785541371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIvddm/SoVY0JsjcwTl95nJ9aWsgQES49WF7YDGAcvw=;
        b=AeDzjiZrSc3VLO1Rsf08cvrtU1It4WfinYfh6ZBMQKVIbuKVAcVXUVARYHsGGDaDEz
         wb+W3BrRr7JZaMRUSN2eNeLq5eC975gfL1grx9PFMtZE444oCmG8EAH+8INquEi8JwQc
         oAcRY4rD4WQRNf8SLV7ze6B7imsgBYxLJNr8Dtp6b7UlMeabdDLWDW3guaBf84Wkiuzm
         qohi8XrqFzsWXLzdAKlenFnBJS//5IQ8ItKJ2X1E7p70ROMLY7YQam/V5xjZcffM8g6E
         Pf+62MgWzmwLcF5lpeOuznX5nX/CSvqBVf/ejdwZrO/X58Cn+aPJF9HW6NTQrVlTy8QG
         y32g==
X-Forwarded-Encrypted: i=1; AHgh+RphtTi4DwDzGS8HmRrtEbD4U5EeYIbyjxUnwHOUMgLaUPKoIMZULdEtcwYFeHh/l6+6UApn9AJ2XpSESA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxELbcQcFsparZoN+FnqU++vcFYlrpwwW2Q8v/NP7NVPVXx6RpJ
	eh6MJO1gkxmphwR1FbJRvu85DWjm2RMZiK1j6uJI7Ys7NScwsDwPtdCz
X-Gm-Gg: AR+sD12l32gfNbMq31OpZKycCnsZ95DbxyOrAbhQvbhnXMDQlWb8KESL0wuiHtoa3GM
	7+wjo/7o0TZDbZ/VpDPkYm2ON/8+YbbT2VptKSNHvJ3k7IOWp5Sli+6Gt53+mwRwfx3zmx+x87R
	Tk6EdDcaUyAyTp+4L/a5Wb0/xrgqLxGSATaWHwZde+05iUcr38l26qjOVlQ6UsGTrLWhFXdFhUv
	yRQqSB3n6kQvtfmmHbNXlAsxr33PWpdLl72v7Z8gl7cKQufOIr4hSSBCPRsrtionLiiQcgWicht
	jV6obG6YAOPoLJtHgUkahiXWhg6cIgOKrI+eyGEgvkTV/WNjPot78XgHyHWbeviDcrY6PvL4+rT
	yGsmaj+B+aIEb2DXy6v1smZbC0XycOs7WtbRb+/YEQCseWhtOdFTNtA4WxbvZFi2mLPGTsDAkf1
	Jt211IX1T+7nMt4jwY1DhAeYWOpXJT6wiG+Dl7TUPO1Nc=
X-Received: by 2002:a05:6300:2287:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3c67236feb3mr2624676637.1.1784936571055;
        Fri, 24 Jul 2026 16:42:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc4164ddsm3312255eec.9.2026.07.24.16.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:42:50 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:42:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <amP4csGgdg51VRZw@google.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>

On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Applied, thank you.

-- 
Dmitry
