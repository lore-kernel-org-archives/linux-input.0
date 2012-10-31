From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: fix incorrect handling of devices with high button
 count
Date: Wed, 31 Oct 2012 16:03:57 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1210311603430.12320@twin.jikos.cz>
References: <508e9004.5593cc0a.3323.0a6c@mx.google.com> <20121031063625.GB32539@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54684 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757743Ab2JaPEM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 11:04:12 -0400
In-Reply-To: <20121031063625.GB32539@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ingo Ruhnke <grumbel@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

yOn Tue, 30 Oct 2012, Dmitry Torokhov wrote:

> On Mon, Oct 29, 2012 at 02:29:30PM +0100, Ingo Ruhnke wrote:
> > Button names for USB gamepads are currently assigned incorrectly, as
> > the evdev code assigned to buttons is "BTN_GAMEPAD + code", which on
> > devices with more then 16 buttons bleeds over into button names
> > reserved for graphic tablets (BTN_TOOL_PEN, etc.). This causes
> > problems further down the line as the device are now no longer
> > detected as joystick. This patch fixes that by assigning buttons
> > outside the range to BTN_TRIGGER_HAPPY (as is already the case for USB
> > joysticks).
> > 
> > Furthermore this patch corrects the assignment to BTN_TRIGGER_HAPPY,
> > as currently the first button over 16 is assigned to
> > BTN_TRIGGER_HAPPY17 (i.e. BTN_TRIGGER_HAPPY+0x10) not BTN_TRIGGER_HAPPY.
> > 
> > Signed-off-by: Ingo Ruhnke <grumbel@gmail.com>
> 
> Makes sense.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Good catch indeed. Applied, thanks!

-- 
Jiri Kosina
SUSE Labs

