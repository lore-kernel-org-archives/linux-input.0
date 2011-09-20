From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Race with Bluetooth hid drivers?
Date: Tue, 20 Sep 2011 19:11:38 +0100
Message-ID: <1316542298.2591.2.camel@novo.hadess.net>
References: <1316482533.2468.6.camel@novo.hadess.net>
	 <CANq1E4TCT=jbWJPERaiARzRgnKf6Ep3oiiNQ2Jofn1QnVEvbOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57676 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab1ITSLp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 14:11:45 -0400
In-Reply-To: <CANq1E4TCT=jbWJPERaiARzRgnKf6Ep3oiiNQ2Jofn1QnVEvbOQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

On Tue, 2011-09-20 at 11:00 +0200, David Herrmann wrote:
> Hi Bastien
> 
> On Tue, Sep 20, 2011 at 3:35 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > Heya,
> >
> > I'm pretty certain that's already been discussed, but can't seem to find
> > the thread in question, or whether somebody sent patches for the issue.
> >
> > The problem I see is that the input device is advertised really early in
> > its creation, and seems to be missing information when udev (and layers
> > above it in the stack) probes it.
<snip>
> The hid-wacom.c driver should probably use the input_mapped() callback
> instead of setting the input flags in wacom_probe(). input_mapped() is
> called for every descriptor field so there must at least be one valid
> field to make it work. I don't have the device so I can't test it, but
> try something like this:
> 
> From 2f91a998b1bca4b654903e41394fae19dfed1a3c Mon Sep 17 00:00:00 2001
> From: David Herrmann <dh.herrmann@googlemail.com>
> Date: Tue, 20 Sep 2011 10:54:06 +0200
> Subject: [PATCH] HID: wacom: Set input bits before registration
> 
> We shouldn't change the event flags of input devices after they get registered.
> Otherwise, udev will not get notified of these flags and cannot setup the
> devices properly.
> This fixes the probing to set the input event flags on the input_mapped callback
> instead of the probe function.
> 
> Reported-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Works beautifully.
Tested-by: Bastien Nocera <hadess@hadess.net>

Jiri, Dmitry, feel free to add a
Signed-off-by: Bastien Nocera <hadess@hadess.net>
if you think this is the right fix for the problem.

/Bastien, can't even fix his own driver

