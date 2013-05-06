From: Todd Showalter <todd@electronjump.com>
Subject: Re: [PATCH 16/26] HID: wiimote: add Classic Controller extension
Date: Sun, 5 May 2013 20:39:14 -0400
Message-ID: <CAFmpkyhX4vmavY8ZHh-ssLFbKrB_AhUa-kL+euuu+X+Yv2k6UA@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-17-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:50313 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab3EFAjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 20:39:15 -0400
Received: by mail-qe0-f53.google.com with SMTP id cz11so1782653qeb.26
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 17:39:14 -0700 (PDT)
In-Reply-To: <1367788390-29835-17-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Sun, May 5, 2013 at 5:13 PM, David Herrmann <dh.herrmann@gmail.com> wrote:

> Add a new extension module for the classic controller so we get hotplug
> support for this device. It is mostly the same as the old static classic
> controller parser.

    Could the buttons/axis values on this please be mapped as
appropriate for the standard gamepad?  What I'd like, ideally, with
new #defines in input.h as needed:

- left stick to ABS_LX, ABS_LY
- right stick to ABS_RX, ABS_RY
- dpad to ABS_DX, ABS_DY
- left trigger to ABS_LTRIG
- right trigger to ABS_RTRIG
- x to BTN_NORTH
- a to BTN_EAST
- b to BTN_SOUTH
- y to BTN_WEST
- zl to BTN_LSHOULDER
- zr to BTN_RSHOULDER
- plus to BTN_START
- minus to BTN_SELECT
- home to BTN_SYSTEM

    I'm trying to get all of the gamepads to use a common control
mapping.  Mapping functions by placement on the controller is far more
useful to games than mapping them by the names assigned by the
manufacturer.  There is no consistency on button naming between
manufacturers, but there is a lot of consistency in functionality and
layout.  I'm hoping that as we bring new gamepads online, we can
expose that layout consistency.

    As an example of what I mean, the classic controller x button is
in the same position as:

- the x button on nintendo gamepads (oddly...)
- the y button on xbox-family gamepads
- the y button on sega gamepads
- the y button on the ouya gamepads
- the p button on the gamestick gamepad
- the triangle button on playstation-family gamepads
- the triangle button on some futime gamepads
- the not-quite-a-triangle don't sue us sony button on at least one
betop gamepad (google for the football one)
- the blue button on gravis controllers
- the 1 button on the noga.net gamepad
- the 1 button on some saitek gamepads
- the 2 button on some steelseries gamepads
- the 4 button on some other steelseries gamepads
- the 4 button on some logitech gamepads
- probably every glyph in the basic multilingual plane on some gamepad or other

    I want those all to map to BTN_NORTH.  They're all at the top of a
diamond-shaped cluster of 4 face buttons under the player's right
thumb.  From a game development point of view, it's that position that
matters, because I'm going to be assigning functions to buttons based
on how accessible the buttons are rather than what random name the
manufacturer may have assigned to them.  Especially when for a while
there was some worry about whether the pattern of button labels was
copyrightable, so the second tier hardware manufacturers were
explicitly avoiding using established button naming conventions.

    If you look at the above list, it clearly doesn't make any sense
to use the button labels to identify these.  It makes far more sense
to identify them by layout position in a standardized layout.

    It seems like there's going to need to be a mapping layer for
gamepads that already have established interfaces (and I'm actually
writing a library to do that right now...), but I'd really prefer if
the library was just for legacy support.

                                       Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
