Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A6327BEC
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072215; cv=none; b=rXLHfSHKw30rjXYMM9CkiIJarmqc0UrBSaVd++1ViaIYMaFaVu22xH23/AVHmSS49/k3uVI3bqePVYy6IkonEuudCRNiJ4hB/ehYkhizSHV83Us0RbpTNy6QdDdYJQ/LXoXEc67CYr2FGKbl9dTVH1LjuhfqHJ5PT1cv3n+fBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072215; c=relaxed/simple;
	bh=K6apShv7PuQKFOIrpPMfbl4d2lt0kR7K+12Y5UKG6qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REeMw/MauvOgQwJGDutcpEnsGjkX37BN1lg3OTA5iuTkx5k3WhQIHRAm9ma/a+BiAQBqhZ4h6+pAKJZ08SEKknGSFJdIJUs2PPH8Y5H1EJ61bBg4+qzQDYZJjFofHWz6thOQfoBaApRwDj1Fi2GZ9evTqkL2QxxYXbV8Im/K5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1FL8saa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1FL8saa"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2006070a91.2
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785072212; x=1785677012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ub9TpKLVdjjDPLO1Dd4PitaZbC716xWHBJENyYX1p2U=;
        b=E1FL8saaZDZV3NdoYVxZ7eYjlJJ7tUeu29QMRsWmHmYvqc7zAAZdUfaFxu1Uwd7VHt
         QtNHpJkpb9Ll5ia8XD64A1qHsuoqTzMTs+s4C/sExL2h2lj6dHtg1JjqXm7BnplCMb52
         SkYfN4yrYy+7Njoaf8smoCbwGYCio1pEMTyOb1mSpJuyhUrhFEyyIQY/cmmWQtLwJkss
         ViP1PU38Fu3P5x+1BBvsvGQNnPcZf48fm2S8fdOibnoo0BqVneofHTIjK9Fx+0ayE9Nd
         AeS0tDSxiauy2VdB52PhYhwRys1gwporDZx4GIBkD//gGhyigyftLkgxmTGRpXkprxuc
         JXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785072212; x=1785677012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ub9TpKLVdjjDPLO1Dd4PitaZbC716xWHBJENyYX1p2U=;
        b=cgef0NJAZ+Pgq/Y4XDIgEiDSbDNU2qc0MhI1jze3r8zPPLd/BSlKMF4WqeuAFbsh2A
         Yd9wq39tl3g16BJHUyGjSnYqbosGw6p7LwiGSiamJwTyy6PshPUJkPb3oMOLso2LHZFf
         MEkMMV4a4pSPOe1489kR47b9kCun8RCeYPRcpCkYA/vSSBTIp/Ho4ss1AUsicTNXjFKm
         vYd//UKduay9S5RVj+mnJa3IIbX0+zo00XNgFPi/oIbJe4FibHJw4Xm6YLIVub/lKz2x
         7CaXJnxuZMt46Qf0tuWXEjek+5DtNyW09oaUEnz+DV0wHKPfFruL0RzqCzqyPecaUZ+6
         VkhA==
X-Gm-Message-State: AOJu0Yzaf5FU3ZRFDwh8BGJ7c+MxnU0Ue2sdf357oVybEpZVxnn6+MSd
	+bRiONdSepFLwiirjXO8AMwy1UkgyO9GGe+SF5Jj7VTjTcYy1llZ0vzr6cXENmBQ
X-Gm-Gg: AR+sD10eYnoom0MaSiN1wiv+PLFxGlGVwQglPPKoRDH4N6ia5f/oHi50DkrLWSCHehy
	6TDX560wCmBdXsdEOG718qX3xbAf2Hd3/BdCL3dWMtuuynmxYR0O6F8EUs0iKb6c8puuwBwhyRv
	1rOCc0rqrU3dkNz5VLEUmaEy7fGodT0UlHmfpMW4yLDCOrfaq3+JQJ244cMVpix5StPsuikh7xo
	PYg/36uHZqE2tkKC1zFWt6DT+hGysxDyfgSqrsx3bRy0PSifDBFurMCxNpeZsA3imJQrUa6Lscv
	gXmxkcHoobI4fliuZgeBmQdaL8telNVoSGIi+fh+ZtdL27JcFpZQWxr3W8CNcr7kk/jCFPZBTVF
	2XvxvbQsgkiQ1yZFSk8PnRb1Q12iwlst04YWlBxXpIJAgYEkDEqbtgxBpmJO9Za6+MmUCDcf50M
	iM44oL4y/g1ifAwQ==
X-Received: by 2002:a17:90b:3cc3:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-38f2950c7dfmr4915863a91.11.1785072211599;
        Sun, 26 Jul 2026 06:23:31 -0700 (PDT)
