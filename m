Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DD248F73
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691826; cv=none; b=HsikIx0FFh9YgwyJEf/3UaVBI0RAS1kP6yhbWQSk4jroJ22h/9Saovi0F+QrNVyr1CLr/tUgrhMFpZs4kLepqMZ9dZN5FUm3MHdgvj8Mh277YS3CoKnoTPaB+QuntKNiyyYF8eT9aXsteq/18vBN5bPceNXQRZL9K+ZLdR4PPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691826; c=relaxed/simple;
	bh=GWaK38Fyi2AkeyK4SkTRLhISNegMHvDrqqaUa18jmPk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p5ObcAIVCPZcx40jTlEjbBURy7HpKYooHg5gm7tDq4T0B+zAJEwezok89U35teN5Kv63Y7+t3UnTsnzSkKYZ6nbnWxhczN2Afg84awBNIPI6GMePTpWo3sW3s9MUJStErX6PG1iOCxOnoOvrRsd30Sm/Xm0tO43JkoM/bjfUXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC9Yu/bD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC9Yu/bD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f60208a5so4553385e9.3
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783691823; x=1784296623; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scyQmkb6R9mhvp0lHFXBIYm/E2nJa7IyjByj31lSlwk=;
        b=mC9Yu/bDh4kdWZ5pauYuK/3Zimn4urFMRlZpX/sKZB2GTRV0aAVczgex8wt+oyJjuM
         SYEhswUuSra2MHUVmY+M5S3yVjG4oEttDcHEJQaExK2MXyoFBXaHgTDYaHMYpfCaG1C9
         wCB5IoUUzhOkwk24sLp12A8lO6jKFPNR+BeEbPr1D3Qc12AzCn8iSO8G6R2U9bCgtKlx
         1qN4tcEO0XxlUA8vxsmyalMuM0mFdK9Sd/rUmoctUYEY0E+NXP4qjugF/ud09fr/ocaC
         8PGzqv7ESefe7QYkJXppzMmMoYz6ErcqTbuCyuiYIy7vccIwuyCqNez6eSq/7MSRGpsK
         5frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691823; x=1784296623;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=scyQmkb6R9mhvp0lHFXBIYm/E2nJa7IyjByj31lSlwk=;
        b=HwrfUtFoxx0ck3g4+k+ewQFyL+O5Op12Bs/XWA4gLSnJPLQ7pZUNJ7cmdWz8dxRj1U
         pMJ+GzUJ4Oa57mO/EYOnIqBxDhypltp9hlX9IfPWUXMtpX3o9C8C9KxBoVvv6nt4OfSM
         U14DBKNmru5K9dC6+BKVjbTja23b1QaOcnsgbgwO6tHr92rsnClTpJLw0bZhNLYvbLgH
         xE4LLXBP81GIAys+RIt0hc3ujzzgv4JnCah44sJfqXR0W++rfyH7HfrlWthYLI12aPVy
         8NR+WnmCgTQfND0wSoV2xtnZFyjjLYO5gOpKSw+CkY8pPux4XthKrxIMZAiS9crl/R4O
         HuUw==
X-Gm-Message-State: AOJu0YwUEAVYQ7nN4ytuRc3pAi7EhKrPg7OwGWioiEkxWfpOn9b2fjCr
	5JLAsdGjM5OPUoZ3yF2mm8BVgsf0ew2q17plDsg0X6zAWBHIRS9/ANJYi57QfTtPo1dJGg==
X-Gm-Gg: AfdE7cn5LdE93ZVjsmKbzqmahIAPuYQscm+PZqh/WEJq8HUFK5yCytrWNHPmLpgksOi
	Goq9GsdEkf0aFSeI6O44QRfAZmGIJzP8yVZUlnJ9lwS8LuNBGRf3YBpOEX3uAayjQtjiX+1gweT
	pH3UjVyCmlECymyKV8sqgXzrv6oMigqLQsvYcci65KC13sbB06Oo1YsHNpmuWwZfZAL3Q6OoEUY
	FnktH9JuX3B7PwZP5AZ8HApDiOlzcNfH6KbZkyqZJaKn919UFXPAeLCnrNdQhb//PNu8NevHLXw
	FnjyMHI7k4su+Mta+a7CDEgd9rOTtbn/9C89w5Qy1o2FuzWEecnpx1YOUGDxoa76ZbfOoTcoKPi
	lu2bhgSyecPSznmLazTEDHLdk1bBzIj6fDLjHaWwhZTdQMe6FKAd7GtvkgNlRAWAcgPTM6J9m/5
	xpv+Vsb3UzLGpvsB8JTEAx3w==
