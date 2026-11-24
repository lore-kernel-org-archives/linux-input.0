Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538831;
	b=lpQzCRHKaZMo0Y4gqmzpv9U1b1KFIcDlWbchyQk6hdXI7DgwQLbFjyiH7tBDMMYwQM7w
	 pS8OHiV8vmSMv/D15R2T+NCFB9l2H5SSnpN4nuc7bgU+eeW5TSPV4nkMzGl2p+TlkXj4O
	 0vykgBhBsTY4h3X35J49uk/aktllyF3Zkusyg4Zd2KGiIwfPkyzNoWgOBTONNCBs8tPeJ
	 EMgsZ9Mivg1O5RrjpkeXGkFplA0IlGColsPeIkF6Ab3NYVcRSkAz0n4lDUAWKNaUUlSyy
	 Yc4QHLGPPtvL9tjoz9Y1/Tt4FAAOh0Tk0ybGqrr33fXq0Bqv9+e56ybNpE21Tah9ngw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538831;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=nDuCuFE/bmYvUEnb8kfQK1m5ErzUBL55spKdyhYfqa8=;
	b=nKayWXeQa3WT8tFd8dr3AKRxyv9YNHTF4K8XBvQ7a7lNso+t/1ZpvrphzHH0c/uJqqGO
	 hZJfETqnPw5TgmUkgfXCcgVDz2oNHGYRVEQmqXp4rSvUUjabXR1JkCCgsZ5rm/zgeAAsw
	 slfzcsmV8pSbpk0zN7Q8Y+pISX6UI9MpxGeFBd3EQISYBl6v3BYpn+9Dk7sTxT7cs6gKS
	 bfaoDGV4cOGuqAzwB/Rh4YAHmNtK4a4Q1rEemZaC4F4NlmD0mkq+WVarnSEHGhN8mdez7
	 2XDsOoB0Gtm9zKkNaft+NtPa63lv24ex5aSbKVIPcdIMvYML40miM/yjyMClwpG8Xqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=ISh4vixt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1D606A321;
	Tue, 24 Nov 2026 16:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D1D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=ISh4vixt
ARC-Seal: i=1; a=rsa-sha256; t=1795538726; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QtcOJnqn3A4P4iLDctQcf5Zc6cCqTkhyOl+w1hvYPnRFVRHGAcuufKC0oGDh1ibaSFS20FFx01+0pZwCtqURBb6zsiqxiPpPvQ5WwjKpcjmJLdCyb8jC58+9p7BOnT6QIibuX64JvTsiN/axZsuGa7cR+kZRbkZ3+VIGrciFebs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538726; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nDuCuFE/bmYvUEnb8kfQK1m5ErzUBL55spKdyhYfqa8=; 
	b=gY4ubVNLBDIRUdYbL6xHuNv2WrAz6El4QFNgWXRXQHxnerCwAYEfJs8bY7HtaTqhEM1zYwN8qDDLSsCO0SOXqaA0Q6BvI+nQBu3shGmdXsjlHl8lJDyEo8hjPadMLk1NdSY8Qgwl5DKE8W31xK4KMsy5aZQ2dW/WzcnZ9hUFtBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=ISh4vixtgeALSv3GKoDUlMJpDU/na/sjnukKM7rslqVCXCjbgSt7yU++kda21VMzZ/KRE6Url3rrKHBYy6Kk1EYJw5299lkAaoWr2przRq3JYHIY0V0T7clPYirp6CKRIYfNz91e0hrEjN8eOSsMIl10K7Cw14IwR7ZXazydjG5fHvvBbmqxXGdPOdi4kMEtZoyi8qQcM3YT0tFHJBngPmzoGkY2hJqx36MFc/d9u904nzkN2vgYG6UXW2Nn78MR1ISYN3OsEDUF3V0lLWgjAIz50tTY+7/fa/AYqkYuUdE1vokHgLiAAGro/rHk4V+q5R4UlWTQSOLhhofGztBQOg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=nDuCuFE/bmYvUEnb8kfQK1m5ErzUBL55spKdyhYfqa8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538723767309.06107591765704;
	Tue, 24 Nov 2026 08:45:23 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:33 +0800
Subject: [PATCH v4 5/9] HID: haptic: Postpone GET_REPORT to init
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
Message-Id: <20261125-hid-haptic-kmod-v4-5-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Currently, the driver calls GET_REPORT within the feature_mapping
callback. This is not optimal, as the driver works only if manual
trigger is also available and the if the device is a touchpad. It makes
no sense to initiate device IO if the device is not supported by the
driver.

Hence, postpone GET_REPORT to hid_haptic_init(), and parse default
trigger in parse_auto_trigger_field() where many fields are already
parsed there.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 3ef2bce67671..ba3d94fb9334 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -22,13 +22,6 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 				"HID_HP_AUTOTRIGGER out of range\n");
 			return;
 		}
-
-		hid_device_io_start(hdev);
-		hid_hw_request(hdev, field->report, HID_REQ_GET_REPORT);
-		hid_hw_wait(hdev);
-		hid_device_io_stop(hdev);
-		haptic->default_auto_trigger =
-			field->value[usage->usage_index];
 		haptic->auto_trigger_report = field->report;
 	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ORDINAL) {
 		usage_hid = usage->hid & HID_USAGE;
@@ -147,6 +140,9 @@ static void parse_auto_trigger_field(struct hid_haptic_device *haptic,
 			break;
 		case HID_UP_HAPTIC:
 			switch (field->usage[n].hid) {
+			case HID_HP_AUTOTRIGGER:
+				haptic->default_auto_trigger = field->value[n];
+				break;
 			case HID_HP_WAVEFORMVENDORID:
 				haptic->vendor_id = field->value[n];
 				break;
@@ -450,6 +446,12 @@ int hid_haptic_init(struct hid_device *hdev,
 		HID_HP_WAVEFORMSTOP & HID_USAGE;
 
 	mutex_init(&haptic->auto_trigger_mutex);
+
+	hid_device_io_start(hdev);
+	hid_hw_request(hdev, haptic->auto_trigger_report, HID_REQ_GET_REPORT);
+	hid_hw_wait(hdev);
+	hid_device_io_stop(hdev);
+
 	for (r = 0; r < haptic->auto_trigger_report->maxfield; r++)
 		parse_auto_trigger_field(haptic, haptic->auto_trigger_report->field[r]);
 

-- 
2.55.0

