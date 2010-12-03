From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 07:03:12 -0600
Message-ID: <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
	<20101202212223.GA9864@core.coreip.homeip.net>
	<AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
	<20101203124240.GH3182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:52319 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab0LCNKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 08:10:34 -0500
Received: by ewy10 with SMTP id 10so5435043ewy.4
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 05:10:33 -0800 (PST)
In-Reply-To: <20101203124240.GH3182@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 3, 2010 at 6:42 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> The sysfs interface offered by polldev is *mostly* doing the same thing

True, except that there is still no synchronization of the polling
events between the driver and application.  For example, if the
polling interval is once per second then the sample ultimately
delivered to applications could be almost one second old--- even if
the application reads from the evdev interface once a second as well.

The callback can be used to reduce the delay between sample generation
and event delivery.  It can also increase system load, but reduces
phase error in situations where that is desirable.  I don't expect
that many drivers will use the callback, but for the ones that do it
will be very useful.

> A callback on read seems like it's a bit limited as it's more work for
> the application (handling the latency introduced by waking up from your
> delay and doing the read is faff) and requires polling in the hardware
> too.

Right.  But if the hardware works that way anyway, then the
alternatives seem to boil down to either unsynchronized polling, or
samples-on-demand.  Some applications e.g. mine, really want the
latter.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
