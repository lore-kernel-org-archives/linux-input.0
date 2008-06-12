From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] [RESEND] fix HID quirks for aluminium apple wireless
	keyboards
Date: Thu, 12 Jun 2008 22:08:09 +0200
Message-ID: <1213301289.17870.72.camel@violet.holtmann.net>
References: <87iqweltzo.fsf@burly.wgtn.ondioline.org>
	 <874p7ylsj0.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33970 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYFLUFM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2008 16:05:12 -0400
In-Reply-To: <874p7ylsj0.fsf@burly.wgtn.ondioline.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Collins <paul@burly.ondioline.org>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hi Paul,

> I noticed that the quirks for Bluetooth Apple keyboards seem to have
> been incorrectly added to the USB HID, thus rendering them ineffective.
> Here is a patch that moves them to the Bluetooth HID.  With this patch
> applied the Fn key on my Apple wireless keyboard now works as expected.
> 
> I also took the liberty of adding defines for the vendor and for the
> existing Mighty Mouse quirk.

I prefer not to do this. I don't see any benefit or readability coming
out of it. Leave it as it is. Add the numeric ids and then a line on top
of it describing the devices.

Regards

Marcel


