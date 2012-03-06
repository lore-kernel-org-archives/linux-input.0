From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: Proper representation of button touch (as opposed to button press)
Date: Mon, 05 Mar 2012 16:59:04 -0800
Message-ID: <4F556158.6020500@gmail.com>
References: <CANRwn3QLhpH=W8r1fJ=xB4Dc46kdfaG+5_x0oFbEJYWjTyYyZA@mail.gmail.com> <20120303002137.GA11833@core.coreip.homeip.net> <CAGzDe_bJFanph5Gy_zCSs21mmH2DRnYUyWYrX8vW_nViBbWy4Q@mail.gmail.com> <CANRwn3SzkR9uDgOTXMgrwY_hJSNdatygnoqXMgVi8G9E2_QDeA@mail.gmail.com> <CAGzDe_aCPxgHXEwXscwxtXQppZig1Mbd8c3a9t67yL3NC-bpdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56596 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598Ab2CFA66 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Mar 2012 19:58:58 -0500
Received: by pbcun15 with SMTP id un15so3414113pbc.19
        for <linux-input@vger.kernel.org>; Mon, 05 Mar 2012 16:58:58 -0800 (PST)
In-Reply-To: <CAGzDe_aCPxgHXEwXscwxtXQppZig1Mbd8c3a9t67yL3NC-bpdw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On 03/05/2012 02:31 PM, Chris Bagwell wrote:
> On Mon, Mar 5, 2012 at 1:36 PM, Jason Gerecke<killertofu@gmail.com>  wrote:
>> On Sat, Mar 3, 2012 at 7:59 AM, Chris Bagwell<chris@cnpbagwell.com>  wrote:
>>> On Fri, Mar 2, 2012 at 6:21 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com>  wrote:
>>>> Hi Jason,
>>>>
>>>> On Fri, Mar 02, 2012 at 10:36:22AM -0800, Jason Gerecke wrote:
>>>>> The Intuos5 was just announced, and I'm working on adding support for
>>>>> it to the wacom kernel module. One feature new to the Intuos5 is the
>>>>> addition of capacitive sensors embedded in the buttons. Each
>>>>> ExpressKey (button) has two bits of state: one for the capacitive
>>>>> switch and one for the mechanical switch. These bits are synthesized
>>>>> into three cases: released, touched, and pressed (the 4th case of
>>>>> "pressed with a non-capacitive object" isn't particularly
>>>>> interesting). My initial thought was to call input_event() with a
>>>>> unique value for the 'touched' case. However, the documentation only
>>>>> defines three values for EV_KEY: 0 (released), 1 (pressed), and 2
>>>>> (autorepeat).
>>>>>
>>>>> Is 'touched' a case we would want to allow for EV_KEY, or should I be
>>>>> representing things differently?
>>>>
>>>> Differently please. It looks like you have 2 independent objects there -
>>>> one mechanical switch (persistent on/off) and one is a key (pressed
>>>> while touched).
>> I think you're confused. The buttons on
>> Inutos4/Intuos3/Cintiq21UX/etc. report when they've been pressed. The
>> Intuos5 embeds a capacitive sensor into each button so that they can
>> report "touched" in addition. If you ignore the capacitive sensor,
>> each button is exactly the same as you'd find on our other tablets, a
>> mouse, or a keyboard.  It should be in a "pressed" state while
>> sufficient force is applied, and in an "unpressed" state otherwise. It
>> is *not* expected to behave like a persistent toggle switch.
>>
>> Since "touched" is a natural and distinct button state, it makes sense
>> (to me at least) to have EV_KEY define it as an additional legal
>> value.
>>
>>>
>>> There is a little overlap here with clickpads and it would be nice if
>>> user apps could work similar for both.  The main use (I think) of this
>>> proposed key press is to give visual feedback were users finger is at
>>> before they press hard enough to activate button.  It could be the HUD
>>> feature of Intuos5 or the taskbar applet Windows synaptics driver has
>>> that gives feedback how touchpad is being touched.
>>>
>>> For clickpads, its an X/Y value that a HUD/applet would use to give
>>> the visual feedback.  If these new "keys" are not exposed as a full
>>> blown capacitive touch strip then you could simulate that and send an
>>> Y=1 and X=1..4 to represent were finger is.
>>>
>>> The main negative with this is you'll have the headache clickpad user
>>> land has trying to detect when X/Y is buttons and when its touchpad
>>> movement.  At least in your case, you could send a BTN_TOOL_STRIP or a
>>> BTN_TOOL_FINGER+serial # to let user land know this is a unique area
>>> of touch.
>>>
>>> Chris
>> I'm not sure about this... I don't think there are really any clickpad
>> user apps out there that would be relevant to the Intuos5 since its
>> buttons aren't used like one. While it'd be possible to simulate a
>> clickpad with the raw data, I'm having a hard time seeing the use for
>> anything beyond a HUD (which could be written without the
>> faux-position data anyway).
>>
>
> Yeah, but the other extreme is a pain as well.  Dmitry suggestion
> would be something like send BTN_1/2/3/4 for 4 button presses and
> KEY_1/2/3/4 when touching buttons but not pressed hard.
>
> That user land app is way to hard coded if they know to bind those two
> things together without hints from kernel.
>
> They need the hint for X/Y solution but I'm only suggesting that
> INPUT_PROP_BUTTONPAD already exists to give that hint.  There are some
> userland assumptions on BUTTONPAD's only wanting BTN_LEFT/RIGHT though
> so maybe its not a great idea.

BUTTONPAD is a device-wide property. This feels more like a property of 
parts of a device.

I kind of like the simplicity of the EV_KEY approach, but it treats 
"pressure" as a binary value. Even if the Intuos 5 only provides a 
binary value, I can image future devices that provide a full pressure 
absolute value range.

Without having thought of any specific solutions, I think one reasonable 
approach would be to come up with a new evdev protocol addition that 
allows for event codes to be grouped together, and allow for custom 
labels of the codes. The two could be provided by the same mechanism 
even. One EV_KEY and EV_ABS axis per Intuos 5 button, both labeled 
"Button <blah>" would group them together and provide for extension as 
we get more and more complex devices.

-- Chase
