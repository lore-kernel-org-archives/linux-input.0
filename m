Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB72232395
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783831660; cv=none; b=UjcR9SYK2QoE4yuUs3mV0QC80xsIHkA7SAPZdNpj8HNnIBnvLYCYmKy397lV1xPavPqXIB2u5e4uU/1mTp0dIbI14X7cP199H7n5ZdqH/kvy96sdLYjdeAXby/qqyEUYlQOq2IT4pbHjXDzTkHqD3Heo4dF0X5jw8/P5edISc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783831660; c=relaxed/simple;
	bh=gVoVhvIy7NIUB1l7ESMbLeoAjSFDx4L17+1xD7r2jjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeeEoVn3jImAgT4OLg9dcUjNJ8G8g/VlJH3cbfs2vUyUp/pCPBxMH6WSposuSFQeh/ZsdbZ7a1SsTAvSVYhSS+3+lsNZPlpvRWHFG/gtto1VB6D/FUZHJ04PDRZJw3XIJRXQTyaHUDeo7KoXc+ipQ0fNzgH7vV7hIVR4/5vz4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=masoncamara.com; spf=pass smtp.mailfrom=masoncamara.com; dkim=pass (2048-bit key) header.d=masoncamara-com.20251104.gappssmtp.com header.i=@masoncamara-com.20251104.gappssmtp.com header.b=LLIBYAYf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=masoncamara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=masoncamara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=masoncamara-com.20251104.gappssmtp.com header.i=@masoncamara-com.20251104.gappssmtp.com header.b="LLIBYAYf"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c89636920a3so1112195a12.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=masoncamara-com.20251104.gappssmtp.com; s=20251104; t=1783831658; x=1784436458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9oLcv0qVSMsTkgn/ZfSsFOjEguUBCGI4Az7FCb7eMIk=;
        b=LLIBYAYfk78rs3UXIhrb5OrBnFn25HUkslivUHRccIrf7WckE6ge1IMM6tJ4tqtz6F
         KVLj53b/Aw3BGiYVYprW2x3UV1/uAqp60Ox2+rdsvB/pNpsRYHb5hv7h2xw7f3X9t5QB
         2d9luZy9S51vR5Sh1q86KKqehT55/9vh2XypTj5XMUZI/ffmVm9dHiCVkEAUtvVCivAe
         RoTLILT0ET4dydBsOabvoCVr3iMqywVGwCnDq2pQLTpb9IapOgXupA8ssBVUihcQEGdC
         xX+z4dBLHCbSv6/UTkhn1+VRqCNKUWKf5JBmlLUoxKRkV8V5NfrQp51CF9SaQDyLwz+x
         iFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783831658; x=1784436458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9oLcv0qVSMsTkgn/ZfSsFOjEguUBCGI4Az7FCb7eMIk=;
        b=io9jFDYuoBNLtLa0QS2YK9ib0w2eLEFcugB/QLYWJCuhOpW/Gw5gToTGxFFQCyw03l
         6PPfYkQBXCyY3lDzh8SbZ+wItxFmJdJlvfObiui13TeSipgf9+6x/1mFryZ5dh1S+sL+
         da19h02evpSUpHAqwTwWMNYStayQmcIVdQFj5o7myqh9hadDnB4anGCXEQli5Cyty17g
         J4PRTw/G8yYnN29hXmyHvgIxGeHflOJAOE2V9g/D+4aTPsjw+oCBM+6pMqYf59oxD60L
         ekLvFHk2ngxThuSncXEthF2FxKjAGdp7sVPTZegDB+yYAoih0a4vBVW4ZE9gtTD05JH4
         QHEA==
X-Forwarded-Encrypted: i=1; AHgh+RoBQtbLpW0xoh7hHE8VzumJWDrYMXV4JsF19+Cy3NCgqB0+xQPmmUktYnPjto/QSRr4c6tZO7g15y+iAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0PUrlP04j9KOK0CT7It9BTH1btnYaLHtzdTvCLyqDA+/eIae
	fZxxTLg0PGCuFeGW47r/AYH40AucpsRO08ZIwHCpjWkRQafDL/NV9O5PUEaqPRr1ZtAp
X-Gm-Gg: AfdE7cm3DqnI0K4wcVNVtqKfy959n87eSWK29s6Xe7oHMWHHgn5DdB6cjEnRR28BIBn
	SLaM8U6jxIL2W5vuyfiD08MN7moavPhb3LgJ6S7GWd5fgxriZjgLOj2IyZjjWAAFRxKVlEpmZiI
	ssbhORm4ZgeZBa62Ur9BwW+ezSrdaB+U8pzRVsLKKpQqHrHqwTZNhgCRFeeseCrjEYrOj46LxNY
	Bg5BAo4Cky6DF7CALEKb6eI9/XrnijCRZb2CNrJteKENTY8tze9YbZd7wnFPHmVGs9G8y1SgPWa
	7+xO1hhOzrR84KzyzlTe53GwOOIlOPg6ZiW/+dFRRbiMiA38qxmpGMgPkztZDK7Plpfdx1scWqS
	hVVOyW+Zqqp/gNgvw4DnJ4zM6jKvk7NltwiG5NWrqr2BRofmRoZHGt4BH3KAgm+A1SwhDP6Jvwk
	gj7Fj0KxOg8oLjM0Zv7NSyyWgqlEjg7mAnx+iFdw==
X-Received: by 2002:a05:6a21:6e91:b0:39f:2dd0:65d5 with SMTP id adf61e73a8af0-3c110b263e8mr4830981637.39.1783831657914;
        Sat, 11 Jul 2026 21:47:37 -0700 (PDT)
Received: from nobara ([69.26.129.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm59384338eec.14.2026.07.11.21.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:47:37 -0700 (PDT)
From: Mason Camara <ping@masoncamara.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Chen <johnchen902@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/hid: test battery queries with nonzero field offsets
Date: Sat, 11 Jul 2026 22:47:02 -0600
Message-ID: <20260712044702.893825-3-ping@masoncamara.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712044702.893825-1-ping@masoncamara.com>
References: <20260712044702.893825-1-ping@masoncamara.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a UHID mouse whose input report 0x90 contains a status byte before
the capacity field. Answer GET_REPORT with 90 04 5f and read the power
supply capacity before sending any input report.

On an unpatched kernel, the capacity read returns the status byte (4)
instead of the capacity value (95), so the test fails. Enable
CONFIG_HID_BATTERY_STRENGTH in the HID selftest configuration.

Assisted-by: Codex:GPT-5
Signed-off-by: Mason Camara <ping@masoncamara.com>
---
 tools/testing/selftests/hid/config            |  1 +
 .../testing/selftests/hid/tests/test_mouse.py | 54 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 1758b055f295..da52335b865a 100644
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
index eb4e15a0e53b..141c1f06905b 100644
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
-- 
2.55.0

