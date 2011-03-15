From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Tue, 15 Mar 2011 12:58:46 +0000
Message-ID: <20110315125846.34b6af32@lxorguk.ukuu.org.uk>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
	<20110315060203.GF1046@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55149 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757626Ab1COM7F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 08:59:05 -0400
In-Reply-To: <20110315060203.GF1046@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, rjw@sisk.pl

> I'd be more happy if it was just an input device. If non-wired interrupt
> is a common case then we should probably add polled input device mode,

I can't really answer how common it is or would be - its a generic chip
that is used on all sorts of equipment

> but we certainly should not register completely non-functional input
> device as the driver does now.

Agreed

> We also have a way of retrieving current (or rather most recent)
> coordinates via EVIOCGABS so I am not sure why we want the sysfs way of
> retrieving coordinates as well.

The sysfs way comes about because the devices are very very power
oriented, waking up and polling regularly burns power, hence also the
power control side. Opening an input device would power it up for the
duration it was open and the polling would cause a lot of wakeups burning
power.

Doing open/EVIOCGABS/close to avoid that aspect of the input layer
won't ensure you get current data that I can see - because an IRQ may not
have occurred between the open and the EVIOCGABS so any data may be very
stale or non-existent.

The polled case looks trivial to sort but for an IRQ driver driver it
looks like you would need a new "get co-ordinates right now" optional
method tht EVIOCGABS would use if available ?

> Regarding power mode - I really believe that this should be done on the
> driver core level instead of implementing "manual off" in every single
> driver out there.

Definitely - not sure what plans Rafael has there ?

Alan
