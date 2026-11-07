Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068669;
	b=YprnEpdlqOf2j4Ex34goSXaeXtwQHMAk1P9V092trBs1LRDrJAU8cgINtBssMiOzb80i
	 iu1FOnpZ/hzeScKgAR8iD7Cun44P+p/rUMT8wph0rSTJW8rue1DDU6fqAoF9Sd+h/b6tw
	 OkezTvynP4MBQqBlE07OjOT31yUbyeY/2W1kOb1fdLBydGqoo0V/sI75RcRI52VMLixVc
	 4q+PuA7He/qpBRiaGjE8bscmWhsMiME3FeNXcwogaEjCa6euIOBV+RDZFoHqibqiBWLyE
	 Y6AIvwF1meOZZS/ZbcwQq6NJHoyr9qmzwqDaGuE8kXKggJF+HGk6kPV4vyzC45Lnz1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=G0Hqu1+FGz/IWPNQ567UsEhZ0Yh7IpxOzw14Cvzayz8=;
	b=BR43mr5/Pmuv6+I1H8CIRQ/y9r0OVXX6yWtRemPrJUnYNk+MLxWs0ug/dczeFdyBiDJq
	 V/YyeON1OyeGt+6226luB/qyvxSQL8N3VlBmdoF3Ck+CD8B6xdJxlQzoK/tCsS8evoX8h
	 QE8gVsxs8/lKBzxBnpPMcgs2y3zKWXgzEmjGojGvCq98I0lQ/6FCtCNNklDYnkpJRBEaE
	 cWZVri4fA2VYc3wtfYDaT3UEEnzyvVukpYNmyCv5s5FvP94YH0NMa3Zky/4qoTiT8lbvj
	 UM+PFogv2eyN1KIdwhXHOA3zBAB+Obbem2Ti9Ehwy9vNKF56fQRSnjcM+5J4IMue6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rF/WqaYE";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821A606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 16:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1821A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF/WqaYE
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2673400eec.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068668; x=1794673468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G0Hqu1+FGz/IWPNQ567UsEhZ0Yh7IpxOzw14Cvzayz8=;
        b=rF/WqaYEza57PrcTeP20UCOKjtuV3xFLTpZWGIpMwgWX77YJcYiquOqutIGEzYd6py
         V71XQXFoxp7gSODveG6Io2g8PKRph5REtXexqiP5gLf4xmqZCA/FOPey6CLQLQbmvBW4
         +YjuxYsYFEZSY830VcJdefBYytyoQYQwp/ie1RVPSpg/JARjunuIFKnw+5E6vxNJLMvv
         0qsckkAMsNExQu+l8fBCITFlLuvtxMJR0joYDCwE3M5PapPqHOfEvZpqBXXhm0unedZX
         95ArVI5DZ8AvKpEGX+mnbXKcBTeA+hqu049ALfhny2Tqf63lpBmfy/WujqeHbYdsQPTL
         2y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068668; x=1794673468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0Hqu1+FGz/IWPNQ567UsEhZ0Yh7IpxOzw14Cvzayz8=;
        b=yJhczknpOmgatEBs0f++ePBZ83xngTq6vqrfsWAyTt4XH6xyaGf4JA0koH6P9fov8r
         vSdmcHC6IhrcSh809xgzMggT/tdIUzDOli847824fIPcg2la1lCCkuWrMVEbFC+398zx
         D/fyL3DUH3wPYjkpAUbStJIUaK+H+VXyM0ih/r9Aov8HZvAZjRfuhUc/Ny2pRZfbjDRw
         uU/+TP1nfXdzGVFIUHHths+ZJbX5BNaR6tF7oGVi1Y8M2lWsvKP8z4D2MIRePxQVERo0
         OQXEwEtIy3agO/OahqwnuUDDJM0OPKOXmOyAilL2Lf75FGYToqZ/e4mAr8h/e93+w2N3
         u8JQ==
X-Gm-Message-State: APuU4Z9vzHpT5HJsH0IdC//ZkM4u/8g82gz37AcfcRTWczs+wi3FjEAe
	3jGxxtlBksXJ0fs17yDP4Bsmuh5svjKcCa8IWGr376bJriEbx8P533l5
X-Gm-Gg: AYBFou3FGJCQLnyaZmCRgVzs4PydpxnlP0teXiPELrnZ30fkG6MfsZiJCVAmzVlGF9b
	jiezrG2w7MOptKRwnEXcioJLzuDGxmTN4ZR8FJGRNgZnM08fHmbzABe7/Pb4iYNETNuPu8x8llX
	uwnqmn4Rov/yIikQC47fhWDCx2LvKUzROkV17CFMRbCYJ/NcGqv/hoTAOoNxZ1QxKvI+IPyMAUh
	yN5zdnbV/E3uhEJr58TydnQhb76XyMpyLQsbSS6EJDh66DCR5HHB+9cxqqFsxorSkAyrUt8xELW
	62aC4KruUidd1ApURmZ+EwArefHIOvD0iUkDRGpoDFUQjXxkjDfp41JvQzKJ0UUw3dEPqHKPopf
	WaXv9cbWy82LvAAVxW5sui/j4k4ExEm7tEDe1vVHshgOsmIyHFAYxNz96KrZRWTvMzYRcdwV/mn
	NqTU1OE4fRyiQr3vtlELIZGwNWL0E0tLtAElTN3bp1J5G7fS7KqJLrrLMIJgwM15leDo4mu91lG
	qewvYvCzR9TDkF5IAyl0iCAE4F6cjFOXUFmupZBMkTuCqx9tVunUd5bJ7rCumyIstf58/QUy9jo
	oYxxNSBg8Mme1Eq6jBkm5NJSL8CdOu5C3swq3r421XkUiYf/u0VQSyl6Z5XdzQ44M8mjdw1M82M
	x+KmJmdxStkBvGs4/j3vg2F+wsnMj
