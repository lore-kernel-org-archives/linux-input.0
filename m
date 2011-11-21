From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Mon, 21 Nov 2011 10:24:20 +0100
Message-ID: <20111121102420.0171df46@wker>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
	<CAM=Q2cuv_OFdrHpmf-fSRkiaz0X07vHpbpWH=MzfR_3S4OADjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:51229 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab1KUJY1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 04:24:27 -0500
In-Reply-To: <CAM=Q2cuv_OFdrHpmf-fSRkiaz0X07vHpbpWH=MzfR_3S4OADjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hello,

On Mon, 21 Nov 2011 14:20:57 +0530
Shubhrajyoti Datta <omaplinuxkernel@gmail.com> wrote:
...
> > +       error = request_irq(priv->irq, edt_ts_isr, IRQF_TRIGGER_FALLING,
> > +                           client->name, priv);
> >
> 
> Could we move to threaded irq instead?
> Or is there a specific reason for the delayed work stuff?

It is already done in an updated patch that will be posted to
the list soon.

Thanks,
Anatolij
