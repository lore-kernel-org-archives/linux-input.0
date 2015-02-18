From: "Holmberg, Hans" <hans.holmberg@intel.com>
Subject: RE: [PATCH 0/2] GPIO joystick driver
Date: Wed, 18 Feb 2015 08:42:27 +0000
Message-ID: <4B6D6D87A8FB62428BE0A3E38461A1AB18D7A2D0@irsmsx105.ger.corp.intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1AA6C46C-36D9-4243-9DC5-254A7202D339@gmail.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF04@irsmsx105.ger.corp.intel.com>
 <20150207204658.GA29015@dtor-ws>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6B24F@irsmsx105.ger.corp.intel.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6BB34@irsmsx105.ger.corp.intel.com>
 <20150211180638.GB29440@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22827 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbbBRImb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 03:42:31 -0500
In-Reply-To: <20150211180638.GB29440@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

> > A digital joystick driver needs to report three states per axis: min,
> > max and neutral. The hardware only have two signals per axis(i.e. up
> > and down) however. See http://wiki.icomp.de/wiki/DB9-Joystick
> >
> > This makes gpio-keys pretty much impossible to use for joysticks - as
> > the driver only reports abs-events when a button/key is pressed, how
> > would the neutral state be reported?  (as there is no signal for
> > "neutral")
> >
> > Even if through some hackery the driver would be modified to report a
> > special neutral event if all  "buttons/keys" for that axis are not
> > pressed, what value should be reported?  An average of the values for
> > that axis?   Also, reporting such an implicit neutral event would
> > break the behavior of existing abs-reporting instances, right?
> 
> You have 2 gpio per axis, and since you can't measure how "far" down the
> axis you have moved the driver should only report values -1, 0, 1 per axis.
> You start at neutral position, and move right. IRQ for right gpio is fired and
> you report EV_ABS/ABS_X/1. Then you start moving to the left, gpio IRQ fires
> (you want it to trigger on both edges) and you report EV_ABS/ABS_X/0. You
> continue moving to the left and IRQ for left gpio fires up and you report
> EV_ABS/ABS_X/-1.
> This assumes that you assign EV_ABS/ABS_X and value 1 for right gpio and
> EV_ABS/ABS_X and value -1 for left gpio.

Right, but the problem I was referring to is that "up/release" events are not reported by gpio-keys.c today:

        if (type == EV_ABS) {
                if (state)
                        input_event(input, type, button->code, button->value);
        } else {
                input_event(input, type, button->code, !!state);
        }

I see three solutions:

1. Start reporting ABS=0 if state == 0 - this is what I would expect of the driver, but would break the current behavior.
2. Add an optional down-abs-value per key. If it is not specified, It won't be reported. 
3. Add a device-global property ("report-neutral-abs") that will report ABS=0 on all "up" events for abs-keys.

Comments?

In any case, I have a patch set based on (3) that works (but that I need to test a bit more), enabling gpio-keys to support digital joysticks using the new device property api.

I had  to define the abs-value device tree property as  a 2's complement signed 32 integer. Negative numbers are not commonly used but the device tree compiler supports it.  In the ACPI case, the iasl compiler only supports unsigned ints, but it's easy enough to work around (-1 <-> 0xFFFFFFFF) .

Thanks!
Hans
