From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: RE: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Sun, 30 Oct 2016 18:45:29 +0000
Message-ID: <1DD62093774CEE42AFC16E785A10880474642D7B@USCULXMSG08.am.sony.com>
References: <ACB931EC-6682-4E17-A028-5BF31689A1D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:11072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754765AbcJ3TU1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Oct 2016 15:20:27 -0400
In-Reply-To: <ACB931EC-6682-4E17-A028-5BF31689A1D4@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Bird, Timothy" <Tim.Bird@am.sony.com>

_______________________________________=0A=
From: Frank Praznik [frank.praznik@gmail.com]=0A=
Sent: Sunday, October 30, 2016 8:04 AM=0A=
To: linux-input@vger.kernel.org=0A=
Cc: Dmitry Torokhov; Henrik Rydberg; Benjamin Tissoires; Bird, Timothy; Col=
enbrander, Roelof=0A=
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers d=
esiring this functionality=0A=
=0A=
>> On Thu, Oct 27, 2016 at 4:19 PM, Dmitry Torokhov=0A=
>> <dmitry.torokhov@xxxxxxxxx> wrote:=0A=
>> > On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander wrote:=
=0A=
>> >> From: Roderick Colenbrander <roderick.colenbrander@xxxxxxxx>=0A=
>> >>=0A=
>> >> The input-mt driver pointer emulation from 'input_mt_sync_frame' rega=
rdless=0A=
>> >> of the flags passed in to 'input_mt_init_slots' by device drivers.=0A=
>> >=0A=
>> > Right, because needing single-touch (pointer) emulation is not propert=
y=0A=
>> > of device or driver but rather consumer. If we get to the point where=
=0A=
>> > everything is ready to accept multi-touch (are we there yet) then we c=
an=0A=
>> > stop doing pointer emulation altogether.=0A=
>> >=0A=
>> >>=0A=
>> >> Pointer emulation is undesired on drivers, which didn't request this=
=0A=
>> >> capability like the hid-sony driver for the Dualshock 4. This gamepad=
 already=0A=
>> >> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation w=
ould=0A=
>> >> inject touchpad values into these sticks, which is undesired.=0A=
>> >=0A=
>> > The driver should not be re-purposing events like that.=0A=
>> > ABS_MT_POSITION_X and ABS_X should match.=0A=
>> >=0A=
>> > Why doesn't driver follow Documentation/input/gamepad.txt?=0A=
>> >=0A=
>>=0A=
>> The original hid-sony code and the multitouch handling code for the Dual=
shock 4=0A=
>> were written by the community. We are stepping in to make the hid-sony d=
river=0A=
>> properly handle the Dualshock 4.=0A=
>> The driver doesn't fully follow the gamepad spec yet, which we will=0A=
>> try to improve. At=0A=
>> least the left analog stick is reported as ABS_X and ABS_Y already,=0A=
>> but the buttons=0A=
>> are inconsistent and right stick is wrong as well.=0A=
>> While it would be great to conform to the spec, the conflict with=0A=
>> multitouch would still=0A=
>> exist as the Dualshock 4 has both analog sticks and a multitouch touchpa=
d.=0A=
=0A=
> The button and axis mappings are what the controller=92s default HID desc=
riptor provides.  The descriptors in the driver just extend the ones sent b=
y the controller to allow additional functionality(i.e. gyro/accel and full=
 Bluetooth mode), but the button and axis mappings were unchanged from the =
defaults so as not to introduce mapping discrepencies with older kernels wh=
ich used the generic HID driver.  Note that changing them at this point *wi=
ll* break a lot of software (SDL has had these mappings hardcoded into it=
=92s controller database header for years now).=0A=
=0A=
Ideally I would like to start following the spec (the current mapping is so=
 awful), but SDL is the issue. Its database can be updated as the table use=
s a guid composed of bus_type | vendor_id | product_id | version. I don't k=
now if it is allowed, but the version field could be utilized to negotiate =
a different button mapping... We wouldn't mind sending such patches.=0A=
=0A=
>>>=0A=
>>> Disabling the pointer emulation feature avoids the conflict. This=0A=
>>> issue was only exposed=0A=
>>> recently by adding of the input_mt_sync_frame call as recommended by Be=
njamin as=0A=
>>> part of some improvements we did for touchpad handling in hid-sony.=0A=
>>>=0A=
=0A=
> Is input_mt_sync_frame even necessary?  The original implementation follo=
wed the protocol for a =93Type B=94 device as defined in Documentation/inpu=
t/multi-touch-protocol.txt which doesn=92t require SYN_MT_REPORT messages.=
=0A=
=0A=
The call was added on recommendation from Benjamin Tissoires when we added =
support for touch history support. He said that if we didn't add this call =
the values would gt mangled by the kernel in evdev and data would get lost.=
 For us the history was important for gesture reasons. =0A=
