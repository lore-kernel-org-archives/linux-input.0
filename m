From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problem statement: Opportunistic suspend and i8042 wakeups
Date: Mon, 10 Oct 2011 20:10:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110102008160.28007-100000@netrider.rowland.org>
References: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:38347 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753731Ab1JKAKU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 20:10:20 -0400
In-Reply-To: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rjw@sisk.pl, Paul Fox <pgf@laptop.org>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Mon, 10 Oct 2011, Daniel Drake wrote:

> In my most recent set of patches I took the following approach:
> http://www.spinics.net/lists/linux-input/msg16599.html
> http://www.spinics.net/lists/linux-input/msg16600.html
> 
> 1. The 'wakeup' property is enabled on the i8042, serio and input
> devices. Before going into suspend where input wakeups are desired,
> userspace must enable wakeup in sysfs on: i8042, serio0, the mouse
> input device, serio1, and the keyboard input device.
> 2. In the suspend/resume handlers, each of the three layers above
> checks to see if wakeups are enabled on its own device, and if so, the
> suspend/resume handlers effectively do nothing, avoiding the triple
> layer resetting described above.
> 3. The i8042 driver wakeup property is also used to call
> olpc_ec_wakeup_set() in order to tell the EC to wake up the CPU on
> input events when in suspend.

It's not clear why this should be connected to the "wakeup" property.  
In principle, even if the keyboard & mouse are not enabled for wakeup, 
you still want to avoid losing input events (if possible).

Alan Stern

