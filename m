From: Olivier Gay <ogay@logitech.com>
Subject: Re: [PATCH] HID: add missing hid usages
Date: Fri, 25 Apr 2014 10:10:54 +0200
Message-ID: <CAFLMSp_y0TnmoJhUghJztxw7JK1WwW+Hp-3e6D9o+7YZf8LqYA@mail.gmail.com>
References: <1396623746-1416-1-git-send-email-ogay@logitech.com>
 <alpine.LNX.2.00.1404070949020.8157@pobox.suse.cz> <20140423000457.GA22183@core.coreip.homeip.net>
 <CAFLMSp-S9rh+i7VkX-gEdjjdrjPDZN_2=rGqLVWo=kPLBcUprw@mail.gmail.com> <20140424232624.GA3782@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:41569 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106AbaDYILQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 04:11:16 -0400
Received: by mail-yh0-f53.google.com with SMTP id i57so3223280yha.26
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2014 01:11:14 -0700 (PDT)
In-Reply-To: <20140424232624.GA3782@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Fri, Apr 25, 2014 at 1:26 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Apr 23, 2014 at 11:37:17AM +0200, Olivier Gay wrote:
>> On Wed, Apr 23, 2014 at 2:04 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Mon, Apr 07, 2014 at 09:49:52AM +0200, Jiri Kosina wrote:
>> >> > +#define KEY_BRIGHTNESS             0x250   /* Display Brightness */
> Then it does not make sense to expose it as a key - how system should
> respond to such event? Pick a random value?

Yes, I also noticed that after sending v2. We would also need to
pass/use the linear control value.

> If we really need to support this we need ABS_BRIGHTNESS, like we have
> ABS_VOLUME.

This is not absolutely needed and the other display brightness usages
are more important (like increment, decrement or toggle). I'm sending
a new v3 without this usage.

Best regards,

Olivier
