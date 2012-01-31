From: Ahmet Inan <xdsopl@googlemail.com>
Subject: [PATCH] synaptics enters infinite reconnect loop on resume from
 suspend on Vostro v13
Date: Tue, 31 Jan 2012 13:58:16 +0100
Message-ID: <CAFDW0jKc0VmYMO_KCXW+Zv8uVLrXL7E_3VioiysRKbNrro4XvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3071c97c4593d104b7d28477
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56866 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab2AaM6R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 07:58:17 -0500
Received: by vcge1 with SMTP id e1so308252vcg.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2012 04:58:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

--20cf3071c97c4593d104b7d28477
Content-Type: text/plain; charset=UTF-8

since linux-3.2 (had linux-2.6.38 before), when resuming from suspend,
the synaptics driver enters an infinite loop, trying to reconnect the touchpad
on my wife's Vostro v13 again and again.

linux-3.2 felt like resuming much faster from suspend than linux-2.6.38 did, so
i added an ssleep(1) before doing anything else in synaptics_reconnect()

well it works. got no complaints from my wife since then. ;-)

Ahmet

Signed-off-by: Ahmet Inan <xdsopl@googlemail.com>

diff -Nru linux-3.2.2.orig/drivers/input/mouse/synaptics.c
linux-3.2.2/drivers/input/mouse/synaptics.c
--- linux-3.2.2.orig/drivers/input/mouse/synaptics.c    2012-01-31
12:43:40.528791525 +0100
+++ linux-3.2.2/drivers/input/mouse/synaptics.c 2012-01-31
10:51:29.000000000 +0100
@@ -1219,6 +1219,7 @@
        int retry = 0;
        int error;

+       ssleep(1);
        do {
                psmouse_reset(psmouse);
                if (retry) {

--20cf3071c97c4593d104b7d28477
Content-Type: text/x-patch; charset=US-ASCII;
	name="linux-3.2.2_synaptics_ssleep_1_before_reset.diff"
Content-Disposition: attachment;
	filename="linux-3.2.2_synaptics_ssleep_1_before_reset.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gy2vbani0

ZGlmZiAtTnJ1IGxpbnV4LTMuMi4yLm9yaWcvZHJpdmVycy9pbnB1dC9tb3VzZS9zeW5hcHRpY3Mu
YyBsaW51eC0zLjIuMi9kcml2ZXJzL2lucHV0L21vdXNlL3N5bmFwdGljcy5jCi0tLSBsaW51eC0z
LjIuMi5vcmlnL2RyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmMJMjAxMi0wMS0zMSAxMjo0
Mzo0MC41Mjg3OTE1MjUgKzAxMDAKKysrIGxpbnV4LTMuMi4yL2RyaXZlcnMvaW5wdXQvbW91c2Uv
c3luYXB0aWNzLmMJMjAxMi0wMS0zMSAxMDo1MToyOS4wMDAwMDAwMDAgKzAxMDAKQEAgLTEyMTks
NiArMTIxOSw3IEBACiAJaW50IHJldHJ5ID0gMDsKIAlpbnQgZXJyb3I7CiAKKwlzc2xlZXAoMSk7
CiAJZG8gewogCQlwc21vdXNlX3Jlc2V0KHBzbW91c2UpOwogCQlpZiAocmV0cnkpIHsK
--20cf3071c97c4593d104b7d28477--
