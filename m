From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2.6.34-rc5 v2] HID: Zydacron Remote Control HID Driver
Date: Mon, 17 May 2010 10:40:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005171039480.28092@pobox.suse.cz>
References: <4BED7AC3.8090808@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51268 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab0EQIkS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 04:40:18 -0400
In-Reply-To: <4BED7AC3.8090808@yahoo.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Don Prince <dhprince.devel@yahoo.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 14 May 2010, Don Prince wrote:

> diff -X /opt/scripts/diff-exclude.txt -Npaur a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> --- a/drivers/hid/hid-core.c	2010-04-22 18:52:46.445384754 +0100
> +++ b/drivers/hid/hid-core.c	2010-05-12 11:38:12.770567799 +0100
> @@ -1365,6 +1365,7 @@ static const struct hid_device_id hid_bl
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },

[ ... snip ... ]

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
