From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Fri, 4 Apr 2008 12:14:47 -0400
Message-ID: <20080404120837.ZZRA012@mailhub.coreip.homeip.net>
References: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se> <20080402060819.GB14189@anvil.corenet.prv> <aec7e5c30804040121k584a0ae5o909b48fbd970245d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.248]:14932 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYDDQOy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2008 12:14:54 -0400
Received: by hs-out-0708.google.com with SMTP id 4so89065hsl.5
        for <linux-input@vger.kernel.org>; Fri, 04 Apr 2008 09:14:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <aec7e5c30804040121k584a0ae5o909b48fbd970245d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, broonie@sirena.org.uk, akpm@linux-foundation.org

Hi Magnus,

On Fri, Apr 04, 2008 at 05:21:48PM +0900, Magnus Damm wrote:
> I just tested using latest sh-2.6 git with evtest. Everything seems to
> work well. The patch is much cleaner now. Please apply.
> 

I was just looking the driver over one more time before applying it
and I think there is a race in migor_ts_remove():

+       /* cancel pending work and wait for migor_ts_poscheck() to finish */
+       cancel_delayed_work_sync(&priv->work);
+

What if interrupt comes here, before we got a chance to shut off the
device? IRQ is still enabled and it will schedule migor_ts_poscheck()
again. I think we need to call disable_irq() before canceling the work.
Since the driver does not support sharing IRQs that should be allright.
What do you think?

+       /* disable controller */
+       i2c_master_send(client, migor_ts_dis_seq, sizeof(migor_ts_dis_seq));
+
+       free_irq(priv->irq, priv);

Thank you.

-- 
Dmitry
