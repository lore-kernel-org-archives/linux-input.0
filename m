From: "Holmberg, Hans" <hans.holmberg@intel.com>
Subject: RE: [PATCH 1/2] Documentation: Device Tree binding information for
 gpio-joy driver
Date: Sat, 7 Feb 2015 07:50:45 +0000
Message-ID: <4B6D6D87A8FB62428BE0A3E38461A1AB18D6AF28@irsmsx105.ger.corp.intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1423215122-19947-2-git-send-email-hans.holmberg@intel.com>
 <20150206105336.GA10324@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21224 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbbBGHut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Feb 2015 02:50:49 -0500
In-Reply-To: <20150206105336.GA10324@leverpostej>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


> The binding should be for a class of hardware, not for a driver. Please
> describe the class of hardware the binding represents, and remove
> references to the Linux driver.

Will do.

> 
> > +Required properties:
> > +	- compatible    = "gpio-joy";
> 
> That does not strike me as a very informative compatible string. At the least,
> s/joy/joystick/.

You're very right, gpio-joystick is better and as about as specific as it can be I believe.

> > +
> > +	- left-gpio     : gpio connected to the "left" joystick signal
> > +	- right-gpio    : gpio connected to the "right" joystick signal
> > +	- up-gpio       : gpio connected to the "up" joystick signal
> > +	- down-gpio     : gpio connected to the "down" joystick signal
> > +	- button-gpio   : gpio connected to the "button" joystick signal
> 
> Only one button?

Hmm, yes, but it would make more sense to have sub-nodes defining an arbitrary 
number of buttons instead, right?

Thanks for reviewing!
Hans
