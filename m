Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D323A4AA5
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939331; cv=none; b=S+PP2a98WqSlXzQVfUS2jDaY6JUSyVmhWB4P6FREK4CfOOFh9+/vPrx2LEMnRPm6CcUdmwrZXoZhpIUf/k3d8RS1Cn29YCw911rjlg3S57oQ51medafRHlpoUEztM2nnLpgqHLmj/CzbhVZfHkiiPrUU6JctaCGUKffGWh6LeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939331; c=relaxed/simple;
	bh=s3MFiEXE/Shhm2XnisHmzrG0GP1tx5iDWolDoOrDhu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRA3H0TX8nTmyKolY5+VJASCXSxyFL9uWzJXM9Xyqx+TXEdrkGPrgQb67QxFMMl3xFCWo3H5lhHM17jiF1WonmJFubY+ZStNGjCPC0cjnMDK2I9RPQPbjLGtb1P+4VE7tPYKGyZ3nXw/Mk6WB9csWmLR79JLX6eMPn4GL1obKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4PIdRx1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4PIdRx1"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c52c1d2a7bso21218785a.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939328; x=1769544128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOI2obtzi7kytuUVUqjlq8TnMN+hzrsORj4dJl4sJSc=;
        b=H4PIdRx1RgvxV9KPM3OFJWx+S+8mIkhp4Rj2L/pJvMdvpKi1Amn5NQotggTh649R15
         noe5N/JRuqKAzhYmCfo4J32d+d+6W1Hb1N2ptUn5A53dHx5L/LwSrYIYprbLfLjQvDOw
         ySfnGUVkmzd6S4OoNsEAwLCScNadT8cPz/PHAZrfWowwREjiTjbBwnOaPxj5ve8Wr7Qr
         qCZnUz6dVni0aPyyqN2/S1Yhs2h1akSEmPThUVAlAGnxe2vUh3VCSMJN07Wzloc/21FV
         EpJPzP4WBwLhhqUs9jwYV92ea5AnNAqBf/NjYDNtEF1yKCJegb4nyW6C2wUV/C8kOfBT
         7xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939328; x=1769544128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOI2obtzi7kytuUVUqjlq8TnMN+hzrsORj4dJl4sJSc=;
        b=n0zpTx3ieKr2WInw1KCXSul4+1uLbCmHr2/uy9pfmK+tVh253u7zGP+Ppk70ljCDjx
         Enba3ngkIN4logO4zQJe4scf/CnSjUlBlBG3FNeOZ3edaTiMTzA8wkXMWisn0PTHR7kD
         KAQ1Q2t0en169FZDjXHjtEx0p+aY5UjZy3QbM3labJDwCxbUbFt3ddoe7u6EA8tFSMgb
         7LFQrFDa/mVTRN+eQFUtPDU05RRHdo13R2VZ6AGv1mnslYxVKlakTjeQjzEVhqhICEuP
         N52A4tcdtxGV0MesgqCDl84eUvXpZ4bKad6QV+hXlU501ZIF+63xBQwZ/c83xyH+txKh
         z/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/4AHf9UGgpQkBoVAPU9XY2AeO45Kszi/i8WiO/fIxe8u50G451b938TQ+oBvEHllEZmt6uz8WylWLRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySNQ5WytvKQ7qUrQAqMU3Dv9lhIboKq0UysJ2MGPIkWTZ4NXzj
	0Sha5LI7T4Tm2RTpH4NRREIjX4WJYNP2CqUGpOPPlGqgwi+JW6RQHQFK
X-Gm-Gg: AY/fxX7UiWGHAtSSNmNr+EO9aOidg0gf6eu8wabs2k4cIkJOIKavkSY2KvHRl06t768
	9IlpHyi+M29ZSNXGCTYDtUOuXVQ/uQ1gXekgch3p3yKP02hOr2uDzC8lPGh6erhPFh51h2L5Qnt
	WLJkRkIz2W2DzMQz6pKYjSTc5CHdLNQpf3PhViln+03wWiNpWIdDeCUb6DneyotPZG9Ek8yv+OO
	5LqKIVe0c7b0yjp6U07QbW3wu8fs/zz2wlE5s+ZBna7YyovYBzdvEwN3t7hiEvCbduCYEUDKA2M
	TJ/+gpGuYmGiOn7cTW9lqMQXmdHm7n7JqXEb1rUGXx/w5cwXpdvLovz6NjiPmf/CMGVAIH6o3ZC
	WJKcKKWtKufbyRYPj15jS+FKdtEzu1nWEThJJSGKVJV/KoMlFM7MkGEYgNjazgL7D+g5Z8OhmN4
	LFaSryJHAB99VYKLXPrSSDPSAF90rzGvSBbzTsd5/IPs/dHvNg7fkOZKQqwbutAFg/TLWEMQ==
X-Received: by 2002:a05:620a:7103:b0:8c5:36be:7c20 with SMTP id af79cd13be357-8c589b84dadmr2456896585a.3.1768939327680;
        Tue, 20 Jan 2026 12:02:07 -0800 (PST)
