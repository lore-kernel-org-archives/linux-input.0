From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: Fix reporting of nonexistent HWheel for Elecom
 BM084 (bluetooth mouse).
Date: Mon, 28 Jun 2010 19:01:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006281900440.13809@pobox.suse.cz>
References: <4C288B57.7060600@googlemail.com> <20100628163451.GB11670@core.coreip.homeip.net> <alpine.LNX.2.00.1006281837090.13809@pobox.suse.cz> <4C28D3C1.7070307@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46992 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671Ab0F1RBf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 13:01:35 -0400
In-Reply-To: <4C28D3C1.7070307@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <richard.nauber@googlemail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>

On Mon, 28 Jun 2010, Richard Nauber wrote:

> Ok, how about this:
[ ... snip ... ]
> +static void elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +		unsigned int rsize)
> +{
> +	if (rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
> +		dev_info(&hdev->dev, "Fixing up Elecom BM084 "
> +				"report descriptor.\n");
> +		rdesc[47] = 0x00;
> +	}
> +}
> +
> +static const struct hid_device_id elecom_devices[] = {
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084)},
> +	{ } heads up and

What is this? :)

I will fix that mess up and apply to my tree.

Thanks for the driver!

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
