Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1243CEFE
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782816; cv=none; b=I3F0gD6nsQ6jchMz86lEGR9s2oRuP654WYHnWl8hDe/vUadH5rFm5n1/zY5N0vKeNHp4BGINk+U65L07QRCe+lmAPUztE0yjGAumwWqrSj5kIAn6nBbiuH3oUpShXajKBOWnv73AJBNhcQ1U/qu+hczt+gFtQFVrpv3KNxAyOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782816; c=relaxed/simple;
	bh=PisLEpAU851Mg7Pg4lhKpGxGkR/wS0p10CRwuDaFrww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVjtTvp4aKm3nsrZZelGWBDTSk5Nr5yfxo2idQCZPn9Cy951aA2Av1m9kysm1tdCb5OdHjwHqMHG78Cy1T7Yid+9POxUQGqlvE5jMoTSBIkmgXaKF0PvfQccwDkZmYwUBs7GKVTs0WNf47cuS394ESuACm5eynKZfBbJWwUvXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBuYwrgN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBuYwrgN"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-caf45fc5202so2529424a12.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782811; x=1786387611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w0IDthsjYtA6pK63nJE/aU6irDSAEPiJfPVdmQsfY5g=;
        b=gBuYwrgN/EuB1cyNYRUCJQJ9PJ+8H+07p7KTmI/v75T0poKS9DB50/s+aih/WpTcg5
         SCMRyyI1BgWKUmThW8Frwvo0RUfyHchefsSSxOW83IHbbChAsvmrLbZhgsYUaEH74dAq
         FBBbGLl0lSU+zzj0IsVNRge+pKm45ZsV6CxFQAbXJS+RYhyNVMNGw1ISUg1+/71zdXH3
         hfaIfWMCeUNYLlR26keESeBBgVzt4ZsaNtKCKmBiIW4LegbxRvj5lpuKwCqyxxSk/noE
         ibMGWoct7ezjPOE6rIitB2uTA9xxqkOb50mHWJrUNhmmpDtjUViBsnunyKbPJQ3c1xpO
         3kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782811; x=1786387611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0IDthsjYtA6pK63nJE/aU6irDSAEPiJfPVdmQsfY5g=;
        b=Dzy3Ypf/oBgeHylZ0eOcalLKUQhr1oQhi+T1gteEv/ZutCo47jSlsMGSwprlwCrvRZ
         MHYgTAUZodFa059f9kUjIaSYx2Ec82DThE/ibIC5D8uwpwKR85yRWolfdwx+zfzns8hm
         5ql4d9dS9n9yHMNY01rXaAjBuaWOUV15d7fv51L8ZuGSr35pntQ2S3qXevxky6nga7Kn
         Di/zIZyjPtPFg7By1K5DHFqC1ySvaZ3AmNWeggapj0Ig8Kildxc/hKZX9ruZbRrQHr9k
         Q3jCy94T5yL0scMzCUXJ8gy5hdTrceAjm2PF3pCq4RoQjk2tuu2ktuIwtDBlNt98p9Px
         limA==
X-Gm-Message-State: AOJu0YylgG08c4WPY3KsxQ6j112pthmJOZ+Bd4HmKXHduh86WsHW89yg
	RYuubWthgegX/AaPWYfXFNv0n7EBoQgdrMDrPuy4G38nfZsY3zG/Sywp
X-Gm-Gg: AR+sD11RLhzSecMzC9yPAipLbk3yQW0iqh74cHWCO1vhbSJmAuWMiQL6usOdnM/28/0
	YKBPhkcNXXTrY2c6OWXeDLl5FQJ7/GFjqh3vfBduplPvyYzVQ2EMokAVzIAmrRfIZF0WMgKRTKT
	WgaO7mdq3VK8tUKhLi+qN7QtK5DYtnJBMleKHaD2XexW8duOJ3LPaBfwz+LSU45m+/gDSXTPALC
	7l7Ay6mMpyn6PXbNqoJhDZiLo1p0+ezctlvDjUebYrEbgpjb3pCMvF70VESIX/Bsb5UOEjkxA+Y
	31ViE3jHqsHT/5ljc+xkAxbiRv2pqH1ZR6zSksha8IqhBZVWLExDS1rCojGUIxkn8FGCH7lx1ZK
	VpJrxWyvH24rPOF6u0NCwFnG8Cb6NQ0bX5X22o2e0rXBu4cIYe88rc+IHU+UnHtWs2P2adCHqM0
	6YFMLLEJ3Runc++Bp1aj7ta2p/rHGOiyyb39fHt5nYyQd/tbIxttcTylUqu9DBJsuDgtUuvp4X0
	Er6dUicFZLwRQHqEbNrQreRmv4zbt92fX3osOTGPc1KHUPsMC2h
