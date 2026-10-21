Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547411;
	b=hFEsYnhysmGJibf6nsjddElqhB5EOFoxsPI9YgPPrYWUWgz1oMZYyzua17G7sGEMnbOA
	 vzLhDBn2uKjGRer13OtNEMRU+eRPzMcA4QfjaoOqfqhvftzGJnsfC7n4FOXxiVl7nKqrl
	 aEPZPp1knjyPZz1E9Ir/Q5qmhajCCk1o+wBgATeZOHdXBrlv9bd3pYAfy57I3XcuVVjKN
	 ZHgleyxSXWxis+hfxCbzQ9StkeLeX+cr0YVLPln97jSK4u46ScOlZL89myfRQ4CYUHdry
	 YBPopTHpGbOrlPnTm1+ismvNbm9SfoL7fBkLQB4PiJSKC0UJzjNu10C945Dj3Vk1TuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8S8G1iypOEwISrWzMI82hOYxhksLEVMBHWgiqS8i/aU=;
	b=O9mDyYIiP4SqUZfaMOgqPm4SHIi7yQfb/mfZ+ROPl9rAsvxmhTwKWVT0k1yXTUW8cnQH
	 IgWMX6c0dZZefv7zMO7s8Pp0WNyl0RUkaAemDhs0Pq4R3Q7rC4Ui/KSwQhhgTY+Gd8cJc
	 EJMSrk9ZriNz+8W636O4liG78BnPQMbVIy3Df6FQYNMeh5xKKKAO0XbOPhv7RrJwSgOdK
	 H0fOHipXaiXO4REZuW2my+FWfvMETqIDq4RMxY7H/bj9vWQ6oKZjGUXcnfmAV5T2zOffZ
	 mXQT1XN4FORO7RTSSGKrOUAlx9Oi/9yfi22NIVmXQBko9q9xdPKVTxtWUqrEAPQBAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="dG2eif/P";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348C606A321
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 01:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2348C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dG2eif/P
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so499644eec.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792547410; x=1793152210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S8G1iypOEwISrWzMI82hOYxhksLEVMBHWgiqS8i/aU=;
        b=dG2eif/PE7Ui9zyAOSwP0CDj3gTDChftpWOLIMVBFAHqrylKJJyHltQOFo/8SyoEUj
         QMdPrFlEMOerAJr9CNjLvczwXC0kX1CMjE9O5vSIEDUVbaKKYnvdUsU/c3WtLzktyWaI
         /RC4ylzNcpFSy8xwt2ijyFqgn/NXmKHv+VmqKEKuO+wQTbtAhAleZavEc+LCQS6qLaPB
         BbwkyOt97+Tw8UyVJv8aEwIiq8ZQE4WochqLMFY0PdDnFeNRbsHZADj5OG7zrXoGJLhD
         Qvz0S+wsJfFL0XzjBzYAM9QW7ExW44IE+LzxMyKdm5yZtiO8tYgYr71t39Ske+rTScAj
         Uqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792547410; x=1793152210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8S8G1iypOEwISrWzMI82hOYxhksLEVMBHWgiqS8i/aU=;
        b=PmxdvJq0NjfJ1dQVVW+WTjJLsKmEI7k55VaOUBc3M9h1BJOBhwY7QkOyOI8kRhmjCL
         n5aBU2aJOgsqUPSFMPSis3vHs3Tl1LJlxeOaf+yLkAbKEgoJ2X1BNAdIfJaDG/KvOIMX
         Ycm4kpxmbTo3O1+h/K0/fy0Tpfh0oTtUgaERkbnQeSz/RwqeewyBftT6SlxqRoSq1mZx
         0EJzF+IRXHedyxJg8GLDKMGpzVxNahBsnvlcyMlyoSFKG0Zd5BfH4BXXFdeMm6sC6nh8
         gZGZ0kigVkCsOPxU9QCMtcvaHhkz24NqLhi5EhaJwXt6fLlPVvn/GbXUOcXSHzYzzIZN
         waig==
X-Forwarded-Encrypted: i=1; AKwUvByqcKsWV1l80D6SoOe7/ILrNw3oG0pNu8KjImaF2fUwDFMUXu+UGXzRqEMd+K9Ehj/7oCxtNu3vG+R5xA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIv2wmXI7KY1x8L8GrUth56F3nT2HrBXi+rk1AEj2oW0mxs/csP
	aYne6AabZ2gaxMGQ0IdA+jdE7VWTEmGz6YTW5lkESL/0rYovArIJMHnC7FHumA==
X-Gm-Gg: AYBFou1yR17JOp2RQwXbjV0W0qgG295zY1dVpJRWqe9Q0pbEVO2VU87HQaEZGMaM0np
	tNR1mJiNkTqwcMVFdJuVfDjHYW1PPgPg+0wR+ByBnlfSXbTit7h3WUvruAWEsTR0onSkVDUow7I
	fnduajI/fV2Y98Va3cebYxxfGaqdCOy1yQATgt6IVHWsHyAqMch1EGlYRUs2tPvyyM4cMmcibV3
	rANiO16iiyRMZdkqd2E1d4eQ+IOKP6mvAIcCJ57HAnzWrHnkmtZot/IS9jr3rQg4zFoi37C8QAO
	SgTk1uXHGC3f3y4UZ2fHKCCUx2OkWdRS6ojmyYHORiXAQwqc7qWtoJEdY2BElkkofHHZ/sTIFkE
	W/PWaKdN14WZgcJmmOEtd1bA5l7kDNZC9J+EImpIESWDCxlNxzqaph5fQW2l0erFG3TgZCsFcpl
	a5Hw/e05B+qn3zeJFMphSRgASUkKUbLSuw7OK5wVdNyijF2/7+bmFx7576S7PvFWiycg8nm+q40
	t66aRNp/bmtI/Mi9NJET8utrNk4c7a693AetlrZjK3y6TjfPWLQB4/5EQZyNIAlx1uZ6GOtbiVj
	73TfYs+iVsqd35WekXXm82pE+nwTentjkF6Netj5OXFo
