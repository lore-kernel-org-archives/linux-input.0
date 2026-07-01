Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD674968F6
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926034; cv=none; b=mRPWbE8BzooI9MwNvQ0Ifg8xRsSNEPV148nLoTV4/qZfsqmL05YBBcZYDUhH+3hGwYeGU8i8hslIsNHQ8cgv1aIZSMgllmJZybr0D6HdTFRQGNge00lXNYVFOupwIXQonSo4wT18e32j0UhlPS0t6NvuCbWWFWlj4a9e8YtKMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926034; c=relaxed/simple;
	bh=aX+b6stSXbvbCLvNaywrRDff11ZszdhZCoQEsYdRPx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL4guQrTf5vXGF2+n7PB0HcxKawjnBt6oajg0OY5QaxuKxVAQwJntk+wmlBDel/5wmLSsXL6dlTSQk6lL0oakqsvZAB7i6o5D0GT0AYJHA9fFqfvLkrIL9ddWNDzXBqIfF7f6VTiVIKehivMSHnttNI83V6IWFlUYja3GTBXkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cystack.net; spf=pass smtp.mailfrom=cystack.net; dkim=pass (2048-bit key) header.d=cystack-net.20251104.gappssmtp.com header.i=@cystack-net.20251104.gappssmtp.com header.b=tyTR4EYa; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cystack.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cystack.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cystack-net.20251104.gappssmtp.com header.i=@cystack-net.20251104.gappssmtp.com header.b="tyTR4EYa"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2c9f52ad059so3372715ad.1
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2026 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cystack-net.20251104.gappssmtp.com; s=20251104; t=1782926033; x=1783530833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDOhWO02xhzurUfA2UXQXMdQzVrek1e0JWgIJjmjJbw=;
        b=tyTR4EYaAPQukLIB+Y4tHGxFLi5amaujULxIiw70V5F3HTAIGLkOljEPnRSQzEkmZ4
         FXMCvhlfxy8A83Qx072aGk6+hIZADG5DzrsVtUNfWA8FrDq5TS+n2ndOoHT/DujPPXK2
         0Qz1sizLPf1M0sEnbR9wPtSUFdkKkG42yEcHmCbkyF2SYQZkkRswJN5TaLwsUaXESm+k
         Wz7/DJ/DWQ+DRUUrnssFo6CYIExAX5Bm/aKXZl8D3ytgCX7621e2ABQD22uhqC1BMrJc
         chbqxVTf+EnrhxTYjsLFWP0+N0xmq58hxSnMvC0iSrbjLn3ATnG5CCQ0vLbsvuRG2NJk
         PhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926033; x=1783530833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDOhWO02xhzurUfA2UXQXMdQzVrek1e0JWgIJjmjJbw=;
        b=lbH/C5bZ9bnJ7HrE843RbNJQq0Da0Kg5sOaSm2iEy/9YTD9pKoFjlgwgtVGdJAzLJQ
         zlpF3tACU+KbOVx4dl3DbV4ul+LZIFyvdIkK/Vu/7FTc9ZOu6jF/1ZHryUZ48NBLzlkr
         HH4BK0QI1Cf/VSKHAx+QUs/Y8IP66oVfNxjvWXwzc/pmlafa6VF89T4TXAWwdYZcxdH8
         n78NgAxkkDxjJPLbIqjS4eM4Px4eaG7qa5+Tsnrztr551Sr9NRD6HSpb1M6S1vqD1013
         RujQVnSDxbNiIDB/lP8Y8lw1K3Io1AAx3yfK+SxiBXv9rbt44Su0iwz1c92VfeCBwo5d
         7aoQ==
X-Gm-Message-State: AOJu0YwORlgo0pv7RXH/EUiw0aW/GUBkx331cKkz9+/YTlrLp7RLnhc6
	3DFpgTk06ZplyZVXPg2r8p3cEFAjYY8wqA4cjB354S91N7jeaV1JxC8i7VcvWBjs1Fk=
