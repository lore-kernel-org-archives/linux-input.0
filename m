From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 20:08:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111958400.21557-100000@netrider.rowland.org>
References: <201010120033.07695.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53642 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751665Ab0JLAI6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 20:08:58 -0400
In-Reply-To: <201010120033.07695.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Tue, 12 Oct 2010, Rafael J. Wysocki wrote:

> It seems to me that for some devices it might be more convenient to have
> an "execute pm_runtime_idle() for this device right now" sysfs trigger
> (and analogously for resume).

Indeed, or even "execute pm_runtime_suspend()".  If the driver uses
autosuspend then the runtime_idle callback will call
pm_runtime_autosuspend, which won't do what you want.

> Anyway, please note that the scenario in which the driver detects inactivity
> and suspends the device in response is not the only one possible.  The other
> one is that the driver is told to suspend the device and then blocks apps
> wanting to access it until resumed.

But it initiates a resume as soon as an app tries to use the device, 
right?  Otherwise you've got a "sticky off", as Dmitry would say.

>  Right now we have interfaces for the
> former, but not for the latter.

If it's not a "sticky off", power/control implements the latter 
interface.

Alan Stern

