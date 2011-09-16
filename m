From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Fri, 16 Sep 2011 11:48:56 +0200
Message-ID: <20110916094856.GA4276@polaris.bitmath.org>
References: <1315970147-11735-1-git-send-email-marek.vasut@gmail.com>
 <20110916062854.GC6731@core.coreip.homeip.net>
 <CAN+gG=GTA69JzM=bWv8Z+wsCneiDA8cJNbPiVA5+6953e4jm0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:56021 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab1IPJpO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 05:45:14 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 98C2CEB268
	for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 11:45:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=GTA69JzM=bWv8Z+wsCneiDA8cJNbPiVA5+6953e4jm0g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

> Globally, the patch is clean. I don't really like it because a cleaner
> way would be to just remove the field .maxcontacts in MT_CLS_EGALAX.
> This would require tests from all the different eGalax owners, and
> personally, I don't have the time to lead them.

It is not too late to start now, though; testing this new device
without maxcontacts would help when/if the ten-finger version comes
along. Marek, would you care to try that?

Thanks,
Henrik
