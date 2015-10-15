From: Julien Grall <julien.grall@citrix.com>
Subject: Re: [PATCH] xen: check return value of xenbus_printf
Date: Thu, 15 Oct 2015 19:20:16 +0100
Message-ID: <561FEE60.7080308@citrix.com>
References: <1444926315-29106-1-git-send-email-wuninsu@gmail.com>
	<561FD717.9090807@citrix.com>
 <CAGoFzNeiu0sNXUh_JtGp8_HWA+k5xq9s-D4qFqU43Vgm=bYiiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:59804 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbbJOSVn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 14:21:43 -0400
In-Reply-To: <CAGoFzNeiu0sNXUh_JtGp8_HWA+k5xq9s-D4qFqU43Vgm=bYiiA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>, David Vrabel <david.vrabel@citrix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Liu <wei.liu2@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, huaixin.chx@alibaba-inc.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Taesoo Kim <taesoo@gatech.edu>, Yeongjin Jang <yeongjin.jang@gatech.edu>, "Yun, Insu" <insu@gatech.edu>

Hi Insu,

On 15/10/15 19:12, Insu Yun wrote:
> 
> 
> On Thu, Oct 15, 2015 at 12:40 PM, David Vrabel <david.vrabel@citrix.com
> <mailto:david.vrabel@citrix.com>> wrote:
> 
>     On 15/10/15 17:25, Insu Yun wrote:
>     > Internally, xenbus_printf uses memory allocation, so it can be failed in
>     > memory pressure.Therefore, xenbus_printf's return should be checked
>     > and properly handled.
>     [...]
>     > --- a/drivers/input/misc/xen-kbdfront.c
>     > +++ b/drivers/input/misc/xen-kbdfront.c
>     > @@ -129,8 +129,11 @@ static int xenkbd_probe(struct xenbus_device *dev,
>     >
>     >       if (xenbus_scanf(XBT_NIL, dev->otherend, "feature-abs-pointer", "%d", &abs) < 0)
>     >               abs = 0;
>     > -     if (abs)
>     > -             xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
>     > +     if (abs) {
>     > +             ret = xenbus_printf(XBT_NIL, dev->nodename, "request-abs-pointer", "1");
>     > +             if (ret)
> 
>     > +                     pr_warning("xenkbd: can't request abs-pointer");
> 
> 
> This error handling is from other code .
> I am not sure that it is right error handling.
>  
> 
> 
>     I think you want abs = 0 here or input device will be configured as
>     absolute but the backend will supply relative coordinates.
> 
> 
> I cannot understand

If the frontend is not able to write the node "request-abs-pointer" in
the xenstore, the backend will always supply relative coordinates.

Although, as abs = 1, the frontend will be configured to handle absolute
coordinate. So the backend and frontend won't be able to understand each
other.

So you have to set abs to 0 if xebus_printf fails.

Regards,

-- 
Julien Grall
