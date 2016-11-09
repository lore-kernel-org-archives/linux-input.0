From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: gpio_keys - Also send release events for ABS
 codes
Date: Tue, 8 Nov 2016 16:09:49 -0800
Message-ID: <20161109000949.GB8719@dtor-ws>
References: <20161101102504.3783-1-paul@crapouillou.net>
 <20161101102504.3783-2-paul@crapouillou.net>
 <20161103162159.GB15366@dtor-ws>
 <56a0750b-c0f6-1fad-c730-11213dd64a97@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34979 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbcKIAJw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 19:09:52 -0500
Content-Disposition: inline
In-Reply-To: <56a0750b-c0f6-1fad-c730-11213dd64a97@crapouillou.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>

On Sat, Nov 05, 2016 at 12:58:00PM +0100, Paul Cercueil wrote:
> On 03/11/2016 17:21, Dmitry Torokhov wrote:
> >On Tue, Nov 01, 2016 at 11:25:03AM +0100, Paul Cercueil wrote:
> >>Right now, the gpio-keys driver is mostly used with EV_KEY event types.
> >>However, this driver (and its devicetree bindings) support specifying
> >>a different input type, like EV_ABS, even though this doesn't work in
> >>practice: "key pressed" events are correctly received and treated, but
> >>"key released" are silently ignored.
> >>
> >>With this commit, keys configured as EV_ABS will inject an event with
> >>the value 0 when released.
> >No, this will break setups like this:
> >
> >gpio0 - ABS_X - 0
> >gpio1 - ABS_X - 1
> >gpio2 - ABS_X - 2
> >...
> >gpio7 - ABS_X - 7
> >
> >- something like a slider built on top of gpios.
> 
> So what would you suggest for the implementation of a hat / d-pad on
> top of GPIOs?

Maybe we should allow specifying "release" value for ABS GPIOs.

Thanks.

-- 
Dmitry
