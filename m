From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH] input: Add Atmel maXTouch touchscreen driver
Date: Wed, 17 Nov 2010 08:04:32 -0600
Message-ID: <AANLkTikob_e2+gZJHb-KOFOeFxffjjwsnrY1=io0WGru@mail.gmail.com>
References: <4CDD4BBA.5070301@atmel.com> <20101112201001.GE1299@core.coreip.homeip.net>
 <4CE3B164.9070607@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57088 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932433Ab0KQOEz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 09:04:55 -0500
Received: by mail-qy0-f178.google.com with SMTP id 33so2158560qyk.2
        for <linux-input@vger.kernel.org>; Wed, 17 Nov 2010 06:04:54 -0800 (PST)
In-Reply-To: <4CE3B164.9070607@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kyungmin.park@samsung.com, jy0922.shim@samsung.com, linux-input@vger.kernel.org

Hi Dmitry

On Wed, Nov 17, 2010 at 4:41 AM, Iiro Valkonen <iiro.valkonen@atmel.com> wrote:
> On 11/12/2010 10:10 PM, Dmitry Torokhov wrote:
> Hi Dmitry,
>
> the current driver is written for one maXTouch chip, mXT224. The driver that I submitted will support all current >maXTouch chips, and it is built to be future-proof so it should work with yet to be released chips too, with minor or >no changes. This shows in the naming too, part name "qt602240" is deprecated and it shouldn't be used. As the >driver should work with all chips in the maXTouch family, a more generic naming convention in the driver name itself >and all the code inside the driver would be more appropriate.

Having written this same driver for this IC I agree with Iiro that we
should have one driver that would support multiple IC firmware
revisions.  Once we had the base driver completed adding functionality
to the driver was a snap.

Can these two drivers co-exist and let the developer decide which driver to use?
Of course the Atmel driver needs to be scrubbed for problems.

Now.  I also strongly agree with Dmitry that the driver you are
submitting is IMHO really rough and needs work.  Without even
reviewing the complete functionality I have many concerns about the
code.

For instance the header file spacing is really crazy.  I am not sure
if the spacing was intended but it is really hard to follow.  In the
source it seems like there is more debug code then functional working
code.  The driver should be updated to use the request_threaded_irq
call and not the request_irq then there is no need for scheduling work
queues.  I can go on and on.... But I won't do a complete review on
this driver unless Dmitry indicates that he will merge it once
complete.

>
> Atmel would like to be the maintainer of this driver, and it would be easiest if we could use the code I submitted. Of course we would be happy to implement any improvements like the threaded IRQs.

I would prefer Atmel be the maintainer as they can expedite future
changes into the driver prior to releasing the support firmware.

Dan

------------------------------------------------------------------------------------
Dan Murphy
Texas Instruments