X-Received: by 2002:a05:600c:c491:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-493e689ba3amr117765935e9.11.1783691823259;
        Fri, 10 Jul 2026 06:57:03 -0700 (PDT)
Received: from nomad.home ([81.26.202.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f3a60404sm50607375e9.1.2026.07.10.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:57:02 -0700 (PDT)
From: djedi <edwards.richard.ai@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Subject: i2c-hid: Goodix GXTP5100 (27c6:01e9) touch engine latches off when
 probed early at boot
Date: Fri, 10 Jul 2026 15:56:59 +0200
Message-ID: <178369181961.1607113.5474217277993277808@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

I'm hitting a reproducible boot-time race on a laptop touchpad and I'd
like input on whether the existing i2c-hid quirk mechanism is the right
place to fix it, or whether I'm looking in the wrong layer. I have a
speculative sketch patch but I'm not confident enough in it to send as a
real submission -- details on why below, and I'd rather ask than send a
patch I can't stand behind.

Hardware
--------
Lenovo ThinkBook 16 G7+ IAH (type 21TL), DMI pvrThinkBook16G7+IAH.
Touchpad: Goodix GXTP5100 haptic pressure pad, i2c-hid over ACPI
(i2c_hid_acpi), USB/i2c ID 27c6:01e9, i2c-1, bound to hid-multitouch.
Kernel: 7.0.12 (also reproduced identically on 6.12.95 -- this is not a
kernel-version regression, both exhibit it).

Symptom
-------
When i2c_hid_acpi probes this device during early boot, the touch
ENGINE latches off permanently: the i2c front end keeps ACKing and the
device enumerates completely normally (identical kernel probe trace
whether the pad ends up dead or alive -- see below), but no touch input
ever arrives. It survives an EC reset. The only way to clear it is a
full power loss to the pad (cold boot; a warm/soft reboot is not
sufficient).

Evidence
--------
1. Identical probe trace regardless of outcome. From journalctl across
   both a "dead" boot and a "revived" one (same day, same kernel):

     kernel: hid-generic 0018:27C6:01E9.0001: item 0 1 0 11 parsing failed
     kernel: hid-generic 0018:27C6:01E9.0001: probe with driver hid-generic f=
ailed with error -22
     kernel: hid-multitouch 0018:27C6:01E9.0001: GT7868Q report descriptor fi=
xup is applied.
     kernel: input: GXTP5100:00 27C6:01E9 as .../input/input3
     kernel: input: GXTP5100:00 27C6:01E9 as .../input/input4
     kernel: hid-multitouch 0018:27C6:01E9.0001: input,hidraw0: I2C HID v1.00=
 Mouse [GXTP5100:00 27C6:01E9] on i2c-GXTP5100:00

   These lines are byte-for-byte identical on a boot where the pad ends
   up completely unresponsive and on a boot where it works fine. The
   kernel-visible probe/bind sequence gives no signal that anything is
   wrong -- whatever differs is happening inside the Goodix firmware's
   touch engine, below what i2c-hid observes.

2. IRQ evidence. On a dead pad, the shared i2c controller line still
   flows (protocol/ACK traffic keeps working) but the touch controller's
   dedicated GPIO IRQ line stays at 0 forever. On a working pad, both
   flow, e.g. currently on this machine:

     32: ... 41998  IR-IO-APIC 32-fasteoi  idma64.0, i2c_designware.0   (i2c =
bus IRQ)
    235: ...  1031  intel-gpio 182  GXTP5100:00                        (touch=
 IRQ, climbing with use)

3. Recovery is 100% correlated with power-cycling the pad, not with any
   driver-level reset, EC reset, or software reload -- only removing and
   restoring power to the Goodix chip itself clears the latch.

4. Empirical fix: blacklisting i2c_hid_acpi at early boot and loading it
   ~15s later via a oneshot systemd unit (after multi-user.target) makes
   the pad come up working consistently. Delaying the probe, not
   retrying it, resolves it -- consistent with a firmware-internal
   power-on/wakeup race that needs time to settle before anything
   touches the device.

Precedent I found, and why I'm not just sending that patch
------------------------------------------------------------
drivers/hid/i2c-hid/i2c-hid-core.c already has a quirk for a sibling
Goodix device, 27c6:0d42:

    { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_0D42,
         I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_RESUME },

with the comment:

    "On Goodix 27c6:0d42 wait extra time before device wakeup. It's not
    clear why but if we send wakeup too early, the device will never
    trigger input interrupts."

That is a striking match for our symptom description. I went and read
where I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_RESUME is actually consumed,
though, and it's only checked inside i2c_hid_core_resume() -- it never
fires during __i2c_hid_core_probe()/i2c_hid_core_probe() at all. Our
repro is a cold-boot/first-probe symptom; this machine never exercises
suspend/resume in any of this investigation (sleep targets are masked
system-wide here because s2idle hard-freezes the box, unrelated issue).
So simply adding 27c6:01e9 to that same quirk table entry would compile
fine and do nothing for us, since the code path that applies it is never
reached on a cold boot. I don't want to send a one-line patch I already
know wouldn't fix anything.

I also noticed I2C_DEVICE_ID_GOODIX_01E9 (0x01e9) is already defined in
drivers/hid/hid-ids.h and used in hid-multitouch.c for the GT7868Q
report-descriptor fixup and device-ID table -- so this exact ID is known
to the HID subsystem already, just not wired into the i2c-hid-core quirk
table or anything probe-time-delay-related.

What I'm asking
----------------
Is there an existing, preferred way to delay the *first* wakeup/reset
handshake after a fresh probe (as opposed to after a resume) for a
device like this? Candidates I can see, roughly in order of how
surgical they'd be, but I'd defer entirely to your judgment:

  a) A new quirk flag applied inside __i2c_hid_core_probe() /
     i2c_hid_core_probe(), analogous in shape to
     I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_RESUME but for the probe path.
  b) Something at the ACPI power-resource layer -- i2c_hid_acpi_probe()
     in i2c-hid-acpi.c calls acpi_device_fix_up_power() right before
     i2c_hid_core_probe(); if the race is really about the ACPI power
     resource turning on the rail and the chip's internal boot sequence
     not being done yet, that might be a better layer than i2c-hid-core.
  c) Something Goodix-firmware-specific that doesn't belong in i2c-hid
     at all.

