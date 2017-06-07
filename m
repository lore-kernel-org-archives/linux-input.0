From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: Add driver for Retrode2 joypad adapter
Date: Wed, 07 Jun 2017 17:42:53 +0200
Message-ID: <1496850173.11482.7.camel@hadess.net>
References: <1496844937.11482.3.camel@hadess.net>
         <20170607142858.GF16591@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57164 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbdFGPm5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 11:42:57 -0400
In-Reply-To: <20170607142858.GF16591@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Wed, 2017-06-07 at 16:28 +0200, Benjamin Tissoires wrote:
> On Jun 07 2017 or thereabouts, Bastien Nocera wrote:
<snip>
> > +		hid_err(hdev, "parse failed\n");
> 
> This error message is probably too much, just return in case of
> failure,
> we will get an error if something wrong happens.
> 
> > +		return ret;
> > +	}
> > +
> > +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +	if (ret) {
> > +		hid_err(hdev, "hw start failed\n");
> 
> Same here.

Both fixed.

> > +static const struct hid_device_id retrode_devices[] = {
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
> > USB_DEVICE_ID_RETRODE2) },
> 
> Aren't you missing the same entry in hid-core.c
> hid_have_special_driver?

I guess I am, fixed.
