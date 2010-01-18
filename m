From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: [PATCHes] Apple IR receiver driver
Date: Mon, 18 Jan 2010 17:19:33 +0100
Message-ID: <20100118161933.GA10491@mac.home>
References: <1263824065.20565.2730.camel@localhost.localdomain>
 <20100118143412.GA9831@mac.home>
 <1263826271.20565.2769.camel@localhost.localdomain>
 <20100118154806.GA10298@mac.home>
 <1263830833.20565.2849.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:42086 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab0ARQTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 11:19:38 -0500
Received: from mac.home (port-92-206-67-99.dynamic.qsc.de [92.206.67.99])
	by eazy.amigager.de (Postfix) with ESMTPA id CA6B5C8C10A
	for <linux-input@vger.kernel.org>; Mon, 18 Jan 2010 17:19:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1263830833.20565.2849.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>

On Mon, Jan 18, 2010 at 16:07:13 +0000, Bastien Nocera wrote:
> Pass something along those lines:
> usbhid.quirks=0xVID:0xPID:0xQUIRK
> on the kernel command-line, and the appleir won't pick up the device,
> and the current quirks would be restored.

So I guess this would be usbhid.quirks=0x05ac:0x8240:0xsomething.

The remaining question is what "something" should be.

> Given that I seriously doubt there's very many people interested in
> using "non-standard" remotes with those receivers, it would make most
> users' life easier (and I doubt that the people that have the hardware
> bothered setting up lirc on their systems...).

IMHO "non-standard" remotes are interesting especially with this
remote, because the vendor supplied remote has only six keys.          

Is there really no way to make the quirk only effective if the appleir
driver is active?

Regards,
Tino
