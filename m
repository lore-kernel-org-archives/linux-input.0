Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11293CEB8A
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124118; cv=none; b=KzZM2JA3AXd3/uehoQRg8KiYci5pozS7R8nkiuU1Ybaxxqo2QdnT72gVWv5u7Oiv2PmCMJkoTUetDEjPuqlv9dcWiTEplJjgPbG5WxPnhxsCK9cZGr3S1Q5f3Czd1/jEZCy9wqAj/Z/yKDmXw09K2CDUGn7DdUcmQesvHN0JZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124118; c=relaxed/simple;
	bh=jRRPpcydWK1Nh6x7ID45tWL+SSWHXsE1Zkq+srsRrI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvC8sRUyMlgtD8SUYIgSy9W5bZSpXRsCXqtpTMCa46ZLzHRGOKbOMlS7GIEzSzCV5Sdr9k6atRtFYagamNBI+eP+7Ct/CCn5zGzEr1xR/xrlTQGey2Y49gHatkUsN13tLEL7vD0wD382Ujqo+uyp24U7TYtQTpMMf72SqVj71KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJAOH1XZ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJAOH1XZ"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1b3d7f10eso678303eaf.3
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789124112; x=1789728912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1No2H2enpWYRkMqmMl17Jmk4Fevgd1ISE1R76jzAfM=;
        b=oJAOH1XZuglrQK8JVmyFvCovC/KOOMCAzob64ygy0eJ7v7exSBaz386WlwnzlGoZHv
         JbzMFsqNvjRuQIBaGGBcEQoo8Q/mHJiH8iZftSI5jfMsjYoAWEuMb/Ib6Gq/eFqVl2kO
         S+kLMeirYlVfnhSmd4JwKI2zUdPvtIt4pYNEFy08zYHKEADRMAAF5MaS1rBaIpRaJT7p
         hu7XFJUsN+1+xRtowsnKzOrof+qjYy85rtjmgZEOr24loIb+++UDfXY2oehwmGQP0PEX
         ZBacHav5fCNIccvYo9taSngwD8i2OZLPIzX+TcQitaES+oKe4TH2da8aANaXd+T6pJXT
         OCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789124112; x=1789728912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1No2H2enpWYRkMqmMl17Jmk4Fevgd1ISE1R76jzAfM=;
        b=BfT94G3YBFjNRdUf0YZhPMAud7oj49CXj0EMeC2zyGsXKAiy7vIgve4+hrIdYJtJU+
         t8XjuRN/oa6vRGKIra6icGlSIp5KNkzOW5BmeUG7PTA8hrjwaYhbp/y4z69OyH6NU4ix
         4iiZIFdaYgPGmnLPAHSDt6AcrS9Zl/p0NHX5SkdKH8PRgbTI38mrCTh23SwMYLrF2K7S
         ET55cIDyfXqTnEJGcJVJvNvBtYmAjLq1YhfUIKYHwzBXuVl4ulIB8a8RlOkaPXd9y8bc
         pOXiVWXZq/gqJ6f0LMTDWcARb6P8KP2YoHvY0P1X8Qs0t8EgWfzZP6F+cviiGAH0cwTP
         8VJg==
X-Gm-Message-State: AFuF++mFR/BYriu0cun33mVgERq8JfMw0uugH/EHvfHyma4GFRsB4pCm
	IpRnPOFX8uE4hECEay7l1ryJ4VvTvifMVr68IcA194IPseZVFgbqNDnb
X-Gm-Gg: AYBFou3n7l1gXAR83Kkd3lHvCgf7+cY9baWMqgBRp8bjhW7UTpZ1FA6hBCKdf8qNpEt
	KL9tEHYC0kbXYM2DRo8ujl9DAIcXzXhz6fFAp3z+OKX74D+G4smP/JXhFiWGEaZG+LFHvlZUNew
	x4sTVw+SmTSP9Cpoyk1BaOlPSYRPy35XgFuPgnpcvtVFgH7U9ZK43hH5F/xHvAjQUNHdZ2VjLKF
	VZI5Ml4yd5JYAZOXr9DndAwa5m8uKPzueozscT4sFOWw0O9++qUNs3Tu5A+5dxXmFfLNgz03OKA
	q9o8H2zYbiv5z7DmYJJbofBu3/gMXvMCPUSPDG0KA/rOBN/8JLr1g5h6uFuTLC89VACejGpOwb1
	izutJt3aiSq1E7isdqPo6Gk1wKX5gkdWE93s2EMha3fq0jK4enImZHEgN49F04Wh3KdUczfNAAo
	Ot5df2POMldMLQjxtRK++dPiB5DMuJesIVlRjvTeV3RvTFdbM6ENoORAhxW60KVI5EddY7Utwlk
	NCoCeBZMdfAlKSTXckVSPh113/oNoNQFLE=
X-Received: by 2002:a05:6820:615:b0:6b1:4fa4:76c5 with SMTP id 006d021491bc7-6c0b985e1e0mr2414649eaf.4.1789124111904;
        Fri, 11 Sep 2026 03:55:11 -0700 (PDT)
Received: from pop-os.. ([2806:2f0:5681:fad6:450b:4440:1d9e:e823])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0990cc05fsm2305646eaf.3.2026.09.11.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:55:11 -0700 (PDT)
From: Oscar Priego Verdugo <oscar.priegov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Priego Verdugo <oscar.priegov@gmail.com>
Subject: [PATCH] HID: kye: fix inverted Manticore open/close condition
Date: Fri, 11 Sep 2026 04:54:38 -0600
Message-Id: <20260911105438.1862810-1-oscar.priegov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Manticore workaround is intended to open each HID interface once and
immediately close it, which is required for the keyboard to become fully
functional.

hid_hw_open() returns zero on success, so the current condition is
inverted: successful opens are left outstanding, while hid_hw_close() is
called after a failed open.

Negate the condition so the interface is closed only after a successful
open. This restores the sequence intended by the original workaround while
preserving its best-effort behavior when opening fails.

Fixes: 8a396321e210 ("HID: kye: fix unresponsive keyboard")
Signed-off-by: Oscar Priego Verdugo <oscar.priegov@gmail.com>
---
 drivers/hid/hid-kye.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index bd96bfa7af70..ed1588e2bfb3 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -594,7 +594,7 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 * The manticore keyboard needs to have all the interfaces
 		 * opened at least once to be fully functional.
 		 */
-		if (hid_hw_open(hdev))
+		if (!hid_hw_open(hdev))
 			hid_hw_close(hdev);
 		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_M406:
-- 
2.34.1

