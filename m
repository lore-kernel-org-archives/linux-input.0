From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH 2/4] hid-lenovo: Add support for X1 Tablet cover LED
 control
Date: Mon, 19 Dec 2016 11:43:53 +0100
Message-ID: <80c99979-0caa-bbd2-d750-96d546618e58@secunet.com>
References: <ef83e1ec-48d5-a011-c95e-8dba060bc8c3@secunet.com>
 <alpine.LSU.2.20.1612191052020.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:48282 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753656AbcLSKqn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:46:43 -0500
In-Reply-To: <alpine.LSU.2.20.1612191052020.19203@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com

Hi Jiri,

Thanks for your comments. I added comments in-lined.

Best regards,

Dennis

On 19.12.2016 10:54, Jiri Kosina wrote:
> Hi Dennis,
> 
> thanks a lot for the patch.
> 
> On Fri, 9 Dec 2016, Dennis Wassenberg wrote:
> 
>> +int hid_lenovo_led_set(enum hid_lenovo_led_type led, bool on)
>> +{
>> +	struct led_classdev *dev = NULL;
>> +	struct lenovo_led_list_entry *entry;
>> +
>> +	if (led >= HID_LENOVO_LED_MAX)
>> +		return -EINVAL;
>> +
>> +	hid_lenovo_initial_leds[led] = on ? LED_FULL : LED_OFF;
>> +
>> +	list_for_each_entry(entry, &hid_lenovo_leds, list) {
>> +		if (entry->type == led) {
>> +			dev = entry->dev;
>> +			break;
>> +		}
>> +	}
> 
> How exactly is this synchronized against lenovo_remove_tpx1cover()?
> 
In case of that the tpx1cover is disconnected it will be removed from hid_lenovo_leds list. That means not included at the hid_lenovo_leds list. In this case dev is still NULL and the function will return -ENODEV. The static array hid_lenovo_initial_leds is still set to store the current state of a LED type. This is used to set the LED appropriately if the tpx1cover is replugged.

Maybe I should add a mutex to protect the hid_lenovo_leds list operations in hid-lenovo.c to fix the case if a unplug occurred concurrently to setting an led?!

>> +
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	if (!dev->brightness_set)
>> +		return -ENODEV;
>> +
>> +	dev->brightness_set(dev, on ? LED_FULL : LED_OFF);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(hid_lenovo_led_set);
> 
> Does this really need to be exported to the whole universe? (I guess this 
> will be further discussed in 4/4).

No, it is sufficient if thinkpad-helper can access it.
> 
