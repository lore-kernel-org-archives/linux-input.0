Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD753FD2B;
	Wed,  9 Sep 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961922; cv=none; b=RD/+FiMgCge49M8d/semhtkytZYTs9EcUK6gd0Fq8Qy/kfsaYUP7jVFBqvPccDUahQ4AX2g5WTFOvoGotdDDddL/3HrL3b3CPJphjMOmoEC9yNftVbeuo/zDMPXRkZjB2k5pU3aW5M9R8lq8muYSWMIJ1ddMEr5RvJfzLNIo6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961922; c=relaxed/simple;
	bh=pAVIrS3A7Rvp0U6cdijMHeBv+L6o6e+82vw+zmkqi7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOxFSt3u+1965SkkHU6T+pr3IzB4Dhm0uVbRJDCxcndgbbTreHEj+koA0HMlvLap47IBdr2lRFYhDWqHJymc42IH60B5fHG+YOa8H7tirpwGHFOx4i0Bh3yrfOSIdCScGYs1wofBMxmof6kz7/e5PA4tVY/SzJYS/n3NDW0vukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ioCAXYPV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ioCAXYPV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 07A784E41592;
	Wed,  9 Sep 2026 13:51:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD57B60448;
	Wed,  9 Sep 2026 13:51:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A566B11C7AF8E;
	Wed,  9 Sep 2026 15:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788961916; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=X3TXa8ZqMQb4DnauQKRwN/9Bqzakf4XtPXYK7Pd7tsY=;
	b=ioCAXYPVeyyJMca8ak7CEqrnzMHTUnvRr+T9Em1q2K55JSPptr9oF0sf8wq+LQEdMpFEKD
	00Vkzm8CTC+NdwdC1gZZ9VtovHy1m5ebKW8EgpOtx8a6YUjVa/AU6YAMdmkFMBXUnNt/NX
	09GgLdWETkP2R+00Kf9hLVtcVDO20S1blQ18HThNPki10EisBVPE0hTs6dtgpE5pofHJc8
	YP07DdcaByF7h4IU4ii4lOqWfFZiccMDPuveULOScrip6ulVUSm+uyjN8NNdXeHizLT7vS
	HqNPdXLA9lk7kniz17hGVcOlsGTDe8/Z24UFy3FJqS9SaDzfZNGprIAeNTOJ8A==
Date: Wed, 9 Sep 2026 15:51:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 13/14] mfd: remove unused menelaus driver
Message-ID: <20260909135149e7d73952@mail.local>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-14-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-14-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 15:21:50+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Menelaus was a companion chip for the omap24xx platform, which has
> been remvoed from the kernel, so now the menelaus driver is unused
> and can be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
