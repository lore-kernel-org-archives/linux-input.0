Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3563DDDC4
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244809; cv=none; b=s1EGWF47IxkJK/OPEl2d8KVC3FOaAtjlJaphVpS6HFIifSQXrFLlSnwWnAL6fmjf4B/TAwn0iRh1eoR5OCA/eqH2wm6b/FQ4UcJ223g91qazqjLtZwJ6hnlzCnZxbZ1MI9eutA5Jab5eibgP/HOybeWhzu6//+MmcsdddS7YwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244809; c=relaxed/simple;
	bh=MNyVJI2hbWvpz28Yan5uNv0jnas35N/Bch/oPiRkTZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXiVnOnctASMaxW94mqxJVS2YSl53dSMLOAmcbe6bgAsLLuC5fGrEgXZt27hjCytd0nyOJdqDVkyfYIo580tfo508UrSJspdtRb5nZ9CZ5bIy4gaJP/5VnnT7yy6Z7/IlsurODNCQrBNsiqHUWpyBb8hOuyUVgeeIeRJg+qxLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xd2FaL8i; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xd2FaL8i"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9d9971d059so303935666b.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1778244806; x=1778849606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Gh6I/+24agVwX8lBZJvSBSrfNENuBcVK4OqqTCY+cw=;
        b=xd2FaL8ipK09rHOvK+0TeGCUCQD7w/0h6NVtzNKLZnwKdsUFizVjZ5gbU6Hhbtf/p+
         0ohY7JK+D39p5/a3ood7fnvRAu3EdgbAkg+0CGPulMCrnlNghu7qkLhzj1Q0XPDbkg/Y
         cNGhCESThbAYoYealr2na+2EY/RolgjL45cQX/X/I1sSMy5AJMTJgN3dhBUaAF9p/Y0F
         Uf57WLYXFV3y4q0LiakP4SSpserK+89APuethWGESRnNxE+/h4yk6/fIAv+oyeh1xT1C
         QvgVfbIiUKwKLb4332XzywSP1vSkPPrBTpgHOJrvccgFgEDGY0KR3NlBGtKU5xrrolbX
         dx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244806; x=1778849606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Gh6I/+24agVwX8lBZJvSBSrfNENuBcVK4OqqTCY+cw=;
        b=CsDHFyNlwa9WAFEayg/9DqeQWTRQp6/KWzLXN6Qivq19zpPdhIfXUxEOAajARgdSUQ
         KsVYKk/gLwwjV9+d4Lno63hmkGV4E/+ZVFa/kBY+6Tdik8FU87ORd4fomHJw+6EjhpeS
         Oe3p+m6tkQsVoedjET15pyIT5eZrE59NbXZu2tB76DR3JxQtvBPHB/abHRVpOoL/nKHW
         Qd6fJ9rkg6oXArEVAhd++zqc/rv/7Gt5OcyaUjXImEJW55uGQoe9BI9WEHZFgQhKdGK7
         0yrIShY9bpkVf0dvaGELvZBn6Zcc5HtOromVdVJasxFXzy1zx2JnbrmiRgxQDnYCk0hm
         X1lg==
X-Gm-Message-State: AOJu0Yy4qGHLULBj2aIF62UeJSHpT3ODlVgm5yGDPQr0fju8BNPP8QKT
	q9BHlaZn9ny4Eqzz5L/0YhCXhPATiMuVEYB1HAdQkdjRJMiLBqXP4HMx6tON4gya1ss=
X-Gm-Gg: Acq92OGMHiWiLeeHjY/VONLPCG4lLfAHieOOeVqkf4tN5es0ZLDVgSBhPJ8dFQ0dg9A
	Q6oQjy94myFybNp0Zd1KqA5VAE1uTip3lR0QtSAHjyydalcD6PD0Rdao9G5Z/l0zCaKKQXSq6Rd
	PizL0ZuW9XAHuE0Fsm1aZ+vxpU3OQ7TgFJcrixEqObSUnMapb72uw9VlE+4Q0wJTCDFEQrLfCbE
	v92FzjGPRMqoflpuRgLlJAVsU4cblsKQ1u1YwV/yITxUJrbVzIkqnF1vHfD/ewh+EsKAuGFLP5Q
	BPcDj/31mVuxRpC8OLmm8iHRYVDZ0Mu94akxF/4MUbhU3QPKcu7QumI2qpfbWMuPzypygoRYEqF
	fjBbW3ie5/6jMNT7KCWcg0WvsbDc5NT+C7VmKK73S/OpUFfFRap8dVKaCjRu7Nm3Robq3MYkjep
	5sIJ3xJzCoFIJelOlkxw3v9yZKLTPIpGVW0kNXnGY+3KCixggCs6qFuFkvcw/tkgCKZHTS9ywDG
	D4dS8/lyg==
X-Received: by 2002:a17:907:7255:b0:bbf:74d7:1c4a with SMTP id a640c23a62f3a-bc56e21ac66mr648201166b.40.1778244805766;
        Fri, 08 May 2026 05:53:25 -0700 (PDT)
