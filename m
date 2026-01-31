Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCF38B98D
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903870; cv=none; b=oYRIBpMCSEvaS08jPe3HKrPT/iXa20V7sBJEOwaawGuS73t8Qtx8q8zCzmn6PBxUkl8wX5ji+Rhsq9sdjTa4nuxG/kf9waUS2wu7MNtInunNxF5/KvMEZsrPcQjrJNYucT3dH+gkYOuKvD3OHrl15O98i7sjN58RLcrNM49T46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903870; c=relaxed/simple;
	bh=A2imHiK3v0Yz1dKU+ScuWXsvDPrBAgY3nyGpXI0O6jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sc4XS2jltfkQNggFG5pfmSYtCMGEPTaF0z0fhphJzqkeK5HlwyDGtP3Wjooo9jAo3WcTtq7kUkwzwktbManZ8L8tVRStNuBJr2dw7ULWgD9b72v7cZ7n/Y2QhatG/mVu9DR1l+SSlN7tQdcsOrIDeYItbY9b99Y+PZzvge87tJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br2B5tZZ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br2B5tZZ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6367481eec.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 15:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769903868; x=1770508668; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Sgt5bEU/BbVZ4tcHAgIaDimpP7PleKb0CFNyglG8Ok=;
        b=Br2B5tZZwRLd35ehdZhJoWeDOSQ1kg2mZyqfVceaWVFZtbqb4knUIZtWqM3GwyYLYN
         MIQUotj15ZGzGLJH6Np+b8FRRbrfVTGBBEGEhn5QaEmIFiBuK6cJoEm7pHXQQ9iSfMHo
         sdE61Rj1b1pF0bglv51EohOq0QAdSScPhUpPr8B/RWcqWOY5ycFfaBP8PV0xbHppf+ob
         1VVEiL03EdAfD5BzsmwfY+ruVyFeDHjhbKKSH45mNxL14oYWCBm9UDyhvHqsHV+qaXKE
         +MDe3/BpeW8A8F3TZKkcjtbUn6MAUmqhGXsRK8NwHtuQJk3dddqb4yg4kI27kBt4A1Tb
         ttow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769903868; x=1770508668;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sgt5bEU/BbVZ4tcHAgIaDimpP7PleKb0CFNyglG8Ok=;
        b=cYbnqUpjeugAgDIO70qER9CEbna31PBXY8krsluAEpmKbeG2gJWE4LheTEmJzy65Bq
         qDCQy7JB8EQM44Kal8Cii5nUMfpNeGe5DFMQV7fDaS27iFWmdSn64f388qmbe1X/UXxv
         Wdli7lucrEm1j1jc0PNFw3UhieCaPJ3x+gsbGpp9qbMrJOQDMyRXZQeCcCPiOML0tChC
         Fqv7fjgOUVEw7V4aiFZzt6j1z3OzyxvzadEpQcvgQLavj7/UT7nAom2AKOQb40uLp6EX
         BSGr93dcyaTr0fLELkFqLcsj/pRxE2U4N/98OzmMb1Xf2qK8s//8bhvxp/9Xpz5bcu6k
         LN/g==
X-Forwarded-Encrypted: i=1; AJvYcCW2BH+QXe2uOYTrIsJIvUU2mJJq/L1quFpsDVxuIkMhto1FSf/sq6DbnhCu/stwza2cAaTwRdrZW3V7pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOKrvDWWL+68oI2oEe6LL/QkuzE+fCvCdisunR82iRr/vpuf1
	heEiwgDnzlmBWZwm4HWdcXePRDYMZrtGkaNBUMdRdoj3qHcH+CAdIdXU
