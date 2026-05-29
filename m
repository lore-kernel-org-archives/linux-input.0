Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D33769ED
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083384; cv=none; b=QVS5RZnJDSlMmtS9UV2LV9Yj7B6NfXQfuanSfTe2GTkafStCZVaCYjf7qByH09CvVYRrGKK5npzwRxR2otzxGsz/kTsqdEDhavI0yY3S8M46N8cHAY9S4uzOXr4gxS6odFxCCGCcc17g7+GUHHrOG5UNE2FlJZxgI8Rfo0Xf2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083384; c=relaxed/simple;
	bh=JvbkFXSv/cT5qrKIlh0WWS5+4L5apG4mkaH3N7WNg/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxwY/pDv1sHLyqJEmFrz7OuJfXwkZZQN12jWhuCNacn227BMX5vpEHUVva2mDp9ANjUcTlDuIRJDwTwQcESJeldsa+uXcHjahb20kb8/VLHTWDK3NmZ+H+mBh/D5Fxk6SgIrSQaM2BZiuyJKTzyv/sQ2kFEP3nhDWoLLaey4dSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/MzM8WG; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/MzM8WG"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so9477024c88.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083381; x=1780688181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEmz1ziTXVbcqph9Xe5tRmLXLVVNs5rWDn4AgRaCi24=;
        b=Y/MzM8WGuNVNllfriRkcqGYHxXkxyQt76JeXTvuoxHZZCwmCikbcboaBjAz5FZ0MOm
         k3elmxAOvFCYti7RPRtFMzBgkADOhZeHPBnUPJS5+4y16spBH5pmmTnPDGUbeFIQ05hX
         ar1TbN7ocyhYG7R8wznTM/n5A5qe40pyTBBP2t0c6gaL+4AExg5ZxfcnmZqoloIplb5T
         P9APWgzpkZsmOGsu9w1zsEjKJWn2pOqFf4TGXa2YFY2sQVikWnPAS3ymY5bTuf5KaNJD
         ekiKGdfLAO0SJFNYTwsOqh09JqeGAdC9Z2yvLDb70nHMDcP5OlGsFQHkxQgdov2L3bWh
         tMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083381; x=1780688181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEmz1ziTXVbcqph9Xe5tRmLXLVVNs5rWDn4AgRaCi24=;
        b=Y9z4APalgmIDxYgMral9flWVBROmzANl48UqDevFIEpSJjJkIXtus0tM6lxdGwFukf
         N4w2veQe+eqEfabZWBrMeUfHnowRhK0NGptE/Fz/mov0WVAqsHXL78+LlcUfmwcjlNlh
         R6C3fcfDJCva02LVzZ0Zmw6usItk6ijDN1Cn5+l1422lhIbC23qBa31/EcW3x+6F+T1a
         S683ExIag9xXCPszA0ZTaRyAQ8Pr+yFtmQOvJrRaHcYEKwet6Z7bHmIwNaGjIhw4cywp
         WmNPssUX5EBotvCXRAuhUO5a679CzB6nx7L45WnNkGo8XAEAHloMnXiYSDNji8WKLLHh
         ecfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NADh6toOvhdeVbYnHjw7WnCopSeFNYqy5MX/+ec1xAuRqNc9CYkYoGPSzDsJ4cEXhqtwz+U1MncbnwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziGsi2LyiD1gw8/W4XqbYGD21CYZBd6j/ZzMXV8K71OLnoUlTz
	haMTu0ehVUtkfJaegD0eKF1f6VaMj7AZGccPlfYLDhsag865Akh1qWfV
X-Gm-Gg: Acq92OGvyBBVc1bEP/glezex3/ZbmvhufMj7YtWe6uNVrA5v6PMl+Sh28ZxMIqoP1f9
	uWOIwe2r/3GgMRb+JiNBiwCOVOtnvq5bTKPZKuXDSKs8iQ9+ye0XnzfaEmrQk+YQzCIcm2dnxSn
	F3f5c+BGUX/7JCpmrh+n5cDxtb0VWj+Awaj7PivOGj4pGQdC7+XU974luIOqtS/llnERT/VSBm4
	AazZL+DqnCnZAgP8XC307hGdy4+HuiK5A23spo+8yhNO5RXa1ah9EiOWtrhDZBJWEdhLdB+bgJd
	NtTCjzY1yd537YdHc7+L0Z2qopYHH+wJoaCJv92+xxrWuppN5ez8GqwTdg6zqFOy2CMUqrXmCwK
	+iIHe/qvvockj6zMdNCO7UDVrGrQ5zI3f0RZfEsjDyTxxYlcr+nlGNAo9HeOhs4oio8Dr/sgk/a
	MDTpKz7sHPR+R+KG1clfkzu7UzwoKOcx7Wy0LseGYogpQ2sUJ7e1jzAZYhAu+Xp5NuvEdumrI5/
	59smYYH2ZVc4Q==
