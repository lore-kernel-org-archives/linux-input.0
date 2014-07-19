From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power-managing devices that are not of interest at some point
 in time
Date: Sat, 19 Jul 2014 13:59:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1407191357140.28179-100000@netrider.rowland.org>
References: <CANLzEkt4g_Y+nC6PSFCch6hR6YSE-S6FBe0Rt=adgWBi3vjM8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:41041 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755560AbaGSR7D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2014 13:59:03 -0400
In-Reply-To: <CANLzEkt4g_Y+nC6PSFCch6hR6YSE-S6FBe0Rt=adgWBi3vjM8Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: Dmitry Torokhov <dtor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrik Fimml <patrikf@chromium.org>, Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, 19 Jul 2014, Benson Leung wrote:

> > This raises an interesting question.  Suppose the system gets suspended
> > while the lid is closed.  At that point, shouldn't wakeup devices be
> > enabled, even if they were already inhibited?
> 
> It's possible that this could be a policy decision, ie, whether
> power/wakeup is set to enabled for those devices or not.
> However, I'd say that there's only one policy that makes sense in that
> case : wakeups should be disabled while suspended.
> 
> If we inhibited the device during runtime to prevent stray input
> events from being generated, it wouldn't make sense to allow the
> device to potentially generate an accidental wakeup while suspended.

That doesn't really make sense.  If you're afraid of a device 
generating spurious wakeup events when the lid is closed, you should 
never enable it for wakeup.  After all, one of the first things that 
people often do after suspending their laptop is close the lid.

Alan Stern

