From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: add Asus macrokey support for Asus "Republic of
 Gamers" laptop
Date: Wed, 14 Dec 2016 11:20:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612141119430.16984@cbobk.fhfr.pm>
References: <1481546578-40703-1-git-send-email-chiu@endlessm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932203AbcLNKdy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Dec 2016 05:33:54 -0500
In-Reply-To: <1481546578-40703-1-git-send-email-chiu@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux@endlessm.com

On Mon, 12 Dec 2016, Chris Chiu wrote:

[ ... snip ... ]
> +static const struct hid_device_id asus_rog_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY1) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY2) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, asus_rog_devices);

[ ... snip ... ]

In addition to what Benjamin said already, you also seem to be missing 
hid_have_special_driver[] entry for these VID/PIDs

Thanks,

-- 
Jiri Kosina
SUSE Labs

