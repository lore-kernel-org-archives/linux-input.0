From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Mon, 7 May 2012 09:09:11 +0200
Message-ID: <CACKLOr1gHPV03LbtYc6=Zb8zD9WDyiMXL1S-1EGPUtYPVySvQg@mail.gmail.com>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
	<20120507070424.GC22074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58916 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab2EGHJM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 May 2012 03:09:12 -0400
Received: by yhmm54 with SMTP id m54so3914588yhm.19
        for <linux-input@vger.kernel.org>; Mon, 07 May 2012 00:09:12 -0700 (PDT)
In-Reply-To: <20120507070424.GC22074@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bo Shen <voice.shen@atmel.com>, khali@linux-fr.org, w.sang@pengutronix.de, josh.wu@atmel.com, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi,
the patch works fine for me in i.MX27.

On 7 May 2012 09:04, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Bo,
>
> On Mon, May 07, 2012 at 10:27:33AM +0800, Bo Shen wrote:
>> The default trigger mode of QT1070 is IRQF_TRIGGER_LOW,
>> Using TRQF_TRIGGER_FALLING to replace IRQF_TRIGGER_LOW | IRQF_ONESHOT.
>
> Why don't you set up IRQ the way you want in board code instead of
> implementing workarounds in the driver?
>
> Thanks.
>
> --
> Dmitry



-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
