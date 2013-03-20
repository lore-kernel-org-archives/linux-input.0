From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v6 0/6] Add ChromeOS Embedded Controller support
Date: Tue, 19 Mar 2013 19:01:42 -0700
Message-ID: <CAPnjgZ1=w5GyfGrSFG63SFTErTQQUQQiBmgC8BVMzy4kLVkPDg@mail.gmail.com>
References: <1361830121-32284-1-git-send-email-sjg@chromium.org>
	<20130320005652.GC26903@zurbaran>
	<20130320011211.GA5905@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:64234 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933452Ab3CTCBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Mar 2013 22:01:49 -0400
Received: by mail-qa0-f44.google.com with SMTP id hg5so758844qab.3
        for <linux-input@vger.kernel.org>; Tue, 19 Mar 2013 19:01:48 -0700 (PDT)
In-Reply-To: <20130320011211.GA5905@zurbaran>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Wolfram Sang <w.sang@pengutronix.de>, Luigi Semenzato <semenzato@chromium.org>, Rob Herring <rob.herring@calxeda.com>, Che-Liang Chiou <clchiou@chromium.org>, Jonathan Kliegman <kliegs@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Sourav Poddar <sourav.poddar@ti.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Alban Bedel <alban.bedel@avionic-design.de>, Roland Stigge <stigge@antcom.de>, Vincent Palatin <vpalatin@chromium.org>, Javier Martinez Canillas <javier@dowhile0.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Bill Pemberton <wfp5p@virgi>

Hi Samuel,

On Tue, Mar 19, 2013 at 6:12 PM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> On Wed, Mar 20, 2013 at 01:56:52AM +0100, Samuel Ortiz wrote:
>> Hi Simon,
>>
>> On Mon, Feb 25, 2013 at 02:08:35PM -0800, Simon Glass wrote:
>> > The ChromeOS Embedded Controller (EC) is an Open Source EC impleme=
ntation
>> > used on ARM and Intel Chromebooks. Current implementations use a C=
ortex-M3
>> > connected on a bus (such as I2C, SPI, LPC) to the AP. A separate i=
nterrupt
>> > line is used to indicate when the EC needs service.
>> All 6 patches applied to my mfd-next tree, thanks a lot.
> Actually, this one fails to build when CONFIG_OF is not set:
>
> drivers/mfd/cros_ec_i2c.c:130:2: error: implicit declaration of funct=
ion
> =91of_device_is_available=92 [-Werror=3Dimplicit-function-declaration=
]
>
> If the check in cros_ec_probe_i2c() is really needed then you'll need=
 to inline
> of_device_is_available() into a NOP in include/linux/of.h.

Actually I suppose that call is not really needed. Would you like to
remove it, or shall I send a new patch?

Regards,
Simon

>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
