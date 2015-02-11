From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] GPIO joystick driver
Date: Wed, 11 Feb 2015 10:06:38 -0800
Message-ID: <20150211180638.GB29440@dtor-ws>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1AA6C46C-36D9-4243-9DC5-254A7202D339@gmail.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF04@irsmsx105.ger.corp.intel.com>
 <20150207204658.GA29015@dtor-ws>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6B24F@irsmsx105.ger.corp.intel.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6BB34@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:39208 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbbBKSGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 13:06:44 -0500
Content-Disposition: inline
In-Reply-To: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6BB34@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Holmberg, Hans" <hans.holmberg@intel.com>
Cc: "'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

On Wed, Feb 11, 2015 at 08:49:16AM +0000, Holmberg, Hans wrote:
> > > > As far as I can tell, there is no way to specify values for ABS-"keys"
> > > > in the device tree binding.
> > >
> > > It may not be present in device tree binding, but the driver does
> > > support it, so I would rather extend the binding than have a brand new
> > driver.
> > 
> > All right, I find it a bit like whacking a round peg down a square hole, but I'll
> > head down that path and see where it leads.
> > 
> 
> This is what I've found:
> 
> A digital joystick driver needs to report three states per axis: min,
> max and neutral. The hardware only have two signals per axis(i.e. up
> and down) however. See http://wiki.icomp.de/wiki/DB9-Joystick 
> 
> This makes gpio-keys pretty much impossible to use for joysticks - as
> the driver only reports abs-events when a button/key is pressed, how
> would the neutral state be reported?  (as there is no signal for
> "neutral")
> 
> Even if through some hackery the driver would be modified to report a
> special neutral event if all  "buttons/keys" for that axis are not
> pressed, what value should be reported?  An average of the values for
> that axis?   Also, reporting such an implicit neutral event would
> break the behavior of existing abs-reporting instances, right?

You have 2 gpio per axis, and since you can't measure how "far" down the
axis you have moved the driver should only report values -1, 0, 1 per
axis. You start at neutral position, and move right. IRQ for right gpio
is fired and you report EV_ABS/ABS_X/1. Then you start moving to the
left, gpio IRQ fires (you want it to trigger on both edges) and you
report EV_ABS/ABS_X/0. You continue moving to the left and IRQ for left
gpio fires up and you report EV_ABS/ABS_X/-1.

This assumes that you assign EV_ABS/ABS_X and value 1 for right gpio and
EV_ABS/ABS_X and value -1 for left gpio.

Thanks.

-- 
Dmitry
