From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Improve Alps HID Touchpad code
Date: Wed, 22 Jun 2016 00:38:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606220036490.6874@cbobk.fhfr.pm>
References: <1466504912-15297-1-git-send-email-masaki.ota@jp.alps.com> <20160621223503.GA34772@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43363 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbcFUWit (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 18:38:49 -0400
In-Reply-To: <20160621223503.GA34772@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Masaki Ota <012nexus@gmail.com>, benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

On Tue, 21 Jun 2016, Dmitry Torokhov wrote:

> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 3cdbc4b..678d8bd 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1772,7 +1772,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
> > -	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP, HID_ANY_ID) },
> > +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP,
> > +	HID_DEVICE_ID_ALPS_U1_DUAL) },

On top of what Dmitry said, the above has been (corrupted) line-wrapped 
(most likely by your mail client). Could you please fix that up while 
fixing the rest of Dmitry's valuable review comments?

Thanks,

-- 
Jiri Kosina
SUSE Labs

