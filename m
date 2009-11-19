From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input: atmel_tsadcc: touchscreen rework setting
	capabilities
Date: Thu, 19 Nov 2009 09:04:27 -0800
Message-ID: <20091119170427.GC15647@core.coreip.homeip.net>
References: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com> <20091118173033.GA4385@core.coreip.homeip.net> <4B05224B.8050403@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:52334 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbZKSREZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 12:04:25 -0500
Content-Disposition: inline
In-Reply-To: <4B05224B.8050403@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: avictor.za@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Nov 19, 2009 at 11:47:39AM +0100, Nicolas Ferre wrote:
> Dmitry Torokhov :
> > Hi Nicolas,
> > 
> > On Wed, Nov 18, 2009 at 03:12:12PM +0100, Nicolas Ferre wrote:
> >> Tiny patch for setting capabilities using input API function.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > All looks good. Since the series span platform and input subtrees how do
> > you want to merge it?
> 
> I propose that you merge the whole series using the input path.
> 
> I had the acknowledgment from Andrew Victor offline. So, could you
> please add on patches #3 & #4:
> 
> Acked-by: Andrew Victor <linux@maxim.org.za>
> 
> Thanks a lot.
> 

OK, I will.

-- 
Dmitry
