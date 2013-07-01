From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH 3/3] Input: tps6507x-ts - convert to polled input device infrastructure
Date: Mon, 1 Jul 2013 12:12:17 +0530
Message-ID: <CAKDJKT4Hi-C3pa+_=dVhBJAC6NFiRyMbFtBdzMQNJ-zwxKnwwg@mail.gmail.com>
References: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
	<1370843627-30823-3-git-send-email-dmitry.torokhov@gmail.com>
	<A4887BF146CD57468F700B415D2F47015A132E@DBDE04.ent.ti.com>
	<20130619061732.GC26181@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:48532 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3GAGmS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jul 2013 02:42:18 -0400
Received: by mail-ve0-f179.google.com with SMTP id d10so3444769vea.10
        for <linux-input@vger.kernel.org>; Sun, 30 Jun 2013 23:42:17 -0700 (PDT)
In-Reply-To: <20130619061732.GC26181@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, alan@linux.intel.com

Hi Dmitry,

On Wed, Jun 19, 2013 at 11:47 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Jun 12, 2013 at 07:12:31AM +0000, Vishwanathrao Badarkhe, Manish
> wrote:
> > Hi Dmitry,
> >
> > On Mon, Jun 10, 2013 at 11:23:47, Dmitry Torokhov wrote:
> > > There is no need to roll our own polling scheme when we already have
> > > one implemented by the core.
> >
> > Please let me know, on which branch this patch series is based on?
> > I failed to apply these patches on master branch of "linux-next".
>
> Linux-next should work, I do not have anything else for this driver
> pending in my queue.

Your patch series is dependant on patch [1] which is not yet applied
to master branch of "linux-next".

After applying your patch series and built kernel for da850-evm board,
I got following error:

arch/arm/mach-davinci/board-da850-evm.c:988:2: error: unknown field
'vref' specified in initializer

I resolved this error with patch [2] and tested your series with event
debug mechanism for touchscreen
functionality. Series works fine for me with above said changes.

Tested-by: Manish Badarkhe <badarkhe.manish@gmail.com>

1. https://patchwork.kernel.org/patch/1531841/
2. https://github.com/ManishBadarkhe/linux-next/commit/c18995435db8e900f97d157c6253da7f9d0e6a23

> Thanks.
>
> --
> Dmitry
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
