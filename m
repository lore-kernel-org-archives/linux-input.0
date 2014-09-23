From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: input: Fix TransducerSerialNumber implementation
Date: Tue, 23 Sep 2014 11:09:28 -0700
Message-ID: <1411495768-5956-1-git-send-email-killertofu@gmail.com>
References: <Message-ID: <6B3C86448604A642A31AAD3F8C07EA7724F0B8CD@Exchange1.wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47964 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbaIWSJf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 14:09:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so2816668pdb.14
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 11:09:35 -0700 (PDT)
In-Reply-To: <Message-ID: <6B3C86448604A642A31AAD3F8C07EA7724F0B8CD@Exchange1.wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "pinglinux@gmail.com" <pinglinux@gmail.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>

The commit which introduced TransducerSerialNumber (368c966) is missing
two crucial implementation details. Firstly, the commit does not set the
type/code/bit/max fields as expected later down the code which can cause
the driver to crash when a tablet with this usage is connected. Secondly,
the call to 'set_bit' causes MSC_PULSELED to be sent instead of the
expected MSC_SERIAL. This commit addreses both issues.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/hid-input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2619f7f..cb1b3fa 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -689,7 +689,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 
 		case 0x5b: /* TransducerSerialNumber */
-			set_bit(MSC_SERIAL, input->mscbit);
+			usage->type = EV_MSC;
+			usage->code = MSC_SERIAL;
+			bit = input->mscbit;
+			max = MSC_MAX;
 			break;
 
 		default:  goto unknown;
-- 
2.1.0

