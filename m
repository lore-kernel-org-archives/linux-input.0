From: Olivier Gay <ogay@logitech.com>
Subject: Re: [PATCH] HID: add missing hid usages
Date: Wed, 23 Apr 2014 11:37:17 +0200
Message-ID: <CAFLMSp-S9rh+i7VkX-gEdjjdrjPDZN_2=rGqLVWo=kPLBcUprw@mail.gmail.com>
References: <1396623746-1416-1-git-send-email-ogay@logitech.com>
 <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz> <20140423000457.GA22183@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:55901 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836AbaDWJhk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 05:37:40 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so826039wib.10
        for <linux-input@vger.kernel.org>; Wed, 23 Apr 2014 02:37:38 -0700 (PDT)
In-Reply-To: <20140423000457.GA22183@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Wed, Apr 23, 2014 at 2:04 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Apr 07, 2014 at 09:49:52AM +0200, Jiri Kosina wrote:
>> > +#define KEY_BRIGHTNESS             0x250   /* Display Brightness */
>
> What is it supposed to do exactly? Show OSD for brightness?

No, it's a linear control usage to (HUTTR41) "Sets brightness to a
value between logical min and max.". I'm changing the comment to /*
Set Brightness */.

>> > +#define KEY_BRIGHTNESS_TOGGLE              0x251   /* Backlight Toggle */
>
> We already have KEY_DISPLAYTOGGLE, isn't this the same?

I agree, they are the same and we should alias it to
KEY_DISPLAYTOGGLE. I'm sending a v2 patch.

Best regards,

Olivier
