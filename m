From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Thu, 18 Feb 2010 13:52:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002181352010.30967@pobox.suse.cz>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>  <alpine.LNX.2.00.1002171333460.30967@pobox.suse.cz> <1266497417.4787.2923.camel@tema>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349Ab0BRMw4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 07:52:56 -0500
In-Reply-To: <1266497417.4787.2923.camel@tema>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 18 Feb 2010, Jari Vanhala wrote:

> On Wed, 2010-02-17 at 13:41 +0100, ext Jiri Kosina wrote:
> > On Wed, 17 Feb 2010, Jari Vanhala wrote:
> > As the device doesn't seem to be registering itself on the HID bus at all, 
> > I am not sure we want to put it together with all the HID drivers. Maybe 
> > drivers/input/misc would be more appropriate?
> 
> I felt like I forgot something.. Well, moving it to input/misc is easy
> (commit attached), but I (still) wanted to try getting it to use
> hid-functions. Results weren't that nice. Looking hid-core just shows,
> it's thought to connect (hotplug) usb or bt devices and i2c doesn't fit
> nicely to that. Making it to use hid_allocate_device(), hid_connect()
> etc takes actually more code..

Well, the major differentiator should be whether the "on-the-wire" the 
protocol is using is (or at least tries to be in some aspects) 
HID standard compliant.

Which, as far as I understand, is not the case here.

> Leaving it as-is in hid would look little odd, so probably moving it to
> drivers/input/misc is best thing. What you think? Dmitry?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
