From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Power-managing devices that are not of interest at some point
 in time
Date: Wed, 16 Jul 2014 23:36:05 +0200
Message-ID: <1405546565.23419.3.camel@linux-fkkt.site>
References: <Pine.LNX.4.44L0.1407161400150.1028-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1407161400150.1028-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dtor@google.com>, Patrik Fimml <patrikf@chromium.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2014-07-16 at 14:08 -0400, Alan Stern wrote:
> > I am not so much concerned about userspace, but about reusing of as
> > much of existing PM framework in the drivers. Right now it is very
> > hard to correctly track dependencies between general open/close,
> > system suspend/resume, and various runtime-PM transitions. Adding
> yet
> > another PM mechanism into the mix will just add more complexity.
> 
> Would it make sense to unbind the drivers for these devices when the 
> lid is closed?  With the drivers gone, there would naturally be no 

No, because I don't want settings of my devices to disappear.
You can do that only for stateless devices. And I doubt you can
tell in general which devices are stateless.

	Regards
		Oliver
