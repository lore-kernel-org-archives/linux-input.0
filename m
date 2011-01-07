From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver (third version)
Date: Fri, 7 Jan 2011 11:50:00 -0800
Message-ID: <20110107195000.GD28875@core.coreip.homeip.net>
References: <4D22ECB6.6090800@armadeus.com>
 <4D22FE0F.7010206@codeaurora.org>
 <4D276CAD.5090604@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49002 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab1AGTuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 14:50:07 -0500
Content-Disposition: inline
In-Reply-To: <4D276CAD.5090604@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabien Marteau <fabien.marteau@armadeus.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 07, 2011 at 08:42:37PM +0100, Fabien Marteau wrote:
> On 04/01/2011 12:01, Trilok Soni wrote:
> > Hi Fabien,
> > 
> > On 1/4/2011 3:17 PM, Fabien Marteau wrote:
> >> +
> >> +static irqreturn_t as5011_int_interrupt(int irq, void *dev_id)
> >> +{
> >> +	struct as5011_platform_data *plat_dat = dev_id;
> >> +
> >> +	mutex_lock(&plat_dat->update_lock);
> >> +	as5011_update_axes(plat_dat);
> >> +	mutex_unlock(&plat_dat->update_lock);
> > 
> > Please explain this lock. Sorry if I have missed out your explanation in the earlier threads.
> 
> If a second interruption occurs the first update must be finished before update again.

The ISR handler will not be called simultaneously on several CPUs. What
else can it race with?

-- 
Dmitry
