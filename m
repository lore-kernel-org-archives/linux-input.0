From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/2] HID: hidraw, fix two NULL pointer dereferences
Date: Tue,  5 Oct 2010 17:20:15 +0200
Message-ID: <1286292017-6746-1-git-send-email-ospite@studenti.unina.it>
References: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:35088 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab0JEPVN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Oct 2010 11:21:13 -0400
In-Reply-To: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org, stable@kernel.org

Hi,

here are some fixes to hidraw.

Patches are against 2.6.36-rc6, but they should be ported to other
maintained stable kernels as well.

Antonio Ospite (2):
  HID: hidraw, fix a NULL pointer dereference in hidraw_ioctl
  HID: hidraw, fix a NULL pointer dereference in hidraw_write

 drivers/hid/hidraw.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)


The first one has been sent already but I am resending it with
stable@stable@kernel.org in the recipients list.


Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
