From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add Hold on/off and volume event keys
Date: Mon, 13 Jul 2009 09:52:22 -0700
Message-ID: <20090713165221.GB28063@dtor-d630.eng.vmware.com>
References: <4A5A0251.8010803@marcansoft.com> <20090713034359.GB10819@dtor-d630.eng.vmware.com> <4A5B0582.4010709@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:39825 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbZGMQw1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 12:52:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1009664rvb.5
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2009 09:52:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A5B0582.4010709@marcansoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: linux-input@vger.kernel.org

On Mon, Jul 13, 2009 at 11:59:30AM +0200, Hector Martin wrote:
> Hi Dmitry,
> 
> Dmitry Torokhov wrote:
> > On Sun, Jul 12, 2009 at 05:33:37PM +0200, Hector Martin wrote:
> >> Recent Acer laptops produce key events when the Hold button on the media
> >> control panel is activated and deactivated. These events are relevant
> >> for software that wishes to interact with the media panel beyond just
> >> using the media control keys.
> > 
> > What exactly is supposed to happen when you press hold key? Also, is it
> > tuly a key or a switch?
> 
> It's a toggle-button: you hit it once to enable the hold, and again to
> disable it. It produces a press-release scancode pair when it is
> enabled, and a press-release scancode pair for a different scancode when
> it is released. It also has direct hardware effects (LED turns on and
> the rest of the buttons on the media panel stop responding). This hold
> state cannot be queried using the Acer proprietary hardware interfaces,
> which is why reacting to these two different scancodes is the only way
> of knowing what the actual Hold state is.

Hmm... you still need to query the state somehow at startup, otherwise
how do you know what behavior user expects before she presses hold
button for the first time.

> Software needs to be able to
> react to these events to handle the media panel properly (basically
> because their firmware is broken and it does some "interesting" things
> when hold is engaged which need to be ignored).

What exactly does your application do when Hold is engaged?

> 
> This behavior is also shared by a few other keys (bluetooth toggle, WiFi
> toggle, touchpad enable toggle), but for Bluetooth and WiFi the state
> *can* be queried from their hardware (and they already work as rfkill
> devices via the acer-wmi driver and can even be toggled by software, so
> I just map both scancodes to the existing KEY_BLUETOOTH and KEY_WLAN
> events which no one is reacting to anyway). I don't see a use for
> software to react to the touchpad enable key.
> 
> > 
> >> There's also a volume notification key event that replaces the usual
> >> volume-up/down events when the panel is in software-controlled mode.
> >> Software can react to this to detect volume level changes instead of
> >> polling.
> >>
> > 
> > No, I don't think this kind of notification belongs to input layer.
> 
> It's a key event delivered by the EC just like all other keyboard events
> (the EC is also the keyboard controller, as is typical). Where else
> would it belong? To the kernel it just looks like yet another PS/2
> keyboard scancode. Short of somehow hooking into the atkbd driver from
> the acer-wmi driver to special-case this key, I don't see what other way
> there is of dealing with this. Of course it's ugly, but I didn't design
> this hardware :)

It is kernels task to convert ugly hardware implementations into a nice
abstractions ;) Really, this kind notification does not belong to the
input layer, same as with battery notification and network card
pluggin/unplugging. Since it is delivered through keyboard controller
I think you'll need to hack into i8042 interrupt routine and "syphon"
off data from there.

-- 
Dmitry
