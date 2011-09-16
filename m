From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Fri, 16 Sep 2011 16:47:00 +0200
Message-ID: <20110916144700.GA5768@polaris.bitmath.org>
References: <1315970147-11735-1-git-send-email-marek.vasut@gmail.com>
 <CAN+gG=GTA69JzM=bWv8Z+wsCneiDA8cJNbPiVA5+6953e4jm0g@mail.gmail.com>
 <20110916094856.GA4276@polaris.bitmath.org>
 <201109161507.44989.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:48119 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab1IPOnR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 10:43:17 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 9238DEA2F9
	for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 16:43:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201109161507.44989.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

On Fri, Sep 16, 2011 at 03:07:44PM +0200, Marek Vasut wrote:
> On Friday, September 16, 2011 11:48:56 AM Henrik Rydberg wrote:
> > > Globally, the patch is clean. I don't really like it because a cleaner
> > > way would be to just remove the field .maxcontacts in MT_CLS_EGALAX.
> > > This would require tests from all the different eGalax owners, and
> > > personally, I don't have the time to lead them.
> > 
> > It is not too late to start now, though; testing this new device
> > without maxcontacts would help when/if the ten-finger version comes
> > along. Marek, would you care to try that?
> 
> Well I own only this one particular device, not the other ones.

I meant removing .maxcontacts from _your_ patch, and testing on your particular device.

Thanks,
Henrik