Received: from [172.16.220.224] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcb94415c94sm800266b.53.2026.05.08.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:53:25 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Fri, 08 May 2026 14:53:13 +0200
Subject: [PATCH RFC 1/4] regulator: add devm_fwnode family of functions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-gpiokeys-vdd-supply-v1-1-0bb32e8e6428@fairphone.com>
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778244804; l=5378;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=MNyVJI2hbWvpz28Yan5uNv0jnas35N/Bch/oPiRkTZ8=;
 b=2ewq8NqF216z48g2VXRM684/943ePCqHB6/J7Y5sEVUk7QRpynBqlqD5IcEYTpjWLGO6gJta0
 mHeVy7YtsdrCiHUXDSUKp5NfBk6zrP+YUWkdFfrAfXfLYRaDb/XLnL7
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devm_fwnode_regulator_get and variants.

These function wrappers allow regulators to be accessed from the fwnode
struct without any casts.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/regulator/devres.c         | 66 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h | 30 +++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 615deba5d22c8ce190c69081c94651d8df93d002..f525b1f48bcf18593798f6fa520ccdfc656f6b6c 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -11,6 +11,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include "internal.h"
 
@@ -803,4 +804,69 @@ struct regulator *devm_of_regulator_get_optional(struct device *dev, struct devi
 	return _devm_of_regulator_get(dev, node, id, OPTIONAL_GET);
 }
 EXPORT_SYMBOL_GPL(devm_of_regulator_get_optional);
+
+static struct regulator *_devm_fwnode_regulator_get(struct device *dev,
+						    struct fwnode_handle *fwnode,
+						    const char *id,
+						    enum regulator_get_type get_type)
+{
+	if (is_of_node(fwnode))
+		return _devm_of_regulator_get(dev, to_of_node(fwnode), id, get_type);
+
+	return ERR_PTR(-ENODEV);
+}
+
+/**
+ * devm_fwnode_regulator_get() - get resource managed regulator from firmware node
+ * @dev: device to supply
+ * @fwnode: firmware node to get regulator from
+ * @id: supply name or regulator ID.
+ *
+ * Managed of_regulator_get(). Regulators returned from this
+ * function are automatically regulator_put() on driver detach. See
+ * of_regulator_get() for more information.
+ */
+struct regulator *devm_fwnode_regulator_get(struct device *dev,
+					    struct fwnode_handle *fwnode,
+					    const char *id)
+{
+	return _devm_fwnode_regulator_get(dev, fwnode, id, NORMAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_regulator_get);
+
+/**
+ * devm_fwnode_regulator_get_exclusive() - get resource managed regulator from firmware node
+ * @dev: device to supply
+ * @fwnode: firmware node to get regulator from
+ * @id: supply name or regulator ID.
+ *
+ * Managed of_regulator_get_exclusive(). Regulators returned from this
+ * function are automatically regulator_put() on driver detach. See
+ * of_regulator_get_exclusive() for more information.
+ */
+struct regulator *devm_fwnode_regulator_get_exclusive(struct device *dev,
+						      struct fwnode_handle *fwnode,
+						      const char *id)
+{
+	return _devm_fwnode_regulator_get(dev, fwnode, id, EXCLUSIVE_GET);
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_regulator_get_exclusive);
+
+/**
+ * devm_fwnode_regulator_get_optional() - get resource managed regulator from firmware node
+ * @dev: device to supply
+ * @fwnode: firmware node to get regulator from
+ * @id: supply name or regulator ID.
+ *
+ * Managed of_regulator_get_optional(). Regulators returned from this
+ * function are automatically regulator_put() on driver detach. See
+ * of_regulator_get_optional() for more information.
+ */
+struct regulator *devm_fwnode_regulator_get_optional(struct device *dev,
+						     struct fwnode_handle *fwnode,
+						     const char *id)
+{
+	return _devm_fwnode_regulator_get(dev, fwnode, id, OPTIONAL_GET);
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_regulator_get_optional);
 #endif
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 56fe2693d9b2284d04ebae50165f9aa7b1b3fee4..7c3aedf7f4902c4e3e8e2f5ecf6e4323b77658f3 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -691,6 +691,15 @@ struct regulator *__must_check devm_of_regulator_get_optional(struct device *dev
 							      const char *id);
 int __must_check of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 					   struct regulator_bulk_data **consumers);
+struct regulator *__must_check devm_fwnode_regulator_get(struct device *dev,
+							 struct fwnode_handle *fwnode,
+							 const char *id);
+struct regulator *__must_check devm_fwnode_regulator_get_exclusive(struct device *dev,
+								   struct fwnode_handle *fwnode,
+								   const char *id);
+struct regulator *__must_check devm_fwnode_regulator_get_optional(struct device *dev,
+								  struct fwnode_handle *fwnode,
+								  const char *id);
 #else
 static inline struct regulator *__must_check of_regulator_get_optional(struct device *dev,
 								       struct device_node *node,
@@ -712,6 +721,27 @@ static inline int of_regulator_bulk_get_all(struct device *dev, struct device_no
 	return 0;
 }
 
+static inline struct regulator *__must_check
+devm_fwnode_regulator_get(struct device *dev, struct fwnode_handle *fwnode,
+	const char *id)
+{
+	return NULL;
+}
+
+static inline struct regulator *__must_check
+devm_fwnode_regulator_get_exclusive(struct device *dev, struct fwnode_handle *fwnode,
+	const char *id)
+{
+	return NULL;
+}
+
+static inline struct regulator *__must_check
+devm_fwnode_regulator_get_optional(struct device *dev, struct fwnode_handle *fwnode,
+	const char *id)
+{
+	return NULL;
+}
+
 #endif
 
 static inline int regulator_set_voltage_triplet(struct regulator *regulator,

-- 
2.43.0

