Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CD1E9B1A
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114692; cv=none; b=k5FjcPcINZi/Wn+ex+yiVo8ROQKoHZrZs+elzfLjgjZOakQ3usWYpxqo5vujr+FyKllXdzqy4r3/yLFtw/u/dktb/hPLHFs2Gb8c+OBuvSQ00APIpMkcGoPz0l57KOi+BEupmAoAl4umAGN6l6CMl9eYxU1C2C7h6FA60RsMxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114692; c=relaxed/simple;
	bh=Dc/SDUG7wsTJwkmbP2Ir4YGAA4eRTTTF2JIZziwjDPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttaObf4BNNxb+/qaBjtV6CZHD0DgIkWDnlCWvgWLP8pXoECke02d99IItYK3aoWAUgpKXhs2/DUmhHlhBnC9V/k8OVADxh0FH3XbHioX5oHSZaWQ0hpD9x0znqCzbGafIjYxWRP5fZhAwLBofUa0FQe4VVQxVDv0dPTVXgDyqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=masoncamara.com; spf=pass smtp.mailfrom=masoncamara.com; dkim=pass (2048-bit key) header.d=masoncamara-com.20251104.gappssmtp.com header.i=@masoncamara-com.20251104.gappssmtp.com header.b=v+K7vvVT; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=masoncamara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=masoncamara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=masoncamara-com.20251104.gappssmtp.com header.i=@masoncamara-com.20251104.gappssmtp.com header.b="v+K7vvVT"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-451e22b4773so1272298fac.0
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=masoncamara-com.20251104.gappssmtp.com; s=20251104; t=1788114688; x=1788719488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dgh1NzZ5hofs8HTSQ7QUxgLQk3+1tZCEvxkmug+HP5E=;
        b=v+K7vvVTxX+70x6G8trJMQMDcVHGCDgALTaSSjH3qPNcjDLJdaFU1jj6NrCEDlN8pF
         GB+xKEyUhBCQ7sgXlB37Ij3pdHI46CGYiXKpiybukQFvx1cYcZZW6YVdyUBdLgMD03u3
         Y0+ANJKQirSsbfedZ2CY628gOnZAAVc3SdW+Fi3/BjYpCxEiIcOc8lKI37x2m0XHAD3u
         soFe3drC9RtgIeA364YOdaF7THiYmoLcdNzIEsVXjj3w01UmPFAsa0U75bcbSIK+HZpz
         Pzy8gXn9bmYsU4WHdpEV3jCQUafKRSUITGPyGhWb2a/DCBJGyHGe4qZcrKtXMhAuXtwN
         aBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114688; x=1788719488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dgh1NzZ5hofs8HTSQ7QUxgLQk3+1tZCEvxkmug+HP5E=;
        b=mHk+4mFze6QMDCH4bDZHrJ6sO78sphfowoM7dpelnbCvluzd/vZIn9thdB1015mFrZ
         EaTu15bG5IrgCHjeUK7ztJAdX4ligKHTlwJgL/OMIhMsWPWQYVPrbwI/exMO30ehcvyC
         le6nWO684oFuyn6LK7VmO5E4boO1AR+j5FmuvyCG6SQJsAvjH6WaxL7QvpNtLLarp+aU
         1R7u6Mi0jOeBJdX9KrrjzFklXl5Noj0XJsHYjYzEDlHL/i8/JY5Lmo9RdYimNnlP0TIg
         P5Epu5iUzRSADFibu7jJxGyKxNqZQVP0/k75ENSirltxX2MmGRIkiXn3+WXDYemcHcKh
         vs7A==
X-Gm-Message-State: AFuF++l8woiDdFZK2Ezl09uoQ72Q2CRus4U0Tpkyrr+48Vbrxlq7JYyn
	9efUkkBfh/xkslqseGVn2GXMw3TuFPXFjCzoaAwnnmIesvn1mYGq/a9taVb/X2fvY3Qb0qBaZzU
	iNu3VZGnuerHE94TR
X-Gm-Gg: AR+sD11ihtmKBD4pJ7YRf2EhOX0Sg3B/B4qIQd5n9Dhbzj3g8iPAvY4n5sNqQoay872
	l1GFzsQgOdY0ecS+fkx7AqHV/iyhlHQ68yeAGYt8XzRQIFGILXh1Cth6HydVpEcHcVzuJDi745Y
	NxyG3pIhDRv5fLqKFfftjDPLmVixgye1ysu6QdiArK0VPzs0FOsb/eLsXcYfXXfr+aqQcb4VeGT
	AeOqyNYOj0CCzwJm5GgsXiNHAjcUeQBD7aB5eYHc5PT5Af04BW+MoW27/n6lIeO0VnbdddtD7mn
	s+YH9L++QK8mBd2E4nSi6U+L8M/wBqNLx+tNYe9Da1AUehCjw+HXkU3a4ZwoJ8CEvuG25hsQHEK
	naNKaUphJQdOwumipFID6BhDz/ca1EVb6ffewdLgl3ebCP6zz17RtuGld/oaReTdnIeI+ZzvLmF
	iBApjn7Cf3GCVouac6A89tTS0nbPOppDJWPnb/tgO6eqEas22KSNmw1FBVcCdWpGTfvH+6SP/qR
	FCc0+3R29vQXqaKpSOPJn21vJFzaAkmbzY0arT2etACR9T1lQ==
X-Received: by 2002:a05:6830:81d8:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7f4f2220121mr22615283a34.5.1788114688486;
        Sun, 30 Aug 2026 11:31:28 -0700 (PDT)
