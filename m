From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: Add support for Hanwang tablet
Date: Wed, 1 Sep 2010 23:24:04 -0700
Message-ID: <20100902062403.GA10087@core.coreip.homeip.net>
References: <201009021229501252232@hanwang.com.cn>
 <20100902062030.GA9416@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65131 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab0IBGYJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 02:24:09 -0400
Content-Disposition: inline
In-Reply-To: <20100902062030.GA9416@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xing Wei <weixing@hanwang.com.cn>
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jkosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@redhat.com>, Ping Cheng <pingc@wacom.com>

On Wed, Sep 01, 2010 at 11:20:30PM -0700, Dmitry Torokhov wrote:
> On Thu, Sep 02, 2010 at 12:29:50PM +0800, Xing Wei wrote:
> > On Wed, Sep 01, 2010 mitry Torokhov wrote:
> > > Hi Xing,
> > > 
> > > On Wed, Sep 01, 2010 at 02:55:44PM +0800, Xing Wei wrote:
> > > > Hi Dmitry, it works well and I really appreciate your work. 
> > > > BTN_3 - BTN_8 & ABS_DISTANCE events are not handled & used in our X system driver by now,
> > > > sorry for my mistake.
> > > >
> > > 
> > > Just to avoid confusion - are BTN_3 - BTN_8 not used by your X driver or
> > > the hardware does not really report them? Because if it the former then
> > > we should continue reporting them - some other user (as in
> > > program/driver) might be interested in these.
> > > 
> > > Also, why do you develop your own X driver? Does not X's evdev driver
> > > work properly for you?
> > > 
> > > Thanks.
> > >  
> > > 
> > 
> > Hi Dmitry, the hardware does really report BTN_3 - BTN_8.
> 
> OK, then we should keep reporting them then. I will add the patch to my
> 'next' branch and it should show up in 2.6.37.
> 
> > And I try to let the evdev driver(remove my X driver & .conf file ) take over the device,
> > but seem like it has no reflection to the pressure and roll wheel pad,just run like a generic mouse.
> > 
> 
> Then I suggest looking into modifying evdev so that it properly works
> with your device. I think Peter Hutterer (CCed) is the man you need to
> talk to.
> 

Hmm, another option is maybe getting wacom X driver to work with your
device.

-- 
Dmitry