X-Gm-Gg: AZuq6aI7ok32SeTw6zmPaG+PwfXM9uFFLdaODdY2eInXH/230nG7oiiJgyNHLnm7xX2
	iF3Bi+2iwTgl/8/yiQDJndpSnqSpw/6FjyPR2lbQaMzhLFwTrfORyBERiS3UJzyvBFYhTCf8Hkl
	18v53C6Qo0WkFQBvgsyFqDUFr7BPTuE5XUIJ94tSV52JfWFRk0KeLMrxFTlDGa6qTcdTlue3qsE
	nUxxjivqmkO5PfaazwIQOLwnN9rcy+ZIwwOUnE/RolrIITy60NbMnbzm8Cm2SMEnKjmHop62U0h
	6DQlFHn6L4QJUjuv3Q0CBIOIY9z/ooUMxj3S+N2n858DRZ7QM1Xe0Heyl9torBmM8cB6G82GZNJ
	PShYv5ytbLML753297vDQxEwmKj0Y2Bdzz77du2swZAHhx0vxgTE9RM3k7G5g1+IXDTT2ewZV7H
	0tnk6uPlwEkWrm23ZUXardQA==
X-Received: by 2002:a05:693c:310b:b0:2b0:4f8d:2f5 with SMTP id 5a478bee46e88-2b7c86269c6mr3109235eec.2.1769903867836;
        Sat, 31 Jan 2026 15:57:47 -0800 (PST)
