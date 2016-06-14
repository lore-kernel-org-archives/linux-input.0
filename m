From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] hid: migrate Dream Cheeky LED driver from USB misc to
 HID
Date: Tue, 14 Jun 2016 21:57:32 +0200
Message-ID: <1465934252.25380.2.camel@suse.com>
References: <8474eef0-3895-70db-c21a-3040417157df@gmail.com>
	 <1465891515.29352.3.camel@suse.com>
	 <9d2c2ae6-3340-55e4-03f5-1fc95b2517cb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60342 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbcFNUBW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 16:01:22 -0400
In-Reply-To: <9d2c2ae6-3340-55e4-03f5-1fc95b2517cb@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

On Tue, 2016-06-14 at 21:34 +0200, Heiner Kallweit wrote:
> Am 14.06.2016 um 10:05 schrieb Oliver Neukum:
> > On Tue, 2016-06-14 at 07:51 +0200, Heiner Kallweit wrote:
> > 
> >> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	minor = ((struct hidraw *) hdev->hidraw)->minor;
> >> +
> >> +	ret = dc_init_device(dcdev);
> > 
> > That is a race condition. You announced an uninitialized device to the
> > rest of the system.
> > 
> I don't see a race. The hdev and lock elements of dcdev are initialized

You have called hid_hw_start(). That implies that the device be ready.

> and dc_init_device just calls dc_send to send the init command to the device.
> It doesn't announce anything.

You send the init command after the rest of the system already sees the
device.

	Regards
		Oliver


