From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: gpio-keys: do not reference platform_data after .probe exits
Date: Mon, 18 Jul 2011 10:24:21 -0700
Message-ID: <201107181024.22134.dmitry.torokhov@gmail.com>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org> <201107181002.45170.dmitry.torokhov@gmail.com> <CACxGe6tFt4h-iVjM26BdD9oLj2Zd+z8i1naR0YU3AbLtGzmXgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37759 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab1GRRY1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 13:24:27 -0400
Received: by iwn6 with SMTP id 6so3282178iwn.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 10:24:27 -0700 (PDT)
In-Reply-To: <CACxGe6tFt4h-iVjM26BdD9oLj2Zd+z8i1naR0YU3AbLtGzmXgA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Phil Blundell <pb@handhelds.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Monday, July 18, 2011 10:15:27 AM Grant Likely wrote:
> On Mon, Jul 18, 2011 at 11:02 AM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
> >> The patch makes a copy of platform data into driver data, so that any
> >> reference to platform_data after .probe exits can be avoided.
> > 
> > And why is this beneficial? I am of the opinion that platform data
> > should stay on (and be accessed through a const pointer to ensure
> > that the driver will not alter it).
> 
> Because when using the device tree, there is no platform_data.
>

So allocate it... That's what Davids patch does. BTW, you never gave
ACK for the final version and I'd prefer to have it for the DT bindings.

Thanks.

-- 
Dmitry
