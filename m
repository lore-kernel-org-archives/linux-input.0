Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636018;
	b=CcHbN55RwXwRDi3tM9HjsyzeVS0Ja32wDl+WpgCKiXsg9z3CM0VUqSeUinfhrRlCf1tJ
	 JNOagsClvaj+LeZ0eOg0uy6QcaIL43F0lOQ7+UcSTlQedevpdrvc4/Y9Zf8og5+kKYvJV
	 GzeCR7PzuH1Zj6gSe2EvnPP82djR+1RzDw464pPA9Q/nb1dPIQDX3CStnCTNv1INJ82Oe
	 pkCaeqd/HTGPAC3rb7qTgkSogSLQPCY49ON5oozIlLTPG0yDiCJBHLxdjre721QXtjxkT
	 ClT+3W0lztsug7IOV4V9lsBIGGgmTPGqwYP3gFCYWgFeUKGd7BCFVpWCpSJWSV2X3Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=dlG+khQPd25/hUUsJ/zyks0f3vmJYhvo8pnfsQXvBJY=;
	b=CYbxJL4uMRtg5QWmXlOplqtNGGZ0W2/QGT7i9O+QVjwO711HDrdd15zeD/bNfNVkm2xw
	 5wargnNy0YlUVANnB3rgtYZ9jAsiLS0+OzXbn1CRIB+JZpk+T5VGs27H+RWfnEdzPeZEH
	 yTM/J/ga4caBkY4k+aQ2VLJqTcNLCssrp76MHr6hOF1c+bg5b3Hw6fhWKgP/Ardp7C8on
	 avR0k5tGOxlSfR+rHmLw7H8qr9XDq/irS81n+hOh0UJD6HBikyQjyn2EWzGEjJtPwon0c
	 DF7Lt6MUsVB14xr3PSzj4Fgm1EpO3RR92VOrbvHQxo9aC9OZ9nfVl5CHlTQY92Falfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3cWz6Zc;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076260A383A
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5076260A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3cWz6Zc
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1167272c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636017; x=1795240817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlG+khQPd25/hUUsJ/zyks0f3vmJYhvo8pnfsQXvBJY=;
        b=h3cWz6Zc2vzDK4xom1UDH8Q2LcF+ZIqJvem3okgO88EpF/LrswJNAGpcj48vlHNOK5
         Fe4JDzWY99iQNUd+I1ZZqUQgElSQcmu0JTWPoUHkPrt7+5WnD6VIptDyZdZGS1stKyBk
         ZJcb2JT9Ta8Men30ib+y+O6/KDgwoDl9w3yZRay5Y1fJe0cSz3c/+bCIIrQUqqGqkKbH
         6w7PbvSRYZkzsKUHaGnM7NIlUPDIVE/sexWIFHkPnZuVl2XvtbXqhLdt7SQfwMGYNzan
         NZSvMBSZQPwRLzWPFcOO7J4lrdYGMqOY9u75tb3rJ38uUfIAdp+WTZ72rlr40h+af6HV
         0CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636017; x=1795240817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlG+khQPd25/hUUsJ/zyks0f3vmJYhvo8pnfsQXvBJY=;
        b=rn0RdRBgAE5QZ70VsWydYcnPCXs66n674lLFQeYyOIifMOheZbXcya+IacbJpl337T
         QLt+tGpdMdXpk3gMTX4j/VSO0Woyf1eEyvp9py6xk4+JpJJRVfxiTTx7IyQgPhcbdkHS
         j88ZoGQ3Q3q9XgBguSbAV7Hk4vQAVE4oH32JcO7Ug6R1zwhnRNb/+SvcW7tdv99ULm5g
         4iRlJvGhpTy+XQRVtLFiqHWo2NUCZ8MPpde9Got0VI0/mgGELAA/Bhdkpdhtx7L6vFQd
         LlKE67QN3CiOUVX+u8a3wgOqRvSr4ToODhu8c/n/4Pxm0J+IXjZQbQYX7ghBdyiqin3U
         KGLA==
X-Gm-Message-State: APuU4Z/6xAcU+iUNyrVsVWd4NChzTnZ1OriA+2zasQabyvcZX8qp/W/Q
	pdSXZkhXnRnyPJ6AiGOFy6/nb6ErUUVGVXY6T6dGTte5slxuyKtZdHgr
