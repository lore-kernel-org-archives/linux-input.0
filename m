From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 8/8] ARM: LPC32xx: Device tree support
Date: Wed, 18 Apr 2012 14:01:53 +0000
Message-ID: <201204181401.53913.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de> <20120418060230.GC17506@avionic-0098.adnet.avionic-design.de> <4F8EB3DC.3060203@antcom.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F8EB3DC.3060203@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, devel@driverdev.osuosl.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com
List-Id: linux-input@vger.kernel.org

On Wednesday 18 April 2012, Roland Stigge wrote:
> As Arnd wrote, there are board specific bits left (open questions
> about how to DT'ize spi's controller_data, and DT-conversion of AMBA
> CLCD). However, I will move board-independent stuff over to common.c.
> (Keeping lpc32xx_auxdata_lookup[] in phy3250.c due to remaining
> platform_data, though.)

FWIW, I think you can remove the most of the auxdata table if you
change the clock lookup table to refer to the automatic device
names, e.g. 31020000.usbd instead of lpc32xx_udc.

	Arnd
