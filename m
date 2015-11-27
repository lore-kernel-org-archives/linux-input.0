From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Fri, 27 Nov 2015 05:50:10 -0500 (EST)
Message-ID: <1953763158.25062502.1448621410440.JavaMail.zimbra@redhat.com>
References: <Pine.LNX.4.44L0.1511261233120.14257-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:38886 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbK0KuX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 05:50:23 -0500
In-Reply-To: <Pine.LNX.4.44L0.1511261233120.14257-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello,

> > Hmm, I see quite a few drivers assuming that endpoint 0 will be present.
> > I wonder if that should not be solved at USB level.
>
> Every USB device always has endpoint 0.  If one didn't, the kernel 
> wouldn't be able to initialize and enumerate it.

Yes for the normal USB device. This case is a weird USB device (with no
endpoints) specially designed to be weird. My point here is that even a
weird device probing should not crash a kernel by a NULL-deref.

> > Alan, does it make sense to have drivers probe interface if it does not
> > have any endpoints?
>
> Yes; in theory an interface can do everything it needs using only 
> endpoint 0.  Driver shouldn't assume anything about the endpoints in 
> the interfaces they problem.

The current kernel code in drivers/usb/core/config.c accepts an interface
with no endpoints in one of its configurations, and I could not find a
direct ban for that in USB standard. So, I currently believe, it is a driver
job to check if the endpoint 0 exist, otherwise we must change the kernel
USB detection code.

btw, indeed, this is not the only driver with this problem, I've met 2 more.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
