From: Peter <peter@slim-one.de>
Subject: [Fwd: Re: [PATCH] G25_support]
Date: Tue, 22 Mar 2011 11:20:52 +0100
Message-ID: <1300789252.5513.46.camel@slim-one-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4tkHEnSAyYV8y3xfrRg3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:47354 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab1CVKUz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2011 06:20:55 -0400
Received: from [88.65.216.36] (helo=[192.168.0.10])
	by smtprelay05.ispgateway.de with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <peter@slim-one.de>)
	id 1Q1yhp-0001Bg-Ei
	for linux-input@vger.kernel.org; Tue, 22 Mar 2011 11:20:53 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>


--=-4tkHEnSAyYV8y3xfrRg3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

CC vger.

--=-4tkHEnSAyYV8y3xfrRg3
Content-Disposition: inline
Content-Description: Forwarded message - Re: [PATCH] G25_support
Content-Type: message/rfc822

Received: from [80.67.29.37] (helo=mx06.ispgateway.de) by
 luna.ispgateway.de with esmtp (Exim 4.68) (envelope-from
 <peter@slim-one.de>) id 1Q1ybR-0002YQ-4P; Tue, 22 Mar 2011 11:14:17 +0100
Return-path: <peter@slim-one.de>
X-Envelope-To: peter@slim-one.de
Received: from [80.67.31.101] (helo=smtprelay06.ispgateway.de) by
 mx06.ispgateway.de with esmtp (Exim 4.68) (envelope-from
 <peter@slim-one.de>) id 1Q1ybQ-00018Y-Vl for peter@slim-one.de; Tue, 22 Mar
 2011 11:14:17 +0100
Received: from [88.65.216.36] (helo=[192.168.0.10]) by
 smtprelay06.ispgateway.de with esmtpsa (SSLv3:AES256-SHA:256) (Exim 4.68)
 (envelope-from <peter@slim-one.de>) id 1Q1ybP-0005Ll-0s; Tue, 22 Mar 2011
 11:14:15 +0100
Subject: Re: [PATCH] G25_support
From: Peter <peter@slim-one.de>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Simon Wood <simon@mungewell.org>, Christophe Borivant
 <christophe.borivant@wanadoo.fr>, Michal =?ISO-8859-1?Q?Mal=FD?=
 <madcatxster@gmail.com>
In-Reply-To: <alpine.LNX.2.00.1103221039090.19969@pobox.suse.cz>
References: <1299842104.2550.24.camel@slim-one-desktop>
	 <1300769820-16198-1-git-send-email-simon@mungewell.org>
	 <alpine.LNX.2.00.1103221039090.19969@pobox.suse.cz>
Content-Type: multipart/mixed; boundary="=-0mQsFb8yduy6I511gElC"
Date: Tue, 22 Mar 2011 11:14:09 +0100
Message-ID: <1300788849.5513.45.camel@slim-one-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Df-Sender: 745494
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
 spamfilter22.ispgateway.de
X-Spam-Level: 
X-Spam-Status: No, hits=0.0 required=9999.0 tests=BAYES_50
 autolearn=disabled version=3.2.5
X-Spam-CMAETAG: v=1.1 cv=jSDid7ar9RMS3b7BAy5O4gKZRwRCT5a2AI3Sw/oqkSA= c=1
 sm=0 a=OiG0dlwCAAAA:8 a=47LbCVvxAAAA:8 a=5SKslGq-TWnOs-xg_F4A:9
 a=CA94OP75RDcekfu6c2X789kfRuUA:4 a=QEXdDO2ut3YA:10 a=6yZCFVB9GRUA:10
 a=QhNQsjeWOoAA:10 a=k3quhN3MqYQwjd6qtosA:9 a=7RM2kLcLApSdoLtar5-3la4-S9UA:4
 a=IKIoO-ieCDEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117 xcat=Undefined/Undefined
X-Spam-CMAECATEGORY: 0
X-Spam-CMAESUBCATEGORY: 0
X-Spam-CMAESCORE: 0


--=-0mQsFb8yduy6I511gElC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

if Michal and Christophe want to test this, they have to set their
G25/DFP into native mode via G25manage
(http://wiki.vdrift.net/Logitech_G25_support). I rewrote the tool so
that only nativemode and range can be set (the original contained
debugging/calibration which isn't really necessary for a device that
calibrates itself when connected) for both the G25/G27 and the DFP. I
attached the rewritten version and proper udev-rules (DFP-rule not
tested but should work fine). 
I don't know if that stuff should be integrated into the kernel (at
least the initialization), too. Without that, the wheels only report 2
axis and are limited to somewhat 270 degrees instead of 4 axis and 900
degrees.

As for wine, it needs to be patched, too, else it will feel more like a
steamhammer. I'm already writing with two of the devs, and it seems they
got it fixed.

Regards, Peter


On Tue, 2011-03-22 at 10:40 +0100, Jiri Kosina wrote:
> On Mon, 21 Mar 2011, Simon Wood wrote:
> 
> > From: Peter <peter@slim-one.de>
> > 
> > Small patch to add support for the G25/G27 by adding USB ID's
> > as suggested by Peter.
> > 
> > Boots but otherwise untested as I don't have hardware, .debs for
> > kernel (2.6.38) here if want to test/run Ubuntu/Debian:
> > http://www.mungewell.org/Logitech_Wii_Wheel/
> > 
> > Reported-by: Peter <peter@slim-one.de>
> > Signed-off-by: Simon Wood <simon@mungewell.org>
> > ---
> >  drivers/hid/hid-lgff.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
> > index 90d0ef2..f099079 100644
> > --- a/drivers/hid/hid-lgff.c
> > +++ b/drivers/hid/hid-lgff.c
> > @@ -73,6 +73,8 @@ static const struct dev_type devices[] = {
> >  	{ 0x046d, 0xc293, ff_joystick },
> >  	{ 0x046d, 0xc294, ff_wheel },
> >  	{ 0x046d, 0xc295, ff_joystick },
> > +	{ 0x046d, 0xc298, ff_wheel },
> > +	{ 0x046d, 0xc299, ff_wheel },
> >  	{ 0x046d, 0xca03, ff_wheel },
> >  };
> 
> You are right that missing entries in this struct for devices which have 
> LG_FF flag set doesn't make too much sense.
> 
> Adding Michal and Chritophe to CC, as they should have the HW to test.
> 


--=-0mQsFb8yduy6I511gElC
Content-Type: application/zip; name="G25manage.zip"
Content-Disposition: attachment; filename="G25manage.zip"
Content-Transfer-Encoding: base64

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
AAAAAAUABQCbAQAA3BAAAAAA


--=-0mQsFb8yduy6I511gElC--


--=-4tkHEnSAyYV8y3xfrRg3--

