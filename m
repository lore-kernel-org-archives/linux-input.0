From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Fri, 16 Sep 2011 17:23:56 +0200
Message-ID: <201109161723.56701.marek.vasut@gmail.com>
References: <1315970147-11735-1-git-send-email-marek.vasut@gmail.com> <201109161507.44989.marek.vasut@gmail.com> <20110916144700.GA5768@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60765 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1IPPZq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 11:25:46 -0400
Received: by eya28 with SMTP id 28so873918eya.19
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 08:25:44 -0700 (PDT)
In-Reply-To: <20110916144700.GA5768@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?q?St=E9phane_Chatty?= <chatty@enac.fr>

On Friday, September 16, 2011 04:47:00 PM Henrik Rydberg wrote:
> On Fri, Sep 16, 2011 at 03:07:44PM +0200, Marek Vasut wrote:
> > On Friday, September 16, 2011 11:48:56 AM Henrik Rydberg wrote:
> > > > Globally, the patch is clean. I don't really like it because a
> > > > cleaner way would be to just remove the field .maxcontacts in
> > > > MT_CLS_EGALAX. This would require tests from all the different
> > > > eGalax owners, and personally, I don't have the time to lead them.
> > > 
> > > It is not too late to start now, though; testing this new device
> > > without maxcontacts would help when/if the ten-finger version comes
> > > along. Marek, would you care to try that?
> > 
> > Well I own only this one particular device, not the other ones.
> 
> I meant removing .maxcontacts from _your_ patch, and testing on your
> particular device.

Ah all right, yes, I can try it. But only _after_ my exam on wednesday (or 
before in case I start being tired of learning).

You're welcome!

Cheers

> 
> Thanks,
> Henrik
