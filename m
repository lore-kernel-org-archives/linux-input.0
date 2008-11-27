From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Thu, 27 Nov 2008 13:41:36 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0811271337320.26670@twin.jikos.cz>
References: <200811262333.45245.lukasz@lubojanski.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-1410113971-1227789697=:26670"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:34170 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbYK0Mll (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Nov 2008 07:41:41 -0500
In-Reply-To: <200811262333.45245.lukasz@lubojanski.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>
Cc: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-1410113971-1227789697=:26670
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Nov 2008, Łukasz Lubojański wrote:

> I have implemented Force Feedback driver for another "GreeAsia" based 
> device (0e8f:0012 "GreenAsia Inc.    USB Joystick     "). The 
> functionality was tested with MANTA Warior MM816 and SpeedLink Strike2 
> SL-6635 and fftest software - everything seems to work right.
> Is there anyone able to check the code say if this good enough to include it
> into official kernel ?

Hi,

thanks for doing this work. The HID code has been redone for 2.6.28, and 
HID generic layer now provides proper kernel bus, to which the specialized 
drivers should register properly. This has been done in order to keep the 
code clean and maintainable, as adding all the quirks during the past 
years started turning the HID code into unmaintainable mess.

Could you please rebase your patch on top of current state of Linus' 
kernel tree for 2.6.28-rc? Then the code could be reviewed and I'll merge 
it through my tree.
For inspiration, you can look into 

	drivers/hid/hid-pl.c

That driver even contains support for some Greenasia device ... (0x0003). 

Thanks!

-- 
Jiri Kosina
SUSE Labs

---1747641777-1410113971-1227789697=:26670--
