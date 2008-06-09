From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: Add newer Apple keyboards to hid quirks table
Date: Mon, 9 Jun 2008 13:44:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806091342420.10085@jikos.suse.cz>
References: <20080607024631.GA24254@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:35068 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758652AbYFILoF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jun 2008 07:44:05 -0400
In-Reply-To: <20080607024631.GA24254@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Alexandre Karpenko <alexander@comm.utoronto.ca>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 7 Jun 2008, Matthew Garrett wrote:

> The keyboards in recent Apple hardware are still not properly supported 
> by Linux due to them not being in the hid quirks table. This patch adds 
> the current hardware. Device IDs come from the Mactel Linux project.

Hi Matthew,

the patch adding these product IDs is already queued in my 
'upstream-fixes' branch.

However ...

> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_JIS, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },

Alexandre's original patch is missing the 
HID_QUIRK_APPLE_NUMLOCK_EMULATION quirk ... Alexandre, was this 
intentional?

Thanks,

-- 
Jiri Kosina
SUSE Labs
