From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo
 LED control
Date: Mon, 19 Dec 2016 11:09:59 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191054270.19203@cbobk.fhfr.pm>
References: <def3f975-9579-c2fe-9411-fb7522dd46a9@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <def3f975-9579-c2fe-9411-fb7522dd46a9@secunet.com>
Sender: linux-sound-owner@vger.kernel.org
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com
List-Id: linux-input@vger.kernel.org

On Fri, 9 Dec 2016, Dennis Wassenberg wrote:

> +#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
> +	if (led_set_func_tpacpi)
> +		led_set_func_tpacpi(TPACPI_LED_MUTE, !enabled);
> +#endif
> +#if IS_ENABLED(CONFIG_HID_LENOVO)
> +	if (led_set_func_hid_lenovo)
> +		led_set_func_hid_lenovo(HID_LENOVO_LED_MUTE, !enabled);

Where does led_set_func_hid_lenovo() come from? I don't see it in Linus' 
tree as of today. Is that something else than tpacpi_led_set()?

Thanks,

-- 
Jiri Kosina
SUSE Labs

