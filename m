Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896528;
	b=jirGdq/QGtjROFokCE+/cMihuPvEKWPxfj3bkNqR2P6HtQy4wmvBUzSFi+q9/pt9eYA6
	 QOAEY47RodbeoSvsScBlg74ZbIzbLDxCr5e5ZzlPeRniG3d+IrEl1i8h89wBPXnCVDn6Q
	 JxGmbkSvUn7HNPNURG4YnZWYVIVa0qKZFNgtva5qGNHjLI29CmD0kZt6qQFYgF59voXCT
	 RvFP35K5xPJob1+1tb92EAFAzRUFTJDU1PrK3RU8bIzEsdMfqxd20XFnJnpHbOz7M6PXD
	 LXrOMIIGEyblAWIWXoCuPeqFxOCIf8OI5TGw7K2zenHm2KdQYg+S5qYUhqG31wMT8wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=zUKQcLBNuUzfdigPpCeMKgQJglhu7H0OTyY8O85pHlA=;
	b=Y0QlBwZjnx47AFWnb6sYZyVU9KMedlui5ZNJV8JTSysDJeFgmnq1rtf0mnq0dVEPVCE9
	 jDfi0l78SPd963THHz9mTfRygFxX501OdTx8qYwa9VA1BO/lFrqilmDFqSdjWThc6O7Vb
	 uPYJdBfTHJOkE7rHGqOp36gunTXpgJJ6l7+ctMm+4Aws3rgg2OyhSLj67c4LmkJFdxVKU
	 6dXDkb6t+b+/wr1iQOlHW0D93pagjwkfoaVDzDj6tiBhiKT1t9z3lbQR5UYAQURhFBfHd
	 8jozO4V1clNoGMJpVsZXNWtbAKDTx4R1DGPltpN/JoXTR1NuDz8NqbtMR378QK8L7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BnZdFL02;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB3606A31E
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EBB3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BnZdFL02
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-156cbe59622so1277105c88.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896527; x=1793501327; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zUKQcLBNuUzfdigPpCeMKgQJglhu7H0OTyY8O85pHlA=;
        b=BnZdFL02ObgqDdlRhZQVGeDOr1hl5bQP9RSCGMuwGhcWXvjsvfQYDrj4Wf5qsZVtKh
         JQnQODsdbE3HCc9RLQwb8IeYH5EU0Tb8v8PDXsVtXh9DbxKkEd8/NP1ZJNfsT+F/SUij
         ugaMNlo5N9Kwqhfz/8O4RQNlBNNk2Dg7f1KyRuS62mV46ZHB5WNFwNBR3GYD3/DLzRue
         tct6QOYLVfYERH51QLZAZTmGuZwrbIAzMjtSOqKuzdZtKGEjXUNP7xQC7v2cvVYDV6u2
         6aVciLAG/ooH6QwJDJqHo2G04nyKzPj69t99i3U0TjdkfAmpXc5aaRGwrGjQdkz+7XrU
         OQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896527; x=1793501327;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zUKQcLBNuUzfdigPpCeMKgQJglhu7H0OTyY8O85pHlA=;
        b=xRFf1xM6NYvhNjw9j2DhMlHQlHeBTaTf7d9Y4g/+OK6yfM0e2CeJZ/6ZU8Dx/RfWtY
         JWub4Y1NUdx9D/rSVpcDC25JDHCUN0QUJ8oeyzy/jUSLiSJjLMeKgUwd+Vry6fk0y+bb
         nSQUmJpJDELZbo0mHOmqlUKBQa/+QWQ7xVVe+49dp0bIDkfe6O7HXfXByUnse7Bc/DD6
         gN013JJ9wXAeMeuq1rCi7qdjiQm0L560UmVRxSPN1VBj7Jn8ns/0AzQKv/hr/ADzUu+q
         CqmDue//MnbjtDpDNmDqMZNduFpQyIiUzU3XW6TSsZibr071bDrBhNgBn88x9XlXYy3e
         8mxA==
X-Forwarded-Encrypted: i=1; AKwUvBx8sHiDoUv1yB/PpQZQ8mF70ukTrXPQ06fKaLAiXGktu4sFU0EqBhHq/1byM/XLdrh1RpAXogJiHFfEFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLrLOE0Au/sUhYdpMX3XFtlTHN3ah1ETPcALIZs6iv2LvDx3HRP
	poq72PuGyoR2G2pn2+5ZS1xpxq+58ECEHLXcFg1BCVyKijhxjKJmiDFC
