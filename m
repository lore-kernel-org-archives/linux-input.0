Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29843440A1A
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990949; cv=none; b=ATLDBehgesdHoKpSei9gU0yprXl/D6LF6g86fCfzfbwSptozJ4cH1g1BnnsbrtZ1JuiLgZO12LnkurVOLIpn69lszOLmLexGVieNaJvLqMxbz9+icCa3FoT5apEKPvCmRZEWnv5VnttAvGpx8jrvhptsC+68HQIjTC7Vy0QYcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990949; c=relaxed/simple;
	bh=RIun3CTewN6YQNwQff089fZvm5G2LmNg86JPd42Vc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOmf7WtFwmitMR92a5OX1sdmm1MFMj5MXnQ5DA9LNlRZtlWNjjI7G/AtQvq4Ao1fruP6uWiNcyJuhtVj3KvmZe2Qo7puH/qoShn32KfyvGaxul3ttS2FRzEcwEkWs8Tru9T1TL0vIOINQwVas4tMFTqms2pi+jGuZGk2+EYjygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNSM0oyw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNSM0oyw"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-936d00181abso169193085a.2
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786990942; x=1787595742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/J5Ku7TUMPFkncTWiaJAkFB/DQoyY+kfM1udqiEm5g=;
        b=NNSM0oywmUPr4uXMqYbzULNHPKnkzeG1npY5XpgoJCI76H2SPKpgDE7lcejQe1xY8Y
         CEG3PuByt3ws0oM0O3+WFkXtUgoOeTh6Dydpov0XTa2t2rPd/3kkDpK2RzyhbEv9GJuk
         0kpTx0rBp/r6gbTbbd86hMTUMjRRlluR1PsDVEyV3idro5EohVqjulwQ/cmFf76Vr1xF
         nC5l4MgePYX0UyI2KFeqKxINnt4/6eDgUPWhYkXipu1qSA1oa2WXGGSsYGWDv5Yqgqhy
         yDyEXoLLMSLBRwDiBOLg2eINyktcbmexnYT8wKVIY7GUWStFoXXQEyqxJolgeEDTl7hL
         qVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786990942; x=1787595742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/J5Ku7TUMPFkncTWiaJAkFB/DQoyY+kfM1udqiEm5g=;
        b=BW33E3dHmJFhHA9XBKC1Ac3w8eMCZ8VMJW7zGeOLFTDlLUDRTSR5pyOJQKJkY+L21D
         dcT9YEaihU50mFvepv5nVVg0Uz8aY2l0309dg6OaBFo6+qgCzhUsyiedPF2/LE+g4D0g
         xQ7en+MXFSPoOWFmeF2npJ/M3cdH04C5TCjvlitQMhYStIOEWIUwPdkckDx/KI/kJxLM
         6gJbWfCWA6YVqRvAMgZccudeUXaGVFIiClWRzFYDgFnworuji35QkRfML4MX0ypocLd1
         ayEvJq4suNUYQHdBNmDQdJZQDxif90OrnvzyJ6vyU0v3RGF+lVIO5hKi33Z/o3UegH5D
         Cicw==
X-Gm-Message-State: AOJu0YwJhRuFTF1hwy7++WwnsT7nsROrls6Di3vPpS8tmahZL6QcdBlw
	Uh67MD7qLTLppYvDUHT48Z4TTvxB54pajJ6naPTjY/DO5fxqB++iimJx
X-Gm-Gg: AR+sD13Ge4lrx1ly6iAPT5OLlbHyyiPWU7XSxQ1WGFnn4nS/ZVnAHZbx4eODwzZEHNL
	asQlfbMI2Q1xzyd20vKGUiziGfzU6T0tGW0zR7mvAqF8eV1xU+9cyzcU0DCZJB+txik/vbGb0M3
	R4wKWw/gGx1g5Gyo1xLkp+x9gkItiO6qnjm+LhtSDNeYNd5ACzk/koOWZQk3I75Iunq4IitvtmP
	hMwyxZ+5chjGLZbdhTgS248OoqIiRfTlr/1/RcYIIxrlYX4jfdxALys9YZc1TGKCU/xL60DR30f
	5BwjQ8IVbYk8Gt2cz2MDYf/HJ3ADeYVYp6iVpkAjEMQY8GntWkSA9lh5F2RYK35LKGH5t+u5wM9
	/tzsnqZNAKbqooYEdV1hwvZueoS8HUVTHZOrC1RsDXT0+LP8Dak4FphHAjXMpc8KnEiyOsqg0Hq
	L6e+lWjCMAz4dSTdSrZSZU8HZHARiHMP7I5LMNj1MXotxrXB5sXWwDCQVfQifYYcDS3U4tDWwlj
	TvvvTN98iRtNeduuWs=
X-Received: by 2002:a05:620a:800b:b0:936:41fe:2351 with SMTP id af79cd13be357-936d22e74f3mr3151285685a.30.1786990942348;
        Mon, 17 Aug 2026 11:22:22 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033cd8a7sm104563185a.28.2026.08.17.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:22:22 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - reject concurrent firmware updates
Date: Mon, 17 Aug 2026 14:22:04 -0400
Message-ID: <20260817182205.906592-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update_fw sysfs store callback can execute concurrently. Each
invocation runs rmi_firmware_update(), which tears down and rebuilds the
RMI function list.

If two writes overlap, both rmi_free_function_list() calls can walk the
same list and select the same rmi_function entry. One invocation can delete
and unregister the entry while the other still uses its iterator's fn
pointer, resulting in use-after-free or list corruption. This was
reproduced as list_del corruption in rmi_free_function_list().

Firmware flashing is an exclusive operation, and running a second update
concurrently has no useful semantics. Add a per-device update_mutex and
try to acquire it immediately before starting the update. Return -EBUSY if
another update is already active, and hold the mutex until the update has
completed so their function-list teardown cannot overlap.

The status attribute does not acquire update_mutex, so update_fw_status can
still be polled while an update is running.

Fixes: 29fd0ec2bdbe ("Input: synaptics-rmi4 - add support for F34 device reflash")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 1 +
 drivers/input/rmi4/rmi_f34.c    | 8 +++++---
 include/linux/rmi.h             | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..3a5cb17e938f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1218,6 +1218,7 @@ static int rmi_driver_probe(struct device *dev)
 
 	mutex_init(&data->irq_mutex);
 	mutex_init(&data->enabled_mutex);
+	mutex_init(&data->update_mutex);
 
 	retval = rmi_probe_interrupts(data);
 	if (retval)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index f1947f03b06a..04f12165cab0 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -468,13 +468,15 @@ static ssize_t rmi_driver_update_fw_store(struct device *dev,
 	if (error)
 		return error;
 
+	if (!mutex_trylock(&data->update_mutex))
+		return -EBUSY;
+
 	dev_info(dev, "Flashing %s\n", fw_name);
 
 	error = rmi_firmware_update(data, fw);
-	if (error)
-		return error;
 
-	return count;
+	mutex_unlock(&data->update_mutex);
+	return error ?: count;
 }
 
 static DEVICE_ATTR(update_fw, 0200, NULL, rmi_driver_update_fw_store);
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ab7eea01ab42..d56c23240868 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -340,6 +340,7 @@ struct rmi_driver_data {
 
 	struct rmi_function *f01_container;
 	struct rmi_function *f34_container;
+	struct mutex update_mutex;
 	bool bootloader_mode;
 
 	int num_of_irq_regs;
-- 
2.43.0