X-Gm-Gg: AfdE7cm1KBd9lc2/xedRfy26wra7LmqcShbsi2F/zPp7JDM10B2J503R88uBf0PTMTq
	4D2T59quScwkh6xER95BH7e6yN39w+3PR6bBUCdn7hGI6Ua33YkXfZs34KiUwP3z1prum/QaMGV
	bALSnkomC73jBRljGbGLRtWzj5i8KAH4O8L2T4Hmfk3HYqz0zf1hSY4sy3pVSDJy/CLcdqjpOz9
	Vra6FlIhSlM/Emj5gA/DXuhsWlnD7H2yOhFjXd85W2vzik5XEwrIDXt7IVuI8/YbpuvpHFcnPRR
	Jf0oK/Fy6bPNbcx+M4n5/tARnckP0IexeY+OjisbNUfUCzPMCDWqTGtQUPjX3GnE7nynBDEKRsV
	/xYstxMbHKM+erFC29ppwHH+U24HcyRgK4KrQS/nUwqxCNpzpYT/wvzqC/dZ+lpGl/RvOXvkH6G
	fLfvB9zuHRGp/ecp19g0Y4lxPdFxoq2Zo+IWXDLzrAl8pqn2AfMw==
X-Received: by 2002:a17:902:d548:b0:2c9:e8a4:811d with SMTP id d9443c01a7336-2ca7e880c39mr26962075ad.38.1782926032498;
        Wed, 01 Jul 2026 10:13:52 -0700 (PDT)
