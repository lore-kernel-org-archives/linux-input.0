From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
Date: Sun, 2 Jun 2013 23:38:41 -0700
Message-ID: <20130603063841.GB13989@core.coreip.homeip.net>
References: <1369709258-14529-1-git-send-email-Baohua.Song@csr.com>
 <20130528075808.GA19496@core.coreip.homeip.net>
 <CAGsJ_4zY0+O6fP2bKLy__U_+-ZsWQXwZ8JXYMpRmtVe6zihfDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52473 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3FCGio (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Jun 2013 02:38:44 -0400
Received: by mail-pd0-f172.google.com with SMTP id t10so1667452pdi.17
        for <linux-input@vger.kernel.org>; Sun, 02 Jun 2013 23:38:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zY0+O6fP2bKLy__U_+-ZsWQXwZ8JXYMpRmtVe6zihfDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, Workgroup.Linux@csr.com, linux-arm-kernel@lists.infradead.org, Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

On Tue, May 28, 2013 at 04:07:46PM +0800, Barry Song wrote:
> 2013/5/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > Hi Barry,
> >
> > On Tue, May 28, 2013 at 10:47:38AM +0800, Barry Song wrote:
> >> +     /*
> >> +      * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
> >> +      * to queue a SUSPEND APM event
> >> +      */
> >> +     input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
> >> +     input_sync(pwrcdrv->input);
> >> +
> >> +     /*
> >> +      * Todo: report KEY_POWER event for Android platforms, Android PowerManager
> >> +      * will handle the suspend and powerdown/hibernation
> >> +      */
> >> +
> > ...
> >
> >> +
> >> +     pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
> >> +     set_bit(KEY_POWER, pwrcdrv->input->keybit);
> >
> > Why are we setting up KEY_POWER if we do not send this event?
> 
> For Android products, we send KEY_POWER to let Android PM trigger
> SUSPEND. that is left to be done.

OK, but then we should be adding capabilities when we are ready to send
KEY_POWER events.

I'll apply without KEY_POWER.

Thanks.

-- 
Dmitry
