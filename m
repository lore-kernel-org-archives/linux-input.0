From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] dt-bindings: input: Add the Goodix GTx5 series
 Touchscreen devicetree bindings
Date: Tue, 20 Jun 2017 11:17:50 +0200
Message-ID: <1497950270.2559.12.camel@hadess.net>
References: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
         <1497911109.2559.2.camel@hadess.net> <20170620085346.GA9345@andrew-dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33654 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdFTJR5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 05:17:57 -0400
In-Reply-To: <20170620085346.GA9345@andrew-dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wang Yafei <wangyafei@goodix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

On Tue, 2017-06-20 at 16:53 +0800, Wang Yafei wrote:
> On Tue, Jun 20, 2017 at 12:25:09AM +0200, Bastien Nocera wrote:
> > On Mon, 2017-06-19 at 18:40 +0800, Wang Yafei wrote:
> > > Signed-off-by: Wang Yafei <wangyafei@goodix.com>
> > > ---
> > >  .../bindings/input/touchscreen/goodix-gtx5.txt     | 75
> > > ++++++++++++++++++++++
> > 
> > Where was the driver sent? I didn't see it on linux-input. Why
> > wasn't
> > this support added to the goodix driver instead?
> 
> Hi, Bastien,
> I'm sorry for confused you. I have posted two patches one is
> touchscreen
> driver another is this dt-bindings. The driver is under reviewing and
> hasn't
> been applied to linux-input.

But where's the driver? It should have been posted to the linux-input
mailing-list, and I cannot see it there.

>  Finally thanks for you advice I'll try add a
> patch in ./bindings/input/touchscreen/goodix.txt rather than add a
> new file.

That's not what I meant. I wonder about the reason why the existing
driver wasn't extended rather than writing a new one.

Good to see that Goodix is finally upstreaming its drivers though, my
attempts at contacting some of your colleagues fell on deaf ears a
couple of years ago.

Cheers