X-Received: by 2002:a05:701b:2706:b0:1a0:5c85:d1b3 with SMTP id a92af1059eb24-1b25d3a8127mr6940925c88.43.1794068667872;
        Sat, 07 Nov 2026 08:24:27 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:b097:433d:def1:34a1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b26294289dsm22854161c88.4.2026.11.07.08.24.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 08:24:27 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Nikolas Koesling <nikolas@koesling.info>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH v3] HID: pulsar: print errors with %pe
Date: Sat,  7 Nov 2026 21:54:06 +0530
Message-ID: <20261107162419.9051-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

%pe prints the symbolic errno, which is easier to read in a log than the
raw number. Convert every print in the driver that logs an errno so they
all report the same way.

The prints that log data bytes, battery readings or a byte count are left
on %d, those are not error values.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
v3: 
  - move changelog below as requested by Nikolas
v2: https://lore.kernel.org/all/20261106083419.29334-1-sinha.aryan03@gmail.com/
  - convert the remaining errno prints too, not just the battery one
v1: https://lore.kernel.org/all/20261104150055.33028-1-sinha.aryan03@gmail.com/
 drivers/hid/hid-pulsar.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index b0b34849f..495ce3b5c 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -162,8 +162,8 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 		spin_lock_irqsave(&drvdata->raw_event_lock, flags);
 		drvdata->pending_event = CMD_NONE;
 		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
-		hid_err(hdev, "failed to send command 0x%02x: %d\n",
-			payload[1], ret);
+		hid_err(hdev, "failed to send command 0x%02x: %pe\n",
+			payload[1], ERR_PTR(ret));
 		goto out;
 	}
 
@@ -295,8 +295,8 @@ static int read_power(struct pulsar_data *drvdata)
 		if (status < 0) {
 			ret = status;
 			hid_err(drvdata->hdev,
-				"%s: failed to read status: %d\n",
-				__func__, ret);
+				"%s: failed to read status: %pe\n",
+				__func__, ERR_PTR(ret));
 			goto unlock;
 		}
 
@@ -320,8 +320,8 @@ static int read_power(struct pulsar_data *drvdata)
 
 	ret = exec_cmd(drvdata, payload, response, CMD_TIMEOUT_MSEC);
 	if (ret < 0) {
-		hid_err(drvdata->hdev, "%s: failed to read power: %d\n",
-			__func__, ret);
+		hid_err(drvdata->hdev, "%s: failed to read power: %pe\n",
+			__func__, ERR_PTR(ret));
 		goto unlock;
 	}
 
@@ -411,8 +411,8 @@ static void power_uevent_work_handler(struct work_struct *work)
 
 	ret = read_power(drvdata);
 	if (ret < 0) {
-		hid_err(drvdata->hdev, "%s: failed to read power: %d\n",
-			__func__, ret);
+		hid_err(drvdata->hdev, "%s: failed to read power: %pe\n",
+			__func__, ERR_PTR(ret));
 		return;
 	}
 
@@ -584,10 +584,11 @@ static void pulsar_init_work(struct work_struct *work)
 	}
 	if (ret < 0) {
 		if (drvdata->type == TYPE_PULSAR) {
-			hid_err(hdev, "failed to read device info: %d\n", ret);
+			hid_err(hdev, "failed to read device info: %pe\n",
+				ERR_PTR(ret));
 			return;
 		}
-		hid_dbg(hdev, "failed to read device info: %d\n", ret);
+		hid_dbg(hdev, "failed to read device info: %pe\n", ERR_PTR(ret));
 		snprintf(drvdata->battery.model,
 			 sizeof(drvdata->battery.model), "%s", hdev->name);
 		goto register_battery;
@@ -615,8 +616,8 @@ static void pulsar_init_work(struct work_struct *work)
 	    devm_power_supply_register(&hdev->dev, &drvdata->battery.desc,
 				       &psy_cfg);
 	if (IS_ERR(drvdata->battery.ps)) {
-		hid_err(hdev, "failed to register battery: %ld\n",
-			PTR_ERR(drvdata->battery.ps));
+		hid_err(hdev, "failed to register battery: %pe\n",
+			drvdata->battery.ps);
 		drvdata->battery.ps = NULL;
 		return;
 	}
@@ -639,7 +640,7 @@ static int pulsar_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret < 0) {
-		hid_err(hdev, "hid_parse failed: %d\n", ret);
+		hid_err(hdev, "hid_parse failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
-- 
2.46.0

