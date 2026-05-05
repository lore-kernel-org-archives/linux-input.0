Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3D3C197F
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957205; cv=none; b=NyV2r24QyIUGwRKuH7DR2LAawqwCcb9Gzg3fnz5gAyJpVI+LsLZnuKKB71IOHSk7fDQhnf0C+haS+3F8cTxZJLoWeNdz/RwqP81lsA7eBj7kTUcFH5nl/fzKam3OG6oXFz4OMSKe5ByPntLFI5cEWXZnlOyniu1TkHIyP2kqEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957205; c=relaxed/simple;
	bh=AXplrR7s7AGLwW1IX4e8KEzh0R3eAKBb1/o6rOguHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkFeP3/rGuObIo90fg6lVcsbHxyc0YiIIeRlgdq47tRwh8USAVAM/OPP3BmeLrV12JFRD1UXThGkjS3Q7QNZUXaQvzrELdtw5NpSZxjVNl3EJUPOcFKSllGBy0ogCWRnmB+8q+/PGrvXwuUzKPJpTc50zgNMEtlsXY9O54myJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzrEkew3; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzrEkew3"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0ad52830cso3294910eec.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957203; x=1778562003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJnK2nHTHKap6LV5wTwh1mU7zzvWh/QmG1m02AjJOGM=;
        b=YzrEkew3aDI1ObhRt2lip6cU/xkoykmP+vtMJDpqumXhPp9MMEAF3qOWHEqmuNiy5z
         qD0U2Y/xxPIp2p0t71Ch06s0IQ3b3X1+UEGkOxBz8LbiBbqjzsUsjk5rj5L7W1JgH79y
         B6W1fcQxTJe3OXtBW8XSL4vNNlgciQY3QOQMIk8uHrCV8p6DHUJ2P3xBfJY9bNpzZus5
         5vB7nBfWEBMBMdYayNyyrqQKmtPF8Xmgkrh2Wz6cpsT06Top7AXY0BOT7WKDmqJLwlkm
         bPbXCBbgfVIgz1RzHZS0YKrt94m+2inBqnZ8n6Qsps2PueybdIgVyBumUhwbk/h9X7Cf
         LgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957203; x=1778562003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJnK2nHTHKap6LV5wTwh1mU7zzvWh/QmG1m02AjJOGM=;
        b=o1RTBboOzMTsx0hdWcfTt8bo3JKf7Ma3NDJwkxhFGFgsbM/mquPKlbMoymB11iqb0I
         y/YZYddOxBW9g4DNue/xmZCNU9R4zacx2BByhVNtLcwZLjhP8OpQrjopcVplcZBDeylz
         kDUdrJvzgvy55k6mn8lqmCsWNpRT+3vr3/fM9LAigbtiAOQzQoF/5rsUDIteu2icRXpN
         MQdYkE1ohUK9drTpmOgfgjmb1DHJC7EAxyv1a5SB0ADUKPYYQoybwsPY1/DS+xz3a2mK
         a8vhZfv6hkuP8Nj7rkx1NUIvfE4FaOb/R0Oq1A/lWDYjwtMJM29ndsIzfrN+cpB9oiDV
         5EOQ==
X-Gm-Message-State: AOJu0Yy0nKqudby7/O6DtyrY066GQt2u+lWijmv5sXzLJ2dicPZOLYOq
	MtVSLMfl+RWGy67hEzoGqa5IhGTBtXsT/vUB9G3KV4t6AYTGH+xKWaau0iPb0A==
X-Gm-Gg: AeBDieuauMha4BiLfK20c5OnDb4AFWLTf55IFC6z1Pyl/g5goF5Z2z+mzAsIQpSiSje
	5PnbbAAFAXTGeRsEcc5IcJWFq0k6JNH5qwi8TbWIfc9LhkHwjCKhfx3KNAnKV9LXXCXsanE0efz
	ca1cakX4mmxmtfYWbqwffcXiyXCJ1z1MAVKGeQWIZAIvDvmWCCX5k2cPOmju7kma7blNa4HDRMA
	Km5IeEz2tW7LdNC+zV8BEGm8nEpYWqHARmsAxTUM5381NiAtoOap8suN7S5Ht6lO1wZk9ddpVLP
	IP/V8YPBOY3ATsrwsA9vmIg5N3BvrlD0gisWU6OJf2y8j2VW5KQb7uCWWYD3jkXsxDFY08VbLSD
	uEJB37Qrz1o9pvFqJfzgxWmIeRg8Jyoq9CEXfJi4x2pntwvYfkzPLolW4dak6n3VJkbeW3HDLBo
	GFaCFgnUF3QIWWiEv1ljNRFGIyUG9xH6FEwP4J0QFkpvqNytLromZdhydaI57jMvxDh7RZ0PPGU
	vZx173Ou7HIlPyecG9Tc9SCqA==
X-Received: by 2002:a05:7022:3897:b0:12c:44a5:fb4f with SMTP id a92af1059eb24-12dfd7bda5emr5489512c88.10.1777957202612;
        Mon, 04 May 2026 22:00:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:01 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 04/20] Input: rmi4 - fix num_subpackets overflow in register descriptor
Date: Mon,  4 May 2026 21:59:34 -0700
Message-ID: <20260505045952.1570713-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RMI_REG_DESC_SUBPACKET_BITS is defined as 296 (37 * BITS_PER_BYTE). This
may overflow num_subpackets in struct rmi_register_desc_item which is
defined as a u8.

Fix this by changing the type of num_subpackets to u16.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 2 +-
 drivers/input/rmi4/rmi_f12.c    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 5f769fcc758d..6952059bf4f5 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -53,7 +53,7 @@ struct pdt_entry {
 struct rmi_register_desc_item {
 	u16 reg;
 	unsigned long reg_size;
-	u8 num_subpackets;
+	u16 num_subpackets;
 	unsigned long subpacket_map[BITS_TO_LONGS(
 				RMI_REG_DESC_SUBPACKET_BITS)];
 };
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8246fe77114b..c2b07c6905d7 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -467,6 +467,13 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		f12->data1 = item;
 		f12->data1_offset = data_offset;
 		data_offset += item->reg_size;
+
+		if (item->num_subpackets > 255) {
+			dev_err(&fn->dev, "Too many fingers declared: %d\n",
+				item->num_subpackets);
+			return -EINVAL;
+		}
+
 		sensor->nbr_fingers = item->num_subpackets;
 		sensor->report_abs = 1;
 		sensor->attn_size += item->reg_size;
-- 
2.54.0.545.g6539524ca2-goog

