From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH 2/4] HID: add device id for Lenovo X1 Tablet Cover
Date: Wed, 14 Sep 2016 08:33:05 +0200
Message-ID: <6b207d9c-9059-bbd1-5726-ded6b13bfafd@secunet.com>
References: <f04a30b2-5128-fb60-a653-329a61d86366@secunet.com>
 <20160912155335.GE25951@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:38302 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbcINGeK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 02:34:10 -0400
In-Reply-To: <20160912155335.GE25951@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de, lukas@wunner.de, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, david.henningsson@canonical.com, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org

Hi Benjamin,

ok, I will do so.

I will prepare a v2 of "[PATCH 3/4] hid-lenovo: Add support for X1
Tablet special keys and, LED control" which is affected by this change.

Thank you & best regards,

Dennis
On 12.09.2016 17:53, Benjamin Tissoires wrote:
> On Sep 12 2016 or thereabouts, Dennis Wassenberg wrote:
>> Add device id for Lenovo X1 Tablet Cover
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
>> ---
> 
> quick comment:
> 
> this patch should be squashed with the next one where you add support of
> this device to the hid-lenovo module.
> 
> Cheers,
> Benjamin
> 
>>  drivers/hid/hid-core.c | 1 +
>>  drivers/hid/hid-ids.h  | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 6add0b6..ba6a200 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2111,6 +2111,7 @@ void hid_disconnect(struct hid_device *hdev)
>>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
>>  	{ }
>>  };
>>  
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 3466f0d..1f08fb5 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -615,6 +615,7 @@
>>  #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
>>  #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
>>  #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
>> +#define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
>>  
>>  #define USB_VENDOR_ID_LG		0x1fd2
>>  #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
>> -- 
>> 1.9.1