Received: from Linux.bbrouter ([115.96.217.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419e3asm20784436eec.11.2026.07.26.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:23:30 -0700 (PDT)
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	nikhilsolanke5@gmail.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] usbcore: Add quirk for 255-bytes initial config read
Date: Sun, 26 Jul 2026 18:50:38 +0530
Message-Id: <20260726132039.28330-2-ishaan.dandekar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
References: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Solanke <nikhilsolanke5@gmail.com>

Certain third-party USB game controllers exposing (or spoofing) an Xbox
360-compatible interface (VID:PID 045e:028e) fail to enumerate under Linux.
The device disconnects from the bus without responding to the initial
GET_DESCRIPTOR(CONFIGURATION) request, and the kernel logs 'unable to read
config index 0 descriptor/start: -71'.

The device then falls back to a secondary Android HID mode (with a
different VID:PID), losing XInput functionality including rumble support.
The failure reproduces across multiple machines, host controller types, and
kernel versions including current mainline and LTS. The device enumerates
correctly and remains in XInput mode under Windows. Notably, the device
enumerates correctly in Android mode when the same 9-byte request
is issued for that mode's configuration descriptor, confirming the firmware
bug is specific to the XInput mode.

usbmon traces from Linux and Wireshark/USBPcap traces from Windows are
identical up to the point of failure, with no visible protocol-level
difference explaining the divergence. The root cause was identified when
Michal Pecio discovered via a QEMU bus-level capture that Windows does not
use wLength=9 for the initial config descriptor request; it uses
wLength=255. Alan Stern subsequently confirmed this with a bus
analyzer on a different USB 2.0 device, and Michal verified the behavior
goes back to Windows 95 OSR2.1.

So, add a new quirk flag USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
usb_get_configuration() to issue a 255 byte sized configuration request
instead of USB_DT_CONFIG_SIZE (9) for the initial
GET_DESCRIPTOR(CONFIGURATION) request, mimicking long-standing Windows
behavior.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/usb/core/config.c                     | 39 +++++++++++++++----
 drivers/usb/core/quirks.c                     |  4 ++
 include/linux/usb/quirks.h                    |  3 ++
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8..14121458a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8169,6 +8169,16 @@ Kernel parameters
 				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
 					claims zero configurations,
 					forcing to 1);
+				r = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE (Device
+					fails during initialization when asked for
+					9-bytes configuration descriptor request.
+					Ask for 255-bytes request instead to mirror
+					Windows' behavior. This quirk is originally
+					meant to fix some quirky gamepads that refuse
+					to connect in their XInput mode. But it can
+					also potentially fix issues with other USB
+					devices that work on Windows but not on
+					Linux);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 45e20c6d7..442c15f92 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -912,6 +912,17 @@ int usb_get_configuration(struct usb_device *dev)
 	unsigned char *bigbuffer;
 	struct usb_config_descriptor *desc;
 	int result;
+	size_t usb_config_req_size;
+
+	/*
+	 * Devices with quirky firmware will stall or reset when the initial
+	 * config descriptor request uses wLength=9. If the quirk is set, use
+	 * 255 instead, mirroring the behavior of Windows.
+	 */
+	if (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
+		usb_config_req_size = 255;
+	else
+		usb_config_req_size = USB_DT_CONFIG_SIZE;
 
 	if (ncfg > USB_MAXCONFIG) {
 		dev_notice(ddev, "too many configurations: %d, "
@@ -938,15 +949,19 @@ int usb_get_configuration(struct usb_device *dev)
 	if (!dev->rawdescriptors)
 		return -ENOMEM;
 
-	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
+	desc = kmalloc(usb_config_req_size, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
 	for (cfgno = 0; cfgno < ncfg; cfgno++) {
-		/* We grab just the first descriptor so we know how long
-		 * the whole configuration is */
+		/*
+		 * Normally we request only the configuration descriptor header
+		 * so we can determine the total configuration length. For
+		 * devices with USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE set, try to
+		 * grab the full descriptor set instead.
+		 */
 		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
-		    desc, USB_DT_CONFIG_SIZE);
+		    desc, usb_config_req_size);
 		if (result < 0) {
 			dev_err(ddev, "unable to read config index %d "
 			    "descriptor/%s: %d\n", cfgno, "start", result);
@@ -956,9 +971,8 @@ int usb_get_configuration(struct usb_device *dev)
 			dev->descriptor.bNumConfigurations = cfgno;
 			break;
 		} else if (result < 4) {
-			dev_err(ddev, "config index %d descriptor too short "
-			    "(expected %i, got %i)\n", cfgno,
-			    USB_DT_CONFIG_SIZE, result);
+			dev_err(ddev, "config index %d descriptor too short (asked for %zu, got %i, need at least %i)\n",
+			    cfgno, usb_config_req_size, result, 4);
 			result = -EINVAL;
 			goto err;
 		}
@@ -972,6 +986,16 @@ int usb_get_configuration(struct usb_device *dev)
 			goto err;
 		}
 
+		/*
+		 * If the device returns the full configuration descriptor set,
+		 * skip the second read. Otherwise, send a second request
+		 * asking for the full set.
+		 */
+		if (result >= length) {
+			memcpy(bigbuffer, desc, length);
+			goto store_and_parse;
+		}
+
 		if (dev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(200);
 
@@ -989,6 +1013,7 @@ int usb_get_configuration(struct usb_device *dev)
 			length = result;
 		}
 
+store_and_parse:
 		dev->rawdescriptors[cfgno] = bigbuffer;
 
 		result = usb_parse_configuration(dev, cfgno,
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 87ee2d938..f5a60ccf2 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -142,6 +142,10 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 				break;
 			case 'q':
 				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
+				break;
+			case 'r':
+				flags |= USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index b3cc7beab..a4043b33c 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -81,4 +81,7 @@
 /* Device claims zero configurations, forcing to 1 */
 #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
 
+/* Use a 255 bytes config descriptor request mirroring windows behavior */
+#define USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE	BIT(19)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.34.1

