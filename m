From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mfd: Add power control platform data to SDHI driver
Date: Mon, 30 Nov 2009 12:05:04 +0900
Message-ID: <20091130030503.GD7217@linux-sh.org>
References: <20091127092803.9204.29222.sendpatchset@rxone.opensource.se> <20091127073801.19796.38165.sendpatchset@rxone.opensource.se> <20091127073224.19786.60477.sendpatchset@rxone.opensource.se> <20091127051621.24738.14619.sendpatchset@rxone.opensource.se> <20091127043658.13573.80166.sendpatchset@rxone.opensource.se> <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:55307 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZK3DGA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 22:06:00 -0500
Content-Disposition: inline
In-Reply-To: <20091127092803.9204.29222.sendpatchset@rxone.opensource.se> <20091127073801.19796.38165.sendpatchset@rxone.opensource.se> <20091127073224.19786.60477.sendpatchset@rxone.opensource.se> <20091127051621.24738.14619.sendpatchset@rxone.opensource.se> <20091127043658.13573.80166.sendpatchset@rxone.opensource.se> <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, ian@mnementh.co.uk, sameo@linux.intel.com, linux-input@vger.kernel.org

On Fri, Nov 27, 2009 at 01:31:27PM +0900, Magnus Damm wrote:
> This patch adds platform data with a function for power
> control to the SDHI driver. The idea is that board specific
> code can provide their own functions so power can be enabled
> and disabled for the sd-cards.

On Fri, Nov 27, 2009 at 01:36:58PM +0900, Magnus Damm wrote:
> This patch adds support for SDHI power control to the
> Ecovec board. Platform data and power control callbacks
> for SDHI0 and SDHI1 are added. Power is by default off.

On Fri, Nov 27, 2009 at 02:16:21PM +0900, Magnus Damm wrote:
> Add sh7724 code to save and restore CPG state during
> R-standby. Only CPG registers IRDACLKCR and SPUCLKCR
> require software save and restore.

On Fri, Nov 27, 2009 at 04:32:24PM +0900, Magnus Damm wrote:
> This patch moves the KEYSC header file from the
> SuperH specific asm directory to a place where
> it can be shared by multiple architectures.

On Fri, Nov 27, 2009 at 04:38:01PM +0900, Magnus Damm wrote:
> This file breaks out the SuperH PFC code from
> arch/sh/kernel/gpio.c + arch/sh/include/asm/gpio.h
> to drivers/sh/pfc.c + include/linux/sh_pfc.h.
> 
> Similar to the INTC stuff. The non-SuperH specific
> file location makes it possible to share the code
> between multiple architectures.

On Fri, Nov 27, 2009 at 06:28:03PM +0900, Magnus Damm wrote:
> This patch improves the serial port communication quality
> of port YC401 on the KFR2R09 board. With this fix serial
> console is fine at 115200 - up and down keys now work as
> expected. Thanks to Hirohide Yamasaki for this fix.

All applied, thanks.
