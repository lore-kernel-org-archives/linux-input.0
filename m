From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 7 Jul 2008 14:19:59 -0400
Message-ID: <20080707141843.ZZRA012@mailhub.coreip.homeip.net>
References: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:59430 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbYGGSUK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jul 2008 14:20:10 -0400
Received: by yx-out-2324.google.com with SMTP id 8so478241yxm.1
        for <linux-input@vger.kernel.org>; Mon, 07 Jul 2008 11:20:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080707153850.4C83B128005C@mail53-wa4.bigfish.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org, grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk, Sadanand <sadanan@xilinx.com>

On Mon, Jul 07, 2008 at 08:38:45AM -0700, John Linn wrote:
> Added a new driver for Xilinx XPS PS2 IP. This driver is
> a flat driver to better match the Linux driver pattern.
> 
> Signed-off-by: Sadanand <sadanan@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Looks good and I am ready to apply with the exception that compile
errors out when i try to build on x86 (asm/prom.h is missing). Do we
need some Kconfig dependencies added?

-- 
Dmitry
