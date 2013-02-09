From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/7] input: atmel_mxt_ts: allow to read/display
 MXT_GEN_MESSAGE_T5 object
Date: Sat, 9 Feb 2013 01:01:48 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1302090058310.18077@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net> <1360246668-2291-3-git-send-email-pmeerw@pmeerw.net> <CAGS+omCPowRC0ut0vgzMZOwqjU3PmEkZznhUSdJE48bHq80b4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53983 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947367Ab3BIABw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Feb 2013 19:01:52 -0500
In-Reply-To: <CAGS+omCPowRC0ut0vgzMZOwqjU3PmEkZznhUSdJE48bHq80b4w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hello Daniel,

> Hmm.  Why do you want to read T5?
> We specifically removed T5 from the readble list in this patch:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=55d6867fe659f4783e57db7b2ae0bb04e4ac816e

ah; haven't seen that patch

> T5 is the message processor object.  Reading it will only have two
> outcomes, neither of which is particularly useful:
> 1) the message count decrements, and a valid message will be lost
> 2) an invalid message will be read (reportid == 0xff)

I found it useful for debugging; but I agree that it interferes with 
normal operation of the driver -- T5 should not be added

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
