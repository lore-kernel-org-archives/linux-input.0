From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH 2/7] Input: xpad: set the LEDs properly on XBox Wireless
 controllers
Date: Mon, 3 Feb 2014 14:35:14 -0800
Message-ID: <52F019A2.3090408@valvesoftware.com>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org> <1391173414-6199-3-git-send-email-gregkh@linuxfoundation.org> <CANq1E4QS9QVhXOAfogmWt0iQ54n7=HVvjkdE_6a=P2E+wcxD1g@mail.gmail.com> <20140203194859.GD3625@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx3.valvesoftware.com ([208.64.203.145]:45951 "EHLO
	mx3.valvesoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbaBCWhq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 17:37:46 -0500
Received: from mx3.valvesoftware.com (127.0.0.1) id hu0d3k0171se for <linux-input@vger.kernel.org>; Mon, 3 Feb 2014 14:35:19 -0800 (envelope-from <pgriffais@valvesoftware.com>)
In-Reply-To: <20140203194859.GD3625@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, HID CORE LAYER <linux-input@vger.kernel.org>

On 02/03/2014 11:48 AM, Greg Kroah-Hartman wrote:
> On Mon, Feb 03, 2014 at 06:31:29PM +0100, David Herrmann wrote:
>> Hi
>>
>> On Fri, Jan 31, 2014 at 2:03 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
>>>
>>> Add the logic to set the LEDs on XBox Wireless controllers.  Command
>>> sequence found by sniffing the Windows data stream when plugging the
>>> device in.
>>>
>>> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>   drivers/input/joystick/xpad.c | 32 +++++++++++++++++++++++++++-----
>>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>>> index 517829f6a58b..aabff9140aaa 100644
>>> --- a/drivers/input/joystick/xpad.c
>>> +++ b/drivers/input/joystick/xpad.c
>>> @@ -715,15 +715,37 @@ struct xpad_led {
>>>
>>>   static void xpad_send_led_command(struct usb_xpad *xpad, int command)
>>>   {
>>> -       if (command >= 0 && command < 14) {
>>> -               mutex_lock(&xpad->odata_mutex);
>>> +       if (command > 15)
>>> +               return;
>>
>> That's really weird. The "command" argument is used to control which
>> of the LEDs are enabled, but the underlying led_classdev passes the
>> brightness value here. Shouldn't we have one led_classdev device for
>> each LED and make "max_brightness"==1 so it's a boolean value?
>> I do that for wiimotes so you end up with 4 sysfs entries, one for each LED.
>
> That would make more sense, but would require a userspace daemon to be
> setting the LED values.  Is there such a thing out there?

I don't believe so, and it would be very nice if the driver could do 
that much by itself (ideally with less hackery than what I came up 
with!) without needing distros to package a daemon just to make sure the 
controllers light up to reflect the right slot.

>
> I agree the "write a value of 4 and it turns on led 4" does not match
> well with the "brightness" file description at all, I don't think that's
> good.

The interface to the HW is as follows (taken from the output of 'xboxdrv 
--help-led'):

    0: off
    1: all blinking
    2: 1/top-left blink, then on
    3: 2/top-right blink, then on
    4: 3/bottom-left blink, then on
    5: 4/bottom-right blink, then on
    6: 1/top-left on
    7: 2/top-right on
    8: 3/bottom-left on
    9: 4/bottom-right on
   10: rotate
   11: blink
   12: blink slower
   13: rotate with two lights
   14: blink
   15: blink once

Since this was all exposed as-is through 'brightness' before, should it 
just be left alone in case people already rely on this behavior?

>
>> Anyhow, you change "command < 14" to "command > 15" here, is this
>> intentional also for the XTYPE_XBOX360 path?
>
> I don't know, Pierre-Loup?

LED command 15 corresponds to 'blink once' for both variants AFAIK, 
which is why I changed that code originally. It definitely wasn't a 
critical part of the patch and what proposed below sounds reasonable 
instead.

Thanks,
  - Pierre-Loup

>
>>> +
>>> +       mutex_lock(&xpad->odata_mutex);
>>> +
>>> +       switch (xpad->xtype) {
>>> +       case XTYPE_XBOX360:
>>>                  xpad->odata[0] = 0x01;
>>>                  xpad->odata[1] = 0x03;
>>>                  xpad->odata[2] = command;
>>>                  xpad->irq_out->transfer_buffer_length = 3;
>>> -               usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>>> -               mutex_unlock(&xpad->odata_mutex);
>>> +               break;
>>> +       case XTYPE_XBOX360W:
>>> +               xpad->odata[0] = 0x00;
>>> +               xpad->odata[1] = 0x00;
>>> +               xpad->odata[2] = 0x08;
>>> +               xpad->odata[3] = 0x40 + (command % 0x0e);
>>
>> This basically makes /sys/..../led/brightness a "circular" value here.
>> Seems weird, but acceptable. But if you bail-out early above with
>> "command > 15", this here is equivalent to "command & 0x0e", right?
>>
>> How about removing the "if (command > 15)" above and make both paths
>> use "(command % 0x0e)"? Anyhow, besides changing the XTYPE_XBOX360
>> path, patch looks good.
>
> That sounds good, will do.
>
> Many thanks for the review,
>
> greg k-h
>

