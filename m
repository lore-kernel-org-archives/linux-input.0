From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 3 Nov 2016 11:43:12 +0100
Message-ID: <20161103104312.GA22701@mail.corp.redhat.com>
References: <ACB931EC-6682-4E17-A028-5BF31689A1D4@gmail.com>
 <1DD62093774CEE42AFC16E785A10880474642D7B@USCULXMSG08.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbcKCKnS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Nov 2016 06:43:18 -0400
Content-Disposition: inline
In-Reply-To: <1DD62093774CEE42AFC16E785A10880474642D7B@USCULXMSG08.am.sony.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Cc: Frank Praznik <frank.praznik@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, "Bird, Timothy" <Tim.Bird@am.sony.com>

On Oct 30 2016 or thereabouts, Colenbrander, Roelof wrote:
> _______________________________________
> From: Frank Praznik [frank.praznik@gmail.com]
> Sent: Sunday, October 30, 2016 8:04 AM
> To: linux-input@vger.kernel.org
> Cc: Dmitry Torokhov; Henrik Rydberg; Benjamin Tissoires; Bird, Timothy; Colenbrander, Roelof
> Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers desiring this functionality
> 
> >> On Thu, Oct 27, 2016 at 4:19 PM, Dmitry Torokhov
> >> <dmitry.torokhov@xxxxxxxxx> wrote:
> >> > On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander wrote:
> >> >> From: Roderick Colenbrander <roderick.colenbrander@xxxxxxxx>
> >> >>
> >> >> The input-mt driver pointer emulation from 'input_mt_sync_frame' regardless
> >> >> of the flags passed in to 'input_mt_init_slots' by device drivers.
> >> >
> >> > Right, because needing single-touch (pointer) emulation is not property
> >> > of device or driver but rather consumer. If we get to the point where
> >> > everything is ready to accept multi-touch (are we there yet) then we can
> >> > stop doing pointer emulation altogether.
> >> >
> >> >>
> >> >> Pointer emulation is undesired on drivers, which didn't request this
> >> >> capability like the hid-sony driver for the Dualshock 4. This gamepad already
> >> >> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
> >> >> inject touchpad values into these sticks, which is undesired.
> >> >
> >> > The driver should not be re-purposing events like that.
> >> > ABS_MT_POSITION_X and ABS_X should match.
> >> >
> >> > Why doesn't driver follow Documentation/input/gamepad.txt?
> >> >
> >>
> >> The original hid-sony code and the multitouch handling code for the Dualshock 4
> >> were written by the community. We are stepping in to make the hid-sony driver
> >> properly handle the Dualshock 4.
> >> The driver doesn't fully follow the gamepad spec yet, which we will
> >> try to improve. At
> >> least the left analog stick is reported as ABS_X and ABS_Y already,
> >> but the buttons
> >> are inconsistent and right stick is wrong as well.
> >> While it would be great to conform to the spec, the conflict with
> >> multitouch would still
> >> exist as the Dualshock 4 has both analog sticks and a multitouch touchpad.
> 
> > The button and axis mappings are what the controller’s default HID descriptor provides.  The descriptors in the driver just extend the ones sent by the controller to allow additional functionality(i.e. gyro/accel and full Bluetooth mode), but the button and axis mappings were unchanged from the defaults so as not to introduce mapping discrepencies with older kernels which used the generic HID driver.  Note that changing them at this point *will* break a lot of software (SDL has had these mappings hardcoded into it’s controller database header for years now).
> 
> Ideally I would like to start following the spec (the current mapping is so awful), but SDL is the issue. Its database can be updated as the table uses a guid composed of bus_type | vendor_id | product_id | version. I don't know if it is allowed, but the version field could be utilized to negotiate a different button mapping... We wouldn't mind sending such patches.

The version is retrieved from the HID descriptor. So technically,
changing it has the risk of introducing a conflict with future devices.
The version field in input is a uint16, while the one in HID is a
uint32. usbhid retrieves a uint16 from the descriptor, so it's fine.
However, if you were to change the version, you should make sure your
company will not reuse the same version number (I guess doing "0x8000 |
version" might prevent future clashes if the version are incremented by
one).

> 
> >>>
> >>> Disabling the pointer emulation feature avoids the conflict. This
> >>> issue was only exposed
> >>> recently by adding of the input_mt_sync_frame call as recommended by Benjamin as
> >>> part of some improvements we did for touchpad handling in hid-sony.
> >>>
> 
> > Is input_mt_sync_frame even necessary?  The original implementation followed the protocol for a “Type B” device as defined in Documentation/input/multi-touch-protocol.txt which doesn’t require SYN_MT_REPORT messages.

input_mt_sync_frame doesn't add the SNY_MT_REPORT events, it introduces
the pointer emulation. And yes, I think I might just have screwed here
by recommending to use input_mt_sync_frame() because the call which is
actually needed is input_sync().

> 
> The call was added on recommendation from Benjamin Tissoires when we added support for touch history support. He said that if we didn't add this call the values would gt mangled by the kernel in evdev and data would get lost. For us the history was important for gesture reasons.

As I said, I screwed this. You should use input_sync(). However, as
Dmitry said, you need to also have ABS_X|Y in sync with
ABS_MT_POSITION_X|Y. So the split of the touchpad from the game
controller is the best move.

You can find an example of this in the hid tree in wacom_sys.c function
wacom_allocate_input(), or in hid-alps.c for a slightly less complex
driver :) (look for input_allocate_device).

Cheers,
Benjamin