Received: from benjamin-desktop-fedora.mynetworksettings.com ([141.154.77.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7298472sm1112863585a.53.2026.01.20.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:02:07 -0800 (PST)
From: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
To: srimanachanta@gmail.com
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] HID: steelseries: Use device data for battery requests
Date: Tue, 20 Jan 2026 15:02:02 -0500
Message-ID: <20260120200202.1225216-4-benjaminwheeler0510@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
References: <20260112041941.40531-1-srimanachanta@gmail.com>
 <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This eliminates several functions that are no longer needed.
When making a battery request, the required data to do so is simply
pulled from the device struct.

Signed-off-by: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
---
 drivers/hid/hid-steelseries.c | 93 +++++------------------------------
 1 file changed, 11 insertions(+), 82 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index dabc4763f072..1200213bc8f3 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -809,44 +809,17 @@ static enum power_supply_property steelseries_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 };
 
-/* Forward declarations for battery request functions */
-static int steelseries_arctis_1_request_battery(struct hid_device *hdev);
-static int steelseries_arctis_7_plus_request_battery(struct hid_device *hdev);
-static int steelseries_arctis_9_request_battery(struct hid_device *hdev);
-static int steelseries_arctis_nova_request_battery(struct hid_device *hdev);
-static int steelseries_arctis_nova_3p_request_battery(struct hid_device *hdev);
-static int
-steelseries_arctis_pro_wireless_request_battery(struct hid_device *hdev);
+static int __steelseries_send_report(struct hid_device *const hdev,
+				     const u8 *const data, const size_t len,
+				     const enum hid_report_type type);
 
-static int steelseries_request_battery(struct hid_device *hdev)
+static int
+steelseries_request_battery(const struct steelseries_device *const sd)
 {
-	u16 product = hdev->product;
-
-	/* Route to device-specific battery request handler */
-	if (product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_7_P ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_7_X)
-		return steelseries_arctis_1_request_battery(hdev);
-
-	if (product == USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_P ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_X ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_DESTINY)
-		return steelseries_arctis_7_plus_request_battery(hdev);
-
-	if (product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
-		return steelseries_arctis_9_request_battery(hdev);
-
-	if (product == USB_DEVICE_ID_STEELSERIES_ARCTIS_PRO)
-		return steelseries_arctis_pro_wireless_request_battery(hdev);
-
-	if (product == USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_P ||
-	    product == USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_X)
-		return steelseries_arctis_nova_3p_request_battery(hdev);
-
-	/* All other Nova series use the same battery request */
-	return steelseries_arctis_nova_request_battery(hdev);
+	const struct steelseries_report_data *const report_data =
+		sd->info->report_data; // Alias
+	return __steelseries_send_report(sd->hdev, report_data->data,
+					 report_data->len, report_data->type);
 }
 
 static void steelseries_battery_timer_tick(struct work_struct *work)
@@ -854,7 +827,7 @@ static void steelseries_battery_timer_tick(struct work_struct *work)
 	struct steelseries_device *sd = container_of(
 		work, struct steelseries_device, battery_work.work);
 
-	steelseries_request_battery(sd->hdev);
+	steelseries_request_battery(sd);
 }
 
 static int steelseries_battery_register(struct steelseries_device *sd)
@@ -895,7 +868,7 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	power_supply_powers(sd->battery, &sd->hdev->dev);
 
 	INIT_DELAYED_WORK(&sd->battery_work, steelseries_battery_timer_tick);
-	steelseries_request_battery(sd->hdev);
+	steelseries_request_battery(sd);
 
 	/* Arctis 9 may need a retry */
 	if (sd->hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9) {
@@ -1685,50 +1658,6 @@ static const struct attribute_group steelseries_attr_group = {
 	.is_visible = steelseries_attr_is_visible,
 };
 
-static int steelseries_arctis_1_request_battery(struct hid_device *hdev)
-{
-	const u8 data[] = { 0x06, 0x12 };
-
-	return steelseries_send_feature_report(hdev, data, sizeof(data));
-}
-
-static int steelseries_arctis_7_plus_request_battery(struct hid_device *hdev)
-{
-	const u8 data[] = { 0x00, 0xb0 };
-
-	return steelseries_send_output_report(hdev, data, sizeof(data));
-}
-
-static int steelseries_arctis_9_request_battery(struct hid_device *hdev)
-{
-	const u8 data[] = { 0x00, 0x20 };
-
-	return steelseries_send_feature_report(hdev, data, sizeof(data));
-}
-
-static int steelseries_arctis_nova_request_battery(struct hid_device *hdev)
-{
-	const u8 data[] = { 0x00, 0xb0 };
-
-	return steelseries_send_output_report(hdev, data, sizeof(data));
-}
-
-static int steelseries_arctis_nova_3p_request_battery(struct hid_device *hdev)
-{
-	const u8 data[] = { 0xb0 };
-
-	return steelseries_send_output_report(hdev, data, sizeof(data));
-}
-
-static int
-steelseries_arctis_pro_wireless_request_battery(struct hid_device *hdev)
-{
-	/* Request battery - response will arrive asynchronously via raw_event */
-	const u8 data[] = { 0x40, 0xAA };
-
-	return steelseries_send_output_report(hdev, data, sizeof(data));
-}
-
 static int steelseries_raw_event(struct hid_device *hdev,
 				 struct hid_report *report, u8 *data, int size)
 {
-- 
2.52.0

