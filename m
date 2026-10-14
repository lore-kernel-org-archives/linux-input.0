Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70843374E5B
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991522; cv=none; b=B/X459885ilWRbDu9IgurN2P7wXe4EHnPwh6oQFzmbPXSdwIjkknMErz44bvvOttdQDytj9rWQ6nWqE68r4jIVj1Zlm0p9vewH+n2wBqyIV9JL1p908CZd/ipA+ACOm5kh5JSWVCOLaStPn6xz++jmkNDvuuxGxupsBy7VW4E/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991522; c=relaxed/simple;
	bh=4xtlwMXyWzq87oKXlTSUTSJUcCXtxizVzZJcF/3R7OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfKEBL8Sai1ld1NIMopiOXJfn7n1KqRVp8OZT4lNSmwRclquGtJymtwbeEM7VWuVlOxKuzKaNObV9Ufh3jgYPOFezm8R+rqn/PyLb2WmninYPr2tPAPiwejGhQQJChGggo2p+XIGUOCFlPF9o0FaCCXEu7MdrZgzjaXKmzt4UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvV3QGR4; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvV3QGR4"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c0466d653fso183128137.3
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791991520; x=1792596320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZlacUVzzy4HBA3NrxiUhpJFwP6Wb2PV4OZMdQ09R7I=;
        b=OvV3QGR4FZThAftPriNMh0Z49gdzBDi90bON/J2qGK4x6casf1MCH7iu0i1QXdMSA8
         BFyJfzLwcxt3JPev9LG1y+5VFqIIjSghbVMKzuB5xyqs4/68DP4kv6fVzv83zMymDsRX
         1qrn+koBA5ex4K3dDF0QYhHc56uAqHiRM6OIDLgzhtp1jpswVE9dKA5VU43IH4PR4PxM
         G3t9zI2cftnG/bVhkAMewxJOTecsfyxbw+/gLlhrTs/IEh+CI69jHmYi+lNLiJtZg/+m
         4J3ogY8xF8roffMtybaOz/QyRuHixaK1iSrl7cPnIt/uMsOcnuoy/Z+UdshEdh0pdDjY
         Z9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991520; x=1792596320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZlacUVzzy4HBA3NrxiUhpJFwP6Wb2PV4OZMdQ09R7I=;
        b=1qjVzF6KsKHzq5ZjIUvNqYcY9HsotFgmWmqYYpMtJKDYapuJDfj+JghhDfYW7x+Vm3
         BTkMBPdRWnt68SGoyCkBv0lhLvnsk7dW+uc7mYvXvG6RGM7IufkFikkuPxcxMKkM4aMf
         QgzChxymfw0XJ4jYbH+Z0I5f484dalJ2uALOmVNOd8WBQVE5NCtCa7iulQCC/XZbHWVm
         +4IVh6fZSxJcTeQ8e0K0oCay3PDFulFSbgyjSTDcBZgZdpJjtIvdY7+hXh1lMROreAx2
         fji5eRX79L4tbxxzC2gL2N8VXRgf2GNFz2/pkxjPAKigY9bp0GIbkX5oARu6tk0zQqJO
         3OOQ==
X-Gm-Message-State: AFq9FYLH1O3PgHhHEtuS0OuUjR6vZ/Fm6O1E5HlpD5TwSszUsnwERw7q
	zZ8qr7JqVeKHi1li4Q420s0sLCElprxPSScmHDZSC3CegDcPNbieOwAqaqT+SRAEcbqVNg==
