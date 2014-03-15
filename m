From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 0/8] HID: sony: More Sony controller fixes and improvements.
Date: Sat, 15 Mar 2014 09:41:14 -0400
Message-ID: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:38466 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756080AbaCONlc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 09:41:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Just a couple of small changes in v3:

Patch 6 was changed to use the controller Bluetooth MAC address as the unique
value for the battery name string.

The IDA code was moved from patch 6 to 7 since it was no longer needed in
patch 6.  It's the same otherwise.
