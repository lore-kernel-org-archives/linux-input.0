From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: No way to turn avoid building HID drivers
Date: Sat, 8 Aug 2009 01:41:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908080138430.25797@wotan.suse.de>
References: <Pine.LNX.4.44L0.0907281049560.5214-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58684 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757129AbZHGXlB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Aug 2009 19:41:01 -0400
In-Reply-To: <Pine.LNX.4.44L0.0907281049560.5214-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Tue, 28 Jul 2009, Alan Stern wrote:

> The current Kconfig settings for many of the special HID drivers don't 
> offer any way to avoid building them unless CONFIG_EMBEDDED is on.  For 
> example:
> 
> config HID_A4TECH
> 	tristate "A4 tech" if EMBEDDED
> 	depends on USB_HID
> 	default !EMBEDDED
> 	---help---
> 	Support for A4 tech X5 and WOP-35 / Trust 450L mice.
> 
> Without CONFIG_EMBEDDED, the tristate doesn't take effect.  Hence the 
> symbol isn't controllable by the user and Kbuild initializes it to the 
> !EMBEDDED setting.
> 
> Should the tristate line say "if !EMBEDDED"?  Or was it your intention 
> that all these drivers should always be built whenever CONFIG_USB_HID 
> is on?

[ sorry for late reply, I have been on vacation, totally offline, for two 
  weeks ]

Hi Alan,

actually this question has been raised by several people in the past 
already. Copy/pasting the latest reply I have sent on this topic

===
mostly this is because we don't want to bother users with asking for every
single quirky device/vendor, as there are unfortunately a lot of them.
Usually compiling everything in doesn't waste runtime footprint (the
modules don't get loaded unless needed), and they don't cost too much disk
space either.
And if you really want to disable them, CONFIG_EMBEDDED allows you to do
that.

Please see last paragraph on

        http://lkml.org/lkml/2008/10/14/284

===

-- 
Jiri Kosina
SUSE Labs
