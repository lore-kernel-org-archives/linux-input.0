Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585927;
	b=LrSpxu/oq2FVCAZ6cv2g+Ij146CM3CTUQJ7GLfO79uZ9w5g4tlBDZpLbU5ZQzxHT5Jg0
	 ImfbCR0m0hXru6GfoF5EVlegbsXDW13L7wHWtvM8ZqIzhJQJap7ghcE3rvc9UjQmyni34
	 zf4KcS4BaHde76S5CLin2hAuYELbQLKrBHn4PThhaqWluGjBs21AE1JobDWhKI9R6666l
	 Cyt2M3RqQLB9XLhV9n5a4yLIShqk3SrS6GDxlCPdh2XIPn8BGPJwQiL52gRyHnq5FKEap
	 jMjt+HgWO5+K/CSd7bKCqH4Rqx8amE7qJxAw/I/jtlWkX7GThEIL8dO2Yhd2CNrYB1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R129GmDUt+qvHZFqEN3VKb8rNuaams87GONxeRw6Drs=;
	b=rIdXzEqcxmB+fZUb8zIYs+hRjbDW1aL2uF5MgoL9nl/MyOoZZ9HnxrMrkKGcYlMxIlsR
	 2j9zVOHx2d1wTceSI1ihzESQw5SmErsi0EQMVSMBpwiPAGJYfMy8MVcZJUVCzqd7LUnVX
	 6ZbbAKnFwNYlCO5gV9bPcxOMY6fyf9YW54I7fNRe7BmbUT6vQj4xdz4vH7QvUfMxhcrCY
	 uDnPvCK1MKHUsslrulhHxjZIbVvuHoipEyoZNFnozI/Q991QUHZ12YjncMy0IoOhV5wX1
	 TjEEkqd6a2W101g3ea1/zE17qGE577wkBg2EgEFCc9s38gTiKPM7uVSOF/nkjMv+ifw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dS6XanIC;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EE606A33F
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318EE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dS6XanIC
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3acc610014eso368579a91.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585926; x=1793190726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R129GmDUt+qvHZFqEN3VKb8rNuaams87GONxeRw6Drs=;
        b=dS6XanICxAcG1TNmiPkCDP2CLwUc/8j9KXXD5drfyueKCkrOYq1BY2HJea2ekENFAU
         PDcGmH9VRXQC4BnXkyQuc83pxrsu/kYm6BE2f4ME/LYnzp1y25EifzkVf1MbavVmuvEG
         UZEbwp2qNQ7yKK2ZYd+43L2nkl5ROM8QdEAniDRGk/7Gk21nSiGzJ6ouDqF2/X+CThOd
         C4acm+q7acwdepGv8DaJ53mVxigcrBPJCn/7dYmCbSioWlBS9CHOh41ZIbsjgS16/TmW
         x6tBV2oh8xxH4W9W9nKj7BWbUlRUVBALw7c1emP01fd/q30fVT5d7okF2YuoTeCzMhDc
         JWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585926; x=1793190726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R129GmDUt+qvHZFqEN3VKb8rNuaams87GONxeRw6Drs=;
        b=WdcDbpZwmEPlFSETYhEf3aoflJW5JprgaXb4Dt8OCVL8zHoCRjcsqhfnEgr6NqW+GP
         L/pU8xoTfCW3MuRBYaGde7lLF6hLSyS8cI4z1PhGmyhAlzmV7g+Qb2onan/Z0uV6D6Oh
         5flK2xs7cOsl/9nX7auLJpv1PoG/TI+cnnPYDNB68OkxAfC72nuCgOvZUqEPCxCyC7yb
         VqIFad/eOFBK2YK2RqRwKwKPp+4lXvomG/+8yNDB66TLFisIuvxfvIA0ZLi6024Bai3G
         ace65V0DrjoxaPxzlWOJCSMxEKpUwkh3pdwWUAOX1jed1cxVvmMwWnb6AQFukLY4x521
         wQvA==
X-Gm-Message-State: AFq9FYKv3mSH+d+gveOm5OjyKUgPNjNet5GHuWNhzEmPVe0cECmyETW2
	9wxuEk5JxK2XM1oiB6pTHV5znvcIdrU+O57a7e7TscDUXqfSkcJxg6tze9lkUnuXy9RDBg==
X-Gm-Gg: AYBFou0IHIeE395a6Vfr1bS1LZcL5L+nZFt8UUCMLCyysnzwiikUIafPu3+6wva2XBE
	xEWeVjQDCNCKoegoUlz8di1qdZCzXXPvFbgmaQsBxgleAeV2tdBNr7PD4zWvWW4SRVYrBrSDlNC
	/iD2RT5aBgLtsqZ25QsNLVeR7+2y1IxekIVl5+pfzOCCjLAET+EtPzGwoqyALtxmU9OKGQCx8nP
	LqFPl3SqGpfNkVNeoNgmrrEK4yTpKmSEBM744XvEyhwJVR2eLpb/wE3PtH2S4zpa1c662lWAN6W
	okkcxzV5WUVEYkbqMm7jhTXpBRScokgZKqBAWWaPYolu+JMk/w32Tvb9RBTjm3rKaYnzYKLZ20B
	KOcmO2u94WIwfXFVMGkGiSelfsSG9rVq5dT/0SoFn5t1k9AQYtkK1NNUJWTsi4bt3HzpPun4/Tq
	cg9c1jQYHhI28Sl3LU7vD2/1YFcTYanzKpH7yFa4bNGzXfb4Axswq6jyi1GSt0fjajJb44BOaGj
	HNtKt2G5nXM/HSJQ3Z9nzhgmUtmnA8NXiBY3UrtnXOiND3i4yQfOkDVeisn41XzpkjWHXsJlg==
