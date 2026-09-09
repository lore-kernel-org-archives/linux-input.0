Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80743559C9F;
	Wed,  9 Sep 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961498; cv=none; b=el8SphKcLJLzxnPi02X/FDAMO/lHtmFCOOHe837WejzSjY8hObRiodxQIAS8yzWQkSkqj+TIhEyAoWMuV+o7+ydysjpbLuCkdrADd2b5nRAf6fVknnWUGXX4TeuJOWX1f7NYQmlB/sb/eN8SruF0O4WbJ4IIc8CGymLWkANF0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961498; c=relaxed/simple;
	bh=40KVgJMpJer2b9dHQSWw4nT3INJ2/tHV3PM8lSibty4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCeVBgc0kZwLl4Xaka2J0pDl+eXx0XjhTRZLW6mWhSXdVMJJBPx4xQ7VKos51KkrURAibR9ZG1w4xctaTNP7xoztxQXixRcNOzpiD0+7iADc5sA+sN9HVKehSlqC1zBtevVtOc/EHTEIqYnZ+lD3Xt9Jp9wqV615rqPj+NPBydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPYFSc7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPYFSc7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BB1F00A3A;
	Wed,  9 Sep 2026 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961497;
	bh=311691/uGkvvFKIwGpWDg1KsCLWCsJMoqMq4WdR/uMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPYFSc7zuElgqPOrUvKFlinRxJJKwheHPvZj90jo4KmpnxV33/ufuBhrNpkTSj7xj
	 2RyspHqXkazeIpBw80R2fnKH5h7xSTHlRroygAHqghJUHmdY3lokSSP79WG/GJiDoB
	 oyBdDww+Ucy2ezUGrlZcwr9zvzgw4CaTeveT7WW6/oC56HlygAVyaKSTf4loP/g25/
	 JbuxGE+JuFDJrB1jVccueZ0gS7opSWr84NdE4okUrMy+Eb+npKXAoyFyecgv0dupb+
	 nOt/5qmgDw055SNzS9Q9wTx7telYpSpj52eSu7BEqy7RFlRlIIZ2qyITJuChYmq+Ij
	 Bdwur7Kmdt/Pg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4Ibe-00000002Iwf-0E2s;
	Wed, 09 Sep 2026 15:44:54 +0200
Date: Wed, 9 Sep 2026 15:44:54 +0200
From: Johan Hovold <johan@kernel.org>
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
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 09/14] mfd: remove unused lm3533 driver
Message-ID: <aqFi1qGC2QMzMAq9@hovoldconsulting.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-10-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-10-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:46PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver has apparently never had any users, as it does not support
> devicetree probing, and no lm3533_platform_data definition ever
> existed upstream.

I don't believe we ever required board files to be upstreamed?

There's also on-going work to enable devicetree support for this one:

	https://lore.kernel.org/lkml/20260617080031.99156-1-clamor95@gmail.com/

Johan