X-Gm-Gg: AYBFou2oy7e6BpJeYAvNE7GmHgF6GRtPdF8A8xhJSETwLpuaUn7DDqDOrHUC9GvwJL/
	/h+k5K2JQBtupavbBvvLB5kcqbPx/4ViSh8ViVzMUib/lU/DiWwa2KA7WmtOfHz/XbhbqaVtjyq
	n7ABy+EURIwS+WYwAHntti4E9Sx8CgQiBnJRThgLqsYpxIVk2xY5lkXNuWq/20l9H2J7MrSksQZ
	RuS3J2BSxxclBV/SxV6WoANLL5loc/9H7OwzqetgiyejsrwKcTVWzVNLY9eldIBsMDkKu4xsfpS
	+k4fmpJZzs0Kmgn8rSBz1ViTXixAs9pp3tHLspxjwrKWTUkNyMPV4sNzXuh1shNoONl04zNJX4c
	Rj+cy9bZyj7w92PJ7DEXVBl3aNR/Y8dOHsLEwOu6ZS+hQA94+3yMXy+qi2+rzteaxWoRI7rMPzQ
	Nup10N1zVJm8GG8s4U0rWgxY2OW2aS2Uwb/FLJvg3Dw0nJigTeNw/574v6qDHHkxlnGg/TM2jgD
	/Q7fIxS0J+CX3rnmApisbZfUzbBmBCWOTI0Zz7sU6uy1YPzg+WPn4XNpQ6Xoq4sNUkzyFTqSwnn
	ucf6hCvDN2sGaOLwbkqBLn/eKm77hQrgzQVBaeSkEt7fV46g
X-Received: by 2002:a05:6102:4193:b0:7a7:12b0:fd03 with SMTP id ada2fe7eead31-7cb50ad7b90mr3825371137.0.1791991519989;
        Wed, 14 Oct 2026 08:25:19 -0700 (PDT)
Received: from debian-t14-gen1-fuhrysteve.ts.fuhry.app (235.sub-75-230-129.myvzw.com. [75.230.129.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b5e5b1sm54887516d6.18.2026.10.14.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:25:19 -0700 (PDT)
From: "Stephen J. Fuhry" <fuhrysteve@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Stephen J. Fuhry" <fuhrysteve@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: input: ignore the battery of Keychron keyboards over Bluetooth
Date: Wed, 14 Oct 2026 11:25:05 -0400
Message-ID: <20261014152505.2523337-1-fuhrysteve@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keychron keyboards identify as Apple's wired aluminium keyboard, rev B
ANSI (05ac:024f), when connected over Bluetooth. hid-apple has bound
that ID over Bluetooth since commit ebe0b42a4252 ("HID: apple: Add
support for Keychron K1 wireless keyboard"). The Keychron K8 tested
here does the same, whichever position its Mac/Windows switch is in.

The report descriptor declares a battery, so hid-input creates a
power_supply node for it. The keyboard never answers the battery
feature report. Every read of the node blocks for the full 5 second
uhid timeout and then returns -ENODATA:

  $ time cat .../power_supply/hid-<addr>-battery/capacity
  cat: ...: No data available
  real    0m5.10s

Anything that enumerates devices pays this on every pass. With the
keyboard connected, "udevadm info --export-db" took 10 to 26 seconds;
with it disconnected, 0.11 seconds. KDE's Solid library enumerates
devices on the GUI thread, so Dolphin and the Plasma panel froze for the
same 10 to 26 seconds. upower already gives up on the device and does
not list it.

0x024f is a wired-only Apple product, so a Bluetooth device using it is
not a genuine Apple keyboard. Ignore its battery so the node is never
created. AVOID_QUERY would stop the blocking read, but the K8 does not
send the battery in its input reports either. The node would then stay
at its initial capacity of 0 with status Unknown, which looks like an
empty battery.

Cc: stable@vger.kernel.org
Signed-off-by: Stephen J. Fuhry <fuhrysteve@gmail.com>
---
Tested on 7.2.6 (Debian trixie-backports base) on a ThinkPad T14
Gen 3 with a Keychron K8 paired over Bluetooth: no battery node is
created and "udevadm info --export-db" takes 0.12 s with the keyboard
connected. The keyboard types normally and hid-apple still binds it.

I have only the K8 to test. If another Keychron model on this ID does
answer the battery report, this hides its battery level. I do not know
whether any does.

 drivers/hid/hid-input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index edd6bbf..380ff8a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -381,6 +381,15 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
+	/*
+	 * Keychron keyboards in Bluetooth mode reuse the product ID of
+	 * Apple's wired aluminium keyboard. They declare a battery but never
+	 * answer the battery feature report, so each read blocks for the full
+	 * uhid timeout and then fails with -ENODATA.
+	 */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_ALU_REVB_ANSI),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
 		USB_DEVICE_ID_SYMBOL_SCANNER_3),
 	  HID_BATTERY_QUIRK_IGNORE },
-- 
2.47.3

