From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 0/4] HID: sony: Some cleanups
Date: Tue, 24 Jun 2014 13:28:39 +0200
Message-ID: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:11295 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbaFXMSW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 08:18:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Hi,

here are some cleanups for hid-sony.

The changes in patches 2 and 3 will prove useful if someday David
Hermann's ABS2 changes make it to mainline.

Ciao,
   Antonio

Antonio Ospite (4):
  HID: sony: Use the SIXAXIS_CONTROLLER constant when possible
  HID: sony: Always override the Sixaxis descriptor
  HID: sony: Format and comment sixaxis_rdesc
  HID: sony: Remove an old and redundant comment

 drivers/hid/hid-sony.c | 130 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 45 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
