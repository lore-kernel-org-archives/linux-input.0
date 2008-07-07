From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 7 Jul 2008 12:27:09 -0600
Message-ID: <20080707182711.7F7E012D0061@mail133-dub.bigfish.com>
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com> <20080707141843.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:19192 "EHLO
	IE1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbYGGS1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jul 2008 14:27:15 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20080707141843.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sadanand Mutyala <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org

Thanks Dmitry, appreciate the help.

Powerpc dependencies in the Kconfig sound right.  Sorry for not thinking
that thru well across all architectures. 

Do you want me to spin the patch again?

-- John

> -----Original Message-----
> From: linuxppc-dev-bounces+john.linn=xilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+john.linn=xilinx.com@ozlabs.org] On Behalf Of Dmitry Torokhov
> Sent: Monday, July 07, 2008 12:20 PM
> To: John Linn
> Cc: Sadanand Mutyala; linuxppc-dev@ozlabs.org;
linux-input@vger.kernel.org
> Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2
driver
> 
> On Mon, Jul 07, 2008 at 08:38:45AM -0700, John Linn wrote:
> > Added a new driver for Xilinx XPS PS2 IP. This driver is
> > a flat driver to better match the Linux driver pattern.
> >
> > Signed-off-by: Sadanand <sadanan@xilinx.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> 
> Looks good and I am ready to apply with the exception that compile
> errors out when i try to build on x86 (asm/prom.h is missing). Do we
> need some Kconfig dependencies added?
> 
> --
> Dmitry
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


