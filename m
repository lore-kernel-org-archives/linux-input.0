From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Sun, 6 Dec 2009 09:47:04 +0100
Message-ID: <20091206084704.GC2766@ucw.cz>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org> <87einfltp3.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45574 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757539AbZLFU0X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 15:26:23 -0500
Content-Disposition: inline
In-Reply-To: <87einfltp3.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi!


> But runtime-pm.txt says for example:
> 
>     Generally, remote wake-up should be enabled for all input devices
>     put into a low power state at run time.
> 
> But in this case the requirement is to suppress input events from a
> given device, effectively muting and putting it into low power state,
> even though it's still open by some other parties.  Runtime PM, on the
> other hand tries not to interfere with the normal usage of the device.
> 
> Later:
> 
> (3) ->runtime_idle() and ->runtime_suspend() can only be executed for a
>     device the usage counter of which is equal to zero _and_ [...]
> 
> which underlines the difference again: the usage counter (defined by
> common sense) won't be zero in our case, because the device is
> constantly kept open, while we want to mute it, putting it into a low
> power state. 
...
> Actually, this could be implemented by the various users cooperating in
> closing the device, letting it go to sleep automatically.  But this
> requires strictly cooperating parties and is more complicated that
> flipping some master switch of the device.  We're looking for this
> master switch, before needlessly building our own.

Please just close the device properly. I do not think we want 100
different 'please mute keys A and G', 'please mute middle mouse button',
... interfaces anywhere near mainline.

Or just do it as local patch.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
