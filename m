From: Chris Friesen <cbf123@mail.usask.ca>
Subject: alps.c patch for Dell E5410?
Date: Wed, 20 Apr 2011 14:48:34 -0600
Message-ID: <4DAF46A2.6050703@mail.usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:64804 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1DTUsi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2011 16:48:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chase.douglas@canonical.com, dtor@mail.ru, sebastian_kapfer@gmx.net, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi everyone,

I've got an E5410 on which I'm trying to get the touchpad working
properly. I'm running Fedora 14 with 2.6.35 and by default it's just
recognized as a mouse.

I found a patch on the web at:
https://confluence.nau.edu/display/~cmg238@nau.edu/Recognize+ALPS+Touchpad+on+Dell+E6510+in+Ubuntu

It appears similar (but not identical) to the patch that was added for
the HP Pavilion dm3 but then backed out.

With the patch applied, the kernel appears to recognize it as a
DualPoint Stick and a DualPoint Touchpad.  On this particular machine
the stick doesn't seem to be actually wired up, but the trackpad looks
visually identical to the E6510.

However, even after it was recognized I haven't yet been able to get
scrolling to work, and "synclient -m 100" doesn't give anything
useful--but various comments have led me to wonder if it actually should
at this point.

So what's the deal here?  Is someone working on getting full support for
these things?  Should "synclient -m 100" work?

Thanks,
Chris



