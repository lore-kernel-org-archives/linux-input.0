Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC3366075;
	Thu, 27 Aug 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863882; cv=none; b=BOROh+vqe+V0cvM+aEa8PGlQDEvpPUMHvSgxrJ1FXpKPrtrAAYg++cCEB+REETB31cHIgHlZNs2fCq/0hZuO7MT9+TKRXnCVfYvSKsI6M0QM4QPNoZAI2keauBeWZSJjP0oFrWvUYStAU/atNxFSZBzGZNwu6C7xHi1ML0fQKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863882; c=relaxed/simple;
	bh=WXeJ9znMzJWiN2tBxM8sER2zjwBK+7hi+xhyYeIFQUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuGbo9S3COaG5Y4xFtkwpRL9yAXnTi0PI2ghU9XIItNxlKiMdxw/c7noL2oiABBaAsFXI79+ctMAa0I9/F6hV8okE7X382Qs5wjN08lJprBQdj8iHKREiMtPHUKLBYUJwwxMWcUOWglKAU44gexE1u7TAnvwrw7OcHMCwl0wezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrkhSe4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrkhSe4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B011F000E9;
	Thu, 27 Aug 2026 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787863880;
	bh=q6v8JgrlCW684JMb4jenL6SwOnn3SOSmKXx8tP8gEV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jrkhSe4fPptvvR3XclukGrKiVVuNb6aqaA84KbSjHf00rJiFoR/bNqwYF24/3xeUy
	 t8qPdtm51VB8U9ajjhrlZCQO1T2ZwoS6TWFCHzQCqEKzY4gp91RRsO9BHJfv54qhaz
	 7FKIcyqTjQBSuW2UbjF+l3IFbE85IOt5OsO9iaMcF2Epi9VOeS+ZB3O3vFPgr9d9h3
	 p+eUkBvJyU36dcl33BvXKijh0ly8YsTiinoU0JTeN0uBS3BLYgz2fc0ltz7B0L8QSu
	 Bhln+no5dyGC6dcK1CQsSUVJhGxCV8mVTAUyqmpQZQzyaN8/EqnRvuHxGzDUuJv3BF
	 zcMseZvktyZWg==
Date: Thu, 27 Aug 2026 21:51:16 +0100
From: Lee Jones <lee@kernel.org>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C
 fixes
Message-ID: <20260827205116.GJ2943942@google.com>
References: <20260827132718.GK770273@google.com>
 <20260827185345.10224-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827185345.10224-1-michael.zaidman@gmail.com>

On Thu, 27 Aug 2026, Michael Zaidman wrote:

> On Thu, Aug 27, 2026 at 14:27 +0100, Lee Jones wrote:
> > What is this?  4 device drivers in one, shoved into HID?  Each
> > component; HID, I2C, GPIO, UART, should live in its respective
> > subsystem, surely?
> 
> The FT260 is a USB HID protocol converter, not four MMIO blocks behind
> an MFD. I2C, UART and GPIO are HID reports on one chip. Mainline
> hid-ft260 already hosts the I2C adapter in HID for that reason. This
> series adds GPIO and UART the same way.
> 
> hid-cp2112 and hid-mcp2221 already register an i2c_adapter and a
> gpiochip from a hid_driver. They are not split into i2c/ and gpio/.
> 
> A subsystem split does not give independent drivers here. The control
> and pin mux live in one feature report, and input is one raw_event.
> 
> System status (HID feature 0xA1) is chip-wide, not per USB interface.
> chip_mode (DCNF0/DCNF1), the 12/24/48 MHz clock, i2c_enable, uart_mode,
> UART configuration (baud/frame/flow), I2C reset and I2C clock, GPIO2/A/G
> function select, DCD/RI enable, and power-save are fields or SET
> requests on that same report. Probe on either HID interface reads 0xA1
> and then decides I2C vs UART from chip_mode plus bInterfaceNumber.
> 
> GPIO is not a third USB function. It is feature report 0xB0. Which pins
> are GPIO depends on that 0xA1 map: I2C enable takes GPIO0/1 (SCL/SDA);
> uart_mode takes or frees RX/TX, RTS/CTS, DTR/DSR and DCD/RI; GPIO2/A/G
> are UART/power LEDs vs GPIO; GPIO3 is wakeup vs GPIO. The gpiochip is
> attached to the I2C HID interface in I2C-only mode and to the UART HID
> interface in UART or dual mode. TIOCMGET/TIOCMSET use that gpiochip
> when the modem pins are in GPIO mode. Changing UART flow control
> rewrites 0xA1 and then updates the GPIO enable mask.
> 
> Input is one hid_driver.raw_event. It dispatches I2C read payloads
> (0xD0-0xDE), UART RX, and UART interrupt status (0xB1) by report ID.
> Dual-mode still has two USB HID interfaces, but they are two pipes to
> one chip. There is one 0xA1; there are not two register files.
> 
> USB reset (the TN_189 workaround) resets the whole device and rebinds
> every interface. Idle wakeup uses chip-wide GET reports (0xA0 / 0xC0)
> and power_saving_en from 0xA1.
> 
> UART is still HID reports on the UART interface (0xE0 / 0xB1 / data
> reports), not an 8250-style port. Putting it in drivers/tty would not
> remove the 0xA1/0xB0 coupling.
> 
> An MFD split would still need a HID core that owns 0xA1, 0xB0 and
> raw_event, with I2C/GPIO/UART cells calling back into it, and with GPIO
> availability depending on UART/I2C mode and on which interface probed.
> That cell-and-core layout is this driver already. Splitting it does
> not give I2C, GPIO, or UART their own independent devices; it is
> still one HID protocol converter, in four files to keep aligned
> across kernel versions.

That's precisely what MFD is.  It's one chip, usually with a shared and
overlapping register spaces, that conducts multiple functions.  This is
no different to any other single-chip device or SoC.

Shoving everything into a single driver isn't how things are done in
Linux.  This should be divided up into the associated sub-systems where
each part can be reviewed and looked after by the appropriate SMEs.

-- 
Lee Jones
