Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEF47B410
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236263; cv=none; b=dAVC0c5z8uc1AvCFb4pinnsGfhZPxxFaMoU67PY46VvSgBH0Kjqu3/3gnPaY2+SNxumhvJZCPhbqO6lbrTONb0YeTx7wLGs2IC9kVTU4SJJuy4VDVRU1CpaCaB352hT6Dv7p+RE1si6F9M1WHfdnxsuGUBSa6GNSEfiyDA5oYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236263; c=relaxed/simple;
	bh=eGkRrkmCJtnCk/bFLLTyry3WFhETRAcalD+Y6Caor/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VreYFH7AtmNH4R3sxBokziuvBHKEMWm4lCeFQq4s2g2NXMAWGsfgCdtHqokes03JO0zvU3NejNrRk1BXIrbUTgZyJeJIFX/VnPZ6eMzem8A7zxezY+2VHlGhbZ1VE5UjSOxMEcdXa1MGfpAztn0l0k66wHr7FLeWFrpEE+8glKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVNwtG6X; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVNwtG6X"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a917a4feso43663406d6.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236260; x=1772841060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uoTaHRHQOOyyAXgJyEhLyvh97GNJstHquvGuNdc7XI=;
        b=GVNwtG6XJTyLJThPIory/UEk/nAGhjXoEfF0Lu7J+mfQpZnWhKwSeydki2gy/5sq08
         ykr008ZvfP31pgdj8gmy5kxXhMFwLqN7pv1QKGQLHZNrqc56oDHebVGIayI9dZ+PApMF
         kQ/WHykqbrhD5gyAdCYa2RBoPZWxeqCvVpM/9wVz6lvwe9fA+XgSO2PuLLqOlwhZM3H+
         /6XAi4ZwcHsnlmHFMv9/Ulzahe3DOANLAi7WqYkcd+YZ3GXIxTMoAluFVKt1S4k2qJ4C
         zaEp+RIPeSQnQ+6Tf0LrDMSjCBmvdSKCOXL74kpMOoItVJMcWQ3+JljY0lYd0KbBbJ/Z
         SuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236260; x=1772841060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uoTaHRHQOOyyAXgJyEhLyvh97GNJstHquvGuNdc7XI=;
        b=OTNHcybLZRIeGkOxImv4dkABfj1Mo0J9VniAKxb6Ao78P4pWVkWtSxCxLnpmbxHf7h
         Phv0g5/CEkmGX98k79PJoAylNMg0ytqBR84tVvktT6agE5iPhl7wOcWMUWHzfg1cAtSQ
         doniJydijGuwK8Lg5sRATO8yfgDE8ZwZEQYRbCoO3uE6GwOkJ3mgGydVs1KOK6Rw8vpZ
         Tvi3tlG4qgWAmKaAma46Ze9U5T2x77707SPXdctdv1Z6ghbnPPbtodU0SnGpjp2MMiHw
         Krk1IQDlUOK1GC1uHxgH1Oacfsol/0kbzzmhnLU6S4C9MDZhaJlueljBri2uBjAmaqKc
         R0jA==
X-Gm-Message-State: AOJu0YzKvn/N0ItiTXNH0+qmlUmRCRmnKZPSnGO2809/UTBalolAS0YI
	KJd+zhZHvEAiT3UV7V+DKbkTRaTwij0/ZxbjlzGTP8huu1qTrTa0Shpt
X-Gm-Gg: ATEYQzyX66XiaAYO4zf0ucLeDfy4doYM57So91gEJq6guBiVD53Sr423L28DF9p4wyC
	OvEdSMNaP7yzvRmiNE9D75GQy9smInAh3NjWzegtHLbCCLxeEtJGKwCXlv44oqdzNQyAJ74gCX+
	2kUKSk53poK+xnOk0IXsue20F4G3WMg3ReQICCeaGdrT5P7FsmVpjtKMuHEptcBG8DO6F/8REfH
	PAtII6ahh6pVlhj8IMqFGezAQyUlGr+XZYxlZBSxbLgJ/bgtOVinw8OfqZtC8ut+4obzXcCOx5q
	ThdfoMxZ0YciGkJqZJIDeAVPMRjDIm7tf9k9HXJZK8DtRji6WB/zG12HLEzrSlpSAzbDbAJB9aD
	90Z7uWEc58ISa+IZqkZjQsgx//BErPrvcdf/86Z+E/PP2RUv0Y6lrvLIpvjyHE9POwk/N+HLZNu
	En+HX8xvbciHdmiW6gxRZnkAFZuEMHn7cEAAAJnZ0LbBSQBJW9wA==
