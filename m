From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Try IRQF_TRIGGER_NONE if IRQF_TRIGGER_FALLING
 returns error
Date: Fri, 4 Feb 2011 00:53:36 -0800
Message-ID: <20110204085336.GC13046@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB770.7090407@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63707 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1BDIxo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 03:53:44 -0500
Received: by iyj18 with SMTP id 18so1915260iyj.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 00:53:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4AB770.7090407@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

On Thu, Feb 03, 2011 at 04:10:56PM +0200, Iiro Valkonen wrote:

> I'm not sure about this one, does it make any sense? I have to do it
> on my test platform; if I request IRQF_TRIGGER_FALLING I get an error.
> With this patch everything works fine. But maybe it would be better to
> try to fix the platform instead...

I guess we should pass irqflags in platfrom data so board code can
adjust as needed.

Thanks.

-- 
Dmitry
