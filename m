From: Masaki Ota <masaki.ota@jp.alps.com>
Subject: RE: [PATCH] Improve Alps HID Touchpad code
Date: Wed, 22 Jun 2016 02:48:26 +0000
Message-ID: <OSXPR01MB0408F71585D0567CF8A01C0EC72C0@OSXPR01MB0408.jpnprd01.prod.outlook.com>
References: <1466504912-15297-1-git-send-email-masaki.ota@jp.alps.com>
 <20160621223503.GA34772@dtor-ws>
 <alpine.LNX.2.00.1606220036490.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0049.outbound.protection.outlook.com ([104.47.93.49]:43018
	"EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750907AbcFVDXx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 23:23:53 -0400
In-Reply-To: <alpine.LNX.2.00.1606220036490.6874@cbobk.fhfr.pm>
Content-Language: ja-JP
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Masaki Ota <012nexus@gmail.com>, "benjamin.tissorires@redhat.com" <benjamin.tissorires@redhat.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Naoki Saito <naoki.saito@jp.alps.com>

Hi, Jiri,

Sorry, I cannot catch your meaning. What is the part corrupted? 
I added "HID_DEVICE_ID_ALPS_U1_DUAL" instead of " HID_ANY_ID".
Because we want to use our devices except for "HID_DEVICE_ID_ALPS_U1_DUAL" as Mouse mode.

Best Regards,
Masaki Ota
-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Wednesday, June 22, 2016 7:39 AM
To: Dmitry Torokhov
Cc: Masaki Ota; benjamin.tissorires@redhat.com; peter.hutterer@who-t.net; hdegoede@redhat.com; linux-input@vger.kernel.org; 太田 真喜 Masaki Ota; 斉藤 直樹 Naoki Saito
Subject: Re: [PATCH] Improve Alps HID Touchpad code

On Tue, 21 Jun 2016, Dmitry Torokhov wrote:

> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index 
> > 3cdbc4b..678d8bd 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1772,7 +1772,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
> > -	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP, HID_ANY_ID) },
> > +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP,
> > +	HID_DEVICE_ID_ALPS_U1_DUAL) },

On top of what Dmitry said, the above has been (corrupted) line-wrapped (most likely by your mail client). Could you please fix that up while fixing the rest of Dmitry's valuable review comments?

Thanks,

--
Jiri Kosina
SUSE Labs

