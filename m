From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] hid: migrate Dream Cheeky LED driver from USB misc to
 HID
Date: Tue, 14 Jun 2016 10:05:15 +0200
Message-ID: <1465891515.29352.3.camel@suse.com>
References: <8474eef0-3895-70db-c21a-3040417157df@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37324 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbcFNIJF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 04:09:05 -0400
In-Reply-To: <8474eef0-3895-70db-c21a-3040417157df@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

On Tue, 2016-06-14 at 07:51 +0200, Heiner Kallweit wrote:

> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +	if (ret)
> +		return ret;
> +
> +	minor = ((struct hidraw *) hdev->hidraw)->minor;
> +
> +	ret = dc_init_device(dcdev);

That is a race condition. You announced an uninitialized device to the
rest of the system.

> +	if (ret)
> +		goto err;
> +
> +	ret = dc_init_rgb(dcdev, minor);
> +	if (ret)
> +		goto err;
> +
> +	dev_info(&hdev->dev, "Dream Cheeky Webmail Notifier %d initialized\n", minor);
> +
> +	return 0;
> +
> +err:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}

	Regards
		Oliver


