Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A8499F35
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734679; cv=none; b=CDHqdvzNmGTsh8ms4AFNlK2DpUzA9Ke/Y5utR2U9HV7XCyaebfezQ+pQCfeNMYSOpOINUsN6hfMrv6XpcSgV0fVWFn1QRthZEGCktMfnpXEzruWhNcDoY3MpwS8G3VvNXsg7QoV7JwuWBz2UkmsnHPBlm0Eu8EqpTn+byWbYonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734679; c=relaxed/simple;
	bh=B5UkpmG2y2P1ZqtbQ6LHxeL9GRpgPTGRf5vUbfSkYOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qapIRwH8g2+sGEVtOWiaySSssp3LyKi4sd4eU94Vl5O7Apf/YyRUhB/TyeFplTmjV9qo5x1Iak7xUjZlQDF8fqjeh0aPC7pTrPwkBJUUkNzi4TyaMQtWzuWOxLB/OvKgVLtTnaacTd8TZntzRgjeLo3JEmOAKMq5rmgjJ4LEBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGfU9s4J; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGfU9s4J"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbeeaac53a9so1376626a12.1
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734675; x=1787339475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3HcrgzPPujtaR7tduYRxie7ZJ959DOOFyRWxW1D0E40=;
        b=tGfU9s4JPk7+HNRh4Qx+H1oKTojCqqs/2LdmFhNLPHWJkqxVvyZRm6YrM8KD/ypxkT
         37J44UqO5w1rBcODBfOTyfwDQBMGoYtdSp5vdBCeU6xrJYa/9FROBSwdnDPvKcY0vVTI
         QUA9oCq+ekcOKEfaQG+LMCj0H/7nfAOb8jj8v0Sfii7T4dt/X8/m+XwZWNnVcEflpSD2
         xM+Zk07F0jGXa0spdk062qSzCi3rEt8H4QyvO7yJsyx8Q7wUvP+IKsBICWqmClmj3WEB
         SHy+Wyfe6hWcwjJs/6vEFiOCLxHsfM3OiqaRqEOcWUrnWBM1ieqa8i1yRIhckIRplcB1
         V00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734675; x=1787339475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HcrgzPPujtaR7tduYRxie7ZJ959DOOFyRWxW1D0E40=;
        b=kQOZRBacPL2q67cXabcGiOa0OrjL6V4zLfjycvvhSUFCPUjRFnjLhOwrQsH0VtraOl
         txq0CUzkyiby95O2xdOdswtxmt0Uyp51dalu2CW4QtQ1ST3qm+8GlogiAJuU7FcMe4qZ
         NJC/MjaYHYnVw1KXoxN0ZnwwLUtKnrF2CEbgvfi6G/i8SNufawlwO30VgXF0yPzPh+jo
         4WvQyaxoLeTZNGezSTs98yVRjCnKWYjKI9SHMq80vyrgspihgTl5ACYBk2V3OZUSZHv/
         F/4fLKxbqdu39pje8EMw5EdEAwNJrQ6Vg/W4rHuBzGRO9XR9s9qGZpPbOlYe7nj0uB2+
         p8sQ==
X-Gm-Message-State: AOJu0YxStO4MLEIVtxBYHx/w2p3NL7ZsJ3AQFktme20KPbdgWgi5y7lh
	ip7+3ML+S17TCMo2WNq7F+uskbNEosNOuPQsWbyMIwEwi8A2z/wOX02L
X-Gm-Gg: AR+sD13uApZJtKcVRECxd94R2uo2RzvbRK1E+DbfjuLNlShAyyY5x6fZXHa3LW6jg/+
	UHXXmfeuaM4DbUDWR3E+Q60SaS8ZaFZQJ4i1ZZAd/4HyXIJWSBkZrKw0zrotvgovEc6/DTAVWUA
	Vrhlwz0UH6Dioem+s2eNxnt57BnfmtubcQ6VuHGuUCUxLCNt/xEPqbVJYlK9A6KEKIegWwyPMF/
	bplimfXpQId29kIxSz5DLEuRshXrfUoah9ggEWiVeKI3Q20NupTMW9ozXOw2aj2KxHqRJjSC72L
	AqHYPI0m7oyaDyjIq5gtxAMvH+K6Z91z8MmEKIeHUSjsr191RHe0p+wLf41kdIWXNOi6Hu+xA3Q
	9Ln9m5jyj8NlfOraMuZYJ+ZXwDclsSb8vm1czVqfvuX7eTc/iAn0yHUiywYTfPlUffPphL+9hrT
	5dNxfVGMyDkAcF9skVIwbytXicaWA4O4DKTL5874S3VroyU1+WBvlgydC9ryrgkbnU82YqoZL97
	l7E4UQcZXzIi3yChE0MafRf3gB8Y6ZLJq9MDBxC
X-Received: by 2002:a05:6a21:6197:b0:3c3:a08d:5b44 with SMTP id adf61e73a8af0-3cc71d7bbeamr10217908637.23.1786734675100;
        Fri, 14 Aug 2026 12:11:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e0b1:a24a:3d2a:2ee9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm15879874c88.6.2026.08.14.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:11:14 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:11:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Longlong Xia <xialonglong2025@163.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH] Input: elan_i2c - Use device-id/acpi.h for ACPI IDs
Message-ID: <an9oS-abMfFf8Vhc@google.com>
References: <20260809142928.4031270-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809142928.4031270-1-xialonglong2025@163.com>

On Sun, Aug 09, 2026 at 10:29:28PM +0800, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> elan-i2c-ids.h only needs struct acpi_device_id from the ACPI
> device ID definitions. The MODULE_DEVICE_TABLE() user already includes
> <linux/module.h>.
> 
> Include <linux/device-id/acpi.h> instead of the broader
> <linux/mod_devicetable.h> header.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Applied, thank you.

-- 
Dmitry
