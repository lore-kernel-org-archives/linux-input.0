Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164278;
	b=3AnXocL+/36bPLvVspGus6UdVZUCSJW4G4LzkTxp4v5U7oOPA40vu64CQoTCf8OO0ahE
	 aKKtEICD4ybEdREFvBgDstM5i8DyukoGRL7/bo0ZxtWHKkJ055MC1KVl3s+dUPZt+O/b6
	 KNqCKHKsoCuOwoa7JU6rrIJVQt8F9yfn28QOA5nYTfBF/YgKG+2BrcD5PuGgXXXK72Yce
	 ccoYMFXg/fiLSNfNAc98F+j1ogkrPENnPODS8aDSsAzFMqQd3nVLVK8sVJim2vIUupAo2
	 YTpS6aFL6xDN/+hfUWG03zkrX1S9lnkkSNIxVrsoV1tcw9e+p0LkrZXBg4cn19Oxvag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=REAY0+Xv0Ze5gPcOy1Ka65XxLhykWbtvWxqzjPw8u0Q=;
	b=kgjUnOJt58KHAs+WboB6ARyGAcm+4fmvl35k9p6jpJ53//QkJ8pEraOoDkLEuSOGGhbN
	 IHyL/s8yKGmdUVGtw7KX2ySrwTJ8N+s8xw6OnItKSKRWFds/0DZLa7tDeBRnJdF8bclV+
	 ka54yXqzEL/NhC/eA6PGo2kUsZCUaLlE53cqZlrn+rBtiuCdzh31bDlNvTUWsvqNA1bC4
	 4Wj9AsRFPx7TqTkzkv7RKoXtYEm36TA9zbjF3zBZd+RdiP+sRQkvOxxRFpS0tTFB28sXq
	 5FIEBxTmk7ikqsvHifHi9RDrwb7IM/bP4EIMW5HkI8ABW0Hjc9zm6PU72yQipN/PZUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmKfCC0H;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA6606CACF
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FA6606CACF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmKfCC0H
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso895983c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164277; x=1795769077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REAY0+Xv0Ze5gPcOy1Ka65XxLhykWbtvWxqzjPw8u0Q=;
        b=CmKfCC0HGc+NUT4lQUTKOid2ejahxWYjkQUWHazInvYRF+eLhJN4KJzuJnbFVoq1XW
         b9EcAgctWWK8a1Ws7Cvq+S+x8YMmKsC8EiwYoHUc0BC9dk8KukYdsq6imnqBkHm6Kfqq
         IEOGCy+KihY6dsMQZLtGAuAhC9iBU/yJu/Um2UW52TZAlhOrNCPMLiQgF5ptPzctWJET
         CWyVtxMZPe4Yu/vSlZ04vD3Din/+hgfUt1twQMB3t4uEs59vJDaj6Jeg901dMeiIk/YV
         ckHXfRsXXGJDRlr8NKKQKzzNJFy6vM/WGbEx5tvF5QxZ75g+WdXf1WVgFUxQ7qlFNEko
         XHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164277; x=1795769077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REAY0+Xv0Ze5gPcOy1Ka65XxLhykWbtvWxqzjPw8u0Q=;
        b=Mf+Io1Fbkr2zAV/G0RjMCUykQeW8xA0dqO0fLsBnFC/fi81Rp+mhnnYuhrsH79wRDz
         bVuUrDL3nQIOX3macWpOuyAW/GxkOsQjBhatjJwyhQx0eqVl4CwhJthMruEJ+fVr7ViF
         aar+scs8qDSUHpCNNIuLa2VCMMPJpW/qabPm+qooQ3gQjGJDvSmznqY+As8VIBUHG0YD
         u+E+m4MJ4Eky0jbAFV1/RCJygaLE7Ha4iT6TlDgm8V2GudmckjWRuu59O86lMNWswz+S
         Tq9Kmvv2lBnz8kc3iJ/3llg6VEt3xnzTSLp6z+jo0SRnzv9+LPOxsX6W08QXx/0d9SJE
         j3Dw==
X-Forwarded-Encrypted: i=1; AL+hErEdZhpREcGUWUTwT8sHvWXx3ZI2rULBA8p4flglyAbAqHCPA1RoSy9x0xro12N1RktlGrAaVHKEPyIYsw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1WjiW4Jlv1Uyfz/nN7kal2rMrIe1pO19gJ4DswGKJORDcyUFk
	OrVVgzGoA74IDNKB9W0zOmg4jVuObYdbhHHvxvwQ7/c7dRpJ8ZBl7fzw
X-Gm-Gg: AYBFou2IcDHi5DSWQM6ReN/O8kBuzcAWslW4uoBnkrXk+4pTVk47nVJSNsK5VN4hYju
	B8+DDwa5C8ttKF7sTjD37C492Z8rwit8Xg8G13LR1yTcWr58ntlme0JHcgsV2aC6jhWdf/Et9/p
	KKKO3A6I6rTBHV5nTmkrb8OK33vlw0nVA4qJL0SrDo6aMFdV38haIsbko6J5ECfnB+UgB6JEWyS
	LWHuPXmoGlLt82cGsPCUkRJsa6Azvb6ig1pzQCY2LYgJFUn0efTuu3wWdco3Je1TIj5EczdbNdl
	cuWFZpXkVrjdGO56S8J9S7kSzDydp0rvUyIFSrhaX2OjgMq7bh19uwqC+OFn+aO+8EbAYuF/Ccz
	l17LZz9d3U/X9GCoDPezIHcd/19WN9nEIE6Q8IYlml9asO/adV2QKx++3G469pNbZN7r6VPrzeB
	Ra4fjx/avlMhOb1gycTtT7yKQ+Tv9FQFqnUNrJbIr57l2EUcDvoTVBCifuAVG1ia1ic3u2Sry8k
	ExUvHOzhfkDyV7aDCqX2WakT+H6hA6Fbwyv9NCYLjRjlmwtqu/yh/wGF4Gj71IafCV2yBL5SJrp
	2nHXguMuDNfQWizDlsGs9op0iR5It8AUQs5gIphLtzeGMU+RzJScjknS+/5wax8PLzmxXvm4i81
	PnkONN6qvQGdoBNP6vOeQFk6H90o+17appqzxdeU=
X-Received: by 2002:a05:701b:2701:b0:1b2:43cc:48 with SMTP id a92af1059eb24-1b5568e8253mr1970423c88.33.1795164276917;
        Fri, 20 Nov 2026 00:44:36 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:36 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:08 -0800
Subject: [PATCH v3 17/18] HID: logitech-hidpp: manage ps_attribute_group
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-17-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
index 261022e4088b..5c2d967246e9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4625,7 +4625,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 
 	/* indicates we are handling the battery properties in the kernel */
-	ret = sysfs_create_group(&hdev->dev.kobj, &ps_attribute_group);
+	ret = devm_device_add_group(&hdev->dev, &ps_attribute_group);
 	if (ret)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);
@@ -4639,7 +4639,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-		goto hid_hw_start_fail;
+		return ret;
 	}
 
 	ret = hid_hw_open(hdev);
@@ -4698,8 +4698,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
-hid_hw_start_fail:
-	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	return ret;
 }
 
@@ -4708,22 +4706,19 @@ static void hidpp_remove(struct hid_device *hdev)
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
2.56.1.750.gf70dc682cf-goog

