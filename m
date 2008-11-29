From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Sat, 29 Nov 2008 23:30:19 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811292327470.19853@jikos.suse.cz>
References: <200811262333.45245.lukasz@lubojanski.info> <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz> <49303827.4050907@gmail.com> <200811282008.41601.lukasz@lubojanski.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-1904674071-1227997819=:19853"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:56807 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752769AbYK2WaV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Nov 2008 17:30:21 -0500
In-Reply-To: <200811282008.41601.lukasz@lubojanski.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-1904674071-1227997819=:19853
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Fri, 28 Nov 2008, £ukasz Lubojañski wrote:

> > It seems the protocol resembles more the hid-lg2ff one. The differences
> > are the additional 0xfa 0xfe 0x0 report sent to the device, and the
> > missing 0xf3 stop command.
> Yep - different reports are send in case of Pantherlord and GreenAsia 
> 0x12 - It could be implemented in it but it will require checking what 
> hardware is used and send different reports. 

OK, so as the reports are not really identical, and in the future we might 
discover that there are many more other Greenasia devices which require a 
slightly different handling as well, I would rather prefer to have it as a 
separate driver, to avoid additions of here-and-there device-specific 
quirks to random places in the code. That's exactly what we are trying to 
avoid with the HID bus approach in the first place.

So I think separate driver is fine.

Thanks to both of you.

-- 
Jiri Kosina
SUSE Labs
--336216065-1904674071-1227997819=:19853--
