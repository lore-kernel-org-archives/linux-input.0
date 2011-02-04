From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Add chip I2C addresses to header file
Date: Fri, 4 Feb 2011 00:43:46 -0800
Message-ID: <20110204084346.GA13046@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB7F5.3070704@atmel.com>
 <20110203144946.GA21568@sirena.org.uk>
 <4D4BBAD7.8060300@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50886 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab1BDInx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 03:43:53 -0500
Received: by iyj18 with SMTP id 18so1909325iyj.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 00:43:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4BBAD7.8060300@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

On Fri, Feb 04, 2011 at 10:37:43AM +0200, Iiro Valkonen wrote:
> On 02/03/2011 04:49 PM, Mark Brown wrote:
> > On Thu, Feb 03, 2011 at 04:13:09PM +0200, Iiro Valkonen wrote:
> >> From: Iiro Valkonen <iiro.valkonen@atmel.com>
> >>
> >> Add chip I2C addresses to header file.
> > 
> > Why do this?
> 
> To help lazy developers, they don't have to dig up the datasheet to
> see what address their chip is at? Well, I guess they might have to do
> that anyway to see what address out of these is selected with the
> address select pin. I thought it would be neat to have all the
> possible addresses listed here, and the developer could pick the
> correct one for his/her board file. Or in the case where he is not
> sure about the state of the address select pin, maybe even try them
> all. 
> 
> It does seem to be common practice to have the plain address in the
> board file without any defines in the header, so maybe this patch is
> not needed.

The headers should carry exported information. I have no problem with
adding register definitions, but data that is not needed for users
should go in .c file.

Thanks.

-- 
Dmitry
