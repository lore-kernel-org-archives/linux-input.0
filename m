From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: Re: [PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo LED
 control
Date: Mon, 19 Dec 2016 11:44:18 +0100
Message-ID: <43171dc4-95e4-4a2b-eebc-0795988eb6f2@secunet.com>
References: <def3f975-9579-c2fe-9411-fb7522dd46a9@secunet.com>
 <alpine.LSU.2.20.1612191054270.19203@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.20.1612191054270.19203@cbobk.fhfr.pm>
Sender: linux-sound-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com
List-Id: linux-input@vger.kernel.org

Hi Jiri,

"led_set_func_hid_lenovo" is set to "hid_lenovo_led_set"

+#if IS_ENABLED(CONFIG_HID_LENOVO)
+static int hda_fixup_thinkpad_hid_prepare(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int ret = 0;
+
+	if (!is_thinkpad(codec))
+		return -ENODEV;
+	if (!led_set_func_hid_lenovo)
+		led_set_func_hid_lenovo = symbol_request(hid_lenovo_led_set);

"hid_lenovo_led_set" is introduced in "[PATCH v2 2/2] hda: thinkpad_helper: Add support for hid-lenovo LED control". This means that "[PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo LED control" can only work with applied "[PATCH 1/4] hid-lenovo: Add support for X1 Tablet cover special keys" and "[PATCH v2 2/2] hda: thinkpad_helper: Add support for hid-lenovo LED control".

Best regards,

Dennis
On 19.12.2016 11:09, Jiri Kosina wrote:
> On Fri, 9 Dec 2016, Dennis Wassenberg wrote:
> 
>> +#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>> +	if (led_set_func_tpacpi)
>> +		led_set_func_tpacpi(TPACPI_LED_MUTE, !enabled);
>> +#endif
>> +#if IS_ENABLED(CONFIG_HID_LENOVO)
>> +	if (led_set_func_hid_lenovo)
>> +		led_set_func_hid_lenovo(HID_LENOVO_LED_MUTE, !enabled);
> 
> Where does led_set_func_hid_lenovo() come from? I don't see it in Linus' 
> tree as of today. Is that something else than tpacpi_led_set()?
> 
> Thanks,
> 
