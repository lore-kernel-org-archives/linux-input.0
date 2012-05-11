From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Fri, 11 May 2012 11:13:41 +0200
Message-ID: <CACKLOr0_ztBXfTwa1R_yLzf6wEABENf=-MzYHd-J5YQtEmQt9w@mail.gmail.com>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
	<20120507070424.GC22074@core.coreip.homeip.net>
	<4FACCDA6.7040506@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61788 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758474Ab2EKJNm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 05:13:42 -0400
Received: by yenm10 with SMTP id m10so2381334yen.19
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 02:13:41 -0700 (PDT)
In-Reply-To: <4FACCDA6.7040506@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bo Shen <voice.shen@atmel.com>, khali@linux-fr.org, w.sang@pengutronix.de, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi all,
let's take a chip which presents a similar issue like the pca953x [1].
This chip has an IRQ line that is meant to be connected to a SoC input
like the qt1070.

The flags that are used for pca953x are: (IRQF_TRIGGER_LOW | IRQF_ONESHOT)

Can't we do the same for qt1070?
And even more important, can you give me an example of an architecture
in mainline which cannot support these irq flags and still be able to
detect a change from high to low in a GPIO as qt1070 requires?

Moreover, if you try a grep for IRQ_TRIGGER_NONE in the kernel tree
you won't find any driver doing this strange thing.

Do you agree at least that we must change IRQ_TRIGGER_NONE flag into a
more sensible choice?

Regards.

[1] http://lxr.linux.no/#linux+v3.3.4/drivers/gpio/gpio-pca953x.c#L495

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
