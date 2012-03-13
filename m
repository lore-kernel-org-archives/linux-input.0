From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/2] input: add MAX8997-haptic driver
Date: Mon, 12 Mar 2012 22:30:35 -0700
Message-ID: <20120313053035.GB9449@core.coreip.homeip.net>
References: <4F571629.8010203@samsung.com>
 <20120307082900.GA20493@core.coreip.homeip.net>
 <4F5DB45C.4050101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35644 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab2CMFam (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 01:30:42 -0400
Content-Disposition: inline
In-Reply-To: <4F5DB45C.4050101@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-input@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

On Mon, Mar 12, 2012 at 05:31:24PM +0900, Chanwoo Choi wrote:
> Hi Dmitry,
> 
> On 03/07/2012 05:29 PM, Dmitry Torokhov wrote:
> > Hi Chanwoo,
> > 
> > 
> > On Wed, Mar 07, 2012 at 05:02:49PM +0900, Chanwoo Choi wrote:
> >> MAX8997 has several features in a single chip,
> >> This patchset supports unimplemented haptic driver of MAX8997.
> >>
> >> v2
> >> - code clean and remove unnecessary code according to comment of Dmitry
> >> Torokhov
> > 
> > Could you please tell me if the version of the patch I sent to you
> > worked or not?
> 
> It isn't worked because it use the mutex lock in irq handler stack.
> so, I resend v3 patch of max8997-haptic driver after modifying it.

Hmm, my patch did not add taking mutex in irq context, I presume you are
talking about max8997->iolock that is taken in max8997_write_reg... OK,
I see...

-- 
Dmitry
