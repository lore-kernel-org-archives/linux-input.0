From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 19/20] Input: atmel_mxt_ts - remove mxt_make_highchg and
 parse T6 report
Date: Tue, 20 Mar 2012 08:38:21 -0700
Message-ID: <4F68A46D.9020601@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-20-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:35679 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759756Ab2CTPiZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:38:25 -0400
In-Reply-To: <1331640263-18935-20-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Daniel Kurtz wrote:
> This function attempts to make the CHG pin high by reading a bunch of
> messages until the device is happy.  Instead of just blindly trying to
> read a fixed number of messages, let's actually read and process them.
> 
> It turns out that the messages after boot or nvupdates are T6 reports,
> containing a status, and the config memory checksum.  So, let's parse
> them and dump a useful info message.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

mxt_make_highchg exists due to the interrupts being edge triggered. It
forces the CHG line to go high.

With this implementation, I suspect that if a new message arrives after you
have read T44 and before you finish processing messages, then the interrupt
handler will not ever be run. What testing have you done on this?

The printout of T6 messages looks OK, though. I'd prefer to see a lookup
table for the report IDs.

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