X-Gm-Gg: AYBFou13Fb7lv84hm+gthGymeFLpZ1Tu2dDB5wY5l22q3zFC8UFCzHTV9bKElFyGfDS
	mpy8gBLvL/1f3zk1EzcbvwsHA58xts+o9B7WvulOvf9DuLuVuZUVwJwWGa6BJt9nhaR6w03z17O
	L6x7jj/K5Cj5Z6yPCKeStJtShKxO6oV8sEu8SKbod5TJBpuJX/lCpfHQBHkHuf4GPswKX8P41TL
	iKDTII0QF37whXP2Th1yyMAguL+1SC+faeLRggZpJF4+IpUjlwDu/ssN1u3xXTcZpnvK3r/DzEw
	G40AYPEpjIA5e9E+TqqCADvEDDj7svb7ZA3SAvlvThWWG2mDtCKcqni5e8RXn3CgA697sZQP4+h
	HyTrKTDF45m9fIvzng6a24IPxukkoIz2rlWzr5A7ZBJyV7m897PZgAtGiwfyz2RLo1mfftvVilp
	hmJ7HSxBTSblfPiOF8nArCH/prPJG4MqF9g4ZFnIxI5hhjoC9zSmlo/vZ6USXtuFLv5Yyt3YfE2
	LnN6D1Ke0b47PbGncggktPX/+vZ/QVsnLe0xtswZ7xVP0hCokmSSsODbdLslVA5qapkm1s6yO/V
	Ek/EUJOjX9DDxvZalJcmueaHKMb38a6+ExLl4bPpylU=
X-Received: by 2002:a05:701b:2414:b0:14c:d84c:7182 with SMTP id a92af1059eb24-199356256c7mr3987099c88.22.1792896526990;
        Sat, 24 Oct 2026 19:48:46 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:46 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/8] i2c: convert i2c_smbus_read_block_data() users to pass
 buffer length
Date: Sat, 24 Oct 2026 19:48:40 -0700
Message-Id: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhu3WoC/yXMTQ6CQAxA4auQrm0yFDDqVQyL6UzB+gNkCsSEc
 HdHXX6L9zYwSSoGl2KDJKuajkNGeSgg3PzQC2rMBnJ0LB0RKgW0Fy+GSXxEfo7hgdHPHtnVVdM
 4Pp3rCnI/Jen0/Xtf279t4buE+TuEff8AdQ4tLn0AAAA=
X-Change-ID: 20261022-i2c-smbus-read-block-data-b043550b8943
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Convert callers of i2c_smbus_read_block_data() across input, ACPI,
IPMI, platform, and power supply drivers to pass destination buffer
sizes, adopting the 4-argument form introduced in commit 68f382641f8c
("i2c: smbus: make i2c_smbus_read_block_data() safer").

Because the prerequisite commit 68f382641f8c is in mainline now,
subsystem maintainers are encouraged to pick up their respective
patches directly into their trees.

The hwmon subsystem conversions will be sent out in a separate series.

In cyapa_gen3 and rmi_smbus, passing the requested chunk size bounds
the transfer and avoids potential out-of-bounds writes when reading
blocks smaller than the SMBus maximum of 32 bytes.

In vexia_atla10_ec, the redundant intermediate bounce buffer and
memcpy() are removed so the response is read directly into the caller
buffer.

Additional conversions update callers in ipmi_ssif, i2c-core-acpi,
elan_i2c_smbus, and sbs-battery to provide explicit buffer lengths,
and update the prototype in Documentation/i2c/writing-clients.rst.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (8):
      i2c: acpi: use 4-argument i2c_smbus_read_block_data()
      i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
      Input: cyapa - use 4-argument i2c_smbus_read_block_data()
      Input: elan_i2c - use 4-argument i2c_smbus_read_block_data()
      Input: synaptics-rmi4 - use 4-argument i2c_smbus_read_block_data()
      ipmi: ssif: use 4-argument i2c_smbus_read_block_data()
      platform/x86: x86-android-tablets: use 4-argument i2c_smbus_read_block_data()
      power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()

 Documentation/i2c/writing-clients.rst              |  2 +-
 drivers/char/ipmi/ipmi_ssif.c                      | 39 ++++++++++++----------
 drivers/i2c/i2c-core-acpi.c                        |  2 +-
 drivers/input/mouse/cyapa_gen3.c                   |  8 +++--
 drivers/input/mouse/elan_i2c_smbus.c               | 36 ++++++++++++--------
 drivers/input/rmi4/rmi_smbus.c                     |  4 +--
 .../x86/x86-android-tablets/vexia_atla10_ec.c      |  4 +--
 drivers/power/supply/sbs-battery.c                 |  8 +++--
 8 files changed, 60 insertions(+), 43 deletions(-)
---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261022-i2c-smbus-read-block-data-b043550b8943

Thanks.

-- 
Dmitry

