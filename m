From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHes] Apple IR receiver driver
Date: Mon, 18 Jan 2010 16:07:13 +0000
Message-ID: <1263830833.20565.2849.camel@localhost.localdomain>
References: <1263824065.20565.2730.camel@localhost.localdomain>
	 <20100118143412.GA9831@mac.home>
	 <1263826271.20565.2769.camel@localhost.localdomain>
	 <20100118154806.GA10298@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17849 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab0ARQHW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 11:07:22 -0500
In-Reply-To: <20100118154806.GA10298@mac.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>, Tino Keitel <tino.keitel@gmx.de>

On Mon, 2010-01-18 at 16:48 +0100, Tino Keitel wrote:
> On Mon, Jan 18, 2010 at 14:51:11 +0000, Bastien Nocera wrote:
> > Yes, which I mentioned could be worked around using usbhid.quirks on
> > boot (if you need the extra key definitions), or using lirc's uinput
> 
> What exactly do you mean with "using usbhid.quirks on boot"?

Pass something along those lines:
usbhid.quirks=0xVID:0xPID:0xQUIRK
on the kernel command-line, and the appleir won't pick up the device,
and the current quirks would be restored.

Given that I seriously doubt there's very many people interested in
using "non-standard" remotes with those receivers, it would make most
users' life easier (and I doubt that the people that have the hardware
bothered setting up lirc on their systems...).

Cheers

