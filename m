From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/1] input: keyboard: add qci keyboard driver
Date: Tue, 7 Sep 2010 15:14:08 -0700
Message-ID: <20100907221407.GA22259@core.coreip.homeip.net>
References: <4C7838DD.1020004@codeaurora.org>
 <201008271533.01542.dmitry.torokhov@gmail.com>
 <4C7BF6D2.5080501@codeaurora.org>
 <20100830215556.GC28865@core.coreip.homeip.net>
 <4C7D6C17.1070604@codeaurora.org>
 <20100901063430.GG23585@core.coreip.homeip.net>
 <4C8148C6.2010006@codeaurora.org>
 <20100903203717.GA6412@core.coreip.homeip.net>
 <4C86B567.8030804@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60107 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab0IGWOQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Sep 2010 18:14:16 -0400
Content-Disposition: inline
In-Reply-To: <4C86B567.8030804@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Hsin.Wu@quantatw.com, mcuos.com@gmail.com

On Tue, Sep 07, 2010 at 05:57:59PM -0400, Neil Leeder wrote:
> On 9/3/2010 4:37 PM, Dmitry Torokhov wrote:
> >
> >Does this mean you are not interested in getting drivers for the current
> >generation of hardware to mainline?
> 
> Hi Dmitry,
> 
> That's correct - I don't think there is much future for the current
> hardware if we can come up with a cleaner solution for the new
> versions. 

Ah, OK, I see.

> I will test 0xF5 with the new hardware.  I think we may
> still need a new keyboard driver, just rewritten to have a serio
> backend.

It would be great if newer hardware could make use of the atkbd driver
(if it is going to use serio + PS/2 ports on the EC).

Thanks.

-- 
Dmitry
