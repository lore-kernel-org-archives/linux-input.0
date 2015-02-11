From: "Holmberg, Hans" <hans.holmberg@intel.com>
Subject: RE: [PATCH 0/2] GPIO joystick driver
Date: Wed, 11 Feb 2015 08:49:16 +0000
Message-ID: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6BB34@irsmsx105.ger.corp.intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1AA6C46C-36D9-4243-9DC5-254A7202D339@gmail.com>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF04@irsmsx105.ger.corp.intel.com>
 <20150207204658.GA29015@dtor-ws>
 <4B6D6D87A8FB62428BE0A3E38461A1AB18D6B24F@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60098 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbBKItV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 03:49:21 -0500
In-Reply-To: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6B24F@irsmsx105.ger.corp.intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>

> > > As far as I can tell, there is no way to specify values for ABS-"keys"
> > > in the device tree binding.
> >
> > It may not be present in device tree binding, but the driver does
> > support it, so I would rather extend the binding than have a brand new
> driver.
> 
> All right, I find it a bit like whacking a round peg down a square hole, but I'll
> head down that path and see where it leads.
> 

This is what I've found:

A digital joystick driver needs to report three states per axis: min, max and neutral. The hardware only have two signals per axis(i.e. up and down) however. See http://wiki.icomp.de/wiki/DB9-Joystick 

This makes gpio-keys pretty much impossible to use for joysticks - as the driver only reports abs-events when a button/key is pressed, how would the neutral state be reported?  (as there is no signal for "neutral")

Even if through some hackery the driver would be modified to report a special neutral event if all  "buttons/keys" for that axis are not pressed, what value should be reported?  An average of the values for that axis?   Also, reporting such an implicit neutral event would break the behavior of existing abs-reporting instances, right?

Do you still prefer this approach?

Thanks,
Hans



