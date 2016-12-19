From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo LED
 control
Date: Mon, 19 Dec 2016 12:05:27 +0100
Message-ID: <8ae41990-73e2-39cf-8d8b-f8b83f0dd996@secunet.com>
References: <def3f975-9579-c2fe-9411-fb7522dd46a9@secunet.com>
 <alpine.LSU.2.20.1612191054270.19203@cbobk.fhfr.pm>
 <43171dc4-95e4-4a2b-eebc-0795988eb6f2@secunet.com>
 <alpine.LSU.2.20.1612191152320.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:49432 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756679AbcLSLIX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 06:08:23 -0500
In-Reply-To: <alpine.LSU.2.20.1612191152320.19203@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com

Hi Jiri,

On 19.12.2016 11:53, Jiri Kosina wrote:
> On Mon, 19 Dec 2016, Dennis Wassenberg wrote:
> 
>> "led_set_func_hid_lenovo" is set to "hid_lenovo_led_set"
>>
>> +#if IS_ENABLED(CONFIG_HID_LENOVO)
>> +static int hda_fixup_thinkpad_hid_prepare(struct hda_codec *codec)
>> +{
>> +	struct hda_gen_spec *spec = codec->spec;
>> +	int ret = 0;
>> +
>> +	if (!is_thinkpad(codec))
>> +		return -ENODEV;
>> +	if (!led_set_func_hid_lenovo)
>> +		led_set_func_hid_lenovo = symbol_request(hid_lenovo_led_set);
>>
>> "hid_lenovo_led_set" is introduced in "[PATCH v2 2/2] hda: 
>> thinkpad_helper: Add support for hid-lenovo LED control". This means 
>> that "[PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo LED 
>> control" can only work with applied "[PATCH 1/4] hid-lenovo: Add support 
>> for X1 Tablet cover special keys" and "[PATCH v2 2/2] hda: 
>> thinkpad_helper: Add support for hid-lenovo LED control".
> 
> Ah, okay, I wasn't aware of the other patchset. These two probably should 
> be merged together. Is the other 2-patch set merged in any tree already? 
> Where has it been submitted to?
> 
No 1/4, 2/4 and 3/4 are currently not merged to any tree. I reworked 1/4, 2/4 and 3/4 because of some comments from Benjamin Tissoires (mail from 14th September 2016).

The patches are submitted to all recipients at the To, CC-Line (e.g. linux-input mailing list).

Maybe I can merge 2/4 and 4/4 together. This is all for LED control. 1/4 is for key/input handling and 3/4 is a special FNLock handling where I should use a separate patch.

Currently I have no feedback regarding the reworked linux-input specific code. I hope I will get it soon :)

Best regards,

Dennis