Received: from [192.168.5.81] ([172.59.162.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88c4sm16629608eec.31.2026.01.31.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 15:57:47 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
Date: Sat, 31 Jan 2026 15:57:43 -0800
Subject: [PATCH v3] selftests: hid: tests: test_wacom_generic: add tests
 for display devices and opaque devices
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-wacom_selftests_display_opaque_dev_tests-v3-1-0857d734ba4b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPaWfmkC/x2NQQrCMBAAv1L2bCBpoqBfEVlistWF2sRsW1tK/
 27ocRiY2UCoMAncmg0KzSychgr21EB4++FFimNlaHV70cYa9fMhfVCo70aSUTCy5N6vmLL/ToS
 RZjyEcmdzDU5r4+wTai4X6ng5VvfHvv8BILneZHoAAAA=
X-Change-ID: 20260131-wacom_selftests_display_opaque_dev_tests-4519c400143b
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Erin Skomra <skomra@gmail.com>, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alex Tran <alex.t.tran@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3418; i=alex.t.tran@gmail.com;
 h=from:subject:message-id; bh=A2imHiK3v0Yz1dKU+ScuWXsvDPrBAgY3nyGpXI0O6jE=;
 b=owEBbQKS/ZANAwAKAXT5fTREJs3IAcsmYgBpfpb6d4CCvqGbI/yYyyLXhkEuWPF7BzIWuPFC3
 2DUyp3quymJAjMEAAEKAB0WIQQAohViG04SVxUVrcd0+X00RCbNyAUCaX6W+gAKCRB0+X00RCbN
 yM/ID/0ViEywEuGbybN3vljzgTIG3XJWbwqrkBumQBpuXo98n/q92SbyWmFOfgxU8jXmsZd0AN7
 KaPiTUdmZvgYzusipQq9y8oKEy3qvXMWEDIefQhLeFnuhbeKoMK1FvuVuYZ/sMQCYPLdN+YqmYE
 vvFhO4xhvYLZqBj8myUEjqxuc1w/RA+IgOxezGvVgEiPbvCxcn+44eLYT6dqdyyl8STwIINP6B1
 6bMLn51a+j2qQpgG/pCEWDrn9wkg1u4pUXsAGZt/kih0AcaLO+GThpAZsql2kYpc02KzMKMOyYX
 +ucZ6cZjZfiy5kjp5Y04NJ33eKaIGuFvjj403zQqTBNml4RSAkDF1A/SE3r5RYOQr2YG8oMSC7k
 oXE4b6pOGoWzAsboqKBObx7L4t6m9Dci3P7ynpE3K9l3iOaiGH0GhW/3ztQBV2uR4N1FJok7N1Q
 9468z/iKtaVuSO6RV4ZCDfrZTAUo5mEXPs78uHRjUQQbvjeNZtKRHR4v8/yIsJLanBmRIT2atgQ
 KBDgDh00SgleBwiR+h9wBN6kugX3XIj8uw3w4zDxD92hShdENRUP44RT0S//zC7lCsfWet8v1Zs
 682goT8t0MmlbNt4GmIHtwV0bJbm7c5QLp34DVt+BIyyiHRI4KZY0Y+f1yBIn60d4I9HZe8Dj7S
 GRhtACLUFS76BFw==
X-Developer-Key: i=alex.t.tran@gmail.com; a=openpgp;
 fpr=00A215621B4E12571515ADC774F97D344426CDC8

Verify Wacom devices set INPUT_PROP_DIRECT on display devices and
INPUT_PROP_POINTER on opaque devices. Verify INPUT_PROP_POINTER
is not set on display devices and INPUT_PROP_DIRECT is not set
on opaque devices.

Moved test_prop_pointer into TestOpaqueTablet. Created a
DirectTabletTest mixin class for test_prop_direct that can be
inherited by display tablet test classes.Used DirectTabletTest
for TestDTH2452Tablet case.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v3:
- add assertion for prop tests where opposite is not set

Changes in v2:
- Removed the tests from the BaseTest class
- Removed disabling tests for certain subclasses
- Moved test_prop_pointer under TestOpaqueTablet
- Created DirectTabletTest mixin class
- Moved test_prop_direct under TestDTH2452Tablet
---
 .../selftests/hid/tests/test_wacom_generic.py      | 34 +++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
index 2d6d04f0ff80bea46dc6c61c2b3a43383be6ac50..3903f479b15bdf8937a9f1ae96791f6dee0f89b7 100644
--- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -598,18 +598,6 @@ class BaseTest:
                 if unit_set:
                     assert required[usage].contains(field)
 
-        def test_prop_direct(self):
-            """
-            Todo: Verify that INPUT_PROP_DIRECT is set on display devices.
-            """
-            pass
-
-        def test_prop_pointer(self):
-            """
-            Todo: Verify that INPUT_PROP_POINTER is set on opaque devices.
-            """
-            pass
-
 
 class PenTabletTest(BaseTest.TestTablet):
     def assertName(self, uhdev):
@@ -677,6 +665,15 @@ class TestOpaqueTablet(PenTabletTest):
             uhdev.event(130, 240, pressure=0), [], auto_syn=False, strict=True
         )
 
+    def test_prop_pointer(self):
+        """
+        Verify that INPUT_PROP_POINTER is set and INPUT_PROP_DIRECT
+        is not set on opaque devices.
+        """
+        evdev = self.uhdev.get_evdev()
+        assert libevdev.INPUT_PROP_POINTER in evdev.properties
+        assert libevdev.INPUT_PROP_DIRECT not in evdev.properties
+
 
 class TestOpaqueCTLTablet(TestOpaqueTablet):
     def create_device(self):
@@ -862,7 +859,18 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
         )
 
 
-class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest):
+class DirectTabletTest():
+    def test_prop_direct(self):
+        """
+        Verify that INPUT_PROP_DIRECT is set and INPUT_PROP_POINTER
+        is not set on display devices.
+        """
+        evdev = self.uhdev.get_evdev()
+        assert libevdev.INPUT_PROP_DIRECT in evdev.properties
+        assert libevdev.INPUT_PROP_POINTER not in evdev.properties
+
+
+class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest, DirectTabletTest):
     ContactIds = namedtuple("ContactIds", "contact_id, tracking_id, slot_num")
 
     def create_device(self):

---
base-commit: 79b95d74470dd97d7d0908d5a3c0734a23e51aa4
change-id: 20260131-wacom_selftests_display_opaque_dev_tests-4519c400143b

Best regards,
-- 
Alex Tran <alex.t.tran@gmail.com>

