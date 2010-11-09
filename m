From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Mon, 8 Nov 2010 22:59:33 -0800
Message-ID: <20101109065933.GA13921@core.coreip.homeip.net>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
 <20101108035121.GA4630@barra.bne.redhat.com>
 <4CD7B012.1030809@cena.fr>
 <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
 <20101109033149.GC19313@barra.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0KIG7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 01:59:41 -0500
Received: by gyh4 with SMTP id 4so4054678gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 22:59:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101109033149.GC19313@barra.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Benjamin Tissoires <tissoire@cena.fr>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Nov 09, 2010 at 01:31:49PM +1000, Peter Hutterer wrote:
> 
> That said, it also goes counter the whole multi-touch approach - allowing
> more than one device on a single physical device.
> 

So maybe we should teach wacom to handle all devices as a single input device even
in cases when they use several USB interfaces? We should be able to
detect related interfaces by examining intf->intf_assoc (I hope) and
using usb_driver_claim_interface() to claim them.

-- 
Dmitry