I have a rough, deliberately-labeled-speculative sketch of option (a)
that I'm attaching inline below for discussion only -- it is untested,
unbuilt, and not something I'm asking you to merge. If (a) or (b) sounds
right to you I'm glad to build a test kernel, reproduce on this exact
hardware (I have a reliable dead-boot repro and a known-working
late-modprobe workaround to compare against), capture before/after
/proc/interrupts, and send a real patch with a proper commit message and
sign-off.

Current workaround, for reference (not something I'm proposing upstream,
just so the symptom description is fully reproducible by others):

    /etc/modprobe.d/goodix-tpad-lateload.conf:
        blacklist i2c_hid_acpi

    /etc/systemd/system/tpad-lateload.service:
        [Unit]
        Description=3DLate-load Goodix GXTP5100 touchpad driver (boot-time wa=
keup race workaround)
        [Service]
        Type=3Doneshot
        ExecStartPre=3D/bin/sleep 15
        ExecStart=3D/sbin/modprobe i2c_hid_acpi
        [Install]
        WantedBy=3Dmulti-user.target

Speculative sketch (RFC only, not a submission -- see caveats above)
---------------------------------------------------------------------
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -52,6 +52,7 @@
 #define I2C_HID_QUIRK_NO_SLEEP_ON_SUSPEND	BIT(5)
 #define I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_RESUME BIT(6)
 #define I2C_HID_QUIRK_RE_POWER_ON		BIT(7)
+#define I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_PROBE	BIT(8)	/* RFC, see this threa=
d */

 /* Command opcodes */
 #define I2C_HID_OPCODE_RESET			0x01
@@ -149,6 +150,16 @@
 		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_0D42,
 		 I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_RESUME },
+	/*
+	 * RFC: 27c6:01e9 (GXTP5100, e.g. Lenovo ThinkBook 16 G7+ IAH)
+	 * appears to latch its touch engine off if probed too early
+	 * after a cold boot; untested guess at the same class of fix
+	 * as the 0d42 resume quirk above, applied at first probe.
+	 */
+	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01E9,
+		 I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_PROBE },
 	{ I2C_VENDOR_ID_BLTP, I2C_PRODUCT_ID_BLTP7853,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ 0, 0 }
@@ -1292,6 +1303,12 @@
 		ret =3D __i2c_hid_core_probe(ihid);
 		if (ret < 0)
 			goto err_power_down;
+
+		/* RFC: see I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_PROBE comment
+		 * above -- untested, guessing at parity with the
+		 * resume-path quirk.
+		 */
+		if (ihid->quirks & I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_PROBE)
+			msleep(1500);
 	}

 	ret =3D i2c_hid_init_irq(client);

Thanks for reading this far, and happy to provide any more detail,
dmesg, or i2cdump output you'd like.

djedi
edwardsr99@gmail.com
