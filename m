From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: Re: edt-ft5x06 question
Date: Fri, 17 Nov 2017 00:10:30 +0100
Message-ID: <98c15a70-1756-0037-3803-3b782ede2545@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:41430 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936377AbdKPXKb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Nov 2017 18:10:31 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A39AAB00E78
        for <linux-input@vger.kernel.org>; Fri, 17 Nov 2017 00:10:30 +0100 (CET)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Za7H6OwyanHI for <linux-input@vger.kernel.org>;
        Fri, 17 Nov 2017 00:10:30 +0100 (CET)
Content-Language: it
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, luca@lucaceresoli.net, simon.budig@kernelconcepts.de, martink@posteo.de, a.mathur@samsung.com

Hi Simon,

sorry for the mess with mailing list.
My mail filter gave me problems and removed e-mails from linux-input 
mailing list.

 > Hi Giulio
 >
 > On Tue, 2017-11-14 at 22:42 +0100, Giulio Benetti wrote:
 > > I'm using ft5206 with edt-ft5x06.c driver,
 > > but what I see is that registers with M09 or M06
 > > seem different from focaltech ft5206
 > > https://www.buydisplay.com/download/ic/FT5206.pdf
 > >
 > > For example, except address 0x80 for threshold register(thgroup),
 > > all the others don't appear:
 > > GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)
 > >
 > > Can someone clarify this?
 >
 > The Registers depend heavily on the actual firmware flashed into the
 > ft5x06. M06 and M09 refers to the resp. touch glasses from EDT (hence
 > the name of the driver), who have a custom firmware installed. Despite
 > being based on the same focaltec chips, their i2c interface is totally
 > different...
 >
 > Most non-EDT ft5x06 touches do use a communication protocol similiar to
 > the M09 series. Unfortunately I've witnessed a lot that it is not
 > possible to rely on the registers that are supposed to provide
 > vendor/model information (according to the Focaltec datasheet). It
 > always takes a little bit of tweaking to figure out what resolution
 > they actually provide (which is possible with the custom EDT-M09
 > firmware).
 >
 > There is a patch series I've sent to this mailinglist (and need to
 > resend, because the first part of the patch series is bogus) that might
 > improve the model detection a little bit, but it by no means is
 > bulletproof.
 >
 > (see https://patchwork.kernel.org/patch/9987467/ and
 > https://patchwork.kernel.org/patch/9987471/)
 >
 > For non-EDT touches that are bonded together with a display it is a
 > reasonable assumption that the touch resolution matches the screen
 > resolution (Which I consider unfortunate: Why throw away more
 > resolution?).
 >
 > Anyway if you have suggestions for improving this driver I am
 > interested in feedback.

I only have an idea,
since we can't know for sure what's the Vendor,
and we can't know for sure max_x and max_y,
I would like to add a field in dt to select which vendor to use.
For example, if you choose "Edt" as vendor, than driver behaves like it 
does now, otherwise there could be "Focaltech" as vendor, and in that 
case I could find a way to get max_x and max_y.
If I can't find a way, we put the need to be inserted in dts both max_x 
and max_y.

Also I would like to export more registers as attributes and dt.

And last. In my company, on previous projects,
we experienced problems with temperature and mechanical drifts.
So the only solution was to send an autocalibrate every n seconds,
when ts is untouched.
I did this adding a timed tasklet inside driver,
so I would like to do the same.

Now what comes in my mind is,
do we need to keep everything in the same driver edt-ft5x.c?
Or does it make sense to write new one(focaltech-ft5x.c) based on 
edt-ft5x.c?

Best regards

 >
 > Bye,
 >         Simon
 >
 > --
 >      kernel concepts GmbH                 Simon Budig
 >      Sieghuetter Hauptweg 48              simon.budig@xxxxxxxxxxxxxxxxx
 >      D-57072 Siegen                       +49-271-771091-17
 >      http://www.kernelconcepts.de/
 >      HR Siegen, HR B 9613; Geschäftsführer: Ole Reinhardt
-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
