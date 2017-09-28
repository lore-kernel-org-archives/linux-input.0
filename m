From: "DISTEC Inan, Ahmet" <Inan@distec.de>
Subject: Re: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Thu, 28 Sep 2017 15:42:18 +0200
Message-ID: <20170928134218.o2bkd5ignrgzahzi@dev-ai1.datadisplay.de>
References: <20170920135129.10283-1-inan@distec.de>
 <20170921211551.GB15858@dtor-ws>
 <20170922124852.2bsx45jeqye6qcss@dev-ai1.datadisplay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:29637 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbdI1NmU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Sep 2017 09:42:20 -0400
Content-Disposition: inline
In-Reply-To: <20170922124852.2bsx45jeqye6qcss@dev-ai1.datadisplay.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ahmet Inan <xdsopl@gmail.com>

Dear Dmitry,

> > > It is important not to rely on the i2c_master_recv return value:
> > > Ignoring failed transfers sometimes causes hanging touch events, as the
> > > controller thinks that the transfer succeeded and won't resend the event.
> > 
> > This statement worries me, because you are basically end up reporting
> > garbage. Does the controller sends all active contacts in each frame, or
> > only changed ones? You can use INPUT_MT_DROP_UNUSED to let input core
> > automatically drop contacts that were not reported within the last
> > frame. And fire up a timer to release everything if last transfer errors
> > out.
> Thank you for the suggestions. I indeed felt uncomfortable about
> ignoring the return value of i2c_master_recv() but INPUT_MT_DROP_UNUSED
> helped and now it works awesome!
I've just got another EXC3000-Controller-Board to play with and it looks
like I need to add that timer you suggested:
I still get sporadically hanging touches with this one :(
So I will send you another patch the moment I figured out how.

Best Regards,

Ahmet

