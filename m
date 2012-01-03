From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Tue, 3 Jan 2012 08:44:32 -0800
Message-ID: <20120103164431.GA31647@core.coreip.homeip.net>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
 <1325484557-27695-1-git-send-email-olof@lixom.net>
 <CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
 <20120103154317.GA27061@quad.lixom.net>
 <CAPnjgZ3xN8+Ve28bcg1OQ4mv5rWvA-9ijP57UsuMQ5D1d=7Xxw@mail.gmail.com>
 <20120103162929.GY2914@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61666 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab2ACQok (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2012 11:44:40 -0500
Content-Disposition: inline
In-Reply-To: <20120103162929.GY2914@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Simon Glass <sjg@chromium.org>, Olof Johansson <olof@lixom.net>, swarren@nvidia.com, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, grant.likely@secretlab.ca, U-Boot Mailing List <u-boot@lists.denx.de>, riyer@nvidia.com, thomas.abraham@linaro.org, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 03, 2012 at 04:29:30PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 03, 2012 at 08:22:21AM -0800, Simon Glass wrote:
> > Can the Linux key codes fit in 8 bits?
> 
> That depends on your point of view.
> 
> If you hack on X, then the answer is yes and you ignore the squeels of
> your users when certain key presses get misinterpreted.  (The Psion LX
> platform, otherwise known as the Netbook Pro, suffered with this problem.)
> 
> If you are a kernel hacker, the answer is no, because key codes currently
> go all the way to 0x300.

For bootloader environment 0-255 range is probably sufficient though,
the upper keys are somewhat recent additions to the maps...

-- 
Dmitry
