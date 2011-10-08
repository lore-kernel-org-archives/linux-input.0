From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Race with Bluetooth hid drivers?
Date: Sat, 8 Oct 2011 23:23:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110082322440.14901@pobox.suse.cz>
References: <1316482533.2468.6.camel@novo.hadess.net> <CANq1E4TCT=jbWJPERaiARzRgnKf6Ep3oiiNQ2Jofn1QnVEvbOQ@mail.gmail.com> <1316542298.2591.2.camel@novo.hadess.net> <CANq1E4Qh123MKXv07aJ6=9zHQunEQOrikNP2=5nyF5BVj9uBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60605 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab1JHVX2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 8 Oct 2011 17:23:28 -0400
In-Reply-To: <CANq1E4Qh123MKXv07aJ6=9zHQunEQOrikNP2=5nyF5BVj9uBpw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

On Sat, 8 Oct 2011, David Herrmann wrote:

> Hi
> 
> *CC'ing Jiri*

Thanks a lot for CC, I am a bit behind in linux-input@ folder :/

> >> From 2f91a998b1bca4b654903e41394fae19dfed1a3c Mon Sep 17 00:00:00 2001
> >> From: David Herrmann <dh.herrmann@googlemail.com>
> >> Date: Tue, 20 Sep 2011 10:54:06 +0200
> >> Subject: [PATCH] HID: wacom: Set input bits before registration
> >>
> >> We shouldn't change the event flags of input devices after they get registered.
> >> Otherwise, udev will not get notified of these flags and cannot setup the
> >> devices properly.
> >> This fixes the probing to set the input event flags on the input_mapped callback
> >> instead of the probe function.
> >>
> >> Reported-by: Bastien Nocera <hadess@hadess.net>
> >> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> >
> > Works beautifully.
> > Tested-by: Bastien Nocera <hadess@hadess.net>
> >
> > Jiri, Dmitry, feel free to add a
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > if you think this is the right fix for the problem.

Good catch, thanks guys. Applied.

-- 
Jiri Kosina
SUSE Labs
