From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: Proper representation of button touch (as opposed to button press)
Date: Sat, 3 Mar 2012 09:59:39 -0600
Message-ID: <CAGzDe_bJFanph5Gy_zCSs21mmH2DRnYUyWYrX8vW_nViBbWy4Q@mail.gmail.com>
References: <CANRwn3QLhpH=W8r1fJ=xB4Dc46kdfaG+5_x0oFbEJYWjTyYyZA@mail.gmail.com>
	<20120303002137.GA11833@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41087 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743Ab2CCP7k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 3 Mar 2012 10:59:40 -0500
Received: by lahj13 with SMTP id j13so3127810lah.19
        for <linux-input@vger.kernel.org>; Sat, 03 Mar 2012 07:59:39 -0800 (PST)
In-Reply-To: <20120303002137.GA11833@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Fri, Mar 2, 2012 at 6:21 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Jason,
>
> On Fri, Mar 02, 2012 at 10:36:22AM -0800, Jason Gerecke wrote:
>> The Intuos5 was just announced, and I'm working on adding support for
>> it to the wacom kernel module. One feature new to the Intuos5 is the
>> addition of capacitive sensors embedded in the buttons. Each
>> ExpressKey (button) has two bits of state: one for the capacitive
>> switch and one for the mechanical switch. These bits are synthesized
>> into three cases: released, touched, and pressed (the 4th case of
>> "pressed with a non-capacitive object" isn't particularly
>> interesting). My initial thought was to call input_event() with a
>> unique value for the 'touched' case. However, the documentation only
>> defines three values for EV_KEY: 0 (released), 1 (pressed), and 2
>> (autorepeat).
>>
>> Is 'touched' a case we would want to allow for EV_KEY, or should I be
>> representing things differently?
>
> Differently please. It looks like you have 2 independent objects there -
> one mechanical switch (persistent on/off) and one is a key (pressed
> while touched).

There is a little overlap here with clickpads and it would be nice if
user apps could work similar for both.  The main use (I think) of this
proposed key press is to give visual feedback were users finger is at
before they press hard enough to activate button.  It could be the HUD
feature of Intuos5 or the taskbar applet Windows synaptics driver has
that gives feedback how touchpad is being touched.

For clickpads, its an X/Y value that a HUD/applet would use to give
the visual feedback.  If these new "keys" are not exposed as a full
blown capacitive touch strip then you could simulate that and send an
Y=1 and X=1..4 to represent were finger is.

The main negative with this is you'll have the headache clickpad user
land has trying to detect when X/Y is buttons and when its touchpad
movement.  At least in your case, you could send a BTN_TOOL_STRIP or a
BTN_TOOL_FINGER+serial # to let user land know this is a unique area
of touch.

Chris
