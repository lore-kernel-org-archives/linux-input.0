From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo LED
 control
Date: Wed, 14 Sep 2016 08:22:45 +0200
Message-ID: <6d21581c-cbc6-f148-77fd-2b468335f481@secunet.com>
References: <91729b41-7537-b506-6980-94b9938c8305@secunet.com>
 <s5hsht5i98s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:38003 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbcINGXy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 02:23:54 -0400
In-Reply-To: <s5hsht5i98s.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, david.henningsson@canonical.com, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org

Hi Takashi,

at my first shot published to github I had an approach which makes thinkpad_acpi and hid-lenovo mutual exclusive (https://github.com/dwassenberg/linux/tree/development/hid-rmi). This approach has some issues. For example in case of thinkpad_acpi and hid-lenovo module is loaded (e.g. at Lenovo ThinkPad X1 Tablet) the symbol request to tpacpi_led_set is successful so the thinkpad_helper will decide in favor of thinkpad_acpi. So I need to add something which checks the return code of tpacpi_led_set. If -ENODEV is returned it can try hid-lenovo.

But the reason why I made thinkpad_acpi and hid-lenovo work in parallel was that if it is mutual exclusive there is no possibility to control LEDs of external Lenovo USB keyboards which are connected to a Thinkpad. Currently (including the other patches) there is only the X1 Tablet Cover LEDs which is controllable from external code. But the hid-lenovo driver is able to handle different Lenovo USB Keyboards.

- ThinkPad USB Keyboard with TrackPoint (tpkbd)
- ThinkPad Compact Bluetooth Keyboard with TrackPoint (cptkbd)
- ThinkPad Compact USB Keyboard with TrackPoint (cptkbd)
- ThinkPad X1 Cover USB Keyboard with TrackPoint and Touchpad (tpx1cover)

These keyboards have these LEDs too. For some of these keyboards a LED control is implemented inside hid-lenovo too. If thinkpad_acpi and hid-lenovo is mutual exclusive it is impossible to let the thinkpad_helper control the LEDs of these external USB keyboards if they are connected to a thinkpad. I don't know if anyone will do this, but I don't want to take the possibility to do such thinks :)

So.. if there is the decision (from your side) that this should be mutual exclusive I will prepare a v2 which the mutual exclusive approach I described at the top.

Thank you & best regards,

Dennis

