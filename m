From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [alsa-devel] [PATCH v2 2/2] hda: thinkpad_helper: Add support for
 hid-lenovo LED control
Date: Thu, 15 Sep 2016 09:54:52 +0200
Message-ID: <6b1192fb-ab9a-9042-4dc4-ab355ce67be3@secunet.com>
References: <433b6428-8ef3-fc7a-86ba-4cbcda7f12fd@secunet.com>
 <s5hoa3qt9gx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:32842 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759785AbcIOHzz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 03:55:55 -0400
In-Reply-To: <s5hoa3qt9gx.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org

Hi Takashi,


On 15.09.2016 00:14, Takashi Iwai wrote:
> On Wed, 14 Sep 2016 14:15:03 +0200,
> Dennis Wassenberg wrote:
>>
>> Make the thinkpad_helper able to support not only led control over
>> acpi with thinkpad_acpi driver but also led control over hid-lenovo.
>> The hid-lenovo driver adapted the led control api of thinkpad_acpi.
>> Make the thinkpad_acpi and hid-lenovo able to work combined to
>> support connected Lenovo USB keyboards at Lenovo Thinkpad devices.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
>> ---
>>
>> Changes v1 -> v2 (suggested by Takashi Iwai):
>>  * Adapt to not rename fixup_thinkpad_acpi to fixup_thinkpad
>>  * Made sure that it works even with one of kconfigs is disabled
>>
>>  sound/pci/hda/thinkpad_helper.c | 182 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 144 insertions(+), 38 deletions(-)
>>
>> diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
>> index f0955fd..0d98624 100644
>> --- a/sound/pci/hda/thinkpad_helper.c
>> +++ b/sound/pci/hda/thinkpad_helper.c
>> @@ -1,83 +1,188 @@
>>  /* Helper functions for Thinkpad LED control;
>>   * to be included from codec driver
>> + *
>> + * These helper functions include both LED control over thinkpad_acpi and
>> + * hid-lenovo
>>   */
>>  
>> -#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
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
> 
> This should be
> 	return is_thinkpad(codec) &&
> 
yes, ok.
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
>> +#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>> +	if (led_set_func_tpacpi)
>> +		led_set_func_tpacpi(TPACPI_LED_MUTE, !enabled);
>> +#endif
>> +#if IS_ENABLED(CONFIG_HID_LENOVO)
>> +	if (led_set_func_hid_lenovo)
>> +		led_set_func_hid_lenovo(HID_LENOVO_LED_MUTE, !enabled);
>> +#endif
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
>> +#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>> +		if (led_set_func_tpacpi)
>> +			led_set_func_tpacpi(TPACPI_LED_MICMUTE, !val);
>> +#endif
>> +#if IS_ENABLED(CONFIG_HID_LENOVO)
>> +		if (led_set_func_hid_lenovo)
>> +			led_set_func_hid_lenovo(HID_LENOVO_LED_MICMUTE, !val);
>> +#endif
>>  	}
>>  }
>>  
>> -static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
>> -				    const struct hda_fixup *fix, int action)
>> +#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>> +static int hda_fixup_thinkpad_acpi_prepare(struct hda_codec *codec)
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
> 
> Isn't old_vmaster_hook initialized twice when both interfaces are
> present...?
> 
> 
> thanks,
> 
> Takashi
> 
No, this is not possible because of fixup thinkpad_acpi is initialized at first and fixup hid-lenovo after that. fixup hid-lenovo has the additional check:

if (update_thinkpad_mute_led != spec->vmaster_mute.hook)
	old_vmaster_hook = spec->vmaster_mute.hook;

Which means if the thinkpad_acpi has already registered hid-lenovo will not register the old_vmaster_hook.

If there would be a double registration this would result in an infinite recursion loop because old_vmaster_hook is function update_thinkpad_mute_led and it will call itself the hole time.


I will prepare a v3 but unfortunately it will take some time (vacation, other work). I think it is not much to do here but a bit more regarding [PATCH v2 1/2]. This patch can not work without [PATCH v2 1/2] thats why I have to fix [PATCH v2 1/2] first.

Best regards,

Dennis
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
>> +static void hda_fixup_thinkpad_acpi_setup(struct hda_codec *codec, int action)
>> +{
>> +	int ret = 0;
>> +
>> +	if (action == HDA_FIXUP_ACT_PROBE) {
>> +		ret = hda_fixup_thinkpad_acpi_prepare(codec);
>> +	}
>> +
>> +	if (led_set_func_tpacpi &&
>> +		(action == HDA_FIXUP_ACT_FREE || ret)) {
>> +
>>  		symbol_put(tpacpi_led_set);
>> -		led_set_func = NULL;
>> +		led_set_func_tpacpi = NULL;
>> +		old_vmaster_hook = NULL;
>> +	}
>> +}
>> +#else
>> +static void hda_fixup_thinkpad_acpi_setup(struct hda_codec *codec, int action)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
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
>> +	if (!led_set_func_hid_lenovo) {
>> +		codec_warn(codec,
>> +			   "Failed to find hid-lenovo symbol hid_lenovo_led_set\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (update_thinkpad_mute_led != spec->vmaster_mute.hook)
>> +		old_vmaster_hook = spec->vmaster_mute.hook;
>> +
>> +	/* do not remove hook if setting delay does not work currently because
>> +	 * it is a usb hid devices which is not connected right now
>> +	 * maybe is will be connected later
>> +	 */
>> +	led_set_func_hid_lenovo(HID_LENOVO_LED_MUTE, false);
>> +	spec->vmaster_mute.hook = update_thinkpad_mute_led;
>> +
>> +	led_set_func_hid_lenovo(HID_LENOVO_LED_MICMUTE, false);
>> +	spec->cap_sync_hook = update_thinkpad_micmute_led;
>> +
>> +	return ret;
>> +}
>> +
>> +static void hda_fixup_thinkpad_hid_setup(struct hda_codec *codec, int action)
>> +{
>> +	int ret = 0;
>> +
>> +	if (action == HDA_FIXUP_ACT_PROBE) {
>> +		ret = hda_fixup_thinkpad_hid_prepare(codec);
>> +	}
>> +
>> +	if (led_set_func_hid_lenovo &&
>> +		(action == HDA_FIXUP_ACT_FREE || ret)) {
>> +
>> +		symbol_put(hid_lenovo_led_set);
>> +		led_set_func_hid_lenovo = NULL;
>>  		old_vmaster_hook = NULL;
>>  	}
>>  }
>> +#else
>> +static void hda_fixup_thinkpad_hid_setup(struct hda_codec *codec, int action)
>> +{
>> +}
>> +#endif
>> +
>> +/** this fixup is not for acpi case only, it will handle hid-lenovo as well */
>> +static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
>> +				    const struct hda_fixup *fix, int action)
>> +{
>> +	hda_fixup_thinkpad_acpi_setup(codec, action);
>> +	hda_fixup_thinkpad_hid_setup(codec, action);
>> +}
>>  
>>  #else /* CONFIG_THINKPAD_ACPI */
>>  
>> @@ -87,3 +192,4 @@ static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
>>  }
>>  
>>  #endif /* CONFIG_THINKPAD_ACPI */
>> +
>> -- 
>> 1.9.1
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>

