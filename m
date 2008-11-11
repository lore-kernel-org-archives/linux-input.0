From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
	protocol
Date: Tue, 11 Nov 2008 14:08:09 +1000
Message-ID: <20081111040808.GA6776@dingo.redhat.com>
References: <49142351.9080805@euromail.se> <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com> <49145016.7090206@euromail.se> <3aaafc130811070636g681accf5qae252679c2edcdb9@mail.gmail.com> <49145628.7030804@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:50888 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbYKKEJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2008 23:09:34 -0500
Content-Disposition: inline
In-Reply-To: <49145628.7030804@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: "J.R. Mauro" <jrm8005@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 07, 2008 at 03:52:24PM +0100, Henrik Rydberg wrote:
> > Have you worked with MPX? Or was a vanilla-X11 driver simple enough?
> > How does this all get presented to userspace applications? Multiple
> > mouse inputs or special stuff that applications would need a rewrite
> > to leverage?
> 
> MPX is about making use of multiple pointers. The MT protocol is about
> making use of multiple fingers. It can in principle be used as input
> to MPX applications; I will bring it up with Peter Hutterer. However,
> the main aim is to bring advanced gestures to the linux desktop.

MPX is about making use of multiple input devices simultaneously and most of
the groundwork to get MT devices going is already there. From X's point of
view we need a bunch of new events to be sent to clients (and the bells and
whistles around it). The hard bit here is deciding which client to send the
events to.

I'd also say that an MT device should be presented as a single device with
multiple input points rather than as multiple separate devices.
This does require to rewrite applications (or at least slot some intermediate
layer in between), but having multitouch look like multi-mouse is a really bad
idea.

Cheers,
  Peter
