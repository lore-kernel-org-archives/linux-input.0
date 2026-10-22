Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653003;
	b=vYe10nGzejfEddsUgReuGVTNWNaBIaR+haIyX+mKGhGKP9GEh/AAfB696tEcUYPR6JEm
	 ctt18rWqGf5OH+mXc8LDpSrR0dN2qBGWTlB2XIDvsT+vUxHMz4S3XTyRNhs5ozEuzbK+q
	 yZc1RMHzyS3YloRL0EcJH9YA/nCIiSo2gOX64rNcfy4RHARw79KP0c3R7tN1+Urd9zhnN
	 83dbCa0FabsXi1IW/uJcRtsq5uo4EB5TTkrluE40kY93GjKSYgu7Ril5JrkLAS7FGtY1U
	 3U3NJ6R5OZ9ZrMk00vIoWpjNbeCkwV0gB+Z0P1wg1hDtKn26xQRklfA8epLOjx2QEFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YNbSVMz9CVaFMRMcwXe+rNEhXXF0h4y5O/CdVjdd2qA=;
	b=L73PjishlRQyNpKELdjF7Bi+fpW+4uqGD9VZIxcWUSohlBvEYgBgLXNh/tMQKTKGdbi+
	 bcDlxrhEkR3w4P7LdFdYHNUZUrTLFUp3Ow4+ShouJtAmev5ObnRudv+vyaYzGTCshztT8
	 5uYWN+aQOIxDk1oRWskb7BxcEXxq5VGZhhckGLQeG7v381rUtRX0SH25qiTjjoPris11r
	 lUD5HcjJ6/cKINW80ki9a4onf4F7CyIpvjFFJMcw+xm8zgKdCJmkEdl3+ZHSYp8Mlxxml
	 r4ZmdJfmkCJ7i7qtc/3K6eK/ybPFTOedoSrkk8mp+9L+0pRwqout7mOszc2XUC7f1JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="FtcP4H/w";
	arc=none smtp.remote-ip=74.125.228.11
Received: from mail-pz2-f11.google.com (mail-pz2-f11.google.com [74.125.228.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035C606A319
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F035C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FtcP4H/w
Received: by mail-pz2-f11.google.com with SMTP id 41be03b00d2f7-cd5f0803c1eso133297a12.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653002; x=1793257802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNbSVMz9CVaFMRMcwXe+rNEhXXF0h4y5O/CdVjdd2qA=;
        b=FtcP4H/wML0Ve6irDqNV4IJmnpuz0MCvhXyb1NxQZlnhXR4rLTgA/4cPOOWQ31YPeq
         ucPxwr+nApOBm2kpNwf9OmcEULe19Q9ftbdqLBxoQ4afNoi6PA1XGV+yxI/B0EquYgKu
         4L5ofyVTjiTwJeepKEYfWNnEh8jxdC6YoumO5NBeHmBqQrGtmW/yd2gpgc97OUDsqh8H
         Xlu0wyPDJR1RqFhLmRLxkY1lZ1H+HlBl7qqpbrub1ZTn+186t0kqP7V31OiwHK0zOKQx
         MmQFqixB1V/foZAZQd/7Y/BVugTh7OFQmkv0aHy8C6FaJ/m6s989yhE9K73XrqDcVdDQ
         OnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653002; x=1793257802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNbSVMz9CVaFMRMcwXe+rNEhXXF0h4y5O/CdVjdd2qA=;
        b=s8V/NHX+uGf45ULAdaur/8mGWnUe7XS+XzAY/blvkmvijbUIwNDySkprRQtrvgEPzM
         G05tfFdt1UbxVSuVi19A/hFhNtgachSv6vSV9IIe2aejh3j1tSM/QqKETMJOCky5wQxY
         LhfrTREDfIwKTYsf2XyCguHCZPXUt797ENs7I43H55KLpjHqtroMBV/QVqT/UE3di0V2
         r4uuYwRJCTxIeFDECOzbn9NZaogQR7F69pEser5KbH69wmyirqvPr0sdguAOKZr+dFTT
         hi1vYbqrkg/SpAWLG2kIn1d0hbLUmWJCVJ4i+kHngjqplCCx5n2og+1xhwrCrB0/GsEa
         XCIg==
X-Gm-Message-State: AFq9FYJZMd0ivj4W4pRfQzsYRE6uCXeYlum9YnfFXMK1McayTC7ULqKW
	A2XzuK3Ifu7KGAOr8yntgiX96jyC9EJN7PIoLmJ+ls9MJhYlrjTdl2MQSLGWqc5vlzDo0Q==
X-Gm-Gg: AYBFou32dmnvpZDoLHTskbU9igczYQAlNahJiNe0JSBWtKup30xmm/FxoqW7C+sPwko
	4hT0woyEeR0n3Mg7KXiZApxJ8B1G73TzI5Tzp9RykGogLoPjCGbWeFjvxs7nkNER8zU9m0GUBs1
	2l5YMLhq5FpmwSeIL7gmufx1uRvtFiE6Zw9YHIBoLWNRBovV0LxvLI9ntzy+cv2W4VjH0bSeps2
	YypvUXu2U44UyeN42I0gYgQ5TmO5XmUmeVkaacA5AeSHn6Q5T3szyqGPuW+Ikk51ZTGutBBFTrw
	MYSTz+HYqL5Bk/uPJPJ9CmOsFHpuAEYmD0Zrli/98GyOJdKTFwhZIxaSdh6LnAqpTbKq2tiI33R
	YgBK7hoq6Caxk+9qvlOd7NdyKmhO4LN6SuqWx7EOXHQuVAYNBIr/05zi16elvEiudvBu72Z2XGX
	Jb4Vkp4z0CTNY6nc1h1TGlVy86KgN5L5NK7mBTTfT1+ODDQrkPVjqTm3cOnCb69ODBgF8rU/wzd
	qo+Q3o1qlEjpBPbC2LE3abu3XqlE5fowsNQ2tppa1eHLl7lkFoNBbHuDqGJAInrnC8vjQ8hzg==
X-Received: by 2002:a05:6a00:23d4:b0:881:8b53:f64 with SMTP id d2e1a72fcca58-8a089facbd7mr3250979b3a.59.1792653002200;
        Thu, 22 Oct 2026 00:10:02 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:01 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 3/6] Input: misc - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:26 +0800
Message-ID: <20261022070929.20820-4-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022070929.20820-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
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

