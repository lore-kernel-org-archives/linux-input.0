From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo
 LED control
Date: Mon, 19 Dec 2016 11:53:11 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191152320.19203@cbobk.fhfr.pm>
References: <def3f975-9579-c2fe-9411-fb7522dd46a9@secunet.com> <alpine.LSU.2.20.1612191054270.19203@cbobk.fhfr.pm> <43171dc4-95e4-4a2b-eebc-0795988eb6f2@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49607 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754995AbcLSKxP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:53:15 -0500
In-Reply-To: <43171dc4-95e4-4a2b-eebc-0795988eb6f2@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com

On Mon, 19 Dec 2016, Dennis Wassenberg wrote:

> "led_set_func_hid_lenovo" is set to "hid_lenovo_led_set"
> 
> +#if IS_ENABLED(CONFIG_HID_LENOVO)
> +static int hda_fixup_thinkpad_hid_prepare(struct hda_codec *codec)
> +{
> +	struct hda_gen_spec *spec = codec->spec;
> +	int ret = 0;
> +
> +	if (!is_thinkpad(codec))
> +		return -ENODEV;
> +	if (!led_set_func_hid_lenovo)
> +		led_set_func_hid_lenovo = symbol_request(hid_lenovo_led_set);
> 
> "hid_lenovo_led_set" is introduced in "[PATCH v2 2/2] hda: 
> thinkpad_helper: Add support for hid-lenovo LED control". This means 
> that "[PATCH 4/4] hda: thinkpad_helper: Add support for hid-lenovo LED 
> control" can only work with applied "[PATCH 1/4] hid-lenovo: Add support 
> for X1 Tablet cover special keys" and "[PATCH v2 2/2] hda: 
> thinkpad_helper: Add support for hid-lenovo LED control".

Ah, okay, I wasn't aware of the other patchset. These two probably should 
be merged together. Is the other 2-patch set merged in any tree already? 
Where has it been submitted to?

-- 
Jiri Kosina
SUSE Labs

