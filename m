From: Stephan Mueller <smueller@chronox.de>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Fri, 31 Jan 2014 22:02:18 +0100
Message-ID: <5545347.HoO9G4Y1gL@myon.chronox.de>
References: <1674012.xCMptsh8XR@myon.chronox.de> <CAN+gG=HAXE4LT_tN+3tE8-T_L5g+2HAE35CN+z8KCEQcmJ=JWw@mail.gmail.com> <13914184.mVhhUrzN60@myon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <13914184.mVhhUrzN60@myon.chronox.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Am Freitag, 31. Januar 2014, 05:31:53 schrieb Stephan Mueller:

Hi,

The middle mouse button works in Linux, but very differently than you may 
expect: I still do not see any events when only pressing the middle mouse 
button.

Out of luck, I pressed the middle button and moved the mouse. And there you 
see, the mouse returns button 4 and 5.That means that pressing the middle 
mouse button seems to morph the mouse into an implicit wheel.

Thus, when I press the middle button and move my mouse, X11 applies the zoom 
in and zoom out operations.

I think I can remap the button 4 / 5 to button 2 for the middle mouse. But 
then, the button 2 would only work when hitting the middle mouse button and 
move the mouse pointer.

This is not what I want. Do you see any other way of turning the middle mouse 
button into a real useful button?

Ciao
Stephan
-- 
| Cui bono? |
