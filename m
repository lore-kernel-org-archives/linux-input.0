Received: from trusted.vivawebhost.com (trusted.vivawebhost.com [173.237.185.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A161333439
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.237.185.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791668756; cv=none; b=g33Wscgz6Pu5BUIjcJjBR7Q422SiAeRorAB89efmXRnUU5Voz3SaBM+PqIOxyt00Krb425v0BYFx2AVKVmtdpgTTJ/kHDDM+jA0gg3K+3PfVrkvmWE5eYmked9U0L31EOSyCfQ7rA4LumVx/n3d6GNEfWzWOijKZT5icYCelV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791668756; c=relaxed/simple;
	bh=b/ljbLD+rLZOPyqR/oLYEdRFZOXMionQt2RzSPSxkqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKZKTyDr7k4ZdpmMTLon/UZLvxGXTdRcWZWmFgPucMkqlx0Ya6YDjSNxaJ1qqe2jDqkZkjqoW+vlNfF0HYbYn5gdY/VnuAE5mzcNhznf86aKQHSfP5ina4vhyIs4qMu4XYM5vFrgOzhuf3ExjGFKH81kmNrhCbSmufy4Bh99N2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=impsoftware.org; spf=pass smtp.mailfrom=impsoftware.org; dkim=pass (2048-bit key) header.d=impsoftware.org header.i=@impsoftware.org header.b=Xldkf3Ns; arc=none smtp.client-ip=173.237.185.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=impsoftware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impsoftware.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impsoftware.org header.i=@impsoftware.org header.b="Xldkf3Ns"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=impsoftware.org; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i2C0joQ4p9Cf3kmO55vnbXtTKjkLVIABzn/KM2Z0/Ys=; b=Xldkf3NsD558J7P8d0+zmu1dQo
	poZ0QGdR052qHtzFZgijIzsNxPPvnjLYGwp4iN5CzIWYxt3QAc3tQfI9ccjOfv7qeIeoefTjhriE4
	zhkOWTnqfB/2oeuIY1RaOCO0l9y1C/3bEeD35WOJwMjagTQMho5JfFRwUt5zs+e1S2xb+FeAYXuIh
	S9B6aj5boT1HRvk5TB2r/bo8hMBwvAVtD2tW4ge30upAwClifoN3DLObhh7w4e1bd1zMQwiXhFHCN
	Vp5ZzSGXFlVhn3NWdE8auE0SUCGi6CMMkIQvw3oLOSVIOeBkLirt3UduFRaIcUj244rzYjOZitN1x
	bvHf1vQg==;
Received: from [199.204.200.132] (port=28178 helo=peniomen)
	by trusted.vivawebhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <matt@impsoftware.org>)
	id 1xFeSP-00000000hrD-3xYu;
	Sat, 10 Oct 2026 17:18:18 -0400
From: Matt Ervin <matt@impsoftware.org>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH] HID: i2c-hid: reset Synaptics SYNA32A4 on resume
Date: Sat, 10 Oct 2026 14:17:43 -0700
Message-ID: <20261010211743.175600-1-matt@impsoftware.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - trusted.vivawebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - impsoftware.org
X-Get-Message-Sender-Via: trusted.vivawebhost.com: authenticated_id: matt.office@impsoftware.org
X-Authenticated-Sender: trusted.vivawebhost.com: matt.office@impsoftware.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On the HP OMEN Laptop 15-ek0xxx (board 878B), the Synaptics SYNA32A4
touchpad (06CB:CE17, hid-multitouch via i2c_hid_acpi) is quiet before
suspend but starts asserting its interrupt continuously within a few
seconds of resuming, at a steady ~590 interrupts/s, while producing no
input events. The storm does not stop on its own; it persists until the
device is reset.

The pad sits behind i2c_designware.1, which shares its IRQ with idma64
and snd_hda_intel, so each spurious report also costs ~58 interrupts on
the shared line:

  irq17 (i2c_designware.1): 33968/s   irq63 (SYNA32A4:00): 588/s
  irq17 (i2c_designware.1): 34116/s   irq63 (SYNA32A4:00): 588/s

That keeps CPU0 at ~40% hardirq and denies it deep C-states, measured
as 3.5x less C3 residency than a sibling core. Unbinding and rebinding
the i2c_hid_acpi driver, which resets the device, takes both rates to
zero and the touchpad keeps working normally afterwards.

This is the same failure mode that I2C_HID_QUIRK_RESET_ON_RESUME was
added for in commit 538f67407e2c ("HID: i2c-hid: reset Synaptics
SYNA2393 on resume"): spurious interrupts after resume until the device
is reset. Add the SYNA32A4 to the quirk table so it is reset on resume.

Tested on a 7.2.8 kernel with this change applied to the i2c-hid module:
with the stock module a suspend/resume cycle brought the touchpad IRQ to
585/s within ten seconds of resume; with the quirk, two consecutive
suspend/resume cycles stayed at 0/s and the touchpad kept working.

Signed-off-by: Matt Ervin <matt@impsoftware.org>
---
 drivers/hid/hid-ids.h              | 1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a9537b7..10e694f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1444,6 +1444,7 @@
 
 #define I2C_VENDOR_ID_SYNAPTICS     0x06cb
 #define I2C_PRODUCT_ID_SYNAPTICS_SYNA2393   0x7a13
+#define I2C_PRODUCT_ID_SYNAPTICS_SYNA32A4   0xce17
 
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a8a9854..8ab7677 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -134,6 +134,8 @@ static const struct i2c_hid_quirks {
 		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA2393,
 		 I2C_HID_QUIRK_RESET_ON_RESUME },
+	{ I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA32A4,
+		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ I2C_VENDOR_ID_CIRQUE, I2C_PRODUCT_ID_CIRQUE_1063,

base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
-- 
2.56.0

