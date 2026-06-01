Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FE3112BC;
	Mon,  1 Jun 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337765; cv=none; b=X5xmRtSm1jIs9n3DGM8xdhXtmW1G6Onyx+ooHb1IZdb8Nx7XGwHBaTzrsXPxqAoPYmbyHyZIimlilzZXbXBeMtDTEDZLCDPcfPJ4AxtfKyMmFqTKcmTSjx5XX1c1v0a76X17v/V//FeGfQaglDVlMmgSswOcaDY9Ab+GuIy0Wtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337765; c=relaxed/simple;
	bh=NApgKG5/tgNAt+Kfh8sCAYFIUBXOpO+73yHttXZftzY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGI/Npsnv1lEJBqsYsbDIY1/BIEtFp4/oDdHGqLJReI+9Be9ujTHfqeJBue3TmCMJx0iJIasPi/o96ix6w600CKdAz/rOFgNv8H6gZ9TG+YT7ti885a2C7WO4Uq7dkjdZ53cvq2Ni/eC74XLm/YKhXIFrZ1X1f40nLDVpOasmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tKy8mKM5; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tKy8mKM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780337751; bh=6JMKDZqYi40kBPVsDSCvPlAVaRFZRBAY6xqgTH6VgdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tKy8mKM59coCkOs65sbg5Ydy8tYso+Z7QA0XieM/NDj7Oqcce7xFanK8d0K9SRF52
	 Zvn2RvMrhF1J4/o/wL+y3U7ZquWheLAKwdCH23W/8VVc/igWJHgbByySUDSi9bXOVC
	 yhXjPMToE0fRsdTyC87uKU9iDoNOJH9d25Mb7K4k=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3D41C48B; Tue, 02 Jun 2026 02:15:20 +0800
X-QQ-mid: xmsmtpt1780337736tbybx4xdk
Message-ID: <tencent_40B6AE07C59AEE0FE999A25DE70722109F05@qq.com>
X-QQ-XMAILINFO: OW/LS6eC+Rx6utjtlMtr14eBGS1cu/ufFaPKO3EgWqlvl0Kvibtk+zh8K+afKr
	 obhP35oWA2c4Z78YjwpLjpbkqj0MidelhbZbv0i9O99+PDS3ceuSopzTtAO98VYjpDHtHSzRRU+X
	 DPanFBsHIQzJoAq4hEFgN18SVqCPj2V6Sh4avutXW9LH/aotBCO1Xb6VA7D7Re3CSrLO0K0Qo5Oz
	 QB9jZkuM2lSC/vYUpBy0ACSneFd312iPKIQt38/qDb5m+QO+y5bQxkPiWpmQQKqVqVhlL3NYUGqN
	 Kaok3VNNmU6vWiYE/u/9Jfg8AbMPy84JP8PMWSgjKQf8t8MN8APmoO9+2jZBEDFJkCTV25nmCOCb
	 AplHBwudano07xLg6h5Rq/vajh/bsOfCig/4Zr5i51C6DbnBmSvRs0lH1JsFJrcYTHqwstbLzUTW
	 Z8Ex9IXfcWuqEjm6ZlbS1IZTeqY1PtBBwYQnaLnLCCBBzyLPtzUrnz06Z9x9f79s3Zb8vQ5ybyIY
	 LeASw0axon+0oD6oU5ewOXnuM5EO3hjlMwzMGiU8Caxmg7dSUUM98daHZSEONFDye0n1ewOI1/dm
	 64R5vGi8KM7UTjU7xN1dvyJekXFXGU0TGJLyOnPA3ocMLu72dyOP8H5BvV5QuH3uMsRJzeQo3aEP
	 pry+r3XgcJywmWamWGaHrZJ2TBnGH/uD3aviX80h277rro/mc2/KezS2F6qhOXbO+fljcMpGtQ8F
	 Qrzi2F3UBkLFzFD5QrCmqn6TiBvspTEak/1duD+rXu+ALVahL4Ma6bieO14oygyphiFcZ0OF4iso
	 TwCfTRT5GpaIlAejW9Px4EtVWMRRrsxf8pSiG1ZHZVj7P5Np8fhDcRSxTjJ82/BXvB/h39MukLQB
	 mcai3ne2i9R++WfqEMjMg674C+ArBW2o+egyc3Xgh2YQhSse4QGnWw9qOQNTCg97tWKGCKLfMDcB
	 pqYgVVqwlCikrUDSQDjMEL87KbS1MYzmC0UOZyD40sL5l4A+iFV26KABPVjrEebDsf2b+jL2ASco
	 F6CQj2FZTz/bebIEYsX7clvva5yTF5RRCGdHm26TTwcIVAHPfvzXbP82ifXPlPFk7Smps+CaMnmj
	 b/gwozPJh5X47hYH474KCAQcf9IMN1XkAAOKcIcRvXRdmgtnZBr8Ib6g8n1uJ0+LUtSOEQvM8NF0
	 IL3lTTS5r3jAE+pE6ziw+4nwzk
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: Yeking@red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 1/3] HID: i2c-hid-acpi: Move blacklist check to probe() before devm_kzalloc()
Date: Mon,  1 Jun 2026 18:15:08 +0000
X-OQ-MSGID: <20260601181510.38705-2-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601181510.38705-1-Yeking@Red54.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601181510.38705-1-Yeking@Red54.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the check so the function can return early without wasting an
allocation. This is a pure refactoring, no functional change.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
v2: Merge declaration into assignment.

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index abd700a101f4..f65fb6396b69 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -60,9 +60,6 @@ static int i2c_hid_acpi_get_descriptor(struct i2c_hid_acpi *ihid_acpi)
 	union acpi_object *obj;
 	u16 hid_descriptor_address;
 
-	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
-		return -ENODEV;
-
 	obj = acpi_evaluate_dsm_typed(handle, &i2c_hid_guid, 1, 1, NULL,
 				      ACPI_TYPE_INTEGER);
 	if (!obj) {
@@ -93,15 +90,19 @@ static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
 static int i2c_hid_acpi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct i2c_hid_acpi *ihid_acpi;
 	u16 hid_descriptor_address;
 	int ret;
 
+	if (acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
+		return -ENODEV;
+
 	ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
 	if (!ihid_acpi)
 		return -ENOMEM;
 
-	ihid_acpi->adev = ACPI_COMPANION(dev);
+	ihid_acpi->adev = adev;
 	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
 	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
 
-- 
2.54.0

