Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929538E8C7
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020742; cv=none; b=jtyzhWUkQmi9okIa9Q7elqQhoxHEeNHXNx/iNSiuDFazelIZdGhONgqLTibNSdv897m4mx5ja1Vhp21j1HnnELn9ih5wtEJrNdSddWfKLVTLpU/ZmfvNhfjeS1PNY9n2pU/TVUr+ju7R6pYAuaTGTTJ49yCvSAgiDolpihKRwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020742; c=relaxed/simple;
	bh=Y3myU6PC6Y/+0AUV070w4T/IlmTKT4MrSxy6LSocXzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHWZIUwape5/iehwaBYcNvi93sCIpk62Uij0WqFL0iol8IknobPqp3RQy7OapC8h+jpc+ihoQSiSNpE3CBvxnZPAP0iiXwaluBNrgAO0aY1uaetMmbP3XBhvuVErqIhyR6sETzp7UmXlVFeF1ngmWXIEMzbB3+iJpVWEpbxsKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R65Mr14a; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R65Mr14a"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472055b0efaso1488020f8f.2
        for <linux-input@vger.kernel.org>; Thu, 02 Jul 2026 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783020739; x=1783625539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qgcEW/wpSAcIIpifYaO2mjjD/biPw57/pk0Dft8EAU=;
        b=R65Mr14aYPfKyxSUm1zLBhaYQf6Yj6CoLwN/32NCIhC/Rg/tcq/SL5MK5Mhp5NH/qM
         Tj/3Zgu2h2qpWY3s4yIe/y4GEwa0OeY9ma95KlNIvlWJLVw2/d4nQJzP3OWtSVbDDabM
         /uz5pwT0bKKt3MWqs9Hi/dM4rfP4UMlYmXUgYDK6vn0uPrs11tNTA3tbzD+f1Sc3vw+f
         TCZHpXlYl2KQrvUfOxrcDMWek8gNTI9xmNgHc0votNwoKHyHlsCnHzzVNSxXhYZqx3d6
         xdyWM0EbG6vklvg6p5U4X8axAwUYbgprWUAD/3aK+GaEqFJPGB6QAWgsWxWBaA/ZWVMC
         +s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783020739; x=1783625539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7qgcEW/wpSAcIIpifYaO2mjjD/biPw57/pk0Dft8EAU=;
        b=Q9/14u3LUB+TxuI5pWroZJpHL6KGxk64jri5f8lW7yqiqAddtwFMukpuTztDnczuGN
         dorlalXvwoDDgiq/JN+uSymPE3qrrXqVAI1pX20u4+836gM+T/JDCr+bkI03qNujc6JN
         9onYyv9tpvtAoeBAQH3G3024PLLaTOr7unQPPh/iZIAVnRkG1I6CnhQiM5v04ITRGVJ2
         EozBbfB99OdggQRz4QlqWi3ZU+GPmR+0FB3iw54FylcwEr3ncL1SKxnG9EdvR7Dyj4OV
         DLBVljxqaJhD7VNIoqrBegTmRIuktQjKCxl6NvN4hQhmQWE3kXSTG0EUVf50r7yJ+qxy
         vfLA==
X-Forwarded-Encrypted: i=1; AHgh+RrJZ0Y5ZId9utDlrV7Q91SBeSPj8SWbLCq5Molav9exy7KEYVLbMt6bxR55qhUztTgnvy95Osr39GUXLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92Auy+xJh7rKyeTHfseHSw4uhPw+K5JvXn3dgN+KMDGPQe/HD
	fMMgM9vPRJVkpXtNtMuQ4QTh5PLCjvR9BPtepMOXYGcQ1WFBTXeMYGz8
X-Gm-Gg: AfdE7ckRSTUuAzg1guWIdmpsvmHXUzSIXley/cNDBJ2egQ2nzzB4ITdtXfKuyvVZtqR
	8YyAuHJcKvci6H1NG0bTQas6qW01J/UQfdMjY42CKf7IqrBJOvTlwIpUoBb9BbDqrktioq96bHh
	n8v1LhhGVBBRZM2LYqOt/bZniira10u/CVucaZF1xdC64yyZq5+2ExU/oZ4QBXDc8pM8zJoJ+Hz
	pJ6s5VvvnkuOgnW+kYoXckpsDJBbW5c7mG0/+vW7XtwlIq6VhTVQHM7AgyEb9M6/4uKXgUfWncy
	ShsLNto+IoCIHQYHaYFrNsBFrM6cel/dpUiLxcTMS00EEZQ+WtmDEyZf0CAS0iXNRw2aridnCgv
	Wfp7b0cHHNQ63gEh4nQu8OGiP1Uf0jbFV+8JAEhzR1jLZi9T9nyWRJhK0Dvp22ItAhnfaIFCTbh
	ojWBReWwDdu109rry/LwleL3+IhrkaQAzJovsZYiSgwuIwZHST3nfK+xVbCEvFNBhlRw+CBirBf
	MUluaOI
X-Received: by 2002:adf:e00b:0:20b0:475:3a97:8e47 with SMTP id ffacd0b85a97d-4775918fa48mr8502412f8f.29.1783020738996;
        Thu, 02 Jul 2026 12:32:18 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94ce4csm12070471f8f.17.2026.07.02.12.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:32:17 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <a0cee001-7bca-438a-943b-da28528e7df7@gmail.com>
Date: Thu, 2 Jul 2026 20:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: michael.reeves077@gmail.com, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-input@vger.kernel.org
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Michael,

On 6/30/26 13:54, Michael Reeves via B4 Relay wrote:
> +source "drivers/hid/dockchannel/Kconfig"
> +
>  endif # HID
>  

> +++ b/drivers/hid/dockchannel/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR MIT
> +
> +config APPLE_DOCKCHANNEL_HID
> +	tristate "HID over Apple DockChannel"
> +	depends on APPLE_DOCKCHANNEL
> +	depends on APPLE_RTKIT
> +	depends on HID

APPLE_DOCKCHANNEL_HID has a duplicate dependency on HID,
since you put the import for this file inside of 'if HID..endif',
and then also gave it a 'depends on HID'.

- Julian Braha
