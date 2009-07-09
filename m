From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Thu, 9 Jul 2009 10:06:06 +0100
Message-ID: <20090709090606.GA30597@n2100.arm.linux.org.uk>
References: <4A555B9E.8060508@gmail.com> <20090709051143.GA14516@dtor-d630.eng.vmware.com> <4A557CBC.3000507@gmail.com> <20090709062929.GD14516@dtor-d630.eng.vmware.com> <20090709073703.GA1785@jasper.tkos.co.il> <20090709085436.GE14516@dtor-d630.eng.vmware.com> <4A55B1B7.3090802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39354 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbZGIJG1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 05:06:27 -0400
Content-Disposition: inline
In-Reply-To: <4A55B1B7.3090802@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

On Thu, Jul 09, 2009 at 05:00:39PM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> >>> Umm, one more thing - we need to add "depends on" to Kconfig since
> >>> clk API is not implemented on every platform. Any ideas what is the
> >>> most wide dependency is?
> >> The most wide dependency for the clk API is HAVE_CLK.
> >>
> > 
> > Cool, thanks.
> > 
> Sure, but why to add it to touchscreen's kconfig?
> it seems it should be put arch/arm/kconfig.
> 
> In addition,I never use this HAVE_CLK in ARCH_W90X900, 
> only using COMMON_CLKDEV to support clk API. 

HAVE_CLK is the configuration symbol which tells the rest of the kernel
configuration system that the clk API is available.  Drivers using the
clk API should depend on HAVE_CLK.

COMMON_CLKDEV is just one implementation of a subset of the clk API, and
nothing should ever depend on this symbol.
