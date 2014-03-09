From: Harald Albrecht <harald.albrecht@gmx.net>
Subject: Re: drivers/input/input.c and a broken USB HID Contour ShuttlePRO
 v2
Date: Sun, 09 Mar 2014 18:31:52 +0100
Message-ID: <531CA588.7030408@gmx.net>
References: <531C8EF4.9090609@gmx.net> <20140309171907.GC30196@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:60779 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbaCIRdI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Mar 2014 13:33:08 -0400
In-Reply-To: <20140309171907.GC30196@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

It seems that I will need help from both mailing lists. I've researched 
more and would like to propose this idea ... and I need feedback from 
the input and usb kernel maintainers in order to get my idea right.

So for the input part I would like to propose to introduce a new input 
property INPUT_PROP_REL_IS_ABS with value 0x04 (this would be the next 
available "propbit" in input land (include/linux/input.h).

#define INPUT_PROP_REL_IS_ABS 0x04 /* relative events report absolute 
coordinates */

When handling EV_REL events in drivers/input/input.c we then could check 
for the propbit being set and then always pass events from such devices 
to the handlers. This would allow us to selectively enable this fix for 
broken devices only.

    static int input_get_disposition(struct input_dev *dev, unsigned int
    type, unsigned int code, int value)

    {
    ...
    if (is_event_supported(code, dev->relbit, REL_MAX) &&
         (value || test_bit(INPUT_PROP_REL_IS_ABS, dev->propbit))
       disposition = INPUT_PASS_TO_HANDLERS;


As for the USB part I'm currently lost. My idea is to have a contour USB 
device module that gets registered as a HID (sub?) driver so the generic 
HID can do all the normal handling. The part I don't know yet is how to 
switch on the propbit I mentioned in the previous paragraph. Can this be 
done in the input_mapped function of such an HID subdriver? Do I need to 
chain my own input_mapped to the generic one? I have to admit that I'm 
lost at this time, as this is my first journey into Linux driver land 
and Linux USB HID territory... So in my simple mind I would think of 
something like...

    static int contour_input_mapped(struct hid_device *hdev, struct
    hid_input *hi,
       struct hid_field *field, struct hid_usage *usage, unsigned long
    **bit,
       int *max)
    {
       __set_bit(INPUT_PROP_REL_IS_ABS, hi->input->propbit);
       return 0;
    }

    static const struct hid_device_id contour_devices[] = {
       { HID_USB_DEVICE(0x0b33, 0x0030) }
       { }
    };

    static struct hid_driver contour_driver = {
       .name = "contour",
       .id_table = contour_devices,
       .input_mapped = contour_input_mapped,
    };

    module_hid_driver(contour_driver);


    MODULE_DESCRIPTION("Driver for Contour ShuttlePRO v2");

    MODULE_LICENSE("GPL");



So, please bear with me and help is greatly appreciated!
-- TheDiveO


On 09.03.2014 18:19, Greg KH wrote:
> On Sun, Mar 09, 2014 at 04:55:32PM +0100, Harald Albrecht wrote:
>> I would like to improve support for the multimedia controllers from
>> Contour company, as there currently get relative events swalled by input.c.
>>
>> The background: Contour seems to have messed up the USB HID descriptions
>> of their multimedia controller devices in that these report to use
>> relative axis when in fact they are creating EV_REL events with absolute
>> coordinate values. The problem here is, that mapping these events to
>> EV_ABS will break all existing software that supports these devices.
>>
>> Unfortunately, drivers/input/input.c correctly swallows any relative
>> events with a relative movement value of zero...
>>
>>      case EV_REL:
>>         if (is_event_supported(code, dev->relbit, REL_MAX) && value)
>>           disposition = INPUT_PASS_TO_HANDLERS;
>>         break;
>>
>> Simply removing the "&& value" would most probably have adverse effect
>> on many software. Unfortunately, there is yet no "quirks" handling
>> present in input.c.
>>
>> How can I add such quirks handling in a way that would be acceptable by
>> the kernel maintainers?
> The people on linux-input@vger.kernel.org (now cc:ed) might know more...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