X-Received: by 2002:a17:90b:5547:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-3ad86ee2cc9mr1596337a91.18.1792585926342;
        Wed, 21 Oct 2026 05:32:06 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:05 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 3/6] Input: misc - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:43 +0800
Message-ID: <20261021123146.17202-4-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
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

The ati_remote2, cm109, ims-pcu, keyspan_remote, powermate and yealink
drivers build their input device physical paths by appending a subpath
with strlcat() after usb_make_path(). Most use "/input0"; ims-pcu also
uses "/input1" for its gamepad interface.

In preparation for removing the deprecated strlcat() API [1], replace
these pairs of calls with usb_make_subpath(). Pass "input0" or "input1"
as appropriate so the helper constructs each physical path in one call,
avoiding a separate buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]

Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/misc/ati_remote2.c    | 3 +--
 drivers/input/misc/cm109.c          | 3 +--
 drivers/input/misc/ims-pcu.c        | 6 ++----
 drivers/input/misc/keyspan_remote.c | 3 +--
 drivers/input/misc/powermate.c      | 3 +--
 drivers/input/misc/yealink.c        | 3 +--
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 8db2dca84975c..20cb7b8efcc0b 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -822,8 +822,7 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 	if (r)
 		goto fail3;
 
-	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
-	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
+	usb_make_subpath(udev, ar2->phys, sizeof(ar2->phys), "input0");
 
 	strlcat(ar2->name, "ATI Remote Wonder II", sizeof(ar2->name));
 
diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 353d3c1d347d5..06d8f0dab4b37 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -765,8 +765,7 @@ static int cm109_usb_probe(struct usb_interface *intf,
 	dev->urb_ctl->dev = udev;
 
 	/* find out the physical bus location */
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	usb_make_subpath(udev, dev->phys, sizeof(dev->phys), "input0");
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index b1a0edcc49b4e..e629a327fdd76 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -215,8 +215,7 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
 	snprintf(buttons->name, sizeof(buttons->name),
 		 "IMS PCU#%d Button Interface", pcu->device_no);
 
-	usb_make_path(pcu->udev, buttons->phys, sizeof(buttons->phys));
-	strlcat(buttons->phys, "/input0", sizeof(buttons->phys));
+	usb_make_subpath(pcu->udev, buttons->phys, sizeof(buttons->phys), "input0");
 
 	memcpy(buttons->keymap, keymap, sizeof(*keymap) * keymap_len);
 
@@ -301,8 +300,7 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
 	snprintf(gamepad->name, sizeof(gamepad->name),
 		 "IMS PCU#%d Gamepad Interface", pcu->device_no);
 
-	usb_make_path(pcu->udev, gamepad->phys, sizeof(gamepad->phys));
-	strlcat(gamepad->phys, "/input1", sizeof(gamepad->phys));
+	usb_make_subpath(pcu->udev, gamepad->phys, sizeof(gamepad->phys), "input1");
 
 	input->name = gamepad->name;
 	input->phys = gamepad->phys;
diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 70cd6586459ef..68c969657806d 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -481,8 +481,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 			 le16_to_cpu(udev->descriptor.idVendor),
 			 le16_to_cpu(udev->descriptor.idProduct));
 
-	usb_make_path(udev, remote->phys, sizeof(remote->phys));
-	strlcat(remote->phys, "/input0", sizeof(remote->phys));
+	usb_make_subpath(udev, remote->phys, sizeof(remote->phys), "input0");
 	memcpy(remote->keymap, keyspan_key_table, sizeof(remote->keymap));
 
 	input_dev->name = remote->name;
diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 754379d2625cf..f004cfca795ec 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -333,8 +333,7 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	pm->intf = intf;
 	pm->input = input_dev;
 
-	usb_make_path(udev, pm->phys, sizeof(pm->phys));
-	strlcat(pm->phys, "/input0", sizeof(pm->phys));
+	usb_make_subpath(udev, pm->phys, sizeof(pm->phys), "input0");
 
 	spin_lock_init(&pm->lock);
 
diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 560f895a00cda..9a8ee7a586f44 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -890,8 +890,7 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	yld->urb_ctl->dev = udev;
 
 	/* find out the physical bus location */
-	usb_make_path(udev, yld->phys, sizeof(yld->phys));
-	strlcat(yld->phys,  "/input0", sizeof(yld->phys));
+	usb_make_subpath(udev, yld->phys, sizeof(yld->phys), "input0");
 
 	/* register settings for the input device */
 	input_dev->name = nfo->name;
-- 
2.43.0

