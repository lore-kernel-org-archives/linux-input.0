Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615550;
	b=dJv/q0y5rsBIWFHqe/sXJneP4SiqNIVs1r7idWyTQ7bZfW6PJLEXcmGiYVK4tuFWvcT+
	 Mu5CFP8NdMXxskh3juDjIAZZr53HSFe5gfhWSnyOg2QRjrykl1vmf/vqRksHzQa+NS7fw
	 TjyLql9kaPhPBYLlfWI7VC0RxGSx576bAVKda0jRKt1Ed7UKRNOMWgY7u/9g6yR+73dqS
	 u693sZZS6fLncwV9jq2MbQ59heED7+c/awx33X5reFWa7HntHdQCA5LFe5gd8gb8M/P8b
	 HPFe5VjVi6k9MC9sCy6LfXbLAnqmL8IG/hZvkAjXIULl2RD1HV6IDm33/2sCh8IUx6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=K377lqXhgQx3ip+MzIQHTbCsdl7pM+CZRLlJAcY/mas=;
	b=UiU+BLWJniHJyATxbru9AZonBkW6nmkHzEfuIoH3mqSHMmeMZwEVR99noxCYW2J1sPeD
	 L0KMGCcaZjD6fxGAq/mkmJArDHIsbWVdZfqyJ4WM9R/UdZSoNj2N3oSVnLeRIigaa1+2u
	 7dtJLfE5c2Bu4ooiw8y+yivE5WMKO1xVK66SOMgsy5/BvBnBgXGjPSlWYFqJPt1khl5Ty
	 LWmIyIqmQ4NfAaAlOdhIP2/d13z4ivkR8lsF0UuXpBNOB2uZzfL+tg9AOFzDvfgo1bCKG
	 IJzwGgoSTO6Q8fPy9OzLhKiztxpU6ukmrXMBrRIptZWO0hJM6AeohU+TvODePNGUcWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=thegoodpenguin.co.uk;
	spf=pass smtp.mailfrom=thegoodpenguin.co.uk;
	dkim=pass header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NrYokqus;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09046606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09046606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NrYokqus
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso42859385e9.2
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795615548; x=1796220348; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K377lqXhgQx3ip+MzIQHTbCsdl7pM+CZRLlJAcY/mas=;
        b=NrYokqusuGIc4t/Q470fAza+H7cssfQiC/j6t9VI2UrMZPxf5KHIj5SVjOIDcs8cHB
         jzAay/IpSWnZtBpBvwX/CgN1L1JoJ+onZ6YrApMJ50F3PbBgOzSPYSw6T9uup+RExfKQ
         LyNiOHSNonWWLgOZw0GRZ8onRRB6a+bZwBfyP/4qsNPDbSNOJqd2YPT3+yu+t8DEnnNj
         GJvD30LotRIs0ex3uQCvd+cAC77ABTKuKZo1Rf1PTwWUsMtq+HkrECOvuu5/9pGn2TaP
         uInxEASGVAbEUMy5Y7qb2LX9jfsYeDRIysGdguSxvsdhEnZFKq/slYiwjnx0GxryObWB
         n70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615548; x=1796220348;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K377lqXhgQx3ip+MzIQHTbCsdl7pM+CZRLlJAcY/mas=;
        b=W/NTTttFW86V4DkNRAJkbKQQ77QZPsme9XLvcs5ug9l18LUdpGZ+sXx2pdm57EsX/a
         2HzNRzZHCB54YlovzhFqQwyFLkdg+YutBITM/eEzPsLJ11Z0k7n062WAd30QkvIIFWQP
         xs0hrNq3LChXyksrT0F1pcyKMWxmgsJoQifnL3rO0eKEfIofHNLEmNPzT0aqhKJ0a67P
         7pNeXd9JJ89YQ4/akq+nYVWMSvWF9JPruis8aoLQmdo3MpJ8h1L3XJRLqvozxXnBQn/f
         7i8DbREt0O9z1H0QitjI3JSjaAZI9tMZrEgE/TxbNIWlqDORvlMBjcBA9zJ4PaKIHGgL
         sytw==
X-Gm-Message-State: APuU4Z8lZoRC7p3H8TVQejQAple18fGA8mwGYFucWClzexNw5xJrNEjw
	3XRAE57k6nckSUu02EN1LJU+BW02cCVfUh5UtO9u7K8zW4XOAQ/cQ7SsRud+1wFjwW4=
