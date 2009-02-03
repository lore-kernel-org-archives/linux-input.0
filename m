From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: [PATCH] sh: maple: Add support for VMU devices (v2) [0/3]
Date: Tue, 03 Feb 2009 00:06:09 +0000
Message-ID: <1233619569.13918.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mk-filter-1-a-1.mail.uk.tiscali.com ([212.74.100.52]:44805 "EHLO
	mk-filter-1-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755017AbZBCAHG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2009 19:07:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg KH <greg@kroah.com>, Paul Mundt <lethal@linux-sh.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

This series of patches adds support for the Dreamcast Visual Memory
Unit, reworking the maple bus code to ensure it supports asynchronous
reads and writes. A consequential amendment to the keyboard driver is
also included.

The VMU is a 'smart' flash chip where access is controlled by a
microcontroller so that, for instance, flash erases appear to be
transparent to the end user. The VMU does, however, show typical
flash-type behaviour (eg phased writes) and the MTD layer and the chip
work well together (eg in the way they handle apparent hotplug events
during a block write).

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

