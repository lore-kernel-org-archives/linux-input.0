Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24E3B777F
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857078; cv=none; b=oLz4/geZ0bHmpJOkblaRnes4uTKBEvPaOdJs2TJmtrrsFkvmENAtQwrkHAghcJW7nh8DH6Dj9jT2QhQSOnljvUglYgKYccLVI3TGJlsp5Qp37r3ZOekVw5IzIr0wIY88zKliQYGLB1S4eWkv/LAtVBZKccBPxmvjfPKSV4fFbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857078; c=relaxed/simple;
	bh=SC/CTbcSjT0Z1rGJfIUzIfcgnu46njymDXgOjHgKlCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGm4uK7OMubrD2tewgmOcjTWoBvKXD6hayVjUYeG8n7cC+bdRGLmeEVGsWaF1KiibczTnGy71XPHpYt2GSjA1lkBdu10ZllX2QKqhzDxpggzBIPiS1bt9WZQFVWLaOcKOiUeTg7nvidREdYCjYTL0HyZMVyxXdajVm+m/USfcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOMXQVkE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOMXQVkE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so109808805e9.3
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857075; x=1779461875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPkTPOfIUkqbVQzdpAjVs51egWppeSF7OM8UWfC68BM=;
        b=iOMXQVkE2qwgPKjsaK3S9YT6F1APsUk4N/pGRixDcBrdEt48YIjb97hUgGZP25cr+Q
         2Uc5FiP/sYGiuauokBx2jyAtAYHVyBH4RKXDjo+NpQd+0z8hiprJ84+BtsPdJ4KNObox
         2sOZiFExrPtdcEN4WSOF+ZVTo075Uf9ROe9x2rDGneEuFmdyN2lcdf0FM2O6hkz8rFKA
         5ZmkEEta8jfPi3qQ5pLMiHb5qle9o/UfuSKleBZ7GQTQVSzKbFad3Lr9oB9epA9mJ8Xh
         i1M82KA5sp8v3yR2jDo0MsdNAbPka4sFQGF91NTMO1b+LmqMA2hW3Pv6qEBM6k3OVnuI
         7YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857075; x=1779461875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPkTPOfIUkqbVQzdpAjVs51egWppeSF7OM8UWfC68BM=;
        b=Oq0VBGhG3NdyhZ7IeZFk5dLeoSi6/nNmKnKeR/Cz8zt1XXPKYlqj24K0Zpzp/yZthX
         1xsdNyp88Kqdp1KzoGUzdvBKhkJG0eF+5XYErgMDksrgxZYabl3fCGfJKkVUXOLOnteJ
         xpsxxhsjvjSgV/NgPfvOtVslT+J0p2n+CMdPNMTqPXRzt3xq3slENCsMGP3aCJBPQoIF
         UY47WdViekG2PXLi+TxgguJYTomkuzGNPveEtKbpsLvA8LYUf3xEd45P9wySpXrT78PQ
         dHlQyzPlFM8z6Y9kxh7rkD86ig6Kll1kmFjWzCg4UkThFBpp842hrdx9N+Ns4Jk8vO26
         Auxg==
X-Gm-Message-State: AOJu0Yztf3eQGo2MBfR7mVaR1jWkJbaZ4zlKXe7JU2bREEyDshFUgxhl
	a/QFpyfLH+W5RagD3Q5FoUDYjHun3xoy3RjSihM8BDlZ1wOiU2HE8DAO
X-Gm-Gg: Acq92OHyBY3/zR5pz24sUSHWnLr2QYJ2SE+7eXJNP5MIz1T+rzKlpXv7KI2a2/6xwoy
	ZLvAzCQDF8UW7Dz24H112JISxIMykHSVl0Xrnm0v0MzdSuJ/4ZpVibtMz7O9az9Y/77yJ3RreUY
	2LdIc39N1uMayui3S2CXQQL4FwDd+cVRJGEmS0dduX/LOc4jikm2x/bVZ09ZtvXOPjWrg5IXTby
	75nGPZv2WrQsi6lgJuri38nKWeo4jirFfSCZM64b1sI6pQ3qGC47eB5pKUpYeT7F4NG0FOceASq
	I/vexf5d7Klici8DMd68evGb4wyikW538spKdkl0cT4xrO9IPwaKjaFopW4oP0+DmThQlR/eZ9g
	8UeXEZIb2JJhV9pC00kZEVDOeQnFOvA1k4saOJ75FBD5gjIEby9uGmkPviEGuRzvXFPBg4YVFGN
	RO41tOjdXoqo+Bo74vQZNNMoMsedSC3CgzsO4xcrE1c/X74Usa+EjEE17IHupziQx6FVQnIwA/E
	FkotyStUVyQgv070gY0f47ovGJpgRXm94IOylsYRnG+HYvPeFi85sDnbdoIckubbZ1Wug==
X-Received: by 2002:a05:600c:6098:b0:48f:d1b8:9ab1 with SMTP id 5b1f17b1804b1-48fe60ecc51mr68749495e9.9.1778857075183;
        Fri, 15 May 2026 07:57:55 -0700 (PDT)
Received: from my-vps.. (ip212-227-39-93.pbiaas.com. [212.227.39.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm76096135e9.11.2026.05.15.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:57:54 -0700 (PDT)
From: Louis Clinckx <clinckx.louis@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: lenovo-go: reject non-USB transports in probe
Date: Fri, 15 May 2026 14:57:39 +0000
Message-Id: <e8f92f07a397f39680c72ca69a5ada9882ff7212.1778701376.git.clinckx.louis@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1778701376.git.clinckx.louis@gmail.com>
References: <cover.1778701376.git.clinckx.louis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers only match HID_USB_DEVICE() entries and assume the
underlying bus is USB. Make that explicit at probe by rejecting any
non-USB hdev, following the pattern used by other HID drivers.

Signed-off-by: Louis Clinckx <clinckx.louis@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 3 +++
 drivers/hid/hid-lenovo-go.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 01c7bdd4f..abf477e68 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1432,6 +1432,9 @@ static int hid_gos_probe(struct hid_device *hdev,
 {
 	int ret, ep;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "Parse failed\n");
diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index d4d26c783..3fa1fe83f 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -2419,6 +2419,9 @@ static int hid_go_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, ep;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP | HID_QUIRK_MULTI_INPUT;
 
 	ret = hid_parse(hdev);
-- 
2.39.5