X-Received: by 2002:a05:6a21:7a46:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3c92a8139c6mr11132293637.38.1785782811369;
        Mon, 03 Aug 2026 11:46:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:50 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:37 -0700
Subject: [PATCH 12/21] HID: move generic FF initialization into
 hidinput_connect()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-12-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

Generic force-feedback initialization (pidff) currently happens in
hid_connect() after hidinput_connect() has already registered the input
devices. This is racy as the device is live and visible to userspace
before FF support is fully set up.

Move the call to hdev->ff_init() into hidinput_connect(), ensuring it
runs before input_register_device() is called. This closes the race
window for standard PID-capable devices.

The initialization now also checks (connect_mask & HID_CONNECT_FF) and
!hid_has_ff_input() to avoid conflicts with custom FF implementations
and respect driver opt-outs.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c  | 21 ++-------------------
 drivers/hid/hid-input.c | 21 +++++++++++++++++++--
 include/linux/hid.h     |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2767a171eae9..d8cba852d2b5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2287,18 +2287,6 @@ static const BIN_ATTR_RO(report_descriptor, HID_MAX_DESCRIPTOR_SIZE);
 
 static const DEVICE_ATTR_RO(country);
 
-static bool hid_has_ff_input(struct hid_device *hdev)
-{
-	struct hid_input *hidinput;
-
-	list_for_each_entry(hidinput, &hdev->inputs, list) {
-		if (test_bit(EV_FF, hidinput->input->evbit))
-			return true;
-	}
-
-	return false;
-}
-
 int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 {
 	static const char *types[] = { "Device", "Pointer", "Mouse", "Device",
@@ -2324,8 +2312,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	if (hid_hiddev(hdev))
 		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
 
-	if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput_connect(hdev,
-				connect_mask & HID_CONNECT_HIDINPUT_FORCE))
+	if ((connect_mask & HID_CONNECT_HIDINPUT) &&
+	    !hidinput_connect(hdev, connect_mask))
 		hdev->claimed |= HID_CLAIMED_INPUT;
 
 	if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hiddev_connect &&
@@ -2347,11 +2335,6 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 
 	hid_process_ordering(hdev);
 
-	if ((hdev->claimed & HID_CLAIMED_INPUT) &&
-			(connect_mask & HID_CONNECT_FF) && hdev->ff_init &&
-			!hid_has_ff_input(hdev))
-		hdev->ff_init(hdev);
-
 	len = 0;
 	if (hdev->claimed & HID_CLAIMED_INPUT)
 		len += sprintf(buf + len, "input");
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..70ec1b7e7d38 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -2317,7 +2317,19 @@ static inline void hidinput_configure_usages(struct hid_input *hidinput,
  * Read all reports and initialize the absolute field values.
  */
 
-int hidinput_connect(struct hid_device *hid, unsigned int force)
+static bool hid_has_ff_input(struct hid_device *hdev)
+{
+	struct hid_input *hidinput;
+
+	list_for_each_entry(hidinput, &hdev->inputs, list) {
+		if (test_bit(EV_FF, hidinput->input->evbit))
+			return true;
+	}
+
+	return false;
+}
+
+int hidinput_connect(struct hid_device *hid, unsigned int connect_mask)
 {
 	struct hid_driver *drv = hid->driver;
 	struct hid_report *report;
@@ -2330,7 +2342,7 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 
 	hid->status &= ~HID_STAT_DUP_DETECTED;
 
-	if (!force) {
+	if (!(connect_mask & HID_CONNECT_HIDINPUT_FORCE)) {
 		for (i = 0; i < hid->maxcollection; i++) {
 			struct hid_collection *col = &hid->collection[i];
 			if (col->type == HID_COLLECTION_APPLICATION ||
@@ -2396,6 +2408,11 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 			continue;
 		}
 
+		if (list_is_first(&hidinput->list, &hid->inputs) &&
+		    (connect_mask & HID_CONNECT_FF) && hid->ff_init &&
+		    !hid_has_ff_input(hid))
+			hid->ff_init(hid);
+
 		if (input_register_device(hidinput->input))
 			goto out_unwind;
 		hidinput->registered = true;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b240baa95ab5..451c3e05d167 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1021,7 +1021,7 @@ extern void hid_unregister_driver(struct hid_driver *);
 
 extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
 extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
-extern int hidinput_connect(struct hid_device *hid, unsigned int force);
+extern int hidinput_connect(struct hid_device *hid, unsigned int connect_mask);
 extern void hidinput_disconnect(struct hid_device *);
 void hidinput_reset_resume(struct hid_device *hid);
 

-- 
2.55.0.629.g250fe7f194-goog