Received: from localhost.localdomain ([69.26.129.115])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96cf17sm6436259a34.15.2026.08.30.11.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:31:27 -0700 (PDT)
From: Mason Camara <ping@masoncamara.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wh6cyy@gmail.com,
	Mason Camara <ping@masoncamara.com>
Subject: [PATCH v2] selftests/hid: test battery queries with nonzero field offsets
Date: Sun, 30 Aug 2026 12:31:09 -0600
Message-Id: <20260830183109.9441-1-ping@masoncamara.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d07644524b65 ("HID: input: read battery capacity from its actual
report offset") fixed synchronous battery queries for reports that place
the capacity byte after status fields.

Add a UHID mouse with the Magic Mouse 2 report layout and answer GET_REPORT
with 90 04 5f. Read capacity before sending an input report so the test
exercises the synchronous query path. Without the fix, it reads the status
byte as 4%; with the fix, it reads capacity as 95%.

Enable CONFIG_HID_BATTERY_STRENGTH in the HID selftest configuration.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221263
Assisted-by: LLM
Signed-off-by: Mason Camara <ping@masoncamara.com>
---

Changes in v2:
- Drop driver fix, superseded by d07644524b65.
- Rebase the regression test onto the current HID for-next branch.
- Amend commit message and tool-assistance trailer.

v1: https://lore.kernel.org/linux-input/20260712044702.893825-1-ping@masoncamara.com/

 tools/testing/selftests/hid/config            |  1 +
 .../testing/selftests/hid/tests/test_mouse.py | 54 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 1758b055f..da52335b8 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -16,6 +16,7 @@ CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_TRACER=y
 CONFIG_HIDRAW=y
 CONFIG_HID=y
+CONFIG_HID_BATTERY_STRENGTH=y
 CONFIG_HID_BPF=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_UHID=y
diff --git a/tools/testing/selftests/hid/tests/test_mouse.py b/tools/testing/selftests/hid/tests/test_mouse.py
index eb4e15a0e..141c1f069 100644
--- a/tools/testing/selftests/hid/tests/test_mouse.py
+++ b/tools/testing/selftests/hid/tests/test_mouse.py
@@ -11,6 +11,7 @@ import hidtools.hid
 from hidtools.util import BusType
 import libevdev
 import logging
+import threading
 import pytest
 
 logger = logging.getLogger("hidtools.test.mouse")
@@ -598,6 +599,35 @@ class ResolutionMultiplierHWheelMouse(TwoWheelMouse):
         return 0
 
 
+class BatteryOffsetMouse(BaseMouse):
+    report_descriptor = [
+        # Mouse report
+        0x05, 0x01, 0x09, 0x02, 0xa1, 0x01, 0x85, 0x12,
+        0x05, 0x09, 0x19, 0x01, 0x29, 0x02, 0x15, 0x00,
+        0x25, 0x01, 0x95, 0x02, 0x75, 0x01, 0x81, 0x02,
+        0x95, 0x01, 0x75, 0x06, 0x81, 0x01, 0x05, 0x01,
+        0x09, 0x01, 0xa1, 0x00, 0x09, 0x30, 0x09, 0x31,
+        0x15, 0x81, 0x25, 0x7f, 0x75, 0x08, 0x95, 0x02,
+        0x81, 0x06, 0xc0, 0xc0,
+        # Battery report: one status byte followed by capacity
+        0x06, 0x00, 0xff, 0x09, 0x14, 0xa1, 0x01, 0x85,
+        0x90, 0x05, 0x84, 0x75, 0x01, 0x95, 0x03, 0x15,
+        0x00, 0x25, 0x01, 0x09, 0x61, 0x05, 0x85, 0x09,
+        0x44, 0x09, 0x46, 0x81, 0x02, 0x95, 0x05, 0x81,
+        0x01, 0x75, 0x08, 0x95, 0x01, 0x15, 0x00, 0x26,
+        0xff, 0x00, 0x09, 0x65, 0x81, 0x02, 0xc0,
+    ]
+
+    def __init__(self, rdesc=report_descriptor, name=None, input_info=None):
+        super().__init__(rdesc, name, input_info)
+
+    def get_report(self, req, rnum, rtype):
+        if rtype != self.UHID_INPUT_REPORT or rnum != 0x90:
+            return (1, [])
+
+        return (0, [0x90, 0x04, 0x5F])
+
+
 class BaseTest:
     class TestMouse(base.BaseTestCase.TestUhid):
         def test_buttons(self):
@@ -1045,3 +1075,27 @@ class TestBadReportDescriptorMouse(base.BaseTestCase.TestUhid):
 
     def assertName(self, uhdev):
         pass
+
+
+class TestBatteryOffsetMouse(base.BaseTestCase.TestUhid):
+    def create_device(self):
+        return BatteryOffsetMouse()
+
+    def test_queried_battery_field_offset(self):
+        uhdev = self.uhdev
+        power_supply = uhdev.power_supply_class
+        assert power_supply is not None
+
+        done = False
+
+        def dispatch():
+            while not done:
+                uhdev.dispatch(1)
+
+        thread = threading.Thread(target=dispatch)
+        thread.start()
+        try:
+            assert power_supply.capacity == 95
+        finally:
+            done = True
+            thread.join()

base-commit: 931aaa59d1826f43b0bb3f07e21233f6faf4540a
-- 
2.39.5 (Apple Git-154)

