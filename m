From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Dual touchscreen implementation
Date: Thu, 19 Aug 2010 22:01:11 -0700
Message-ID: <20100820050109.GA12243@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043F6195B1@dlee03.ent.ti.com>
 <20100813075047.GA7700@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043F6CC264@dlee03.ent.ti.com>
 <C9D59C82B94F474B872F2092A87F261412470D10F6@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45724 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab0HTFBY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 01:01:24 -0400
Received: by pvg2 with SMTP id 2so1049635pvg.19
        for <linux-input@vger.kernel.org>; Thu, 19 Aug 2010 22:01:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C9D59C82B94F474B872F2092A87F261412470D10F6@dlee07.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dan,

On Tue, Aug 17, 2010 at 09:06:00AM -0500, Murphy, Dan wrote:
> Abraham
>
> My thoughts would be similar to Dmitry's.  We should let the user
> space figure it out.  Then the application itself can combine and
> render the touches as a contiguous touch screen or as an independent
> touch.
> 
> But we would probably need a way for the kernel driver to identify
> which touch controller that the information came from.
> 
> For multi touch we may be able to use ABS_MT_TRACKING_ID for passing
> up the controller ID but there is not really a good code for the
> standard ABS axes.  Maybe we can make one called ABS_TRACKING_ID to
> keep with the theme.
> 
> This way the user space and use that to know where it came from.
> 
> Or Dmitry if you have any patches or thoughts let me know.
> 

I am confused - you should have 2 device nodes for each pf your
controllers and so you should be able to figure out what device
particular event is coming from. What am I missing here?

Thanks.

-- 
Dmitry
