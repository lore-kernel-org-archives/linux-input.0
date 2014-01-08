From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: Information about Atmel MXT224
Date: Wed, 8 Jan 2014 13:50:02 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1401081344451.1454@pmeerw.net>
References: <52CD04F1.8090100@gmail.com> <alpine.DEB.2.01.1401081228580.1454@pmeerw.net> <52CD4376.50305@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:50255 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbaAHMuE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Jan 2014 07:50:04 -0500
In-Reply-To: <52CD4376.50305@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
Cc: linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>

Hello,

> I am in Belgium and we deal with Gleichmann & Co. Electronics in Germany to
> have their devkit (SMT-C-T10). I have signed a NDA with them to have MXT224
> protocol guide but they never send me Protocol Guide.
> I will try another distributor.

just ask harder; I got it from them
 
> > something goes wrong in the initialization; the object table of the
> > chip doesn't match the register data fed in -- the mxt224 can be a bitch
> > and play dead
 
> So what can I do ? Maybe a problem with the embedded firmware that need an
> update (atmel_mxt_ts 0-004b: Family ID: 129 Variant ID: 1 Major.Minor.Build:
> 2.0.AB)

you need to understand the object table and see what object leads to the 
invalid object message; there is some mismatch between the driver and the 
chip

> When I do cat /proc/interrupts and I short-circuit /CHG to ground, number
> increases so low-level handling of interrupt is working.

if I remember correctly, the mxt224 does periodic interrupts (200ms?) 
when something is wrong with the config

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
