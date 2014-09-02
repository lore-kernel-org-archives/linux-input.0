From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-thingm: kernel panic on remove
Date: Tue, 02 Sep 2014 15:58:08 -0400
Message-ID: <54062150.2010800@gmail.com>
References: <20140902174659.GA1811@datura.dylex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:50683 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbaIBT6K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2014 15:58:10 -0400
Received: by mail-qg0-f52.google.com with SMTP id z60so7096628qgd.39
        for <linux-input@vger.kernel.org>; Tue, 02 Sep 2014 12:58:09 -0700 (PDT)
In-Reply-To: <20140902174659.GA1811@datura.dylex.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dylan Alex Simon <dylan-kernel@dylex.net>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,

On 09/02/2014 01:46 PM, Dylan Alex Simon wrote:
> Whenever either disconnecting the USB device or simply rmmod'ing the module
> (even when not in use), I get a kernel panic.  I haven't managed to capture a
> backtrace, but at least the first two lines were saved after an rmmod:
> 
> 18:53:17 kernel: thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> <snip, rmmod hid-thingm:>
> 08:38:42 kernel: BUG: unable to handle kernel paging request at fffffffb8a80aaf8
> 08:38:42 kernel: IP: [<ffffffff8106e30c>] osq_lock+0x3c/0x110
> 
> Let me know if you'd like me to try to capture more info, but this problem
> seems very reproducible (at least with a mk2 device; I never had the problem on
> older kernels with a mk1).  I do direct write()s to the hidraw device, but
> don't otherwise use the driver while it's loaded.
> 
> Also at https://bugzilla.kernel.org/show_bug.cgi?id=83751

Do you happen to see a "unsupported firmware " error when plugging your device?

If so, then the following patch should help with the panic (but you will an other one to be able to use again your device).

---

>From 791297375227b91990b37f94fc9de93156a3c21a Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 2 Sep 2014 15:50:43 -0400
Subject: [PATCH] HID: thingm: set the proper error code before leaving

In case of an unsupported firmware, the driver bails out without setting
the LEDs interfaces, but forget to set the proper error code.
err is then still equal to 0 and the hid subsytem consider the device
to be in perfect shape.
When removing it, thingm_remove() tries to unbind the rgb LEDs which
has not been created, leading to a segfault.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-thingm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 134be89..f91f971 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -250,6 +250,7 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (!tdev->fwinfo) {
 		hid_err(hdev, "unsupported firmware %c\n", tdev->version.major);
+		err = -ENODEV;
 		goto stop;
 	}
 
-- 
2.1.0

