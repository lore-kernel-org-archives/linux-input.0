From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] hid: ignore all recent SoundGraph iMON devices
Date: Sat, 08 Aug 2009 12:49:49 +0300
Message-ID: <4A7D4A3D.50102@gmail.com>
References: <200907311056.36729.jarod@redhat.com> <alpine.LNX.2.00.0908080221190.25797@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:33209 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933934AbZHHJuJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 8 Aug 2009 05:50:09 -0400
In-Reply-To: <alpine.LNX.2.00.0908080221190.25797@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jarod Wilson <jarod@redhat.com>, linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Fri, 31 Jul 2009, Jarod Wilson wrote:
> 
>> After some inspection of the Windows iMON driver, several additional
>> device IDs were added to the lirc_imon driver. At least a few of these
>> have been seen in the wild, and require manual quirking to keep the
>> usbhid driver from binding to them. Rather than list out every single
>> device, ignore the entire device ID range, 0x0034 - 0x0046. Some of
>> these may not advertise themselves as HID devices, but no harm done to
>> such devices anyway. Does the right thing in brief testing w/my 0x0045
>> device.
>>
>> Signed-off-by: Jarod Wilson <jarod@redhat.com>
>>
>> ---
>>  drivers/hid/hid-core.c |   10 +++++-----
>>  drivers/hid/hid-ids.h  |    7 ++-----
>>  2 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 5eb10c2..18bf803 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1623,11 +1623,6 @@ static const struct hid_device_id hid_ignore_list[] = {
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0003) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0004) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD2) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD4) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD5) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY1) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY2) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO) },
>> @@ -1694,6 +1689,11 @@ static bool hid_ignore(struct hid_device *hdev)
>>  				hdev->product <= USB_DEVICE_ID_LOGITECH_HARMONY_LAST)
>>  			return true;
>>  		break;
>> +	case USB_VENDOR_ID_SOUNDGRAPH:
>> +		if (hdev->product >= USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST &&
>> +		    hdev->product <= USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST)
>> +			return true;
>> +		break;
>>  	}
>>  
>>  	if (hdev->type == HID_TYPE_USBMOUSE &&
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 6301010..989a3ba 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -376,11 +376,8 @@
>>  #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
>>  
>>  #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
>> -#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD	0x0038
>> -#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD2	0x0036
>> -#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3	0x0034
>> -#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD4	0x0044
>> -#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD5	0x0045
>> +#define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034
>> +#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST	0x0046
>>  
>>  #define USB_VENDOR_ID_SUN		0x0430
>>  #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
> 
> [ sorry for late reply, have been away for quite some time ]
> 
> So after reading the thread, I understand that Anssi will rather submit 
> his changes through lirc project, and has therefore no objections to 
> applying Jarod's patch, right?

Yes.

-- 
Anssi Hannula
