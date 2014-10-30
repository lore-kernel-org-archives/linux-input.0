From: Ross Vandegrift <ross@kallisti.us>
Subject: Re: Synaptics, =?utf-8?b?Q0FQX0ZPUkNFUEFELA==?= bad behavior
Date: Thu, 30 Oct 2014 21:58:23 +0000 (UTC)
Message-ID: <loom.20141030T225122-734@post.gmane.org>
References: <543656A2.4080009@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53642 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161470AbaJ3WkG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2014 18:40:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1XjyNw-00085D-DE
	for linux-input@vger.kernel.org; Thu, 30 Oct 2014 23:40:04 +0100
Received: from malaclypse.ittns.northwestern.edu ([malaclypse.ittns.northwestern.edu])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 30 Oct 2014 23:40:04 +0100
Received: from ross by malaclypse.ittns.northwestern.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 30 Oct 2014 23:40:04 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Nicole Faerber <nicole.faerber <at> kernelconcepts.de> writes:
> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
> caps: 0xd002a3/0x940300/0x12f800, board id: 2911, fw id: 2560
> 
> The issue is that now a button release is only issued after the finger
> has completely left the touchpad and not when releasing the physical
> button. Is this physical button now called FORCEPAD? Anyway, this is
> pretty annoying. Double clicking become a real pain.

I'm also experiencing this, but wanted to add that it happens on only one of
two T440s laptops I've used recently.

Affected:
psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps:
0xd001a3/0x940300/0x12e800, board id: 2962, fw id: 2560

Unaffected:
psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps:
0xd002a3/0x940300/0x127c00, board id: 2668, fw id: 1545510

Ross

