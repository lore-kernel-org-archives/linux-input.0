Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D64192EF
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574466; cv=none; b=esuXb/1pYZ3TX/YZhGik9RMQYVQjpnbA2NEr8iInhgjX0qWPCgcFdJ2g9tW+pD5ryShrmdYwMyJf9nWl+hz0itwwR9j/1YItdwTMopeKIEE7rRYivQMBiNit8yXljAQtpeBQBv7sJV6GYHEMOe7fladDIWbxpzDiMjsfWek4xbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574466; c=relaxed/simple;
	bh=WZE0UAjryG3LKGmJlWlrF4NVV/WeS+t9+KyPhRYEdqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIl/8sa82DYSMbLU1+rMeafK9ywSgyYzB73G/rya08jjIAjgifOLv5ul6R73TBQ73aSFPqYXxhK3pyXqN9Vy48fcKY9ztqGYNUibmRHZ706z3tPWgPT9rqaNXJoVjPRR6N2YaJ82XWGiH7n4V78qmLjjfK4/OQN6VinGoAsVrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOdtWIR8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOdtWIR8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52de50e77ffso25289631cf.2
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574463; x=1788179263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EB3wFOXHlXyIKQOwKFQXlogVT9fQ7bqKTlFugd3hmJ4=;
        b=mOdtWIR8Vuc4hJv29I4T9WGf9AJPLc57Qvad8aeBK5UtrjIQ59S+lbGOJkNKfIy19R
         wEzMfSU/FLcwJKSSqTyJ3EH7m3ONVfObO+VhFAojK1/v53bM8D9o4kGqcGs1KhblQrop
         6nS8c9tvn6USnMmiRliSsxC8uBFBx5Mr6VztFjvPMO1lJcfmI4AZixmuLcYQdAIYA8VU
         rm5eP6OEPzCCDK3oOi90bH3yRNmanTp30fAUdVbXt53iQqnAvWOvXaXmWmgrp4KOV/FO
         ljUVRIRUt6uctLDD4KoS166WSihSG2iXZS6Ck2osRxeySojnCpwmSYWLo+RaFVbZyTo6
         ezVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574463; x=1788179263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EB3wFOXHlXyIKQOwKFQXlogVT9fQ7bqKTlFugd3hmJ4=;
        b=TW/Ys8zHq9bUOekiNKOzCW3/TCXEUGuSZ+YPk/XuxR9td93oNz+UhOE4SGMpvecG6W
         rz4eI6Ov52VPhxfriE6rg2eqJ2Xhkyb+Wuf0tO6mrDm5g0usMymrCOqFBShpkynYUAhg
         gSUhZUC1WEV5kGm/ejxyuP+r6+j5J44fIjcTHXp6zqaAzRF7Uy2HCwZMRI2mVsI8LDor
         gB+bAkUApwmR6Us5DlC9WVVs82wSVLrmkV8re8M0dhKBRTbRohFsXNzrw3iP5IGCab+m
         mxIqP6blPznNtkVqBbOc/JZAYcvrm8p4yARwGAeA861TPcBbl8rzSfAEvwmUQQs+Fzgp
         kA/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq309PERxatbNmM7fL8ctf+piwD6pcGOEXXZ0hgX/9DyDcd2oPbbmEbr2VRdeofeVLEbyo3TcfbS10HFg==@vger.kernel.org
X-Gm-Message-State: AFuF++kgUkAXgUdriSDQvho+7AKPRAfRziz45vosM0a5D2M8CMJAHfjo
	nkUhotsha/Jd+7DJBKCgn8VtaMspZcT9klwJPT1rvZeypoMa990RO6SrF0yKrJVWA7M=
