From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Sat, 11 Jul 2009 16:33:36 +0100
Message-ID: <20090711153336.GE26260@n2100.arm.linux.org.uk>
References: <4A555B9E.8060508@gmail.com> <20090709051143.GA14516@dtor-d630.eng.vmware.com> <4A557CBC.3000507@gmail.com> <20090709062929.GD14516@dtor-d630.eng.vmware.com> <20090709073703.GA1785@jasper.tkos.co.il> <20090709085436.GE14516@dtor-d630.eng.vmware.com> <4A55B1B7.3090802@gmail.com> <20090709090606.GA30597@n2100.arm.linux.org.uk> <4A55B706.60801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42085 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZGKPd4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2009 11:33:56 -0400
Content-Disposition: inline
In-Reply-To: <4A55B706.60801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

On Thu, Jul 09, 2009 at 05:23:18PM +0800, Wan ZongShun wrote:
> config ARCH_W90X900
> 	bool "Nuvoton W90X900 CPU"
> 	select CPU_ARM926T
> 	select ARCH_REQUIRE_GPIOLIB
> 	select GENERIC_GPIO
> 	select COMMON_CLKDEV
> 	select HAVE_CLK
> 
> Is it right?

Yes.
