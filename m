From: Wang Yafei <wangyafei@goodix.com>
Subject: Re: [PATCH] dt-bindings: input: Add the Goodix GTx5 series
 Touchscreen devicetree bindings
Date: Tue, 20 Jun 2017 16:53:46 +0800
Message-ID: <20170620085346.GA9345@andrew-dell>
References: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
 <1497911109.2559.2.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Mailgw01.goodix.com ([58.250.26.195]:2220 "EHLO
        barracuda.goodix.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751095AbdFTI7Y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 04:59:24 -0400
Content-Disposition: inline
In-Reply-To: <1497911109.2559.2.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

On Tue, Jun 20, 2017 at 12:25:09AM +0200, Bastien Nocera wrote:
> On Mon, 2017-06-19 at 18:40 +0800, Wang Yafei wrote:
> > Signed-off-by: Wang Yafei <wangyafei@goodix.com>
> > ---
> >  .../bindings/input/touchscreen/goodix-gtx5.txt     | 75
> > ++++++++++++++++++++++
> 
> Where was the driver sent? I didn't see it on linux-input. Why wasn't
> this support added to the goodix driver instead?

Hi, Bastien,
I'm sorry for confused you. I have posted two patches one is touchscreen
driver another is this dt-bindings. The driver is under reviewing and hasn't
been applied to linux-input. Finally thanks for you advice I'll try add a
patch in ./bindings/input/touchscreen/goodix.txt rather than add a new file.