X-Gm-Gg: AR+sD10LQKdB9B1wqzapROEfNbdc3Rdl39XcTVS4wOAYfSNQZJ1xQSUbI9vyQCAsghh
	fDjdQl8cCXf1W9DGS3ibLb2OSUwK13IFXWGYyDPPViae0B6JLqf42i5jYV2NS1JxLyaj3SpWjYU
	XRpdXhl67Sq7hDmy2iaAFxPgyMb/Gvu7kPrzosUXBak2Sa4MJUAJG/tDSz3DKdPEM4AFFLo0t/3
	sFX/C1D3CxcDBazz/TsLtaItZfH4SXREEvje5vJv6dMKDSYfM+F+5pHorRHrXJY1TdILy3EIKN6
	TWE12MO/zGnIi4N58IOwHPMvDAAJ22oBjDqEwhVE4JQoAXPd1aFCJ9/enHMmXbgRsSQhQHzgcLA
	FYSE334YTjvl9YeSPyOZU3SbOcoqtMuhGNHvn1FfMEBGV5F2XxffZNTQcI21qQjVEd+EY2Qth9D
	3ySNl85WbC0VXwTiCZhbL5H1D5JrDeP4ZoEgljoZQCgba3/yBfCjuB1xVRDED3Xhm7pzg/YTRTm
	hvYCb/qQkzoI8eFTquY/LwNJYOL9RNLnwEi0XgmNfVgpbSqFmiZJmGB0BWgA+t+p7ogAu5lJf8B
	kNFRBNh7UJ6FXJKHGFQg0OdF
X-Received: by 2002:a05:622a:481a:b0:52d:78c9:9377 with SMTP id d75a77b69052e-52e09ce9a34mr177469481cf.36.1787574463031;
        Mon, 24 Aug 2026 05:27:43 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a4f093sm60745276d6.37.2026.08.24.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:42 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Mon, 24 Aug 2026 20:27:32 +0800
Message-ID: <20260824122733.76321-2-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824122733.76321-1-98lawweijie@gmail.com>
References: <20260824122733.76321-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_read_pdt_entry() takes the interrupt source count straight out of the
Page Description Table entry the device supplies:

	entry->interrupt_source_count = buf[4] & RMI_PDT_INT_SOURCE_COUNT_MASK;

RMI_PDT_INT_SOURCE_COUNT_MASK is 0x07, so the value can be 7, and
rmi_create_function() copies it verbatim into fn->num_of_irqs.  But
struct rmi_function declares

	int irq[RMI_FN_MAX_IRQS];

with RMI_FN_MAX_IRQS == 6, and both rmi_create_function_irq() and
rmi_unregister_function() index that array up to fn->num_of_irqs.  A
device declaring 7 interrupt sources for a function that has a handler --
F01 always does -- makes the driver write irq[6], which is the storage of
the following member, unsigned int irq_pos.  The function's position in
the interrupt bitmap then holds a Linux virq number, and that value feeds
set_bit(fn->irq_pos, ...) in rmi_f11_probe()/rmi_f12_probe() and the
irq_dispose_mapping() loop on teardown.

UBSAN reports every store in the loop body and the read on the unregister
path:

  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:183:10
  index 6 is out of range for type 'int [6]'
  Workqueue: events uhid_device_add_worker
   dump_stack_lvl+0x64/0x80
   __ubsan_handle_out_of_bounds+0xc8/0x100
   rmi_function_probe+0x1c1/0x210 [rmi_core]
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:186:28
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:187:35
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:189:32
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:191:54
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:282:30

Size the array to match the three bit field that feeds it.  Clamping
num_of_irqs instead would silently drop an interrupt source a device is
allowed to declare, and would desynchronise irq_pos for every function
created after it.

Reproduced with an emulated RMI4 device that publishes a single F01 PDT
entry with interrupt_source_count = 7, driven over /dev/uhid and again
over dummy_hcd plus raw-gadget, on v6.12.69 and v6.12.105 with
CONFIG_UBSAN_BOUNDS=y.  No reports after this change, and the same device
now probes normally.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_bus.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 90122df21f74..faf2ebb00d52 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -12,10 +12,13 @@
 struct rmi_device;
 
 /*
- * The interrupt source count in the function descriptor can represent up to
- * 6 interrupt sources in the normal manner.
+ * The interrupt source count in the function descriptor is a three bit field
+ * (RMI_PDT_INT_SOURCE_COUNT_MASK), so a device can legitimately declare up to
+ * 7 interrupt sources for a single function.  irq[] must be able to hold all
+ * of them: rmi_create_function_irq() and rmi_unregister_function() both walk
+ * it up to fn->num_of_irqs.
  */
-#define RMI_FN_MAX_IRQS	6
+#define RMI_FN_MAX_IRQS	7
 
 /**
  * struct rmi_function - represents the implementation of an RMI4
-- 
2.43.0

