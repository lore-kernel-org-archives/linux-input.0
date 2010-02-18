From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: EV_PWR events for reporting battery state?
Date: Thu, 18 Feb 2010 20:51:06 +0000
Message-ID: <1266526266.3181.1.camel@pldmachine>
References: <1266357620.4195.10.camel@pldmachine>
	 <20100217051940.GC7160@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cheetah.host-care.com ([66.7.219.192]:27644 "EHLO
	cheetah.host-care.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0BRVfG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 16:35:06 -0500
In-Reply-To: <20100217051940.GC7160@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dnia 2010-02-16, wto o godzinie 21:19 -0800, Dmitry Torokhov pisze:
> Hi Przemo,
[..]
> > There are some definitions in HID usage tables in HID specification, but
> > I cannot see any of them implemented in kernel (or I omitted something).
> 
> I maintain that these kind of events are outside of input subsystem
> doman (which I would like to limit to human interfaces, not general
> purpose transport).
Hi Dmitry,
OK, it makes sense. I'll use sysfs then.
--
Thanks,
Przemo

