From: simon@mungewell.org
Subject: Re: Bug: HID-Sony: DS4 touch-pad corrupts Axis0
Date: Tue, 22 Apr 2014 12:50:42 -0400
Message-ID: <35342da9a382362bc86ab7abfa7ee07a.squirrel@mungewell.org>
References: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>
    <535555C6.5050407@gmail.com> <53557CB5.1010100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41181 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737AbaDVQuo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 12:50:44 -0400
In-Reply-To: <53557CB5.1010100@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>


> The joydev device *is* missing the mappings for the touchpad axes for
> some reason (JSIOCGAXES returns 14 instead of 17 like it should).  I'm
> not sure why though.  In the Sony driver the touchpad axis bits are set
> in the probe function and work correctly via the evdev interface and
> looking in the joydev module it should properly handle and map all axes
> up to ABS_MAX so the problem probably lies somewhere else.  If I had to
> guess, it seems like the joydev device is being created after the HID
> descriptor is parsed, but before the device probe function is called.
>
> Can anyone more familiar with the general input system comment on why
> this might be happening?

I find it suspicious that it doesn't happen the first time (after boot)
that the controller is plugged in, but then does every subsequent time...
maybe some un-init memory somewhere.

Is this kernel behaviour, or down to the controller state (ie alive after
first plug)? We see that the DS3 behaves differently wrt leds depending on
whether it is asleep or alive when plugged in.

I'll dig a little deeper tonight to see if I can track the problem down.
Simon.

