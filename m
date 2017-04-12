From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: asus: support backlight on USB keyboards
Date: Wed, 12 Apr 2017 22:12:35 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704122211390.28004@cbobk.fhfr.pm>
References: <20170406101817.14699-1-carlo@caione.org> <20170410063907.GA20349@mail.corp.redhat.com> <CAL9uMOFYk5ru3P96xVTyH_ayq6jiOhn7E1wXLH-BsahYtXP2JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60489 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753231AbdDLUMi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 16:12:38 -0400
In-Reply-To: <CAL9uMOFYk5ru3P96xVTyH_ayq6jiOhn7E1wXLH-BsahYtXP2JA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Carlo Caione <carlo@caione.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

On Wed, 12 Apr 2017, Carlo Caione wrote:

> >> +     ret = devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
> >> +     if (ret < 0) {
> >> +             /* No need to have this still around */
> >> +             devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> >> +             cancel_work_sync(&drvdata->kbd_backlight->work);
> >
> > Small nitpick, you don't need to call cancel_work_sync() here, nobody
> > could have called a worker. But OTOH, it doesn't hurt.
> >
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks Benjamin. Who should pick this up?

I am going to.

I'll drop the cancel_work_sync() call while doing it, ok?

-- 
Jiri Kosina
SUSE Labs

