From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Generic implementation for Input enable disable methods
Date: Mon, 1 Feb 2010 00:59:01 -0800
Message-ID: <20100201085901.GC24188@core.coreip.homeip.net>
References: <1263968920.18053.24.camel@4fid08082>
 <1264141700.2889.14.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:52429 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab0BAI7I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2010 03:59:08 -0500
Received: by pzk2 with SMTP id 2so4049807pzk.21
        for <linux-input@vger.kernel.org>; Mon, 01 Feb 2010 00:59:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264141700.2889.14.camel@4fid08082>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Onkalo Samu <samu.p.onkalo@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Westerberg Mika.1" <ext-mika.1.westerberg@nokia.com>, "Nikula Jani.1" <ext-jani.1.nikula@nokia.com>

On Fri, Jan 22, 2010 at 08:28:20AM +0200, Onkalo Samu wrote:
> On Wed, 2010-01-20 at 07:28 +0100, Onkalo Samu.P (Nokia-D/Tampere)
> wrote:
> > Hi
> > 
> > Some time ago, there were two parallel implementation proposals for
> > disabling input devices. See following email:
> > http://www.spinics.net/lists/linux-input/msg05984.html
> > 
> > It was asked to combine these two to have generic interface.
> > I'm proposing following sysfs interface:
> > 
> > ../input0/disable/avail_xx
> > ../input0/disable/disable_xx
> > 
> > So, new directory for disable control entries. Own entries for each
> > of the events or event group. Implementation is using bitmap format:
> > 
> > Examples
> > 
> > See what event groups can be disabled. Disable and enable all the groups
> > # cat avail_ev
> > 0-1,4,20
> > # echo "0-1,4,20" > disable_ev
> > # cat disable_ev
> > 0-1,4,20
> > # echo -e "\0" > disable_ev
> > # cat disable_ev
> >  
> > See what individual events can be disabled. Disable and enable one of
> > them:
> > # cat avail_key
> > 528
> > # echo "528" > disable_key
> > # cat disable_key
> > 528
> > # echo -e "\0" -> disable_key
> > # cat disable_key
> > 
> 
> After some playing with this interface it is quite clear that this is
> not very user friendly. To have better usability, I'll change my
> proposal to following one:
> 
> Entries are changed to this format:
> .../inputx/disable/enable_xx
> .../inputx/disable/disable_xx
> (no avail_xx anymore)
> 
> Use:
> echo "1,2" > disable_xx  disable events 1 and 2
> echo "" > disable_xx   do nothing
> cat disable_xx   list of currently disabled entries
> 
> echo "4-5" > enable_xx enable events 4,5,6
> echo "" > enable_xx  do nothing
> cat enable_xx   list of currenty enabled entries
> 
> Read operation returns only events which can be controlled via this
> interface.
> 
> Enable all currently disabled events:
> cat disable_xx > enable_xx
> 
> Disable all currently enabled events:
> cat enable_xx > disable_XX
> 

Hi Samu,

I still believe that the only thing we need (apart of special plumbing in
gpio-keys) is a way for userspace clients to subsribe on unsubscribe
from certain events rather than device-wide configuration. This way we
can avoid waking up processes that are not interested in some of the
events.

Thanks.

-- 
Dmitry
