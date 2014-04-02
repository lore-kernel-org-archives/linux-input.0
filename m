From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v4 0/7] HID: sony: More Sony controller fixes and improvements.
Date: Wed,  2 Apr 2014 12:31:18 -0400
Message-ID: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:39381 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932233AbaDBQbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Apr 2014 12:31:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

v4 of this series has been rebased against jikos/hid.git/for-linus

There was another bit of mismerge code duplication in for-linus that caused
merge conflicts with patches 3 and above in v3 of the series.

The first patch in v4 fixes the mismerge and the remaining patches now apply
cleanly.

Patch 1 should be queued for 3.15 as soon as possible.