X-Gm-Gg: AYBFou0/uVfvKYV/R7q2r1ngetTHvs5Oi0vjRorJDgFS5xaNrbFWCiqNAarQTw1nZfM
	jM4tOwHDnsZjl9htNUzbnO8yQxmhGll2v04aGQCoT7KTLMR64gDThkHBW+SJFyxQKHw45+zeMCj
	EQ2PrI6o4o3Zc2tA27S+tXLTGIcxsKa75fjxxUesIrP1uSaisuu+kH+tu8boD0uYZCL2pUTYAj+
	Kj8aCu6VRK/05A3diTJzEJVS2UWsxejRJbPLmUvHHMsA3Ma/uhNDB/Z86tjDE+jGigKMhV5/1HP
	h4CXzyCV4KSfe3fpBkEETVk0FpREmI3mxn4ib72N0zFVTdIWoVK7i4kBNZJ1T7t0msTlRZ9JLZJ
	bd1Orx5KnO+lujrOX1wXnlc6+HwzceaGl71ksO/cjJ7pIw+/a/Yh77H4RDrG9d28VCaQ5bVwczm
	BJJIs+QSO6+VDwkIz9GE3lICzH1YPi8eBe4eYDNbIzJmkq3gNyBRg3QL0LN91CuWqF7HzIoQw2K
	GRDnILXy64KC5EwtNsrek9Ir0LdGOH1AjzshPXVGJ46CrWkRYAkNn828lIgJ47Za+4uFwt7oekp
	/+JPF2XfLUJwOxwQXA3YDa8vIY6wsyiN33F8tNSotW2b15w2up8MiVdxODVKKeQi6rB/JDwUTso
	lQc2kBADdoKUTzcSi468xjNeTlZbsaka+pzcZVg==
X-Received: by 2002:a05:7022:3a87:b0:1b2:5884:a020 with SMTP id a92af1059eb24-1b50302ac09mr4765175c88.6.1794636017116;
        Fri, 13 Nov 2026 22:00:17 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:16 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 22:00:01 -0800
Subject: [PATCH 11/12] HID: rmi: remove dead code and reorder report write
 helper
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-hid-rmi-v1-11-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Leftover unused definitions, unreachable control flow, and an
unnecessary forward declaration clutter the driver.

Drop the dead code, remove the redundant pointer cast, and move the
report write helper ahead of its callers to eliminate its forward
declaration.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 67 +++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index ec0d18cb06f6..d5961d408e72 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -39,13 +39,6 @@
 #define RMI_DEVICE_HAS_PHYS_BUTTONS	BIT(1)
 #define RMI_DEVICE_OUTPUT_SET_REPORT	BIT(2)
 
-/*
- * retrieve the ctrl registers
- * the ctrl register has a size of 20 but a fw bug split it into 16 + 4,
- * and there is no way to know if the first 20 bytes are here or not.
- * We use only the first 12 bytes, so get only them.
- */
-#define RMI_F11_CTRL_REG_COUNT		12
 
 enum rmi_mode_type {
 	RMI_MODE_OFF			= 0,
@@ -104,7 +97,34 @@ struct rmi_data {
 
 #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
 
-static int rmi_write_report(struct hid_device *hdev, u8 *report, int len);
+static int rmi_write_report(struct hid_device *hdev, u8 *report, int len)
+{
+	struct rmi_data *data = hid_get_drvdata(hdev);
+	int ret;
+
+	if (data->device_flags & RMI_DEVICE_OUTPUT_SET_REPORT) {
+		/*
+		 * Talk to device by using SET_REPORT requests instead.
+		 */
+		ret = hid_hw_raw_request(hdev, report[0], report,
+				len, HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	} else {
+		ret = hid_hw_output_report(hdev, report, len);
+	}
+
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to write hid report (%d)\n", ret);
+		return ret;
+	}
+
+	if (ret != len) {
+		dev_err(&hdev->dev, "short write to hid device (%d < %d)\n",
+			ret, len);
+		return -EIO;
+	}
+
+	return 0;
+}
 
 /**
  * rmi_set_page - Set RMI page
@@ -162,35 +182,6 @@ static int rmi_set_mode(struct hid_device *hdev, u8 mode)
 	return 0;
 }
 
-static int rmi_write_report(struct hid_device *hdev, u8 *report, int len)
-{
-	struct rmi_data *data = hid_get_drvdata(hdev);
-	int ret;
-
-	if (data->device_flags & RMI_DEVICE_OUTPUT_SET_REPORT) {
-		/*
-		 * Talk to device by using SET_REPORT requests instead.
-		 */
-		ret = hid_hw_raw_request(hdev, report[0], report,
-				len, HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
-	} else {
-		ret = hid_hw_output_report(hdev, (void *)report, len);
-	}
-
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to write hid report (%d)\n", ret);
-		return ret;
-	}
-
-	if (ret != len) {
-		dev_err(&hdev->dev, "short write to hid device (%d < %d)\n",
-			ret, len);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 		void *buf, size_t len)
 {
@@ -412,8 +403,6 @@ static int rmi_raw_event(struct hid_device *hdev,
 	default:
 		return 1;
 	}
-
-	return 0;
 }
 
 static int rmi_event(struct hid_device *hdev, struct hid_field *field,

-- 
2.56.0.679.gc527c65306-goog

