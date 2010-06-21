From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 0/3] HID: magicmouse: More scroll improvements
Date: Sun, 20 Jun 2010 21:32:28 -0400
Message-ID: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53149 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab0FUBcg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jun 2010 21:32:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org

The following three patches improve scrolling for Apple Magicmouse
devices. The first two were sent as a set of four patches. Two were
applied while two were reviewed later. They are now ready for
application. The last patch is new, but is rather simple.

I have been running with these patches for a few weeks and have been
very happy with the results :).

HID: magicmouse: properly account for scroll movement in state
HID: magicmouse: add param for scroll speed
HID: magicmouse: enable horizontal scrolling
--
 drivers/hid/hid-magicmouse.c |   63 ++++++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 18 deletions(-)
