From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] Input: Elan HID-I2C device driver
Date: Thu, 12 Apr 2012 11:10:40 +0200
Message-ID: <CAN+gG=EQ-B8_brthJnrq0pw1HYGo15Q6unaEQAbu-e2x10z0XA@mail.gmail.com>
References: <1334061766-20577-1-git-send-email-tom_lin@emc.com.tw>
	<20120411071212.GB6894@core.coreip.homeip.net>
	<4F85583F.6050008@emc.com.tw>
	<20120411162519.GA27562@core.coreip.homeip.net>
	<4F8631C8.1090705@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49688 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab2DLJKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Apr 2012 05:10:41 -0400
In-Reply-To: <4F8631C8.1090705@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?Big5?B?qkyr26b2?= <tom_lin@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djkurtz@chromium.org, Jiri Kosina <jkosina@suse.cz>

Hi Tom,

I read Microsoft's things about HID over I2C few days ago. And from
what I understood, the report descriptors and the enumeration of the
devices are stored in the ACPI table and not in the device itself. Can
you confirm this?

I was thinking about making hid-multitouch independent from the usb
stack and was thinking about doing the i2c-hid bridge. However, I did
not start writing a line yet ;-)

Cheers,
Benjamin

On Thu, Apr 12, 2012 at 03:37, =AAL=AB=DB=A6=F6 <tom_lin@emc.com.tw> wr=
ote:
> Hi Dmitry
>
>
> On 04/12/2012 12:25 AM, Dmitry Torokhov wrote:
>>
>> On Wednesday, April 11, 2012 06:09:03 PM =AAL=AB=DB=A6=F6 wrote:
>>>
>>> Hi Daniel
>>>
>>> On 04/11/2012 03:12 PM, Dmitry Torokhov wrote:
>>>>
>>>> Hi Tom,
>>>>
>>>> On Tue, Apr 10, 2012 at 08:42:46PM +0800, Tom Lin wrote:
>>>>>
>>>>> This patch adds driver for Elan I2C touchpad. These protocol of H=
ID-I2C
>>>>> was
>>>>> defined by Microsoft. The kernel driver would use the multi-touch
>>>>> protocol
>>>>> format B.
>>>>
>>>>
>>>> If this device truly supports HID protocol shouldn't we define i2c=
-hid
>>>> transport, similar to usbhid?
>>>
>>>
>>> I merely follow defined by Microsoft.
>>> It was called "HID OVER I2C" by Microsoft.
>>>
>>> (http://msdn.microsoft.com/en-us/library/windows/hardware/hh825917(=
v=3Dvs.85).
>>> aspx) But I agree to change from hid i2c to i2chid.
>>> Do you have any better opinions?
>>
>>
>> I am not sure we are talking about same thing... I do not really car=
e
>> whether it is named "hid i2c" or "i2chid". What I meant if the devic=
e
>> really speaks HID protocol, except that the transport is not USB or
>> bluetooth but I2C, then instead of writing a custom driver for this
>> particular part we need to add a new HID transport into
>> drivers/hid/i2c-hid that is similar to drivers/hid/usbhid/ and reuse=
 the
>> rest of HID framework along with hid- multitouch.c which handles
>> HID-compliant multitouch devices.
>>
>> I am CCing Jiri (HID maintainer) for additional input.
>
> Sorry! I misunderstood what you mean.
> I fully agree with your suggestion. The I2CHID device will be more an=
d more
> in the future. Need the new i2chid-driver that would cover all hid-co=
mpliant
> i2c-devices.
> Thank you
>
> Tom-
>>
>>
>> Thanks.
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
