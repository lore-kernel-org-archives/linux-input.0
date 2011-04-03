From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Sun, 3 Apr 2011 10:21:26 +0200
Message-ID: <201104031021.26509.alexander.stein@informatik.tu-chemnitz.de>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de> <201104021031.53430.alexander.stein@informatik.tu-chemnitz.de> <20110403042305.GB24788@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:35690 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab1DCIVU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Apr 2011 04:21:20 -0400
In-Reply-To: <20110403042305.GB24788@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dimitry,

On Sunday 03 April 2011 06:23:05 Dmitry Torokhov wrote:
> On Sat, Apr 02, 2011 at 10:31:53AM +0200, Alexander Stein wrote:
> > Hello Dimitry,
> > 
> > On Wednesday 16 March 2011 07:36:18 Dmitry Torokhov wrote:
> > > On Tue, Mar 15, 2011 at 02:13:49PM +0100, Alexander Stein wrote:
> > > > On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> > > > > This patch adds a generic driver for slide switches connected to
> > > > > GPIO pins of a system. It requires gpiolib and generic hardware
> > > > > irqs.
> > > 
> > > Hm, can't it be merged with gpio_keys? Just add the 'value' to the
> > > gpio_keys_button structure that would be valid for EV_ABS (or even
> > > EV_REL) types. Debouncing should filter out jittery events...
> > 
> > Sorry, for no answer long time.
> > I just tried merging both. The problem i noticed is that the PGIO
> > interrupts are independable and each GPIO will generate an event, which
> > is wrong. Assume the switch state change from position 2 to 1 it will
> > actually generate lots of interrupts: e.g. 2, 1, 2, 1.
> > Depending from the order of such interrupts the last event shows a
> > possible wrong position.
> 
> However at some point the output should stabilize. Does not setting
> appropriate debouncing interval help here?

Well, a debounce interval will prevent to get events for position 2, 1, 2, 1 
(from the example above). You will get only 2 and 1.
The debounce will only decrease the amount of events for _each_ GPIO 
interrupt. It will not prevent GPIO interrupts from different pins while moving 
the switch one position.

Alexander
