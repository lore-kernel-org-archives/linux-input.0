Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630F39061C;
	Sat, 12 Sep 2026 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789251664; cv=none; b=HRLRBqlPqXYQKn/0NcNlQkpYv84aS2xuk409J784xaqmGKsfTVoAxex7+hamY3Z1mezMhEopbiTCz+kmLaBvWMBQ0RMRNyHkjQEg6uh7idme378XZ855juxaC3xPyFKWc/wIHFB3L2W9QGlub2SzXSbdCAPNJHVmg2Hx6wxZuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789251664; c=relaxed/simple;
	bh=jJN5bbmJG6+W8ZaAl9RR52OiGtP0jEKBmRMAckxoXiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJe6HCLeEcaYPMYTJDo6bj52O4C4tN9/S/pJQ+nuxskJRaZYMGv/KJlET++t6zOUyeerAhGe7S1q8c9iuQ3BMZPp4tgAzfaoYtqM/d2uJ+98i0Myg33FwevRkgp9GRgF1P/rzFIYzEFpyw8oWzz9UatbWIXSpAj7k4XKeWMNeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHhPvzDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHhPvzDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434821F000FF;
	Sat, 12 Sep 2026 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789251662;
	bh=A9T5TqugoZpwriYm80tITfJ7eL5e79XFR+RGRlWT3Yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BHhPvzDnmzwpQttZFmPMZf/UutFNeY/Degy6vahXXbV7Z6hNGc9MkvFE+rdhQJ6MU
	 VAw3b4RYQvofx2lNTbeX4zkZRnpelNzwDei0UTSd3ZGNIs/4odMQ67B9LiiARuySxb
	 U6BER7d7wfXohAn2tXbzGwa2wiTRgp4c4+hrPC/Fg2mvopBtYwKpfuJcqo2gQktz/i
	 UBA340zyHxS9IBLWpHZ7ZP/iBROp/81WLbTAUh34hL3mGOOjez8TZZyGHIC4Q8vD6X
	 SvDJPAFOvk+SgEr6vR+aGc41krBbPQbYbAOql8ew7alD2jpnrmyuGLi/805cAMk+g3
	 S6DFuxrkx8D2Q==
Date: Sat, 12 Sep 2026 23:20:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Daniel Thompson"
 <danielt@kernel.org>, "Helge Deller" <deller@gmx.de>,
 devicetree@vger.kernel.org, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, "Jingoo Han" <jingoohan1@gmail.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Linus Walleij" <linusw@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, "open list:GPIO SUBSYSTEM"
 <linux-gpio@vger.kernel.org>, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-watchdog@vger.kernel.org, "Guenter Roeck" <linux@roeck-us.net>,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, mfd@lists.linux.dev, "Michael Hennerich"
 <michael.hennerich@analog.com>, patches@opensource.cirrus.com, "Pavel
 Machek" <pavel@kernel.org>, "Rob Herring" <robh@kernel.org>, "Sebastian
 Reichel" <sre@kernel.org>, "Support Opensource"
 <support.opensource@diasemi.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Message-ID: <20260912232047.19c4cb10@jic23-hlaptop>
In-Reply-To: <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
	<11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 20:14:15 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
> > __ 
> > Hello Arnd! May you please spare AAT2870 from being removed? I have a 
> > device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed 
> > yet, but in process as well) and atm I am working on converting this 
> > driver to use OF. Thank you!  
> 
> Sure, I have removed this patch from my series now.
> 
> > P. S. If you are planning to remove more old drivers, please CC me in 
> > since I may be interested in some additional driver upgrades for 
> > devices I own.  
> 
> Please have a look at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
> 
> I tried to be careful about figuring out exactly which drivers are
> unused, but I'm sure there are still a few false positive and false
> negative ones in there. I've added the current list of driver files below,
> let me know if you see something that shouldn't be there.
Hi Arnd

For I2C and SPI at least, there doesn't need to be explicit
device tree support as long as they have defaults when platform
data isn't there. Those two buses will happily bind based on
a dt-compatible and their i2c_device_id or spi_device_id tables
for example.

So unless they fail to probe (some might?) we don't have
a clear signal on whether they are in use via DT or not.

For vast majority of IIO drivers we don't have an upstream
DTS as there is no clear motivation for anyone to upstream
the dts for a random industrial control board or similar.

> drivers/iio/adc/ad7266.c
No to dropping this.

Has fallbacks and should bind just fine  No one ever
bothered adding an of_device_id table because it isn't
needed. Fine to rip out the platform data support as nothing is
using that.

This is a production part that is likely being used in new designs.

> drivers/iio/adc/ad7791.c
No to dropping this one.

I'm fine with ripping out the platform data but this again
has defaults and may well be in use via DT. Antoniu from
Analog was doing some cleanup on this recently so I'd guess
they probably still at least somewhat care and some of the
supported parts are still in production (e.g. the AD7788)

> drivers/iio/adc/ad7793.c
Maybe. Analog devices ack needed.

Production part but this one indeed fails to probe.  Analog
folk, do you want to fix this one up?

> drivers/iio/adc/ad7887.c
No to dropping this.

Production part - should work fine with defaults in driver.
Could like the others drop the platform data handling.

> drivers/iio/adc/lp8788_adc.c
Probably

Sub driver of an MFD.  I'm fine with that going if we know
the mfd is no longer in use.

> drivers/iio/adc/lpc18xx_adc.c
> drivers/iio/dac/lpc18xx_dac.c
Probably

Likewise these two.

> drivers/iio/frequency/ad9523.c
Maybe. Analog Devices ack needed.

Fails to probe without platform data and marked not recomended
for new designs. If we get an Ack from Analog devices folk
I'm fine with this one going away.

Jonathan

