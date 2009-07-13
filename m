From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] input: add Hold on/off and volume event keys
Date: Mon, 13 Jul 2009 11:59:30 +0200
Message-ID: <4A5B0582.4010709@marcansoft.com>
References: <4A5A0251.8010803@marcansoft.com> <20090713034359.GB10819@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:44790 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138AbZGMJ7e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 05:59:34 -0400
In-Reply-To: <20090713034359.GB10819@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Dmitry Torokhov wrote:
> On Sun, Jul 12, 2009 at 05:33:37PM +0200, Hector Martin wrote:
>> Recent Acer laptops produce key events when the Hold button on the media
>> control panel is activated and deactivated. These events are relevant
>> for software that wishes to interact with the media panel beyond just
>> using the media control keys.
> 
> What exactly is supposed to happen when you press hold key? Also, is it
> tuly a key or a switch?

It's a toggle-button: you hit it once to enable the hold, and again to
disable it. It produces a press-release scancode pair when it is
enabled, and a press-release scancode pair for a different scancode when
it is released. It also has direct hardware effects (LED turns on and
the rest of the buttons on the media panel stop responding). This hold
state cannot be queried using the Acer proprietary hardware interfaces,
which is why reacting to these two different scancodes is the only way
of knowing what the actual Hold state is. Software needs to be able to
react to these events to handle the media panel properly (basically
because their firmware is broken and it does some "interesting" things
when hold is engaged which need to be ignored).

This behavior is also shared by a few other keys (bluetooth toggle, WiFi
toggle, touchpad enable toggle), but for Bluetooth and WiFi the state
*can* be queried from their hardware (and they already work as rfkill
devices via the acer-wmi driver and can even be toggled by software, so
I just map both scancodes to the existing KEY_BLUETOOTH and KEY_WLAN
events which no one is reacting to anyway). I don't see a use for
software to react to the touchpad enable key.

> 
>> There's also a volume notification key event that replaces the usual
>> volume-up/down events when the panel is in software-controlled mode.
>> Software can react to this to detect volume level changes instead of
>> polling.
>>
> 
> No, I don't think this kind of notification belongs to input layer.

It's a key event delivered by the EC just like all other keyboard events
(the EC is also the keyboard controller, as is typical). Where else
would it belong? To the kernel it just looks like yet another PS/2
keyboard scancode. Short of somehow hooking into the atkbd driver from
the acer-wmi driver to special-case this key, I don't see what other way
there is of dealing with this. Of course it's ugly, but I didn't design
this hardware :)

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