X-Received: by 2002:a05:7022:11f:b0:130:73ed:214 with SMTP id a92af1059eb24-137d3bf78d8mr522232c88.1.1780083380498;
        Fri, 29 May 2026 12:36:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36aef95sm1766326c88.4.2026.05.29.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:36:19 -0700 (PDT)
Date: Fri, 29 May 2026 12:36:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@red54.com>, 
	linux-input@vger.kernel.org, bentiss@kernel.org, dianders@chromium.org, jikos@kernel.org, 
	linux-kernel@vger.kernel.org, superm1@kernel.org
Subject: Re: [PATCH] HID: i2c-hid-of: Fall back to ACPI _DSM when
 hid-descr-addr is missing
Message-ID: <ahnqMMhD8jn51ch7@google.com>
References: <9e5232a7-5b8b-4025-8a31-108eb164861e@kernel.org>
 <tencent_ECC71F91403F5AC69E1E6B963FA667ABF607@qq.com>
 <7c2c86d8-be10-4e8e-8e96-d22788ec488f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c2c86d8-be10-4e8e-8e96-d22788ec488f@kernel.org>

On Fri, May 29, 2026 at 05:00:37PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 29-May-26 14:16, 谢致邦 (XIE Zhibang) wrote:
> > Before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are
> > separate modules"), the unified i2c-hid driver handled both PNP0C50 ACPI
> > devices and hid-over-i2c OF devices. After the split, devices with _HID
> > "PRP0001" and _DSD compatible "hid-over-i2c" are only probed by
> > i2c_hid_of, which requires "hid-descr-addr" in the _DSD. Some devices,
> > for example the Lenovo KaiTian N60d and Inspur CP300L3, provide the HID
> > descriptor address only through the _DSM method. Fall back to the _DSM
> > call when the property is absent.
> > 
> > Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
> > Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> Thank you for the new patch, this is an interesting approach and better
> then the modalias magic from the previous version.
> 
> Note I'm not the i2c-hid maintainer, with that said I think this should
> be acceptable. But currently it duplicates the _DSM handling code and
> that should be fixed.
> 
> I think this should be changed to a series of 3 patches:
> 
> 1. Move the i2c_hid_acpi_blacklist handling out of
>    i2c_hid_acpi_get_descriptor() into i2c_hid_acpi_probe()
>    to above the devm_kzalloc() call.
> 
> 2. Move i2c_hid_acpi_get_descriptor() to a generic
>    int i2c_hid_acpi_get_descriptor(struct device *dev)
>    helper in drivers/hid/i2c-hid/i2c-hid-core.c .
>    Wrapped in #ifdef CONFIG_ACPI and with a static inline
>    stub in drivers/hid/i2c-hid/i2c-hid.h when CONFIG_ACPI
>    is not set, e.g. in drivers/hid/i2c-hid/i2c-hid.h add:
> 
> #ifdef CONFIG_ACPI
> 	int i2c_hid_acpi_get_descriptor_address(struct device *dev);
> #else
> 	static inline int i2c_hid_acpi_get_descriptor_address(struct device *dev)
> 	{
> 		return -ENODEV;
> 	}
> #endif
> 
> 3. Modify i2c-hid-of.c to try i2c_hid_acpi_get_descriptor_address() as
> fallback for the missing "hid-descr-addr" property.  Please also add
> a comment in the code explaining that this fallback is about ACPI I2C-hid
> devices which use a "PRP0001" ACPI _HID with an "hid-over-i2c" compatible.

I think we should also stick a big fat warning if _DSM succeeds in that
code branch: hopefully manufacturers will notice and fix the firmware on
new devices.

Thanks.

-- 
Dmitry
