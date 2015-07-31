From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH 6/8] Input: xpad: use bitmask for finding the pad_nr
Date: Fri, 31 Jul 2015 14:46:12 +0200
Message-ID: <CA+b0ujdpVB0sCSf+mfT=g39NfPntj4=24wMoh6N2EkmzzncfXw@mail.gmail.com>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
 <1436572068-10661-7-git-send-email-rojtberg@gmail.com> <20150730065517.GB35939@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33538 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbGaMqd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 08:46:33 -0400
Received: by qged69 with SMTP id d69so44470833qge.0
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2015 05:46:32 -0700 (PDT)
In-Reply-To: <20150730065517.GB35939@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Greg KH <gregkh@linuxfoundation.org>

Hi Dimitry,

2015-07-30 8:55 GMT+02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Pavel,
>
> On Sat, Jul 11, 2015 at 01:47:46AM +0200, Pavel Rojtberg wrote:
>> From: Pavel Rojtberg <rojtberg@gmail.com>
>>
>> The pad_nr should be consistent after disconnecting/ reconnecting a
>> xbox360 controllers.
>> Use a bitmask to track connected pads - this way we can re-assign freed
>> up pad numbers.
>>
>> Consider the following case:
>> 1. pad A is connected and gets pad_nr = 0
>> 2. pad B is connected and gets pad_nr = 1
>> 3. pad A is disconnected
>> 4. pad A is connected again
>>
>> using the bitmask controller A now correctly gets pad_nr = 0 again.
>
> And what happens if I pull both out and plug B first? Why do we care
> about this? If we really want stable numbering maybe it should be driven
> from userspace based on connection path?
Note this is not about stable numbering, but really about ida style enumeration.
This is used only for determining which LED should be lit (range = [0..4[).
So plugging B first and having it pad_nr = 0 is actually the expected
result here.
(We do not know whether pad A will be connected at this point, so pad
B gets slot 0)

The original patch used the joypad id for enumeration:
http://www.spinics.net/lists/linux-input/msg29448.html
But the response was that this is a bad approach, this is why I came up
with the ida style enumeration.

Using userspace for enumeration was also already discussed here:
http://www.spinics.net/lists/linux-input/msg29539.html
the consensus was (and I am with it) that a daemon is overkill, just
to light some LEDs.

>> Note: this sets a limit of 32 simultaneous connected xbox360
>> controllers. However this should be tolerable.
>>
>> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
>> ---
>>  drivers/input/joystick/xpad.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>> index a9ff4c2..e28a9c1 100644
>> --- a/drivers/input/joystick/xpad.c
>> +++ b/drivers/input/joystick/xpad.c
>> @@ -346,6 +346,8 @@ struct usb_xpad {
>>       struct work_struct work;        /* init/remove device from callback */
>>  };
>>
>> +static unsigned long xpad_pad_seq;
>> +
>>  static int xpad_init_input(struct usb_xpad *xpad);
>>  static void xpad_deinit_input(struct usb_xpad *xpad);
>>
>> @@ -940,6 +942,12 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
>>   */
>>  static void xpad_identify_controller(struct usb_xpad *xpad)
>>  {
>> +     if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
>> +             return;
>> +
>> +     xpad->pad_nr = find_first_zero_bit(&xpad_pad_seq, 32);
>> +     set_bit(xpad->pad_nr, &xpad_pad_seq);
>> +
>
> This is racy. If we really want it you might consider idr/ida.
Thanks, this is what I actually needed here. Will change this for v2.

>
> Thanks.
>
> --
> Dmitry
