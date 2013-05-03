From: Simon Farnsworth <simon.farnsworth@onelan.com>
Subject: Re: Game Controllers
Date: Fri, 03 May 2013 11:29:25 +0100
Message-ID: <3024546.hGDLPfhqRN@f17simon>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com> <CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com> <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp04.uk.clara.net ([195.8.89.37]:58045 "EHLO
	claranet-outbound-smtp04.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752351Ab3ECLwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 May 2013 07:52:37 -0400
In-Reply-To: <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thursday 2 May 2013 15:10:55 Todd Showalter wrote:
>     Users want to plug in a gamepad and have it just work, regardless
> of who made it.  Developers occasionally want access to he more
> esoteric parts of the gamepad hardware, but 99% of the time they just
> want standard sticks-and-buttons functionality mapped in a predictable
> way.
> 
>     As a developer, if I had to choose between the current situation
> or having all game hardware map down to a standard one-stick, two
> button controller with no access to anything else, I'd jump on the
> standard controller in a heartbeat.  A standard controller means
> there's a gigantic pile of crap I don't have to deal with every time I
> write a game.  It means once a player knows what the NORTH button is,
> it's the same in every game and on every controller, regardless of
> developer or hardware maker.
> 
Could you consider a gamepad equivalent of libv4l2 (source found in 
http://git.linuxtv.org/v4l-utils.git/tree/HEAD:/lib )?

The idea here is a shared library that can be used in two ways:

 * As an LD_PRELOAD library, for applications that have been designed around a 
standard device. When used as an LD_PRELOAD, it intercepts 
open()/ioctl()/close() etc; it passes them through if you're opening something 
that isn't a V4L2 device, and uses its internal functionality to emulate 
standard devices atop whatever you've actually got (e.g. doing colour space 
conversion).

 * As a genuine shared library, using v4l2_open, v4l2_ioctl etc when working 
with V4L2 devices. This is a mechanical change to an existing codebase, as the 
functions provided by libv4l2 behave the same way as the kernel functions do, 
but add extra functionality like colourspace conversion.

A gamepad version would intercept opens of /dev/input/event* nodes, and if 
that node was a gamepad, do the remapping from gamepad-specific events to the 
standard gamepad events. You can then use this with unmodified apps as an 
LD_PRELOAD, or with modified apps as a shared library that only gets in the way 
if the app is accessing a gamepad.
-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com
