From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 3/3] Input: goodix - use generic
 touchscreen_properties
Date: Wed, 15 Nov 2017 14:43:56 +0100
Message-ID: <1510753436.2510.22.camel@hadess.net>
References: <20171114124217.2863-1-m.niestroj@grinn-global.com>
         <20171114124217.2863-4-m.niestroj@grinn-global.com>
         <1510670229.2510.17.camel@hadess.net>
         <20171114180330.enmtmi4txedxkyku@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58177 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932852AbdKONn7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Nov 2017 08:43:59 -0500
In-Reply-To: <20171114180330.enmtmi4txedxkyku@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org

On Tue, 2017-11-14 at 10:03 -0800, Dmitry Torokhov wrote:
> On Tue, Nov 14, 2017 at 03:37:09PM +0100, Bastien Nocera wrote:
> > On Tue, 2017-11-14 at 13:42 +0100, Marcin Niestroj wrote:
> > > Use touchscreen_properties structure instead of implementing all
> > > properties by our own. It allows to reuse generic code for
> > > parsing
> > 
> > "It allows reusing"
> > or
> > "It allows us to reuse".
> > 
> > > device-tree properties (which was implemented manually in the
> > > driver
> > > for now). Additionally, it allows us to report events using
> > > generic
> > > touchscreen_report_pos(), which automatically handles inverted
> > > and
> > > swapped axes.
> > 
> > Looks good otherwise. Yay for code removal.
> 
> I am sorry, but I am confused as to why we had to go through all this
> pain fixing the custom code in the driver and then replacing it all
> with
> touchscreen helpers?
> 
> If generic code is shorter and also fixed the bug I do not see the
> reason for intermediate steps...

Patch 2 and 3 can probably be melded. I'm guessing that an intermediate
 change makes it more obvious what the fixes are, and could help with
backporting. Up to you.
