From: Michael Tokarev <mjt@tls.msk.ru>
Subject: where to put USB IDs to?
Date: Wed, 28 Jan 2009 20:07:27 +0300
Message-ID: <498090CF.7070609@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([81.13.33.159]:52697 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbZA1RRx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 12:17:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux INPUT list <linux-input@vger.kernel.org>
Cc: Linux USB list <linux-usb@vger.kernel.org>

F.e., a Powercom UPS (0x0d9f:0x0002).  It's
defined in drivers/usb/serial/cypress_m8.h
(and used in drivers/usb/serial/cypress_m8.c)
for now, I'd like to add it to hid blacklist
at drivers/hid/hid-core.c.  So it belongs
to some common place.  The question is which
one.

Thanks.

/mjt
