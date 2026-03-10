Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB62E2EEE
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185759; cv=none; b=QAgW+nQElYW0+uzXQCTG8s+8yM1Ykehzo3XoxnGThfzbWROpewdDOmYJGj9DD101dsE+sNO0OyY3ORcH9nhqPJ3xvuQPDFj6Qh0//ElVOSMW69dst5GfC9cWb0e1m3u856LKiCXGVfR9LC4LG+7JzR7gCOa6wkJO+VLM/XCOrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185759; c=relaxed/simple;
	bh=hP+WJz/jKU6NpzI4xyhs/JtORqAsnUOJ5KWRgrIVvoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrLfjR/Cfeml9t1IuIUNZPycltYdai7x++jpzmtyO+o9UQQ58kVkipyW879Sg8nNb1HU8S7k1RDq7/ujmYaJQD/fwkhI6WLnbP1Jc6ekKOB94Iarn8Lh3s6H3oCRzkDyK/IpPxp2t3jfwWOD64Syh0lqKHcDbWxJaPlH59LhTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFkgOqJl; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFkgOqJl"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso13762593eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773185757; x=1773790557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxUPjcUmulSXUd9DWxJ7ndVUYnE5TGazkQsXUEMmZVs=;
        b=NFkgOqJlGiPlob9isuinp0sELIC5WGTzdsj3HbE7W0anXTs9Dwpfyc2CD8/AjoWqN2
         dUuXCu8ExdG7U2T1/P78kxv7Or8EXG8b0HRGJuIMGcLya/sRkWtfAC5MKA6JDSqcKSob
         JUwm7qmPdgRkuk7doXxEyYHFI6/wokj6J/40UUvRb3QzPPFEF4B8u7rkQcy/Ifar7oJj
         OjfUs8mDYO0257I0BU4xrxtf8B6EBVbG7lpN4MauwhTgIrqvyYwJaniJcITwZ3xvIiu6
         VzcEOx1PgRrYKDp2eifw7z2COQM57US6SQpnxwvPAugRWNGDMCUeTxGiHFIXFioKPSVX
         F1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185757; x=1773790557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxUPjcUmulSXUd9DWxJ7ndVUYnE5TGazkQsXUEMmZVs=;
        b=AN9T839Sq9llI3ZuYJdD36oS6q6GcUGUztACJU/h/FdPkJk41jvZbvw5T8ysi9eunv
         u1meKhNYqE3zwsXLEtdq0AE0/eBTxsKJ4nd4tuMIDW51mQ8gSdlzY63YtbFtbf8S8WCO
         8RxRIZY317TQdtQNzXHeWbbvFK3PjhNKIaViuxbhvpSNaktRh0b9xlj3oAXApLlTcjz0
         R9NLdlAc9Hxzlw8iOESDwQ0l1Y8AT9uI6hAclRf64MzMYhx+XHwRgCO8GaYe+xiwsSFu
         2s/Uv2TXO8VxuznO+JTmuPeoVnAAAqwP8xaoC84CMfdfqrem/SXVhbjebgOpOSsolUKc
         EGgA==
X-Forwarded-Encrypted: i=1; AJvYcCV9f5SBagAKFTLEo7fNd6vKMvV1JMYcFWxKBbbOIct9puXrKtgLKM5KLuLqpiofoEBshry+vFqIBoss1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9ezbhBEQttdwQTqQW2HClIK/BBLgF0aOYY78gJTNDgkUIKRE
	eamHeT+H0qbY6/mvxwqqh6+1FElVhuMVXUBbt61vnVsu1GHDlEG43wWf0hDxqA==
X-Gm-Gg: ATEYQzxeaTUfuTQaYAKfVf0uLIDnfpVwvB8cu6kHpSPMiiKMtmZeK45/4KZJQVCki/s
	8m7O+QqW8A3mtJywYZFVYKt+y3BMXIB3pFMtknNtSwClejhreADQ6ECNmDNrE2snTjZnWqUgGM1
	iGHdFSRaloNIyIljr13EaoYrLsagGiS5mXliCjBtLE80ii53j9FI4Nzh+i6sCk4A+vjK2BkwFeQ
	gMbBKYZ5yv14cxe7LT9u87Q2qGXdIRUhU1sWsPKmEFP8JyQiM1OUbDbxn3Xw2vivr8R+AvF1NYD
	tqduuTK3DcM7JE1zexT2fhZIhu0yDNOZ2w882c24G4dKRu5vIQznRw8nPwniaztXWwV4V5U7f+V
	MYqtJhdzQOOZc5ZU4+YYtB6vqVJQKsyfWkEwoi6FyB+TKEJZc2DvoJ+Pxy2BdSFv1EhoG0p08cW
	d0PPpTcL0/q4w+ZKBvvPJuQU0xFucNR58nJVVJTdf2T40yMaOtdTL2o0mOiLXB/nA543iZxeXFC
	1Y=
X-Received: by 2002:a05:7022:6983:b0:128:d375:f1d3 with SMTP id a92af1059eb24-128e77bee00mr299440c88.18.1773185756882;
        Tue, 10 Mar 2026 16:35:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cd6aafsm445110c88.14.2026.03.10.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:35:56 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:35:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: phucduc.bui@gmail.com
Cc: krzk+dt@kernel.org, geert+renesas@glider.be, krzk@kernel.org, 
	krzysztof.kozlowski@oss.qualcomm.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	hechtb@gmail.com, javier.carrasco@wolfvision.net, jeff@labundy.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	magnus.damm@gmail.com, robh@kernel.org, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v4 1/2] dt-bindings: input: touchscreen: sitronix,st1232:
 Add wakeup-source
Message-ID: <abCqyU2-iQgcghzy@google.com>
References: <20260309000319.74880-1-phucduc.bui@gmail.com>
 <20260309000319.74880-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309000319.74880-2-phucduc.bui@gmail.com>

On Mon, Mar 09, 2026 at 07:03:18AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Document the 'wakeup-source' property for Sitronix ST1232 touchscreen
> controllers to allow the device to wake the system from suspend.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied, thank you.

-- 
Dmitry
