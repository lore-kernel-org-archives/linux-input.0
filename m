From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 8/8] ARM: LPC32xx: Device tree support
Date: Wed, 18 Apr 2012 08:15:28 +0000
Message-ID: <201204180815.29234.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
	<1334682507-15055-9-git-send-email-stigge@antcom.de>
	<20120418060230.GC17506@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120418060230.GC17506@avionic-0098.adnet.avionic-design.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Roland Stigge <stigge@antcom.de>, devel@driverdev.osuosl.org, srinivas.bakki@nxp.com, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, marek.vasut@gmail.com, arm@kernel.org, linux-input@vger.kernel.org, axel.lin@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Wednesday 18 April 2012, Thierry Reding wrote:
> >  arch/arm/mach-lpc32xx/phy3250.c                       |  146 +++++--------
> 
> While at it, this should probably be renamed board-dt.c or something similar
> since it is no longer phy3250 specific.

I believe there are still a few phy3250 specific bits left in there, using auxdata,
right? In that case, I think it's fine to leave the file name for now, but I
think everyhting that is not phy3250 specific should just get moved into common.c
since we don't want to support any other board files for lpc32xx any more.

	Arnd
