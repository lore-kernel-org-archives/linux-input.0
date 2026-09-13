Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32430C60D
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789278405; cv=none; b=f6F3UQpgTAhrYBYV3vQ4tKAHuh+CUyx6JnFOMu4VRBlMmaWMp0tkKsTNAkGGUCvdlroa6EjWzqHCXR9wJq1TOLFSOvNcG0SsEN2joIzmsDrmbP0D7YXJbzKDu8w4xnAGQjyA3AVKlXI2QkshqJ3N7s6VmMuhPXIdiFmSjB1lHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789278405; c=relaxed/simple;
	bh=go6oz8+xCXd4w3muWW/18hv9nuLa13rdSkVXoFj2oUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW13g+Z4siG30Twh/90pZtYUX0mjB7tIjTRdjlxei+iLDdU3l7aWmQoB62f5heOGr4gZY7hKhXvoXVIw4LJGUj4Kj12NaR77oMJxp4h6GZpfcD2kcT09QgJXiEhEHckEWLY4ht+IzUHw0LcmhgOgQmiDWB4E7JvrnZL6rL+vYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asTRFj6d; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asTRFj6d"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8692be1cda4so1794124b3a.1
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789278401; x=1789883201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaHndl2K0pFULmTR4xlAbGHwp91x25cpvpgq3imyoWI=;
        b=asTRFj6dUc6F8B8mUOx7OACjuszcaPYx7VvKy8TaY0H7sWrV7aoWOyMJyExukvwVDr
         NiATn3aEew5BrbbyASHdG3YjKY1SHDcKq13/gwAm90+5hMV2FrKblSwglQWm+yAsFIBv
         dbLqTdCUStpmCLiBAKO71TG6DlM+A9DoGPXpw+D+ljxDvfGVlcapV12ZmVQKyWL5lZ1Y
         izdi8/PNeT/j9799HlfwVFi3nFAegly78JnJyanLAI4VRqQROtN9IwNnWnCMKaSt16Te
         j+3KC/ef0aSCt0nBXblZv/7kMmA+jtOON+wQJqm2rriZPFD5Jx8qbBeBJgpjxt7zw+kZ
         H97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789278401; x=1789883201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VaHndl2K0pFULmTR4xlAbGHwp91x25cpvpgq3imyoWI=;
        b=Tq0LMEVjOpZ/slGlUh7GIphw5KobVBvkVXwHU+5R1kJM8a0b+8DcnCJ1AOpoFQIyVK
         USn1DXHd8xIgeRTSuY+a4CjahVuBqNNRSc7byRXQIwi2rv3MPUW/VAuhZ9QHZxFiyR4+
         Om3/bP13PFMBEu/z0sDR7vu4l+Divw2iZAIfGrmsl+J3bwgqRsp5bJsKN25LJ7gMdVqL
         RvDn/1xt6GfpbrY/HV3prRGTLNN34ij2hpGaXlwAGO8eYU4ZFCScWVideQC30JkP4xY6
         XtvI619Jf8YdA+YiNkNve57xNAM6W2l6CsUA1Isf8BqpUJciGTEn1Y0xIIFVvP150lxG
         RLVg==
X-Forwarded-Encrypted: i=1; AKwUvBy7xn1BgQYgsVKORBbBUUUl0/V0uNqmdm6b0J3dMDOufEvZh5eg7+mOafEBOKucrYfWbBkEe/FJ5TKYRA==@vger.kernel.org
X-Gm-Message-State: AFuF++myC0DiL+9X91PSqWJI76w6UCRkdJGeiNEwU/rsoEojtbMntJhr
	1ibTpbfufO6tjm7MC+FpPSQfoyc6HGM5dashBoEmXTRqFeACYKr0GtO9
X-Gm-Gg: AYBFou2FsPpHC1AGVObuR1zSv4ZNvcsit06w2Ej5JM7DxS/HVr+zM9z8VWwZHhwnlA4
	6jQLFcZ8mq/j+6uxJ7z8gGdkNFoIGJeoOxL6PhZgACLlxIZhg0l4qDbOw8ujd4CuPwRY5gstBFA
	qce1+IcdO3lGg5G3/MK+nR2A9Ypi2KyCH1Yqp0GqBnnACOXboVTuIKmB4oB/ywTUeDgPeVbS6k9
	Q3AvVDygycYJhVqyyUvUaN/cjVv2/0E5re9XpC4yplezIcGCCsU7vBiVTEFNE0qgjPXZ5PeXJs3
	fHyy0vOkbnylGGXHgo7AeeNk9XRZTE1EUoL9wa+QkwYsyMfox0hZ6ik7eC9v4dK+QTgHYFXPjg+
	qSlCp8dy5/ZS/IpdNjFzWdPpgIbTbdAzTByQHzogXIQkz6R5YalrlHD53tdTyI1wH5M7h+m8Cs1
	RKaiZPrWyXVrjzK71Tx6m9BxxjFIKtPg8Em3sNORDWs57fZzYLCkFWiKNMbwTR6ppne1WeueFAo
	ArWzI/JMoaaQQu4K8ED2zuznrM90zDVnfzQYl8x
X-Received: by 2002:a05:6a21:3a83:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3daed4bba12mr23004520637.10.1789278401414;
        Sat, 12 Sep 2026 22:46:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:318c:d45a:8797:2b03])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e4fb3esm17772221eec.7.2026.09.12.22.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 22:46:40 -0700 (PDT)
Date: Sat, 12 Sep 2026 22:46:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?yJh0ZWZhbiBHaGXIm3U=?= <stefanghetu9@gmail.com>
Cc: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: convert sis_i2c to DT
 schema
Message-ID: <aqY4tgXZzfiHczw6@google.com>
References: <20260821131039.37525-1-stefanghetu9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821131039.37525-1-stefanghetu9@gmail.com>

On Fri, Aug 21, 2026 at 04:10:39PM +0300, Ștefan Ghețu wrote:
> Convert the SiS 9200 family I2C touchscreen binding from free-form
> text to DT schema format.
> 
> While at it, fix the example which referenced a non-existent
> "irq-gpios" property; the driver looks up "attn" via
> devm_gpiod_get_optional(), so the correct property is "attn-gpios".
> 
> Signed-off-by: Ștefan Ghețu <stefanghetu9@gmail.com>

Applied, thank you.

-- 
Dmitry
