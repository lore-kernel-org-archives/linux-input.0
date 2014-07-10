From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] GPIO button wth wakeup attribute is supposed to wake the system up
Date: Thu, 10 Jul 2014 13:27:02 +0200
Message-ID: <1614271.1peg23gJZx@vostro.rjw.lan>
References: <53A2340D.9030503@linux.intel.com> <4301161.i6ArOLmcsg@vostro.rjw.lan> <53BDFA22.2000409@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60724 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751083AbaGJLIz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 07:08:55 -0400
In-Reply-To: <53BDFA22.2000409@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, July 10, 2014 10:27:46 AM Li, Aubrey wrote:
> On 2014/7/9 20:45, Rafael J. Wysocki wrote:
> > On Tuesday, July 08, 2014 05:54:35 PM Dmitry Torokhov wrote:
> >> On Wed, Jul 09, 2014 at 02:59:33AM +0200, Rafael J. Wysocki wrote:
> >>> On Tuesday, July 08, 2014 05:15:06 PM Dmitry Torokhov wrote:
> >>>> On Wed, Jul 09, 2014 at 01:06:07AM +0200, Rafael J. Wysocki wrote:
> > 
> > [cut]
> > 
> >>>>
> >>>> When device driver marks IRQ as a wakeup source I believe it is prepared
> >>>> to handle it (or it would shut it off explicitly).
> >>>
> >>> I can agree with that.
> >>>
> >>> Are you suggesting that __disable_irq() should check irq_data for
> >>> IRQD_WAKEUP_STATE and skip the IRQ (in the 'suspend' case) if that is set?
> >>
> >> Yes, something like that.
> > 
> > OK
> 
> Many thanks to you both for the discussion.
> > 
> > Aubrey, can you please check if the appended patch helps on the T100?
> 
> I verified this patch on T100, it works as expected, freeze can be waken
> up by reverting my patch and applying this one.

Thanks!

> Is this a final solution?

I hope so.  I'll resend it with a proper changelog later today.

Rafael

