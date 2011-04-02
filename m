From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Sat, 2 Apr 2011 10:31:53 +0200
Message-ID: <201104021031.53430.alexander.stein@informatik.tu-chemnitz.de>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de> <201103151413.50042.alexander.stein@informatik.tu-chemnitz.de> <20110316063617.GG14604@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jessica.hrz.tu-chemnitz.de ([134.109.132.47]:51207 "EHLO
	jessica.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753988Ab1DBIb4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Apr 2011 04:31:56 -0400
In-Reply-To: <20110316063617.GG14604@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dimitry,

On Wednesday 16 March 2011 07:36:18 Dmitry Torokhov wrote:
> On Tue, Mar 15, 2011 at 02:13:49PM +0100, Alexander Stein wrote:
> > On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> > > This patch adds a generic driver for slide switches connected to GPIO
> > > pins of a system. It requires gpiolib and generic hardware irqs.

> Hm, can't it be merged with gpio_keys? Just add the 'value' to the
> gpio_keys_button structure that would be valid for EV_ABS (or even
> EV_REL) types. Debouncing should filter out jittery events...

Sorry, for no answer long time.
I just tried merging both. The problem i noticed is that the PGIO interrupts 
are independable and each GPIO will generate an event, which is wrong.
Assume the switch state change from position 2 to 1 it will actually generate 
lots of interrupts: e.g. 2, 1, 2, 1.
Depending from the order of such interrupts the last event shows a possible 
wrong position.
This can only be avoided if each GPIO interrupt starts the same state checking 
routine. Thus reading the GPIO pin state and report just one event.
Some ideas to still merge those drivers?

Regards,
Alexander
