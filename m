From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH RFC 3/4] input: add a EV_SW event for ratchet switch
Date: Tue, 28 Mar 2017 06:36:47 -0300
Message-ID: <20170328063647.00a83748@vento.lan>
References: <cover.1490481944.git.mchehab@s-opensource.com>
        <c48652786b1e139503834f67b1a5037ff677a174.1490481944.git.mchehab@s-opensource.com>
        <20170327015357.GE21915@jelly>
        <20170327092731.3fd5db9a@vento.lan>
        <20170328002517.GA12967@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:38142
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754217AbdC1Jhc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Mar 2017 05:37:32 -0400
In-Reply-To: <20170328002517.GA12967@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Stuart Yoder <stuart.yoder@nxp.com>, Hans Verkuil <hans.verkuil@cisco.com>, Douglas Anderson <dianders@chromium.org>, Ping Cheng <pinglinux@gmail.com>, Kamil Debski <kamil@wypas.org>

Em Tue, 28 Mar 2017 10:25:17 +1000
Peter Hutterer <peter.hutterer@who-t.net> escreveu:

> On Mon, Mar 27, 2017 at 09:27:31AM -0300, Mauro Carvalho Chehab wrote:
> > Em Mon, 27 Mar 2017 11:53:57 +1000
> > Peter Hutterer <peter.hutterer@who-t.net> escreveu:
> >   
> > > On Sat, Mar 25, 2017 at 07:49:41PM -0300, Mauro Carvalho Chehab wrote:  
> > > > Some mouses have a switch on their wheel, allowing to switch
> > > > between ratchet or free wheel mode. Add support for it.    
> > > 
> > > I understand the want to support it because it's there but what do you
> > > expect this to be used for?
> > > 
> > > tbh, I wouldn't know what to do with this information, short of displaying
> > > some OSD to inform the user. Which is rather superfluous since the physical
> > > change will feel obvious anyway.  
> > 
> > For this particular device, the main reason is because it is there :-)
> > As adding support for it is trivial, I don't see any reason why not
> > adding it.
> > 
> > Yet, applications could use it, in order to switch between a "discrete" 
> > mode, where one wheel position corresponds to one line of scroll, and
> > movements below a threshold would be ignored.  
> 
> fwiw, that would more likely be the  result of receiving a different event
> code (hires-wheel), more so than a ratchet switch - at least on this device.

Yeah, that would be another alternative.

> the mice I have here don't change the behaviour of the wheel, so the
> granularity is the same before and after. But they also don't send events
> for the state, so there's that :)

Another alternative would be that applications could be listening to
EV_SW SW_RATCHET event. When the switch changes to free wheel, it could
be enabling high-resolution mode.

Thanks,
Mauro
