From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 20:46:46 +0200
Message-ID: <201010122046.46562.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010111958400.21557-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39126 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab0JLSrl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 14:47:41 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010111958400.21557-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Tuesday, October 12, 2010, Alan Stern wrote:
> On Tue, 12 Oct 2010, Rafael J. Wysocki wrote:
> 
> > It seems to me that for some devices it might be more convenient to have
> > an "execute pm_runtime_idle() for this device right now" sysfs trigger
> > (and analogously for resume).
> 
> Indeed, or even "execute pm_runtime_suspend()".  If the driver uses
> autosuspend then the runtime_idle callback will call
> pm_runtime_autosuspend, which won't do what you want.
> 
> > Anyway, please note that the scenario in which the driver detects inactivity
> > and suspends the device in response is not the only one possible.  The other
> > one is that the driver is told to suspend the device and then blocks apps
> > wanting to access it until resumed.
> 
> But it initiates a resume as soon as an app tries to use the device, 
> right?  Otherwise you've got a "sticky off", as Dmitry would say.

Yes, that's the "sticky off" thing.

Rafael
