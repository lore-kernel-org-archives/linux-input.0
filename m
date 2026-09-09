Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B474F55A5;
	Wed,  9 Sep 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961659; cv=none; b=GdeD4mBIQeWHnGdMT3SW/IqdAQ2J8DRn+cnaCC0JwCslKpOaD0hNk4HlB5/bSRf9TQxRGpn+s3XmiOAl2UKjMwIswnYSDdhuWd3w2ci0rs5bwyD14jdXYK73imDiO5acA6O5QobYIFS4ePDCOyvcPRg9+jud0M8XJW0mydr6QEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961659; c=relaxed/simple;
	bh=paMgZuNREAZRlfZm0w4BUOSPbd88b6hgz9N3jycmZig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcs+/hXN/ckzZvOhCavWR0jmD9E5V2gRQrDTlTUnNkpX7IbrH+Xn4chufTLQe8NsJUfunDdUXYmBz5yovE6pmsdjOtE9egbOvRUcbAjTIBVu+5C7g8JLGi0Cw3jaLpd0onskTbMo43xX+wBVP0yak2LipWEXOBSeowXUJZdfN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GCHpAQ+O; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GCHpAQ+O"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 11B541A1A70;
	Wed,  9 Sep 2026 13:47:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D920F60448;
	Wed,  9 Sep 2026 13:47:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E878511C782BF;
	Wed,  9 Sep 2026 15:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788961652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UeQWrBHUsYzfR8OG1tLDH6xJ9uIj59JiQoZuHROubjw=;
	b=GCHpAQ+OrX4KfJhFAWkevTRLOtcTPUS8G9Z+Qk0T1XTKkFRt9FjGrGjCYhRGd9BtQhCjo/
	EjrkQN54tfMFRkO5+xmticdh9JQRCnP2A6n6eTLXDpmK7ohZQa0h2ZLHdz6McP4I8NsWd7
	Vhhg7eZxU5SjMneaW0TFE74yKyqTBm3QDE3kSX31z2V59Awjm5z2K1z2U17N9pizI0//yg
	GjoEmkXUvZsDmi3QmJQ5OdeX67P1EmPvSDqjVYKsmyBs8NvIaHtOqAOZbnt7yRBk6aq0Q9
	1TDtXjaJ35VLd+ubtK3nvQd8cnqvwUzV/I8u/lS/OxzWY95CvKOygSUOa+SMoQ==
Date: Wed, 9 Sep 2026 15:47:25 +0200
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
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
Message-ID: <202609091347259a3b9fa4@mail.local>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-8-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 15:21:44+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver was apparently never used upstream, and without devicetree
> support cannot be used by external board support.
> 
> The MAINTAINER entry was already removed in 2021 as the email address
> bounced.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
