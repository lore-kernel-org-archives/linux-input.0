From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Tue, 5 Apr 2011 11:36:52 -0700
Message-ID: <20110405183651.GD13086@core.coreip.homeip.net>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
 <201104021031.53430.alexander.stein@informatik.tu-chemnitz.de>
 <20110403042305.GB24788@core.coreip.homeip.net>
 <201104031021.26509.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab1DESg5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 14:36:57 -0400
Received: by iwn34 with SMTP id 34so648209iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 11:36:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104031021.26509.alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Sun, Apr 03, 2011 at 10:21:26AM +0200, Alexander Stein wrote:
> Hello Dimitry,
> 
> On Sunday 03 April 2011 06:23:05 Dmitry Torokhov wrote:
> > On Sat, Apr 02, 2011 at 10:31:53AM +0200, Alexander Stein wrote:
> > > Hello Dimitry,
> > > 
> > > On Wednesday 16 March 2011 07:36:18 Dmitry Torokhov wrote:
> > > > On Tue, Mar 15, 2011 at 02:13:49PM +0100, Alexander Stein wrote:
> > > > > On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> > > > > > This patch adds a generic driver for slide switches connected to
> > > > > > GPIO pins of a system. It requires gpiolib and generic hardware
> > > > > > irqs.
> > > > 
> > > > Hm, can't it be merged with gpio_keys? Just add the 'value' to the
> > > > gpio_keys_button structure that would be valid for EV_ABS (or even
> > > > EV_REL) types. Debouncing should filter out jittery events...
> > > 
> > > Sorry, for no answer long time.
> > > I just tried merging both. The problem i noticed is that the PGIO
> > > interrupts are independable and each GPIO will generate an event, which
> > > is wrong. Assume the switch state change from position 2 to 1 it will
> > > actually generate lots of interrupts: e.g. 2, 1, 2, 1.
> > > Depending from the order of such interrupts the last event shows a
> > > possible wrong position.
> > 
> > However at some point the output should stabilize. Does not setting
> > appropriate debouncing interval help here?
> 
> Well, a debounce interval will prevent to get events for position 2, 1, 2, 1 
> (from the example above). You will get only 2 and 1.

No, if the switch settles in position 2 then we will report only 2. I.e.
if you set debounce interval for 200 msecs for all gpios at the end of
this period gpio representing "1" position will not be active so you
will not send any event for it. The gpio representing "2" will still be
active and thus you will send ABS_whatever/2.

> The debounce will only decrease the amount of events for _each_ GPIO 
> interrupt. It will not prevent GPIO interrupts from different pins while moving 
> the switch one position.

It will not prevent interrupts but should prevent unstable events. It
might be beneficial if you posted the code you tried and we'd see why
debouncing does not work for you.

Thanks.

-- 
Dmitry
