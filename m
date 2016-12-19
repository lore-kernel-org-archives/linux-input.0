From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/4] hid-lenovo: Add support for X1 Tablet cover LED
 control
Date: Mon, 19 Dec 2016 10:54:05 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191052020.19203@cbobk.fhfr.pm>
References: <ef83e1ec-48d5-a011-c95e-8dba060bc8c3@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758584AbcLSJyI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 04:54:08 -0500
In-Reply-To: <ef83e1ec-48d5-a011-c95e-8dba060bc8c3@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com

Hi Dennis,

thanks a lot for the patch.

On Fri, 9 Dec 2016, Dennis Wassenberg wrote:

> +int hid_lenovo_led_set(enum hid_lenovo_led_type led, bool on)
> +{
> +	struct led_classdev *dev = NULL;
> +	struct lenovo_led_list_entry *entry;
> +
> +	if (led >= HID_LENOVO_LED_MAX)
> +		return -EINVAL;
> +
> +	hid_lenovo_initial_leds[led] = on ? LED_FULL : LED_OFF;
> +
> +	list_for_each_entry(entry, &hid_lenovo_leds, list) {
> +		if (entry->type == led) {
> +			dev = entry->dev;
> +			break;
> +		}
> +	}

How exactly is this synchronized against lenovo_remove_tpx1cover()?

> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (!dev->brightness_set)
> +		return -ENODEV;
> +
> +	dev->brightness_set(dev, on ? LED_FULL : LED_OFF);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hid_lenovo_led_set);

Does this really need to be exported to the whole universe? (I guess this 
will be further discussed in 4/4).

-- 
Jiri Kosina
SUSE Labs

