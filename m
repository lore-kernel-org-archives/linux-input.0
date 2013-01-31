From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v2 0/9] Support of Nexio 42" and new default class for hid-multitouch
Date: Thu, 31 Jan 2013 17:22:22 +0100
Message-ID: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33897 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3AaQWy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jan 2013 11:22:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi guys,

so, this is the v2 of the support of win7/8 devices.

changes since v1:
- removed the "optimization" patches, as the benefit was minimum
- introduce a new callback "report" in hid-core that drivers can use to treat the
  report by having it entirely parsed
- rely on this new hook to support Nexio 42"

side notes:
- I've tested removing the heavy call to kzalloc in hid_input_field. The results
  are disapointing -> the processing time remains the same.
- I've also tested not to rely on .event hook in hid-multitouch but only on .report.
  Idem, I thought it would reduce the code of hid-multitouch and will enhance its
  processing time, but the results are a roughly same number of lines for hid-multitouch
  and the same processing time... :(
- these 2 tests helped in cleaning the patch set from the last time.

And again, finally, I've pass all the 40 regression tests of my db. \o/

Cheers,
Benjamin

Benjamin Tissoires (9):
  HID: core: add "report" hook, called once the report has been parsed
  HID: multitouch: use the callback "report" instead of sequential
    events
  HID: multitouch: add support for Nexio 42" panel
  HID: multitouch: fix Win8 protocol for Sharp like devices
  HID: multitouch: ensure that serial devices make no use of contact
    count
  HID: multitouch: fix protocol for Sitronix 1403:5001
  HID: multitouch: fix protocol for Cando 2087:0a02
  HID: multitouch: fix protocol for Elo panels
  HID: multitouch: make MT_CLS_ALWAYS_TRUE the new default class

 drivers/hid/hid-core.c       |   4 ++
 drivers/hid/hid-ids.h        |   3 +
 drivers/hid/hid-multitouch.c | 142 ++++++++++++++++++++++++++++++++-----------
 include/linux/hid.h          |   2 +
 4 files changed, 115 insertions(+), 36 deletions(-)

-- 
1.8.1

