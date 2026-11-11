Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380238;
	b=VEgTsbpMdCTjFgWtVXpqwDpDSuZaHDeyuqWva912qMioSjJU8IGMJgztmW0GBWe3ru9m
	 lWRK7+8z9WZAdNgdT31yQfLX96pq6QjcY3h4UgbzDCYagrRoEArbUg5hvaxJiZK9rmYQu
	 44qzZwB1r4kQKyY4R3PXZ6hKpZ31JoUd+Ab4UGJuzhgC0t0gILGgBB3HlNMbOVHolVDpo
	 QQFCHuBbdU5TcMLo7ll+lBcDIiueB/l/R4I+eh/IBB+s2FCdWbxkIYpMTPhCZDtVL1UUU
	 l93OQTaUEUK0PZshSOwdXtACps28gOJiPMDcthLuTi5UEaCKM2/wvCspOSmEPMfUXRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=bhvMvFH7eU7owbTmWTGdGWX6kvxc3rwopdiBlGg5XF8=;
	b=uvazr4REo93c6pWzsaAqxHsX/mwCQijliubyxcaUEutjf7YEXZCc34WtVUDcnkXUTHU4
	 xJ/4CPVw1pSB4IoozhutkLYQqfRg8w16zjdTyxExWkjZO4StA4ANoBjxuhwRbXMN1chyz
	 dp0Xjy6Ow8Idams+sSZXimkG4EoRDLKYMxWZUNVqnK4q+rXQ+33hxN/GcW41vdt904lIe
	 YnsnhykWTq9/9w+Oow0diVJ1CaSL5PykaNOu5jugm+/byoziR+7w6xQZWDPvh9byzbRXP
	 ES1ld/Xj5vJ7xzJz9q3aVOB8V3/awFTce0eqfn2UbrMKZkQQiI977/JtO6ULNwyqoyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LK8Yr/IV";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF2606ED90
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BF2606ED90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LK8Yr/IV
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a8cc11ac42so2811151c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380237; x=1794985037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhvMvFH7eU7owbTmWTGdGWX6kvxc3rwopdiBlGg5XF8=;
        b=LK8Yr/IVHhomlJCMcrR2W/GqKRjNatfGvq2QMkM2j8rsiX5+8aerEfcVy7R9Giz/O1
         2QLo5dm75Wc9820FkOdm6Wm34j61yktpPbgJJZPAnE9Bfgm67YbS6Lj38LQ16MCIYd2k
         7TnJJTcnAbpw0M6Gnp5DKb5eKnlNLHjhzNw4uSwl+z2xuXQ7DtSTRzUDK6At0uraUtk6
         RtIwvzFIIz4ZpqFplCkTsjZWtEAEAQww+40NbDbThnu90ECMNXBkr8A2b+uS1f0ZZiNY
         NZGkZqxMCmt/4hrVnPPOHWgW7TcTsDvRevmscRLveQbrz7+cCZ8otZuo1KfhR4Fp/oBF
         Lz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380237; x=1794985037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bhvMvFH7eU7owbTmWTGdGWX6kvxc3rwopdiBlGg5XF8=;
        b=E8uHbV/EMVZaQiCgQJqI7k4r4aGa3dqKb8nSOc9DmN2/2WeRC4NsH5spHUgr5rxU74
         6WoQjq/SNwD8BrjjJp4HILxm75bZwzQEgAfJ2Fp69tlDzzxQO1sroexCqBZAU4DUD7r0
         7oTROKJlyL0CGaUEZApkKERBLlxDKVN2J9/bqlG6UVSZwuFQlEOq6oVpGWdyfUMOg6OV
         4RLmbWBtWL7RyA5cBkHqKVXpW/1tJ52vjyG+asaBF4fMJPSb6ZAyr5o5PT9gIQbHYogS
         udQz/E8NhuknXgBx9gZnkx5V7W1BpCj1SWa8Q82sQ8pbyTa3vGcUNoE8gaIiD+N+8gzn
         tglQ==
X-Forwarded-Encrypted: i=1; AL+hErElru6yINtST8nzC8ZgnQhjUZ3gCg98C0r0JoVGOevK+ZhYlaC4dgRGc4k2ysRoz6iwDQzcpYUUybTlGw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oMWGu5NQzn9aHwLIIgBbBHh4/RaOMumDHsICNlhZRkY0jFF+O
	90EfN0UtsuK0UweragAmebcwds4+wBNUpx5WlyWfKysak4EyGkCNwSIw