Received: from localhost.localdomain ([171.225.202.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8de800sm1329215ad.12.2026.07.01.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:13:51 -0700 (PDT)
From: Trung Nguyen <trungnh@cystack.net>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trung Nguyen <trungnh@cystack.net>
Subject: [PATCH 2/2] selftests/hid: multitouch: test a large ContactCountMaximum
Date: Thu,  2 Jul 2026 00:13:20 +0700
Message-ID: <20260701171320.16367-2-trungnh@cystack.net>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260701171320.16367-1-trungnh@cystack.net>
References: <CAO-hwJLS6uAX__aGkmpcDQ8v6GJaHGrL+TOYXVRX6jvjzNW+wg@mail.gmail.com>
 <20260701171320.16367-1-trungnh@cystack.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for the out-of-bounds bit operations on
struct mt_device.mt_io_flags.

A HID multitouch device can advertise a ContactCountMaximum far larger
than the number of contacts a single report describes, up to 255. The
driver used to keep the per-slot active state in the bits of a single
unsigned long and index set_bit()/clear_bit() by the slot number, so such
a device drove those operations out of bounds. The sticky-fingers release
timer made it fatal: mt_release_contacts() cleared one bit per slot and
overwrote the adjacent members of struct mt_device.

The new device advertises a ContactCountMaximum of 250 while exposing only
a few finger collections (a large contact count cannot be expressed with
one finger collection per contact within the HID descriptor size limit).
The test sends a single contact and lets the 100ms sticky-fingers timer
release it. A kernel without the fix panics in mt_release_contacts(); a
fixed kernel reports the release cleanly.

Signed-off-by: Trung Nguyen <trungnh@cystack.net>
---
 .../selftests/hid/tests/test_multitouch.py    | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools/testing/selftests/hid/tests/test_multitouch.py
index fa4fb2054bd4..7897340118b4 100644
--- a/tools/testing/selftests/hid/tests/test_multitouch.py
+++ b/tools/testing/selftests/hid/tests/test_multitouch.py
@@ -513,6 +513,79 @@ class SmartTechDigitizer(Digitizer):
         return absinfo is not None and absinfo.resolution == 3
 
 
+class MinWin8TSParallelBigContactMax(Digitizer):
+    """A parallel Win8 touchscreen that advertises a ContactCountMaximum much
+    larger than the number of contacts it actually reports.
+
+    Such firmware makes the driver allocate that many input slots (up to 255)
+    while the input report only carries a few contacts. This is what used to
+    drive the per-slot bit operations on mt_io_flags out of bounds. The number
+    of contacts a HID report can describe is limited by the descriptor size,
+    so a large ContactCountMaximum can only be expressed this way, decoupled
+    from the number of finger collections."""
+
+    def __init__(self, n_fingers=5, contact_max=250):
+        self.phys_max = 120, 90
+        rdesc_finger_str = f"""
+            Usage Page (Digitizers)
+            Usage (Finger)
+            Collection (Logical)
+             Report Size (1)
+             Report Count (1)
+             Logical Minimum (0)
+             Logical Maximum (1)
+             Usage (Tip Switch)
+             Input (Data,Var,Abs)
+             Report Size (7)
+             Logical Maximum (127)
+             Input (Cnst,Var,Abs)
+             Report Size (8)
+             Logical Maximum (255)
+             Usage (Contact Id)
+             Input (Data,Var,Abs)
+             Report Size (16)
+             Unit Exponent (-1)
+             Unit (SILinear: cm)
+             Logical Maximum (4095)
+             Physical Minimum (0)
+             Physical Maximum ({self.phys_max[0]})
+             Usage Page (Generic Desktop)
+             Usage (X)
+             Input (Data,Var,Abs)
+             Physical Maximum ({self.phys_max[1]})
+             Usage (Y)
+             Input (Data,Var,Abs)
+            End Collection
+"""
+        rdesc_str = f"""
+           Usage Page (Digitizers)
+           Usage (Touch Screen)
+           Collection (Application)
+            Report ID (1)
+            {rdesc_finger_str * n_fingers}
+            Unit Exponent (-4)
+            Unit (SILinear: s)
+            Logical Maximum (65535)
+            Physical Maximum (65535)
+            Usage Page (Digitizers)
+            Usage (Scan Time)
+            Input (Data,Var,Abs)
+            Report Size (8)
+            Logical Maximum (255)
+            Usage (Contact Count)
+            Input (Data,Var,Abs)
+            Report ID (2)
+            Logical Maximum ({contact_max})
+            Usage (Contact Max)
+            Feature (Data,Var,Abs)
+          End Collection
+          {Digitizer.msCertificationBlob(68)}
+"""
+        super().__init__(
+            f"uhid test parallel big contact max {contact_max}", rdesc_str
+        )
+
+
 class BaseTest:
     class TestMultitouch(base.BaseTestCase.TestUhid):
         kernel_modules = [KERNEL_MODULE]
@@ -1735,6 +1808,47 @@ class TestMinWin8TSParallel(BaseTest.TestWin8Multitouch):
         return MinWin8TSParallel(10)
 
 
+class TestMinWin8TSParallelBigContactMax(base.BaseTestCase.TestUhid):
+    """Regression test for the out-of-bounds bit operations on
+    struct mt_device.mt_io_flags.
+
+    A Win8 touchscreen may advertise a ContactCountMaximum much larger than
+    the number of contacts it reports. The driver used to keep the per-slot
+    active state in the bits of a single unsigned long while indexing
+    set_bit()/clear_bit() by the slot number, so such a device drove those bit
+    operations out of bounds. The sticky-fingers release timer made it fatal:
+    mt_release_contacts() cleared one bit per slot, overwrote the adjacent
+    struct mt_device members and panicked the kernel.
+
+    Send a single contact, let the 100ms sticky-fingers timer release it, and
+    check that the kernel reports the release cleanly instead of crashing."""
+
+    kernel_modules = [KERNEL_MODULE]
+
+    def create_device(self):
+        return MinWin8TSParallelBigContactMax()
+
+    def test_sticky_fingers_release_big_contact_max(self):
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+
+        assert evdev.num_slots == uhdev.max_contacts
+
+        t0 = Touch(1, 5, 10)
+        r = uhdev.event([t0])
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == 0
+
+        # do not release the contact; the sticky-fingers timer must do it
+        # after 100ms, which is where the out-of-bounds release used to hit
+        time.sleep(0.2)
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 0) in events
+        assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+
+
 class TestMinWin8TSHybrid(BaseTest.TestWin8Multitouch):
     def create_device(self):
         return MinWin8TSHybrid()
-- 
2.45.1.windows.1

