Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E348664F
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836009; cv=none; b=ivBBoHoNczoHmY/gIYopFYLlmFKjG9NkweZZn1Q29E+8FatkIfxVW09kGomDD3L3sEjUPgy0TODb4KABTwV5uMST/pnIafiAAPAFWlUo9QRc5/VPIkEfEoRwYAVa8ojfr10Wnch2OYqFi+xBSRmBeASySyrVGwj0emmQZ5hoevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836009; c=relaxed/simple;
	bh=Z9jvfY1BROxk+boW+9quXdYMhRw6bTJEZD6pUkJTGL0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4Q3gyjewTla6nRAta3hP+SaJu6rP+wi80Mylf3/BOJi1meR6/EhFNeT3Tl7eNDu8pg/LtQnCXl/fdslkwdwZ1zpmtOxI1pKaeDTNwiQydKVjP0d/yhzUrITGDL8DeI+o7Y48FGa1H1LU3jemHWdnpLrPWCY2qHJNDe8iKqbTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIDIJLbY; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIDIJLbY"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso3028898eec.3
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790836004; x=1791440804; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fYiLKq2bV7ugiw5hQzlAAJbklyqM/fI/bLfHGK84MR4=;
        b=cIDIJLbYOl6rLNVemifWBibLHlMjS2N78t3PIHy2M5bKPl4GiLlZfgd/DR/SxSif42
         RWJQEk+CZNsxxjatyI3gCEPOJ1nbEaD97zsbsPrptOHiTkCkZSmvrtwk/MWbuiDsVkHt
         Bb4lTVUZW5MD/Ek+ef10kKrnQOrLQIIOa71fwx74wloRsTSUVDOTbnb6PSX21GF8V7lO
         I3H/iYswFK/m/zJ8J7GXUQmw2o2ZuYL7HAD3fN0rYVr4KoNg6Ho4JJVWJwqfWgp2wIWa
         s60NRsgXRmhV7X/P/dH/HT5PNIO3YQOTv6TiAAoNJsdHewMt/GhOC8Xl2OPGurvO0cM6
         RHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790836004; x=1791440804;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYiLKq2bV7ugiw5hQzlAAJbklyqM/fI/bLfHGK84MR4=;
        b=HLDYlOCkfJyGE+M/+2TEwdxzhHqj5+2H2P1RGChmdR6dsn/tr5rpCdh6auiyLvOD4L
         mfz4oonrJ+vJKc4Yj0hWxDBfnzHaKGM7GqOFSgVvQh6NCm1RVciF6LEPfPCiSKD+zu8a
         ocz+lZ3G8ywNGgdjrWHuV4VtxRNfvBtLj9txFycT+XNH0qGLGEoJOiLpA+zae/ex5XrY
         kyb88lGYOr892qTxUTLCqpZzoCMhWspToyNznKyAB/lv7OrObSv54UVBxTkxeNp4q2IW
         CtVcsccfwaLqXIa5b4VuM3Y74ACMXABL1t37WaTK+yFb9H8J62nTihYXzEj36KXVHs4l
         D/EQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtTaAoHXH4PRs9QaGvqhCvcLB8TOF/VHfE+JzzTQTsb+AfSA8qZawubjZXTSXPPS9wOdiIcZZr4AomKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvaPyhG+AVCtp/0OuvdVDDm3bKUo91Isneacy8IfBTo5USj+/X
	AgkPdF0lTKwfc57djBBcOBokcFVFXo7XvTmTgLGVF0hWbWQC6cVoNSqw
X-Gm-Gg: AYBFou18JeSH36BWeiJnnla2742qFfWC+D5AcZ6aQUS2r25rvkJMxqw9O/RIjFxP+Jx
	y/Mq9vemRMhJHbPgbmmF5ijLubNVIR1zXcV88rGzJeS7dRYoe7Vs7cQg4DCCk9oNcGUmaUC/zDh
	zzV+N8uN7avBAVgzzZzOzBgQjGlxfdtH7yYqdal66Tg8A9AMbg+Mb2c8Vz+i6MmjKJ1zIT1SYoQ
	643G/N/+4b/e5/meyG+HU6oUDUPv7kokgBXmvWbbkLl3idtC2ahxV0+WN4tummaVUfTQTeYHd+R
	TjE0NzyI0TUb+Bgvwzl1ViysdWm5jFVF3fyYzXD4b45DB7Y1VoVThaSQhLk4Z+t9JiiuAe6QddE
	IcyfHTaGEspyQTD3f/rl6Uzh2rpoLfVoYlLrX3kQ+sxkf3yRCjlhBz44PnIWk0QLlFNYJGU3ruC
	mvMwFn4rMUWIVMluhArkzW/A2etRLAysEqVutbNDZuEhbkbLpEBtwCx6kAAGhRwzOWwm8a8A2+n
	s4ISfFsl6T7EyRXHB4RAOT4Fx2IY32Rzcd7X4OerA5mibgCAAI=
X-Received: by 2002:a05:693c:20c5:20b0:34b:4b99:24ab with SMTP id 5a478bee46e88-34cdc6bbfb5mr3860417eec.22.1790836003947;
        Wed, 30 Sep 2026 23:26:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9835:e0ad:476f:74a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34dae0ad3a8sm4822762eec.0.2026.09.30.23.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:26:43 -0700 (PDT)
Date: Wed, 30 Sep 2026 23:26:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] Input: synaptics-rmi4 - fix input device name lifetime with
 hid-rmi
Message-ID: <ar38b7ToAe8iGU5v@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

rmi_driver_set_input_name() allocates the input device name string
using devm_kasprintf(&rmi_dev->dev, ...). When the input device is
supplied by a transport driver via rmi_dev->xport->input (such as
hid-rmi), the input device's lifetime is owned by the transport device
rather than rmi_dev.

When rmi_remove() in hid-rmi calls rmi_unregister_transport_device()
before hid_hw_stop(), or if rmi_driver_probe() fails after setting the
name, or if rmi_dev is unbound via sysfs, devres releases the name
string while the HID input device remains registered, causing a
use-after-free when input->name is later accessed (for example when
generating the KOBJ_REMOVE uevent or reading /proc/bus/input/devices).

Allocate the name string on input->dev.parent instead of &rmi_dev->dev:
- For hid-rmi, input->dev.parent is &hdev->dev, whose driver devres
  group is released in hid_device_remove() after rmi_remove() and
  hid_hw_stop() have unregistered the input device.
- When rmi_driver_probe() allocates the input device itself via
  devm_input_allocate_device(), input->dev.parent is &rmi_dev->dev, and
  the subsequent input_register_device() call pushes the unregistration
  devres action onto &rmi_dev->dev after the name allocation, so the
  input device is unregistered before the name is freed.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a349dfd17519..4ab00b2cf4f0 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -361,7 +361,14 @@ static void rmi_driver_set_input_name(struct rmi_device *rmi_dev,
 	const char *device_name = rmi_f01_get_product_ID(data->f01_container);
 	char *name;
 
-	name = devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
+	/*
+	 * Allocate the name string on the input device's parent rather than
+	 * rmi_dev->dev so that when the input device is supplied by a
+	 * transport driver (such as hid-rmi), the name string is not freed
+	 * when rmi_dev is torn down before the transport unregisters its
+	 * input device.
+	 */
+	name = devm_kasprintf(input->dev.parent, GFP_KERNEL,
 			      "Synaptics %s", device_name);
 	if (!name)
 		return;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Dmitry
