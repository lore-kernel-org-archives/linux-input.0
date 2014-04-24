From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add missing hid usages
Date: Thu, 24 Apr 2014 16:26:24 -0700
Message-ID: <20140424232624.GA3782@core.coreip.homeip.net>
References: <1396623746-1416-1-git-send-email-ogay@logitech.com>
 <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz>
 <20140423000457.GA22183@core.coreip.homeip.net>
 <CAFLMSp-S9rh+i7VkX-gEdjjdrjPDZN_2=rGqLVWo=kPLBcUprw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45421 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbaDXX03 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2014 19:26:29 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so2454974pbb.8
        for <linux-input@vger.kernel.org>; Thu, 24 Apr 2014 16:26:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFLMSp-S9rh+i7VkX-gEdjjdrjPDZN_2=rGqLVWo=kPLBcUprw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Gay <ogay@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Wed, Apr 23, 2014 at 11:37:17AM +0200, Olivier Gay wrote:
> On Wed, Apr 23, 2014 at 2:04 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Apr 07, 2014 at 09:49:52AM +0200, Jiri Kosina wrote:
> >> > +#define KEY_BRIGHTNESS             0x250   /* Display Brightness */
> >
> > What is it supposed to do exactly? Show OSD for brightness?
> 
> No, it's a linear control usage to (HUTTR41) "Sets brightness to a
> value between logical min and max.". I'm changing the comment to /*
> Set Brightness */.

Then it does not make sense to expose it as a key - how system should
respond to such event? Pick a random value?

If we really need to support this we need ABS_BRIGHTNESS, like we have
ABS_VOLUME.

Thanks.

-- 
Dmitry
