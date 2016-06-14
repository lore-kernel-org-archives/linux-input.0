From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Mainlining of Pyra nub joystick driver
Date: Tue, 14 Jun 2016 17:14:52 +0200
Message-ID: <5881169.t4LCy37Pi6@wuerfel>
References: <20160614114523.GC4820@zver>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:51607 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcFNPN4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 11:13:56 -0400
In-Reply-To: <20160614114523.GC4820@zver>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: linux-input@vger.kernel.org, devel@driverdev.osuosl.org, kernel-mentors@selenic.com, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mark Brown <broonie@kernel.org>, Daniel Hung-yu Wu <hywu@google.com>, Moritz Fischer <moritz.fischer@ettus.com>, Geert Uytterhoeven <geert@linux-m68k.org>, S Twiss <stwiss.opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Grant Grundler <grundler@chromium.org>

On Tuesday, June 14, 2016 2:45:23 PM CEST Andrey Utkin wrote:
> There's a pair of "nub" devices on Pyra handheld PC
> (https://pyra-handheld.com/), and there's driver for nub, which is going
> to be reworked for upstreaming. While the device itself fits most to
> "joystick" category, the computer itself lacks touchpad and mouse
> buttons, and the existing driver is capable of switching between modes, in
> which it shows up like one of the following:
>  - scrolling wheel,
>  - mouse buttons set,
>  - pointer updating its absolute position (graphic pad alike AFAIU),
>  - pointer device behaving like actual joystick / pointing stick.
> 
> Currently modes switching happens through r/w file in /proc, which is of
> couse going to be changed.
> 
> I wonder if such mode switching mechanism is tolerable for inclusion to
> upstream kernel in this case. I'd like some advice how to rearrange the
> driver to save most of flexibility while matching upstream kernel
> conventions. I am especially interested in comments from subsystem
> maintainers.
> 

My best idea for this is that the device driver should just report one
type of device, with the other modes being handled on top of that,
by a generic kernel framework or in user space.

Code for registering the same inputs to all those frameworks doesn't
seem to belong into a driver.

	Arnd
