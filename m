From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: USB host support should depend on HAS_DMA
Date: Thu, 11 Jul 2013 01:12:56 +0200
Message-ID: <201307110112.57398.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1307101724430.1215-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1307101724430.1215-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 10 July 2013, Alan Stern wrote:
> This isn't right.  There are USB host controllers that use PIO, not
> DMA.  The HAS_DMA dependency should go with the controller driver, not 
> the USB core.
> 
> On the other hand, the USB core does call various routines like 
> dma_unmap_single.  It ought to be possible to compile these calls even 
> when DMA isn't enabled.  That is, they should be defined as do-nothing 
> stubs.

The asm-generic/dma-mapping-broken.h file intentionally causes link
errors, but that could be changed.

The better approach in my mind would be to replace code like


	if (hcd->self.uses_dma)

with

	if (IS_ENABLED(CONFIG_HAS_DMA) && hcd->self.uses_dma) {

which will reliably cause that reference to be omitted from object code,
but not stop giving link errors for drivers that actually require
DMA.

	Arnd
