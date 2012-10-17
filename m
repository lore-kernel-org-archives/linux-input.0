From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 1/2] input: qt2160: Fix I2C write function.
Date: Wed, 17 Oct 2012 08:59:35 +0200
Message-ID: <CACKLOr1NdcT5_MyEd4-M5Cg9yaRreQ1kcXwhGU-ctMWcX9sn9g@mail.gmail.com>
References: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
	<20121016173156.GB412@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:65034 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2JQG7h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 02:59:37 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so6067635wgb.1
        for <linux-input@vger.kernel.org>; Tue, 16 Oct 2012 23:59:36 -0700 (PDT)
In-Reply-To: <20121016173156.GB412@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

Hi Dmitry,
thank you for your answer.

On 16 October 2012 19:31, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Oct 16, 2012 at 05:19:30PM +0200, Javier Martin wrote:
>> The previous implementation of qt2160_write() didn't work
>> properly. Use a similar aproach as qt1070 instead.
>
> I think your editor lost the end of the sentence: "... qt2160_write()
> didn't work properly because ..." :)
>
> Thanks!
>
> --
> Dmitry

Because the requested value was actually not written to the device.
Probably nobody detected this because the only write that was issued
was the one related to auto calibration.

It was while I was trying to add support for the LEDs when I realized
that they were not being powered on.

Do you want me to send a v2 patch with these information added to the changelog?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
