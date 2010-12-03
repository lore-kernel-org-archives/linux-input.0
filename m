From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 14:17:36 -0600
Message-ID: <AANLkTim_f9dVdUVRmqO4dVfdta6b3LRbMKZArtON0ggb@mail.gmail.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
	<20101202212223.GA9864@core.coreip.homeip.net>
	<AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
	<20101203124240.GH3182@sirena.org.uk>
	<AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
	<20101203135346.GI3182@sirena.org.uk>
	<AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
	<20101203195030.GB21277@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38019 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab0LCURh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 15:17:37 -0500
Received: by eye27 with SMTP id 27so5318473eye.19
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 12:17:36 -0800 (PST)
In-Reply-To: <20101203195030.GB21277@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

Dmitry:


On Fri, Dec 3, 2010 at 1:50 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Right. The indication that application wants the data is open() call. If
> userspace does not want data, it should close() the interface.

It *does* want the data, just at a specified rate.  And right now, we
have no consistent way of having applications express that rate to the
input device.  A read callback is one, very flexible way of correcting
that.

> Drivers have no idea what users want to do with the data so they can't
> decide whether to ignore the hardware or query it and queue events up.
> Some applications might be interested in "sample on demand", while
> others would prefer events to be queued and consumed at once.

Yep.  We've already covered that.

> [... cut long argument for an inconsistent and incompatible change to
> the interface ...]

I object.

My proposed change is carefully considered to be neither inconsistent
nor incompatible with the current interface.  Existing drivers will
continue to work exactly as they do now.  Future drivers that don't
utilize the read callback will work exactly as conventional drivers do
now.

Certain hardware drivers will want to take advantage of the read
callback, and those drivers will perform differently in ways that some
applications won't care about, and others won't even notice.  And
those drivers will perform usefully for applications that *do* care
about the differences.

I predicted (and welcomed) a lot of constructive challenges to making
a change to such a widely used API.  But your outright hostility isn't
a productive use of anyone's time.

> BTW, if application reads (supplies space for) just one event should we
> disacard the rest of hardware state that we read from the device? You
> know, just asking...

Ridiculously hypothetical, distracting and unrelated question, but
I'll answer it anyway.  If the application wants more than one event,
it had better make room for them.  As for the events that remain in
the queue, if any: that depends on how the driver works.  Just like it
does today.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