On 12.09.2016 14:38, Takashi Iwai wrote:
> On Mon, 12 Sep 2016 12:47:03 +0200,
> Dennis Wassenberg wrote:
>>
>> Make the thinkpad_helper able to support not only led control over
>> acpi with thinkpad_acpi driver but also led control over hid-lenovo.
>> The hid-lenovo driver adapted the led control api of thinkpad_acpi.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
>> ---
>>  sound/pci/hda/thinkpad_helper.c | 149 ++++++++++++++++++++++++++++++----------
>>  1 file changed, 111 insertions(+), 38 deletions(-)
>>
>> diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
>> index 62741a7..c24a4a9 100644
>> --- a/sound/pci/hda/thinkpad_helper.c
>> +++ b/sound/pci/hda/thinkpad_helper.c
>> @@ -2,79 +2,152 @@
>>   * to be included from codec driver
>>   */
>>  
>> -#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>> -
>> +#if IS_ENABLED(CONFIG_THINKPAD_ACPI) || IS_ENABLED(CONFIG_HID_LENOVO)
>>  #include <linux/acpi.h>
>> +#include <linux/hid-lenovo.h>
>>  #include <linux/thinkpad_acpi.h>
>>  
>> -static int (*led_set_func)(int, bool);
>> +static int (*led_set_func_tpacpi)(int, bool);
>> +static int (*led_set_func_hid_lenovo)(int, bool);
>>  static void (*old_vmaster_hook)(void *, int);
>>  
>>  static bool is_thinkpad(struct hda_codec *codec)
>>  {
>> +	return (codec->core.subsystem_id >> 16 == 0x17aa);
>> +}
>> +
>> +static bool is_thinkpad_acpi(struct hda_codec *codec)
>> +{
>>  	return (codec->core.subsystem_id >> 16 == 0x17aa) &&
>>  	       (acpi_dev_found("LEN0068") || acpi_dev_found("IBM0068"));
>>  }
>>  
>> -static void update_tpacpi_mute_led(void *private_data, int enabled)
>> +static void update_thinkpad_mute_led(void *private_data, int enabled)
>>  {
>>  	if (old_vmaster_hook)
>>  		old_vmaster_hook(private_data, enabled);
>>  
>> -	if (led_set_func)
>> -		led_set_func(TPACPI_LED_MUTE, !enabled);
>> +	if (led_set_func_tpacpi)
>> +		led_set_func_tpacpi(TPACPI_LED_MUTE, !enabled);
>> +
>> +	if (led_set_func_hid_lenovo)
>> +		led_set_func_hid_lenovo(HID_LENOVO_LED_MUTE, !enabled);
>>  }
>>  
>> -static void update_tpacpi_micmute_led(struct hda_codec *codec,
>> +
>> +
>> +static void update_thinkpad_micmute_led(struct hda_codec *codec,
>>  				      struct snd_kcontrol *kcontrol,
>>  				      struct snd_ctl_elem_value *ucontrol)
>>  {
>> -	if (!ucontrol || !led_set_func)
>> +	if (!ucontrol)
>>  		return;
>>  	if (strcmp("Capture Switch", ucontrol->id.name) == 0 && ucontrol->id.index == 0) {
>>  		/* TODO: How do I verify if it's a mono or stereo here? */
>>  		bool val = ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1];
>> -		led_set_func(TPACPI_LED_MICMUTE, !val);
>> +		if (led_set_func_tpacpi)
>> +			led_set_func_tpacpi(TPACPI_LED_MICMUTE, !val);
>> +		if (led_set_func_hid_lenovo)
>> +			led_set_func_hid_lenovo(HID_LENOVO_LED_MICMUTE, !val);
>>  	}
>>  }
>>  
>> -static void hda_fixup_thinkpad(struct hda_codec *codec,
>> -				    const struct hda_fixup *fix, int action)
>> +static int hda_fixup_thinkpad_acpi(struct hda_codec *codec)
>>  {
>>  	struct hda_gen_spec *spec = codec->spec;
>> -	bool removefunc = false;
>> +	int ret = -ENXIO;
>>  
>> -	if (action == HDA_FIXUP_ACT_PROBE) {
>> -		if (!is_thinkpad(codec))
>> -			return;
>> -		if (!led_set_func)
>> -			led_set_func = symbol_request(tpacpi_led_set);
>> -		if (!led_set_func) {
>> -			codec_warn(codec,
>> -				   "Failed to find thinkpad-acpi symbol tpacpi_led_set\n");
>> -			return;
>> -		}
>> +	if (!is_thinkpad(codec))
>> +		return -ENODEV;
>> +	if (!is_thinkpad_acpi(codec))
>> +		return -ENODEV;
>> +	if (!led_set_func_tpacpi)
>> +		led_set_func_tpacpi = symbol_request(tpacpi_led_set);
> 
> This would be performed even if CONFIG_THINKPAD_ACPI=n when
> CONFIG_HID_LENOVO!=n.  You'd need to have a proper ifdef surrounding
> the function.
> 
> 
>> +	if (!led_set_func_tpacpi) {
>> +		codec_warn(codec,
>> +			   "Failed to find thinkpad-acpi symbol tpacpi_led_set\n");
>> +		return -ENOENT;
>> +	}
>>  
>> -		removefunc = true;
>> -		if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
>> -			old_vmaster_hook = spec->vmaster_mute.hook;
>> -			spec->vmaster_mute.hook = update_tpacpi_mute_led;
>> -			removefunc = false;
>> -		}
>> -		if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) {
>> -			if (spec->num_adc_nids > 1)
>> -				codec_dbg(codec,
>> -					  "Skipping micmute LED control due to several ADCs");
>> -			else {
>> -				spec->cap_sync_hook = update_tpacpi_micmute_led;
>> -				removefunc = false;
>> -			}
>> +	if (led_set_func_tpacpi(TPACPI_LED_MUTE, false) >= 0) {
>> +		old_vmaster_hook = spec->vmaster_mute.hook;
>> +		spec->vmaster_mute.hook = update_thinkpad_mute_led;
>> +		ret = 0;
>> +	}
>> +
>> +	if (led_set_func_tpacpi(TPACPI_LED_MICMUTE, false) >= 0) {
>> +		if (spec->num_adc_nids > 1)
>> +			codec_dbg(codec,
>> +				  "Skipping micmute LED control due to several ADCs");
>> +		else {
>> +			spec->cap_sync_hook = update_thinkpad_micmute_led;
>> +			ret = 0;
>>  		}
>>  	}
>>  
>> -	if (led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
>> +	return ret;
>> +}
>> +
>> +static int hda_fixup_thinkpad_hid(struct hda_codec *codec)
>> +{
>> +	struct hda_gen_spec *spec = codec->spec;
>> +	int ret = 0;
>> +
>> +	if (!is_thinkpad(codec))
>> +		return -ENODEV;
>> +	if (!led_set_func_hid_lenovo)
>> +		led_set_func_hid_lenovo = symbol_request(hid_lenovo_led_set);
>> +	if (!led_set_func_hid_lenovo) {
>> +		codec_warn(codec,
>> +			   "Failed to find hid-lenovo symbol hid_lenovo_led_set\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (update_thinkpad_mute_led != spec->vmaster_mute.hook)
>> +		old_vmaster_hook = spec->vmaster_mute.hook;
>> +
>> +	// do not remove hook if setting delay does not work currently because
>> +	// it is a usb hid devices which is not connected right now
>> +	// maybe is will be connected later
> 
> The comment should be C style.  Try checkpatch.pl once before the
> patch submission.
> 
> 
>> +	led_set_func_hid_lenovo(HID_LENOVO_LED_MUTE, false);
>> +	spec->vmaster_mute.hook = update_thinkpad_mute_led;
>> +
>> +	led_set_func_hid_lenovo(HID_LENOVO_LED_MICMUTE, false);
>> +	spec->cap_sync_hook = update_thinkpad_micmute_led;
>> +
>> +	return ret;
>> +}
>> +
>> +static void hda_fixup_thinkpad(struct hda_codec *codec,
>> +				    const struct hda_fixup *fix, int action)
>> +{
>> +	int ret_fixup_acpi = 0;
>> +	int ret_fixup_hid = 0;
>> +	bool remove = 0;
>> +
>> +	if (action == HDA_FIXUP_ACT_PROBE) {
>> +		ret_fixup_acpi = hda_fixup_thinkpad_acpi(codec);
>> +		ret_fixup_hid = hda_fixup_thinkpad_hid(codec);
> 
> Basically these two are exclusive.  So you don't have to process the
> latter when the former succeeds.  But...
> 
>> +	}
>> +
>> +	if (led_set_func_tpacpi &&
>> +		(action == HDA_FIXUP_ACT_FREE || ret_fixup_acpi)) {
>> +
>>  		symbol_put(tpacpi_led_set);
>> -		led_set_func = NULL;
>> +		remove = true;
>> +	}
>> +
>> +	if (led_set_func_hid_lenovo &&
>> +		(action == HDA_FIXUP_ACT_FREE || ret_fixup_hid)) {
>> +
>> +		symbol_put(hid_lenovo_led_set);
>> +		remove = true;
>> +	}
>> +
>> +
>> +	if (remove) {
>> +		led_set_func_tpacpi = NULL;
>> +		led_set_func_hid_lenovo = NULL;
>>  		old_vmaster_hook = NULL;
>>  	}
>>  }
> 
> ... reading through the patch, I find the code is a bit too
> redundant.  The access is exclusive between ACPI and HID, and the hook
> functions are in the same form but just the argument value is
> different (TPACPI_LED_MUTE vs HID_LENOVO_LED_MUTE).  So we may need
> only a single function pointer and pass the different value depending
> on the model instead of keeping two individual function pointers.
> 
> 
> thanks,
> 
> Takashi
> 
