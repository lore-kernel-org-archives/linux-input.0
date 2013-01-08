From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v5] input: qt2160: Add support for LEDs.
Date: Tue, 8 Jan 2013 09:03:22 +0100
Message-ID: <CACKLOr2-ODH82MQb+0Tzs+DDzCD0v1ccbBJ3K5qQ0T7GJORLJQ@mail.gmail.com>
References: <1351158824-19432-1-git-send-email-javier.martin@vista-silicon.com>
	<CACKLOr3DDNawzqU3S1jzfFzTmwmbrsWrDi-V27NU1_kGH7kVqQ@mail.gmail.com>
	<20130105005926.GB13440@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:35490 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3AHIIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 03:08:30 -0500
Received: by mail-we0-f176.google.com with SMTP id r5so88442wey.21
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 00:08:28 -0800 (PST)
In-Reply-To: <20130105005926.GB13440@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

Hi Dmitry,

On 5 January 2013 01:59, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> [PATCH v2 1/2] input: qt2160: Fix I2C write function.
>
> This one was already in.
>
>> [PATCH v5] input: qt2160: Add support for LEDs.
>
> This one I just applied removing __devinit markings (some of them should
> have been __devexit BTW) and making sure that cancel work is called
> after unregisterting led device, otherwise it is racy.

Thank you for taking your time for fixing that yourself.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