X-Received: by 2002:a05:6214:da6:b0:894:6ff2:191c with SMTP id 6a1803df08f44-899d1e2b732mr71580246d6.33.1772236260060;
        Fri, 27 Feb 2026 15:51:00 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:59 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 18/18] HID: steelseries: Document sysfs ABI
Date: Fri, 27 Feb 2026 18:50:42 -0500
Message-ID: <20260227235042.410062-19-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation/ABI/testing/sysfs-driver-hid-steelseries documenting
the sysfs attributes and LED class device exposed by the driver:

- bt_enabled, bt_device_connected: read-only Bluetooth radio state
- inactive_time: read/write auto-shutoff timer in minutes
- bt_auto_enable: read/write Bluetooth radio power-on behavior
- <dev>::micmute/brightness: mic mute LED brightness via LED class

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 .../ABI/testing/sysfs-driver-hid-steelseries  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-steelseries

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-steelseries b/Documentation/ABI/testing/sysfs-driver-hid-steelseries
new file mode 100644
index 000000000000..7b8d29282ed6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-steelseries
@@ -0,0 +1,87 @@
+What:		/sys/bus/hid/drivers/steelseries/<dev>/bt_enabled
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Sriman Achanta <srimanachanta@gmail.com>
+Description:	(RO) Whether the Bluetooth radio on the headset is currently
+		enabled.
+
+		* 0 = Bluetooth radio off
+		* 1 = Bluetooth radio on
+
+		Returns -ENODEV if the headset is not connected to the
+		receiver.
+
+		Supported on: Arctis Nova 7 Gen2, Arctis Nova Pro Wireless
+
+What:		/sys/bus/hid/drivers/steelseries/<dev>/bt_device_connected
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Sriman Achanta <srimanachanta@gmail.com>
+Description:	(RO) Whether a Bluetooth device is currently connected to
+		the headset.
+
+		* 0 = no Bluetooth device connected
+		* 1 = Bluetooth device connected
+
+		Returns -ENODEV if the headset is not connected to the
+		receiver.
+
+		Supported on: Arctis Nova 7 Gen2, Arctis Nova Pro Wireless
+
+What:		/sys/bus/hid/drivers/steelseries/<dev>/inactive_time
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Sriman Achanta <srimanachanta@gmail.com>
+Description:	(RW) Auto-shutoff timer for the headset, in minutes. A
+		value of 0 disables the timer. The maximum accepted value
+		is device-specific.
+
+		The encoding sent to the firmware varies by device family:
+		the Arctis 9 converts the value to seconds, the Nova 3P
+		rounds down to its nearest supported discrete step, and the
+		Nova Pro maps to six firmware-defined level indices. For all
+		other devices the value is sent in minutes directly.
+
+		Reading the attribute returns the last value reported by the
+		firmware. Writing immediately sends the new timeout to the
+		device.
+
+		Returns -ENODEV if the headset is not connected to the
+		receiver.
+
+		Supported on: Arctis 1 Wireless, Arctis 7, Arctis 7+,
+		Arctis 9, Arctis Nova 3P, Arctis Nova 5, Arctis Nova 5X,
+		Arctis Nova 7, Arctis Nova 7P, Arctis Nova 7 Gen2,
+		Arctis Nova Pro Wireless
+
+What:		/sys/bus/hid/drivers/steelseries/<dev>/bt_auto_enable
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Sriman Achanta <srimanachanta@gmail.com>
+Description:	(RW) Whether the headset automatically enables its
+		Bluetooth radio on power-on.
+
+		* 0 = Bluetooth radio stays off at power-on
+		* 1 = Bluetooth radio activates automatically at power-on
+
+		Returns -ENODEV if the headset is not connected to the
+		receiver.
+
+		Supported on: Arctis Nova 7, Arctis Nova 7P,
+		Arctis Nova 7 Gen2
+
+What:		/sys/class/leds/<dev>::micmute/brightness
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Sriman Achanta <srimanachanta@gmail.com>
+Description:	(RW) Brightness of the microphone mute status LED.
+		<dev> is the HID device node name (e.g.
+		0003:1038:12AE.0001).
+
+		* 0 = off
+		* 1 = low
+		* 2 = medium
+		* 3 = high
+
+		Supported on: Arctis Nova 5, Arctis Nova 5X, Arctis Nova 7,
+		Arctis Nova 7P, Arctis Nova 7 Gen2
-- 
2.53.0

