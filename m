From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/3] Few cleanups
Date: Wed, 11 Sep 2013 22:12:22 +0200
Message-ID: <1378930345-6670-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117Ab3IKUMb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Sep 2013 16:12:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

Well, while debugging hid-lenovo-tpkbd, I also cleaned it up a little (so this
goes on top of the CVE series):
- use devres API
- remove usb references (so that the regressions tests through uhid are working)

This has also been tested by https://bugzilla.redhat.com/show_bug.cgi?id=1003998

And I also had a patch for sony that I wanted to send, but I was waiting for a
complete drop of usb, which I still did not managed to do.

Cheers,
Benjamin

Benjamin Tissoires (3):
  HID: lenovo-tpkbd: devm conversion
  HID: lenovo-tpkbd: remove usb dependency
  HID: sony: use hid_get_raw_report() instead of a direct call to usb

 drivers/hid/Kconfig            |  2 +-
 drivers/hid/hid-lenovo-tpkbd.c | 50 ++++++++++++------------------------------
 drivers/hid/hid-sony.c         | 11 ++--------
 3 files changed, 17 insertions(+), 46 deletions(-)

-- 
1.8.3.1

