Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929555218A6
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904551; cv=none; b=lndQbJcfMHmTUiysVtWegwxIgtRccHyAlbo5o1uoHP4ibHohc8s1HSHZM2jNFIUd3HCoWHyclQWxw7O4wxfp52frZ3COM7O5M8OWleW5XDzjZMS3Ty5GJxlXs+GY6b9KrK6QltUphQcY8Y4WWDnDv+3BDNmlxzsSKwlLMHAhx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904551; c=relaxed/simple;
	bh=HmGWDDaqG9wgYzaaOhCtIlUpwfVuv7eZAzQKZvw2NO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LnDhfN/O4n4sh4j2UbOM/4Cz0sFR+kWcZnqp27LEoXxQ+Xavm5NqEjB/tKgcyJRWfrlJ7GzzAxp8+wo6Z+g0detqN4fAeUbF7gL33vYXbdUdDtXlXY9gVVKZi6QNrPvBR6u/x0xM0GlwOuWltfBWLHOFjNwKDFkwipMNHtBMDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=JWEgw3uW; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="JWEgw3uW"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-17bc533fda3so569405c88.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791904550; x=1792509350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/4xf9ixNsPOw+XXMk3VwH3ZhfDNhWjYPrvc7VQp0Lc=;
        b=JWEgw3uWTlFOyFtqcJnFR6u07H31+PLkPy6cU/CGAtJbU5mZcWG/erQaX0OraCo+I8
         KgyLtUlXY4e935EWhB6I7wHslhhod5vCwWbjheTL9EsdCfyMIZjPgvVAZ71j+vaCjuUX
         uM/abnVDe7ILe8q4wk/gtBbGDZNZewVXPDnCwMQc/QV7oR1DmqnzqgflL5LjZ02RvQRk
         VUFApJEVwW+2ZCQPAVFuwJFW38PK/ZLGlVoxoca3LXliMdK+iM89WrZF6B96c4I7W0em
         RwUzM+qrrHGnUDSoBqXIgYQ/HqOEyo1Db9t6bMHXKXLDpmGFz/Ns43u7iAWlvu4f6vEs
         HzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904550; x=1792509350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/4xf9ixNsPOw+XXMk3VwH3ZhfDNhWjYPrvc7VQp0Lc=;
        b=g/VxwpXzqIWjKf2OHJV3GKW0aU9279mLFePvkAxj44vfy96560afgUIyKPBM7xhS/T
         KYclvJ0CDBR1P+9qeeAHwQWgvTE8xr4GNUfZmnX4QeieKTSOKMy6KgK222fDc2pFq3v3
         KIdiB1pPos+T1goXfqSsrxG0jXWUbqpNTIQc8en4v+ezEb96sUtBfKXebgMGqqy0qPck
         Oi3v01S85Irkz5pZGz4esl2mhmE4qj8EJyiiAQ6Q9rf9qQGvt0dpp84z6+pJbhJ8Wl53
         kaBnxnScytBC4WFuw4tpMdGw5icJyTDBSECTUHsXC7zIOHBGiPN0rywePeXhRXsC/2bR
         oWgw==
X-Gm-Message-State: AFq9FYISGGCtNPUAQ+C+suMelaezniPUHSLVIw1RFFiVy5+XOlhGOvFU
	isiHJAZHQ/RpElpUBq2D8eGkuC8kMHowGTBAv+tUhcDkVDkt/0+B8lgMVuCTk4+YlO8=
X-Gm-Gg: AYBFou0FxVSta5BHcI+MzFZN1gkTYBcLzjpjsF+0Vu/G8t5KVMNPOozc5FlMELIMTsS
	+YxS2RSDd5LDnJtkMcsaH/3IB6DQXjR3DYavqXTHwFXFaswsIdZx8MN/K/EyX5Fsz8VXIcprP4g
	JKqawdKbYHILHoOZp/0Q743cUI1KXBu6I8xziFpCXMJBvMdfp+Q+Fe/qugrmGm32Uyt9l/nY2mM
	XMdRNnZFO8yp1OwsgA/MqQ/I/jwAjp+5x8kDz9ZiZLFzkpQd5NMsxkeJXMMRW6gskg2YSiGHGJM
	CD11CjY6nam/+yGUtLn8joQe2dP7QGZsumPgouI+0bUzSoQWh6VSemsbIwcox6CsLb4CX+7jume
	8jCcR7nQFUElwE7HbmDtDrk/NY7IGJpfK26I9Lj6yriiuAtqvc4N/GMOBPxK46uItM9wMjTB4xZ
	PDoWSecBLxI22usCGgmKqd48qZwwJgVYWg2GMLB40YzhuFoJrEebWxli+MXZ2rcI6X6c2NDeHIr
	XuzJ3zuMuz+cB8=
X-Received: by 2002:a05:7022:927:b0:150:c9c5:1ce4 with SMTP id a92af1059eb24-16a56ab133dmr22268863c88.6.1791904549516;
        Tue, 13 Oct 2026 08:15:49 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:49b8:4c98:b3d1:72aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm30691751eec.31.2026.10.13.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:15:47 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 13 Oct 2026 16:15:24 +0100
Subject: [PATCH 3/4] Input: mouse: cyapa: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-acpi-input-v1-3-53ad09ba82b7@thegoodpenguin.co.uk>
References: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
In-Reply-To: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Nick Dyer <nick@shmanahar.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791904532; l=1214;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=HmGWDDaqG9wgYzaaOhCtIlUpwfVuv7eZAzQKZvw2NO0=;
 b=orrWjgwEEFh1FiTF7HQVb9je4Hn8Voxwhgi2CmEj3dj5klRtM2XsKllESdRoEFsFHxl0ERJPf
 mOt99NSkjYeCeABG03IuTSlUlXMnG+AUxvH3Q05qFKuzUV3PACcnUjJ
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/input/mouse/cyapa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 47000c30e4d8..8a4c78261aeb 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1463,9 +1463,9 @@ MODULE_DEVICE_TABLE(i2c, cyapa_id_table);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cyapa_acpi_id[] = {
-	{ "CYAP0000", 0 },  /* Gen3 trackpad with 0x67 I2C address. */
-	{ "CYAP0001", 0 },  /* Gen5 trackpad with 0x24 I2C address. */
-	{ "CYAP0002", 0 },  /* Gen6 trackpad with 0x24 I2C address. */
+	{ .id = "CYAP0000" },  /* Gen3 trackpad with 0x67 I2C address. */
+	{ .id = "CYAP0001" },  /* Gen5 trackpad with 0x24 I2C address. */
+	{ .id = "CYAP0002" },  /* Gen6 trackpad with 0x24 I2C address. */
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);

-- 
2.53.0

