From: Barton C Massey <bart@cs.pdx.edu>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Thu, 12 Apr 2007 17:32:32 -0700
Message-ID: <200704130032.l3D0WWaX009409@adara.cs.pdx.edu>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-reply-to: Your message of "Thu, 12 Apr 2007 17:21:57 PDT."
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Barton C Massey <bart@cs.pdx.edu>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

--------
I wrote:

> 	Section "InputDevice"
> 	  Identifier  "MouseMightyMouse0"
> 	  Driver      "mouse"
> 	  Option      "Device" "/dev/input/mouse1"
> 	  Option      "Dev Name" "Mitsumi Electric Apple Optical USB Mouse"
> 	EndSection

Oops---thinko.  The config I'm actually using is

  Section "InputDevice"
    Identifier  "EvMightyMouse0"
    Driver "evdev"
    Option "Name" "Mitsumi Electric Apple Optical USB Mouse"
  EndSection

Sorry for the confusion.

	Bart
