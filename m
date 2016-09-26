From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH 1/2] Revert "HID: dragonrise: fix HID Descriptor for 0x0006 PID"
Date: Mon, 26 Sep 2016 14:11:36 +0300
Message-ID: <87eg467w5z.fsf@ni.com>
References: <20160926025839.2790-1-adi@adirat.com> <20160926091054.GB19261@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160926091054.GB19261@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi

On Mon, 26 Sep 2016, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> Thanks for the patch series. I am not against it, but I'd rather see the
> commit message of this one amended, and the second patch changed.

Sorry if I came out too aggresive (I'll amend), I'm just annoyed that I
had to spend a weekend night digging through this crap because my fiancee
came crying to me that her gamepad stopped working after a kernel update.

>
> On Sep 26 2016 or thereabouts, Ioan-Adrian Ratiu wrote:
>> This reverts commit 18339f59c3a6 ("HID: dragonrise: fix HID...")
>> because the "fix" is bogus. That report descriptor is different in
>
> I am pretty sure this "fix" works for many. You seem to have a different
> hardware (generation probably) that makes the "fix" to fail for you.
> The issue is more that the manufacturer doesn't bother to reallocate a
> new PID for the new device when they change something in it, so please
> don't blame the author of the fix (which I am not).

We don't actually know that it's a new generation of hardware without a
new PID and I really doubt manufacturers are *that* stupid, they should
at least have increased the device revision number, but... China.

>
>> hardware (see below) and it's the way the hardware works, it can't be
>
> Well, it's kind of hard to compare the lsusb output to the fixup in the
> kernel. I'd like to know what changed, but I can't...
>
>> fixed at this level because it reuses axes by design.
>
> It can be fixed in hid-dr. See my comments on the next patch.

Thanks, I'll try to add an input mapping in the driver. However if
indeed there are different hardware with the same PID and this "fix" is
for another issue than the one I'm having then I'd really rather not
revert this if possible to not break other people's hardware. But I also
can't keep it because it breaks my hardware.

Does anyone have any suggestions what to do in this case?

>
>> 
>> What this change tried to fix is a regression caused by commit 20aef664f139
>
> As mentioned in your next patch in the series, the correct commit id is
> 79346d620e9de87912de73337f6df8b7f9a46888

Thanks, this was a slip-up on my part.

>
>> ("HID: input: force generic axis to be mapped to their user space axis") by
>> working around the problem and trying to change the report descriptor in
>> hid-dr, which obviously can't work and introduces more breakage because it
>> adds another unnecessary layer of multiplexing/indirection, making the
>> dragonrise gamepad practically unusable in userspace.
>
> Not sure who you are blaming here. Is it me (the author of 79346d620e or
> the author of the fix in hid-dr)? If it's me, I agree, the patch was a
> little too aggressive, though I must say only one hardware maker has
> such a crappy device that we need to care of. So this is why I just let
> the patch in place without trying to have a better solution.
>
> If the blame is on the author of the hid-dr, I must say that I find the
> tone of this paragraph quite aggressive for nothing. Your device is
> different than the one that was used for the original fix, so it breaks.
> But I can guarantee you that the fix works for the intended device (I
> happen to have one I tested recently). So please blame the hardware
> maker, not the people involved in the community who are doing their
> best.

I'm not assigning blame because it's counterproductive. Of course, I
agree if we are to find a scapegoat it's the crappy manufacturers
because they make the crappy hardware with crappy or no Linux support
(btw I am in no way affiliated with dragonrise or any other vendor).

The only thing that annoys me is that this known hid-input kernel
regression has been ignored for all this time, leaving users like me
dead in the watter with a broken driver upon kernel update.

>
>> 
>> This needs to be fixed where the regression was initially introduced in
>> hid-input (the next patch does this).
>
> Actually, again, I tend to disagree :)
> I'll go more in details in the next patch.
>
> Cheers,
> Benjamin
>
>> 
>> Here's the descriptor taken directly from the device via lsusb:
>>         HID Device Descriptor:
>>           bLength                 9
>>           bDescriptorType        33
>>           bcdHID               1.10
>>           bCountryCode           33 US
>>           bNumDescriptors         1
>>           bDescriptorType        34 Report
>>           wDescriptorLength     101
>>           Report Descriptor: (length is 101)
>>             Item(Global): Usage Page, data= [ 0x01 ] 1
>>                             Generic Desktop Controls
>>             Item(Local ): Usage, data= [ 0x04 ] 4
>>                             Joystick
>>             Item(Main  ): Collection, data= [ 0x01 ] 1
>>                             Application
>>             Item(Main  ): Collection, data= [ 0x02 ] 2
>>                             Logical
>>             Item(Global): Report Size, data= [ 0x08 ] 8
>>             Item(Global): Report Count, data= [ 0x05 ] 5
>>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>>             Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
>>             Item(Global): Physical Minimum, data= [ 0x00 ] 0
>>             Item(Global): Physical Maximum, data= [ 0xff 0x00 ] 255
>>             Item(Local ): Usage, data= [ 0x30 ] 48
>>                             Direction-X
>>             Item(Local ): Usage, data= [ 0x31 ] 49
>>                             Direction-Y
>>             Item(Local ): Usage, data= [ 0x32 ] 50
>>                             Direction-Z
>>             Item(Local ): Usage, data= [ 0x32 ] 50
>>                             Direction-Z
>>             Item(Local ): Usage, data= [ 0x35 ] 53
>>                             Rotate-Z
>>             Item(Main  ): Input, data= [ 0x02 ] 2
>>                             Data Variable Absolute No_Wrap Linear
>>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>>             Item(Global): Report Size, data= [ 0x04 ] 4
>>             Item(Global): Report Count, data= [ 0x01 ] 1
>>             Item(Global): Logical Maximum, data= [ 0x07 ] 7
>>             Item(Global): Physical Maximum, data= [ 0x3b 0x01 ] 315
>>             Item(Global): Unit, data= [ 0x14 ] 20
>>                             System: English Rotation, Unit: Degrees
>>             Item(Local ): Usage, data= [ 0x39 ] 57
>>                             Hat Switch
>>             Item(Main  ): Input, data= [ 0x42 ] 66
>>                             Data Variable Absolute No_Wrap Linear
>>                             Preferred_State Null_State Non_Volatile Bitfield
>>             Item(Global): Unit, data= [ 0x00 ] 0
>>                             System: None, Unit: (None)
>>             Item(Global): Report Size, data= [ 0x01 ] 1
>>             Item(Global): Report Count, data= [ 0x0c ] 12
>>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>>             Item(Global): Physical Maximum, data= [ 0x01 ] 1
>>             Item(Global): Usage Page, data= [ 0x09 ] 9
>>                             Buttons
>>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>>                             Button 1 (Primary)
>>             Item(Local ): Usage Maximum, data= [ 0x0c ] 12
>>                             (null)
>>             Item(Main  ): Input, data= [ 0x02 ] 2
>>                             Data Variable Absolute No_Wrap Linear
>>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>>             Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
>>                             (null)
>>             Item(Global): Report Size, data= [ 0x01 ] 1
>>             Item(Global): Report Count, data= [ 0x08 ] 8
>>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>>             Item(Global): Physical Maximum, data= [ 0x01 ] 1
>>             Item(Local ): Usage, data= [ 0x01 ] 1
>>                             (null)
>>             Item(Main  ): Input, data= [ 0x02 ] 2
>>                             Data Variable Absolute No_Wrap Linear
>>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>>             Item(Main  ): End Collection, data=none
>>             Item(Main  ): Collection, data= [ 0x02 ] 2
>>                             Logical
>>             Item(Global): Report Size, data= [ 0x08 ] 8
>>             Item(Global): Report Count, data= [ 0x07 ] 7
>>             Item(Global): Physical Maximum, data= [ 0xff 0x00 ] 255
>>             Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
>>             Item(Local ): Usage, data= [ 0x02 ] 2
>>                             (null)
>>             Item(Main  ): Output, data= [ 0x02 ] 2
>>                             Data Variable Absolute No_Wrap Linear
>>                             Preferred_State No_Null_Position Non_Volatile Bitfield
>>             Item(Main  ): End Collection, data=none
>>             Item(Main  ): End Collection, data=none
>> 
>> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
>> ---
>>  drivers/hid/hid-dr.c | 58 ----------------------------------------------------
>>  1 file changed, 58 deletions(-)
>> 
>> diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
>> index 8fd4bf7..2523f8a 100644
>> --- a/drivers/hid/hid-dr.c
>> +++ b/drivers/hid/hid-dr.c
>> @@ -234,58 +234,6 @@ static __u8 pid0011_rdesc_fixed[] = {
>>  	0xC0                /*  End Collection                  */
>>  };
>>  
>> -static __u8 pid0006_rdesc_fixed[] = {
>> -	0x05, 0x01,        /* Usage Page (Generic Desktop)	*/
>> -	0x09, 0x04,        /* Usage (Joystick)			*/
>> -	0xA1, 0x01,        /* Collection (Application)		*/
>> -	0xA1, 0x02,        /*   Collection (Logical)		*/
>> -	0x75, 0x08,        /*     Report Size (8)		*/
>> -	0x95, 0x05,        /*     Report Count (5)		*/
>> -	0x15, 0x00,        /*     Logical Minimum (0)		*/
>> -	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
>> -	0x35, 0x00,        /*     Physical Minimum (0)		*/
>> -	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
>> -	0x09, 0x30,        /*     Usage (X)			*/
>> -	0x09, 0x33,        /*     Usage (Ry)			*/
>> -	0x09, 0x32,        /*     Usage (Z)			*/
>> -	0x09, 0x31,        /*     Usage (Y)			*/
>> -	0x09, 0x34,        /*     Usage (Ry)			*/
>> -	0x81, 0x02,        /*     Input (Variable)		*/
>> -	0x75, 0x04,        /*     Report Size (4)		*/
>> -	0x95, 0x01,        /*     Report Count (1)		*/
>> -	0x25, 0x07,        /*     Logical Maximum (7)		*/
>> -	0x46, 0x3B, 0x01,  /*     Physical Maximum (315)	*/
>> -	0x65, 0x14,        /*     Unit (Centimeter)		*/
>> -	0x09, 0x39,        /*     Usage (Hat switch)		*/
>> -	0x81, 0x42,        /*     Input (Variable)		*/
>> -	0x65, 0x00,        /*     Unit (None)			*/
>> -	0x75, 0x01,        /*     Report Size (1)		*/
>> -	0x95, 0x0C,        /*     Report Count (12)		*/
>> -	0x25, 0x01,        /*     Logical Maximum (1)		*/
>> -	0x45, 0x01,        /*     Physical Maximum (1)		*/
>> -	0x05, 0x09,        /*     Usage Page (Button)		*/
>> -	0x19, 0x01,        /*     Usage Minimum (0x01)		*/
>> -	0x29, 0x0C,        /*     Usage Maximum (0x0C)		*/
>> -	0x81, 0x02,        /*     Input (Variable)		*/
>> -	0x06, 0x00, 0xFF,  /*     Usage Page (Vendor Defined)	*/
>> -	0x75, 0x01,        /*     Report Size (1)		*/
>> -	0x95, 0x08,        /*     Report Count (8)		*/
>> -	0x25, 0x01,        /*     Logical Maximum (1)		*/
>> -	0x45, 0x01,        /*     Physical Maximum (1)		*/
>> -	0x09, 0x01,        /*     Usage (0x01)			*/
>> -	0x81, 0x02,        /*     Input (Variable)		*/
>> -	0xC0,              /*   End Collection			*/
>> -	0xA1, 0x02,        /*   Collection (Logical)		*/
>> -	0x75, 0x08,        /*     Report Size (8)		*/
>> -	0x95, 0x07,        /*     Report Count (7)		*/
>> -	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
>> -	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
>> -	0x09, 0x02,        /*     Usage (0x02)			*/
>> -	0x91, 0x02,        /*     Output (Variable)		*/
>> -	0xC0,              /*   End Collection			*/
>> -	0xC0               /* End Collection			*/
>> -};
>> -
>>  static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>>  				unsigned int *rsize)
>>  {
>> @@ -296,12 +244,6 @@ static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>>  			*rsize = sizeof(pid0011_rdesc_fixed);
>>  		}
>>  		break;
>> -	case 0x0006:
>> -		if (*rsize == sizeof(pid0006_rdesc_fixed)) {
>> -			rdesc = pid0006_rdesc_fixed;
>> -			*rsize = sizeof(pid0006_rdesc_fixed);
>> -		}
>> -		break;
>>  	}
>>  	return rdesc;
>>  }
>> -- 
>> 2.10.0
>> 
