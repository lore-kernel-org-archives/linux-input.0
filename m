From: James Cloos <cloos@jhcloos.com>
Subject: hid-lenovo-tpkbd unknown key/button events
Date: Mon, 16 Jun 2014 06:41:28 +0000
Message-ID: <m3egypuzjb.fsf@carbon.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ore.jhcloos.com ([198.147.23.85]:59302 "EHLO ore.jhcloos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbaFPGvI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jun 2014 02:51:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

My Lenovo ThinkPad Keyboard with TrackPoint reports two keys/buttons
events which have no names in input.h.

Event 282 (0x11A) is generated on the pointer devices via Fn-F9:

  Event: time 1402899841.080255, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90018
  Event: time 1402899841.080255, type 1 (EV_KEY), code 282 (?), value 1
  Event: time 1402899841.080255, -------------- SYN_REPORT ------------
  Event: time 1402899841.176247, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90018
  Event: time 1402899841.176247, type 1 (EV_KEY), code 282 (?), value 0
  Event: time 1402899841.176247, -------------- SYN_REPORT ------------

I have not found how to generate event 286 (0x11E).

Lenovo documents Fn-F9 on:

  http://support.lenovo.com/en_US/detail.page?LegacyDocID=MIGR-42883

as ThinkPad EasyEject Utility.

Are there any other devices known to generate codes in the 0x118-0x11F
range?  Woulditbe beneficial to come up with names for them?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6
