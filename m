From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Thu, 17 Nov 2011 13:20:41 +0100
Message-ID: <20111117132041.0b581ac0@wker>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
	<20111114172809.GD12659@core.coreip.homeip.net>
	<4EC1832D.3080405@emcraft.com>
	<20111114213241.GA26418@core.coreip.homeip.net>
	<20111115101715.7b330e1d@wker>
	<20111115174137.GB15129@core.coreip.homeip.net>
	<4EC420A1.7080502@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:48583 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757070Ab1KQMUo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 07:20:44 -0500
In-Reply-To: <4EC420A1.7080502@emcraft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Ilya,

On Thu, 17 Nov 2011 00:44:17 +0400
Ilya Yanok <yanok@emcraft.com> wrote:

> Hi Dmitry, Anatolij,
> 
> On 15.11.2011 21:41, Dmitry Torokhov wrote:
> >>> Do you really need to read gpio state in IRQ? Can't you simply rely on
> >>> 'event' do decide whether to emit input events?
> >>
> >> We can't rely on the 'event' only. The peculiar behaviour of the
> >> touch controller enforces this. The touch controller toggles the
> >> interrupt line when you keep the finger down. The rate is not exactly
> >> specified by the the manufacturer (~80/sec). Measured rate deviates
> >> from this specified rate. Valid touch packet data can be read when
> >> interrupt line is pulled down.
> > 
> > So what ensures that the gpio line stays low between the check and the
> > time you get access to i2c bus and get around reading the data.
> 
> Anatolij, could you please comment on this? What can we do about this?
> Check the pin state after i2c read maybe?

I received a suggestion to look at the time elapsed since falling
edge of the GPIO IRQ before reading the touch packet data and
skip reading if it is too late. I'll also check what the touch
packet data looks like when reading it while finger is down but
the line stays high. 

Anatolij
