From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Fri, 16 Sep 2011 15:07:44 +0200
Message-ID: <201109161507.44989.marek.vasut@gmail.com>
References: <1315970147-11735-1-git-send-email-marek.vasut@gmail.com> <CAN+gG=GTA69JzM=bWv8Z+wsCneiDA8cJNbPiVA5+6953e4jm0g@mail.gmail.com> <20110916094856.GA4276@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35553 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1IPNHs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 09:07:48 -0400
Received: by bkbzt4 with SMTP id zt4so3439876bkb.19
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 06:07:47 -0700 (PDT)
In-Reply-To: <20110916094856.GA4276@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?q?St=E9phane_Chatty?= <chatty@enac.fr>

On Friday, September 16, 2011 11:48:56 AM Henrik Rydberg wrote:
> > Globally, the patch is clean. I don't really like it because a cleaner
> > way would be to just remove the field .maxcontacts in MT_CLS_EGALAX.
> > This would require tests from all the different eGalax owners, and
> > personally, I don't have the time to lead them.
> 
> It is not too late to start now, though; testing this new device
> without maxcontacts would help when/if the ten-finger version comes
> along. Marek, would you care to try that?

Well I own only this one particular device, not the other ones.

btw sorry about the CC.

Cheers

> 
> Thanks,
> Henrik
