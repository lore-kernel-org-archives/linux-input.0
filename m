From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Sat, 2 Apr 2011 21:23:05 -0700
Message-ID: <20110403042305.GB24788@core.coreip.homeip.net>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
 <201103151413.50042.alexander.stein@informatik.tu-chemnitz.de>
 <20110316063617.GG14604@core.coreip.homeip.net>
 <201104021031.53430.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58254 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab1DCEXK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Apr 2011 00:23:10 -0400
Received: by iwn34 with SMTP id 34so4725359iwn.19
        for <linux-input@vger.kernel.org>; Sat, 02 Apr 2011 21:23:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104021031.53430.alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Cc: linux-input@vger.kernel.org

On Sat, Apr 02, 2011 at 10:31:53AM +0200, Alexander Stein wrote:
> Hello Dimitry,
> 
> On Wednesday 16 March 2011 07:36:18 Dmitry Torokhov wrote:
> > On Tue, Mar 15, 2011 at 02:13:49PM +0100, Alexander Stein wrote:
> > > On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> > > > This patch adds a generic driver for slide switches connected to GPIO
> > > > pins of a system. It requires gpiolib and generic hardware irqs.
> 
> > Hm, can't it be merged with gpio_keys? Just add the 'value' to the
> > gpio_keys_button structure that would be valid for EV_ABS (or even
> > EV_REL) types. Debouncing should filter out jittery events...
> 
> Sorry, for no answer long time.
> I just tried merging both. The problem i noticed is that the PGIO interrupts 
> are independable and each GPIO will generate an event, which is wrong.
> Assume the switch state change from position 2 to 1 it will actually generate 
> lots of interrupts: e.g. 2, 1, 2, 1.
> Depending from the order of such interrupts the last event shows a possible 
> wrong position.

However at some point the output should stabilize. Does not setting
appropriate debouncing interval help here?

Thanks.

-- 
Dmitry