X-Received: by 2002:a05:701b:4504:10b0:185:b157:f271 with SMTP id a92af1059eb24-190a51e5f49mr758501c88.23.1792547410075;
        Tue, 20 Oct 2026 18:50:10 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm2106839c88.13.2026.10.20.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:50:09 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: soc_button_array - use __free() cleanup facilities to free memory
Date: Tue, 20 Oct 2026 18:50:00 -0700
Message-ID: <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
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

Switch to using __free(kfree) cleanup facilities instead of doing manual
cleanup or abusing devm for allocations that are only needed during
probing.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/soc_button_array.c | 52 ++++++++++++---------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index d4dc4e7116a7..8d782ef4f78b 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -366,10 +366,10 @@ static const u8 btns_desc_uuid[16] = {
 static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
-	const union acpi_object *desc, *el0, *uuid, *btns_desc = NULL;
-	struct soc_button_info *button_info;
+	const union acpi_object *el0, *uuid, *btns_desc = NULL;
 	acpi_status status;
 	int i, btn, collection_uid = -1;
+	int error;
 
 	status = acpi_evaluate_object_typed(ACPI_HANDLE(dev), "_DSD", NULL,
 					    &buf, ACPI_TYPE_PACKAGE);
@@ -378,8 +378,9 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	const union acpi_object *desc __free(kfree) = buf.pointer;
+
 	/* Look for the Button Descriptors UUID */
-	desc = buf.pointer;
 	for (i = 0; (i + 1) < desc->package.count; i += 2) {
 		uuid = &desc->package.elements[i];
 
@@ -397,8 +398,7 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 
 	if (!btns_desc || !btns_desc->package.count) {
 		dev_err(dev, "ACPI Button Descriptors not found\n");
-		button_info = ERR_PTR(-ENODEV);
-		goto out;
+		return ERR_PTR(-ENODEV);
 	}
 
 	/* The first package describes the collection */
@@ -414,32 +414,26 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 	}
 	if (collection_uid == -1) {
 		dev_err(dev, "Invalid Button Collection Descriptor\n");
-		button_info = ERR_PTR(-ENODEV);
-		goto out;
+		return ERR_PTR(-ENODEV);
 	}
 
 	/* There are package.count - 1 buttons + 1 terminating empty entry */
-	button_info = devm_kcalloc(dev, btns_desc->package.count,
-				   sizeof(*button_info), GFP_KERNEL);
-	if (!button_info) {
-		button_info = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	struct soc_button_info *button_info __free(kfree) =
+		kzalloc_objs(*button_info, btns_desc->package.count);
+	if (!button_info)
+		return ERR_PTR(-ENOMEM);
 
 	/* Parse the button descriptors */
 	for (i = 1, btn = 0; i < btns_desc->package.count; i++, btn++) {
-		if (soc_button_parse_btn_desc(dev,
-					      &btns_desc->package.elements[i],
-					      collection_uid,
-					      &button_info[btn])) {
-			button_info = ERR_PTR(-ENODEV);
-			goto out;
-		}
+		error = soc_button_parse_btn_desc(dev,
+						  &btns_desc->package.elements[i],
+						  collection_uid,
+						  &button_info[btn]);
+		if (error)
+			return ERR_PTR(error);
 	}
 
-out:
-	kfree(buf.pointer);
-	return button_info;
+	return_ptr(button_info);
 }
 
 static void soc_button_remove(struct platform_device *pdev)
@@ -458,6 +452,7 @@ static int soc_button_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct soc_device_data *device_data;
 	const struct soc_button_info *button_info;
+	const struct soc_button_info *dynamic_button_info __free(kfree) = NULL;
 	struct soc_button_data *priv;
 	struct platform_device *pd;
 	int i;
@@ -473,9 +468,11 @@ static int soc_button_probe(struct platform_device *pdev)
 	if (device_data && device_data->button_info) {
 		button_info = device_data->button_info;
 	} else {
-		button_info = soc_button_get_button_info(dev);
-		if (IS_ERR(button_info))
-			return PTR_ERR(button_info);
+		dynamic_button_info = soc_button_get_button_info(dev);
+		if (IS_ERR(dynamic_button_info))
+			return PTR_ERR(dynamic_button_info);
+
+		button_info = dynamic_button_info;
 	}
 
 	error = gpiod_count(dev, NULL);
@@ -507,9 +504,6 @@ static int soc_button_probe(struct platform_device *pdev)
 	if (!priv->children[0] && !priv->children[1])
 		return -ENODEV;
 
-	if (!device_data || !device_data->button_info)
-		devm_kfree(dev, button_info);
-
 	return 0;
 }
 
-- 
2.56.0.212.g129ede20d9-goog