X-Gm-Gg: AZFdTZcytsyWIYfT+3Iyk0PGTxBOdBvtbN7/LgGFXgRVx+noulNZR73FnzMPG0gytm2
	hCnmFnvWrdRLx2Y8TwjChOeTBx4b2ZojDvIeJ3xyINGxF5aserIktaeH7Edi9VhoqiSFV56mRwN
	GgJ5V/5US6X+kTvWgUSs4LQCaypRPLBZ4yx5vIcqv4PGxmck/TLukavD2r7As1extUOPVoeYxDH
	ETC2mxLSwbjaXBsSXHtAG43KkONeNeWBpONlr3ajTXu/rF+kJUfB51IYmn1qZBK+Rt3ATJneVNy
	5JNk38VbdSWRKZNktrd5Huq7MgXf4k+m2aHK4uGlqn1EIw9MWq3o7Uc9dmvzu4bL2w9ympPS0RN
	3IAgO2/G3w5SN2G7r0RFmdIps11/FDwWSV4n4leWgGtVqdreEcuQ2w42ywdcrTTz4vWyQ8lZyEI
	errcLZgo7kjuMPPPR6/BjQngB4/56kA7hBE2bvx+98Y3OlBChbkMx8XDloj8B/BctsxH1vcM8bh
	0JQHGHTe/YTjPy10yJ5TKoHtyRkCFfck/VwsADGdw1io7KvCjPDMecvJmUCbyDtSikwA17T/uBV
	b/vSoy1vjAXx4Ivsrl4x0xZyvyBI0/biR+/aIpbN93ghZw==
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr348647905e9.7.1795615548291;
        Wed, 25 Nov 2026 06:05:48 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm282404955e9.0.2026.11.25.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:05:47 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 14:05:36 +0000
Subject: [PATCH] HID: hid-core: sanitize user input in 'new_id_store'
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
Message-Id: <20261125-acpi-sanitizer-v1-1-44b4aa8c538e@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDXR+ncVsagajEVJBxHi7orlt
 3jvAkZHyFAFFzjciWm2HjIMwIzaDiio8wYVqUxKlQptFhKsLa10ohNpVMalSdqiiHPw0eKwp+M
 b1s1v3toJzfpe4L4f/itbhnIAAAA=
X-Change-ID: 20261125-acpi-sanitizer-50939c4b8837
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795615547; l=2153;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=qRsauazP39/EM6diKx1CP08kblPIAD4NFHyd2XRVteE=;
 b=p5UK+2QBl+p6Ekewa11GB+LDluucE1k9hHjZS0SHMxJrcsjCk4BdKLwDRVYIkLdIrOHzjyw6o
 fj6EKJ/9ZU/CDsspKIP9znEoL2RLVHrObd7TeiWT0xFL+jOjQIWBVfk
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Only accept 'driver_data' values that match an existing 'id_table' entry
within the driver. This makes the field mandatory if the 'id_table' is
defined in the HID module and disallows overriding pre-defined values
within the driver module with arbitrary entries from the command line.
This could lead to invalid access as 'driver_data' can be a pointer, hence
the user input needs to be sanitized.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
This patch was originally part of the series that tidied up the usage of 
driver_data [1] - however that did not go anywhere. I think out of the  
whole series this patch is the most important as it patches up a potential 
invalid memory access in the HID subsystem (as driver_data can be a  
pointer).

[1] https://lore.kernel.org/linux-input/20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk/
---
 drivers/hid/hid-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4a47deb9d833..4de6a0476d30 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2666,6 +2666,8 @@ static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 		size_t count)
 {
 	struct hid_driver *hdrv = to_hid_driver(drv);
+	const struct hid_device_id *ids = hdrv->id_table;
+
 	struct hid_dynid *dynid;
 	__u32 bus, vendor, product;
 	unsigned long driver_data = 0;
@@ -2676,6 +2678,22 @@ static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 	if (ret < 3)
 		return -EINVAL;
 
+	/* Only accept driver_data values that match an
+	 * existing id_table entry
+	 */
+	if (ids) {
+		ret = -EINVAL;
+		while (ids->bus) {
+			if (driver_data == ids->driver_data) {
+				ret = 0;
+				break;
+			}
+			ids++;
+		}
+		if (ret)	/* No match */
+			return ret;
+	}
+
 	dynid = kzalloc_obj(*dynid);
 	if (!dynid)
 		return -ENOMEM;

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261125-acpi-sanitizer-50939c4b8837

Best regards,
--  
Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

