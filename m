From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH V1 2/6] regulator: da9062: DA9062 regulator driver
Date: Sat, 18 Apr 2015 10:32:09 +0200
Message-ID: <1429345929.16771.144.camel@x220>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
	 <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

I spotted only a license mismatch.

On Fri, 2015-04-17 at 15:23 +0100, S Twiss wrote:
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license is
just GPL v2. So I think either the license comment or the license ident
used in the MODULE_LICENSE() macro needs to change.

The same mismatch can be found in 3/6, 4/6, and 5/6.

Thanks,


Paul Bolle
