From: Sergey Senozhatsky <sergey.senozhatsky@mail.by>
Subject: Re: [PATCH] HID: Avoid double spin_lock_init on usbhid->lock
 (resend)
Date: Tue, 23 Jun 2009 17:34:02 +0300
Message-ID: <20090623143402.GA14578@localdomain.by>
References: <20090623093324.GB3805@localdomain.by>
 <alpine.LNX.2.00.0906231532460.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [212.98.175.89] ([212.98.175.89]:33725 "EHLO localdomain.by"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754962AbZFWOdQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 10:33:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0906231532460.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sergey Senozhatsky <sergey.senozhatsky@mail.by>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On (06/23/09 15:33), Jiri Kosina wrote:

Hello Jiri.

> I have applied the patch. Your mail hasn't reached my @suse.cz address
> though, I have digged it from linux-input

Thanks.


> Is your SMTP server or some blacklist?
>
Yeah... Looks like...
"Client host [XX.XX.XX.XX] blocked using pbl.spamhaus.org".
I need to do something with it.

Thanks,
	Sergey