X-Gm-Gg: AYBFou0nONuln2npg/WMckbWUfI+fuwyyAXk3jFP2Km69ui9eBaYX4rFZOvlg1eizpZ
	ezRE5uQla7WmwAnDd/SlcWbava9jRSe07SuHCL9dmqTNqLth2G172J4Ud0k6v/Rw14TaQBQjqDw
	gVDRjNISVeIUnmhjK8zRGlGjG5KlbK4K3XAS0cZS/UMPJjmo+5co99X1VcspEnETG5Li9dMVVVu
	Y7n05f6sb2qSt6KRmKSNmO1ihYSnhZeNj7z+XdpzIkbcjEm3SqfvYpphCHcGLHgqwwZok77FDVU
	tWn21MMbGGzWOo9nl37ZfUV2PAry1l2Bk/Zc5a/oAqp09SapdV7kl7RrUA55320ZeTk+fpikmuW
	FmuMSqoqXR2SaLbri/3mieroHUEX11GQ2C0E2j99h+D999yI+o546jWtYzyHsysNkPujmzhYx2g
	9FxY0jjdW8quY93X8+7qhoObbeWLtwnRCmeP2r2L/QwW4H5hqhsv6Ylpc0RZiH1MPJ6uZGuiR67
	9LR1rqEIp02xGogxVvOuMLr0dZqOVQlmz1dUtHxYTLQH9NErAEz9JK8ww5ed3bsuunEnSUhSD6m
	3TTLPG5kUKLV52m8Nih9WMHUA27FS3hp4ZdJfjAE6r+RKuAGRMiHkUCs0sio7yHHfwnb/Vu5rYu
	bzAzS32gzkfrvDhvkbFY=
X-Received: by 2002:a05:7022:b058:10b0:185:33ab:4d55 with SMTP id a92af1059eb24-1b3c137c87emr1138700c88.29.1794380236899;
        Tue, 10 Nov 2026 22:57:16 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:16 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:30 -0800
Subject: [PATCH v2 32/33] HID: logitech-hidpp: manage ps_attribute_group
 with devm_device_add_group()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-32-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Managing the power-supply sysfs attribute group manually requires
explicit cleanup in both probe failure paths and device removal, even
though all surrounding device state uses devres.

Switch to devm_device_add_group() while keeping synchronous creation
before connecting subdrivers and non-fatal warning behavior on failure.
Drop the manual removal calls, eliminate the empty start-failure unwind
label in probe, and simplify device removal accordingly.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index be3c2649b0e3..019b917c3b90 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4638,7 +4638,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 
 	/* indicates we are handling the battery properties in the kernel */
-	ret = sysfs_create_group(&hdev->dev.kobj, &ps_attribute_group);
+	ret = devm_device_add_group(&hdev->dev, &ps_attribute_group);
 	if (ret)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);
@@ -4652,7 +4652,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-		goto hid_hw_start_fail;
+		return ret;
 	}
 
 	ret = hid_hw_open(hdev);
@@ -4711,8 +4711,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
-hid_hw_start_fail:
-	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	return ret;
 }
 
@@ -4721,22 +4719,19 @@ static void hidpp_remove(struct hid_device *hdev)
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	bool claimed_input;
 
-	if (!hidpp)
-		return hid_hw_stop(hdev);
-
-	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-
-	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
-	hdev->claimed &= ~HID_CLAIMED_INPUT;
-	if (claimed_input)
-		hidpp->input = NULL;
-
-	hid_device_io_start(hdev);
-	disable_work_sync(&hidpp->work);
-	disable_work_sync(&hidpp->reset_hi_res_work);
-	if (claimed_input)
-		hidinput_disconnect(hdev);
-	hid_device_io_stop(hdev);
+	if (hidpp) {
+		claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
+		hdev->claimed &= ~HID_CLAIMED_INPUT;
+		if (claimed_input)
+			hidpp->input = NULL;
+
+		hid_device_io_start(hdev);
+		disable_work_sync(&hidpp->work);
+		disable_work_sync(&hidpp->reset_hi_res_work);
+		if (claimed_input)
+			hidinput_disconnect(hdev);
+		hid_device_io_stop(hdev);
+	}
 
 	hid_hw_stop(hdev);
 }

-- 
2.56.0.542.g3ef89b7020-goog

