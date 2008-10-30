From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: proposal on runtime power management in hid
Date: Thu, 30 Oct 2008 13:01:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810301258390.2513-100000@iolanthe.rowland.org>
References: <200810301704.01005.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51943 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754316AbYJ3RBD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2008 13:01:03 -0400
In-Reply-To: <200810301704.01005.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brownell <david-b@pacbell.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jslaby@suse.cz>, linux-pm@vger.kernel.org

On Thu, 30 Oct 2008, Oliver Neukum wrote:

> Hi,
> 
> I am looking at runtime power management for usb hid devices.
> There's a problem with hidraw. As we have no idea, what goes
> on between a device and users of hidraw, it seems to me that
> such a device should not be subject to runtime power management
> without the user's explicit agreement.
> But that would be only a kludge. Therefore this is my first draft of
> an API to cleanly allow this.
> 
> It is based on telling drivers what capabilties a device must provide
> to the system, allowing the driver to use the most aggressive runtime
> power management compatible with the requirement.
> Comments?

Would it make more sense never to autosuspend a device that has an open
hidraw interface?  Then if you want to, you could add an API allowing
the user to tell the kernel to suspend or to resume (if the existing
sysfs interface isn't sufficient).

Alan Stern

