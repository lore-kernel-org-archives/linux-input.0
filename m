Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618813;
	b=OolpQ9nDgqbXnn2ZdWr29bTrUZmeFOZTOYtSSxFt0PTS59rfySuTUt/r9S2vyrIo/N7q
	 QPLTJnPClzhQC8cyycKp4XPkOuFjTSai121wSLjFcFHrSMELuaNO8UWsD++ZBtR2p7dp9
	 efJGkTB3nUeeJDWUhJXc9ISAvVBrZHUnMk+df9JKy4aGPg+ko9RPWh0mKFdABQVtodCT6
	 JqVC05npZRaA41MO+BpiMTVWLo21gGPXYahkaobkMoTWvEyxpG2FeJlCgVPiDPBQxjr2p
	 EKos9lVKRoen4HystCAoYkqJbxot5Dffv40tSfR1z73a8hC4OZFMBr8ZANITFBQZb9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MuHBdOREgT33dVaiK+GfvRB4AtU3CtWcrJ1VyfxYTOA=;
	b=nklvswPe0xTwSn2+TDy8gRpcO7ccZEhTJdj1ln8cNn054LvJzS9gZmPdi6BK40G4WoKY
	 Dt6lC79XD98Od2my4ctk52v9gkUn2q12wTR9Zw0k8Ew6omNzSRlhJM6bEIsOi58c1FTdE
	 58WDKPZD/nsSA6S6GLBc+W1fdjZyUx1BuwwzOAlKXPlrmao3KWypI/D+c0N7yEa7GI4Ja
	 ZqHdZ1HMxKad7xoYuRFNdhxmXRQ14JFsrbDGI8rAPuDoS+eOsRaM7KsZREZpwkVtD3W/h
	 je8lvjLWTZAallkeEb60pJ+0F9zkev5i7C/iuO4bjBpIOqwtinqdkn6DzylHR49EByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=botanica.software;
	spf=pass smtp.mailfrom=botanica.software;
	dkim=pass header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b="b4U/A0ID";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4F606A327
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 11:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A4F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=botanica.software
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=botanica.software
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b=b4U/A0ID
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so21839235e9.3
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 03:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=botanica.software; s=google; t=1793618811; x=1794223611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuHBdOREgT33dVaiK+GfvRB4AtU3CtWcrJ1VyfxYTOA=;
        b=b4U/A0IDMYCMtbjw9NloplekzGCqR6wa7FE9ezsCBxD2IuUmdSrPkxqpvKl5J7SyjC
         ApI5ZRq9/MpJr7krna024i4ZSo5701g8Yg958IVVzCakwr+CDVZc0iSkgMnYAQerjxEA
         siBV8Db0jwVBmmPFQRQRarJLuTzQTEOIhqLd7HJrVhiVOU9UwcHiI7bmMuFCVKjwWFq6
         foZPQROpagq8L3cxXWE7aHIl9C3Oi0sA+pncM9LjubDXh/ce1dGoZ8wOqrYT9RXPcdHf
         iT+mjRmlU/xpABHX/9pPzgOqEnzlhg8d73QF5L40WNS5pqPpgdznILbp2NTR+nhH7ETx
         0Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618811; x=1794223611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuHBdOREgT33dVaiK+GfvRB4AtU3CtWcrJ1VyfxYTOA=;
        b=2U5Dl5LQEMy0+3dlxo5m2s/WhxTra7P70cZwRcjUTA+broCR8iPTBaR8NpgLJp3mC0
         +s1IF79Uqmne9byz4Yq8/tLzAhg//kwHyDoDkG9zr8hUwDvT/vjqvtyv6gcvuE18w2U5
         ngerpZtN4ruOfYKWyvHx8qUhT8hwPO7FR7+iDAA1mKKbrbQH1HhqTyD+DnuXqPNZordr
         vdAKH7IadYfv5uB8lcrtUMGXK3G6qJNM5lS9UmGvmbQiRFA/vi0iM0dUTld+Qxh7Zj0r
         pywFVWnfROkDh06CjBn8msizDnrAN0N2lUl2W30CR1EvuskX6lRqXDZX3CC5nI94CZ3B
         t+Dw==
X-Gm-Message-State: AFq9FYKBOXt3hbxEbGIjTfD65qGhZ2EHmlhh5RKf83eeV2yFNPI98rkQ
	rMXM54ZlEE+dgFlxI6dHTx2c8zDAmpOCwEu5ViehymtZkIG1gmtM4+fVv8WZ2vW9EsE=
X-Gm-Gg: AYBFou3pqHx/LLt8FckYr+oRQXg4X7ECEz3kQsd0fJvZuVk26ifpGpeVrMyGKZGy5ri
	iCNJITtrlSwzefHThC+Mdom2SEWGZ+pRcSTp7xQ7ev2c8Uf2EpZHFbk70qwtHDcD+shMKLEnA7i
	35rXKyB1BBivdw49hoWXX82ARBnKxcSmMIJchBl02xXgwSvzElnVrSCu4RpINyZv4Am+FeYtT7e
	HgTchcOlt1o6f+3jlc21X6632QbWhTI1FSyNUXBeyncN/6OY/TuCy0JKYaXod9jfTTNAkR8bmVG
	a3HF15YSJcTVUPLaKT4Jap84YiOk+4rwLpJWomnyVtujIW28c2gpzQC4Fkwt561IRmgZeOQadJo
	5Q18r/RUscDftP/tERXtbd19yHC15GacAQOGREDeZD2p2ZJZKskDJYphccIdlEix5pC7tcJt8Dr
	NCpP8brH/FYGXNaVI8PeEgJ8bMl5gVDZZ+Te0fgC6yPX+677rlF8nQHTJSq+1t/sU1kwvVvTNWB
	6hYCOlwT/2Y2QlNucwKcXbUxKhQmEzUNBaCsNMYs5hOmSuQF4usS0+gvMrZmo9CyWWH0C7IukYg
	bGIgagyMtNHkcmM6fJlQ1rCisaHenZeUXqMMBxiVFZcgfSZLQdjLfO9eFetrkkFkAz1Q8DemP5j
	VmDnISWk/24yWcLJWMhxl7ev8ZUirJNKv+oBo1ACw0rZcaqXtBEY9q8lq4/NM5u8bv6Wq3KD80s
	7Csw5mKg7okAprOYFh3IIxTSpXJl2WYYNRohWZY1tn
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4ac17d1995amr226446505e9.18.1793618811026;
        Mon, 02 Nov 2026 03:26:51 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-147-102.red.bezeqint.net. [109.67.147.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a0a3495sm211033105e9.4.2026.11.02.03.26.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 03:26:50 -0800 (PST)
From: Alon Livne <alon@botanica.software>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	peter.hutterer@who-t.net,
	security@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: bpf: bound incoming report size in dispatch_hid_bpf_device_event()
Date: Mon,  2 Nov 2026 13:26:30 +0200
Message-ID: <20261102112630.53400-1-alon@botanica.software>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAL1NV=j_naY7Mf3BZtFR4OVQdHsxXurr4_6FF7RhJvxwF3Ma7A@mail.gmail.com>
References: <CAL1NV=j_naY7Mf3BZtFR4OVQdHsxXurr4_6FF7RhJvxwF3Ma7A@mail.gmail.com>
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

dispatch_hid_bpf_device_event() copies the incoming report into the
per-device scratch buffer hdev->bpf.device_data with:

	memcpy(ctx_kern.data, data, *size);

hdev->bpf.device_data is allocated to the largest parsed report length
rounded up to 64 bytes (DIV_ROUND_UP(max_report_len, 64) * 64). *size is
the length supplied by the transport and is never checked against
hdev->bpf.allocated_data before the copy; the only size check in the
function is applied afterwards, to the value the BPF program returns.

For transports that bound the report to the parsed model (usbhid,
i2c-hid) this is harmless. But uhid accepts up to 4096 bytes per
UHID_INPUT2 and hidp up to 16384 bytes per interrupt frame regardless of
the descriptor. A report larger than the buffer therefore overflows the
slab allocation with attacker-controlled length and content, in kernel
context, whenever any HID-BPF program with a hid_device_event hook is
attached to the device.

This is reachable over Bluetooth with no local access. BlueZ feeds remote
HID devices to the kernel through uhid, the remote device supplies its
own bus/vendor/product ids, and udev-hid-bpf auto-attaches shipped
programs by those ids. On a host with udev-hid-bpf installed (common on
machines used with drawing tablets), bonding with a device that claims to
be a Huion KeyDial K20 over Bluetooth (BUS_BLUETOOTH, 0x256C:0x8251)
causes the shipped Huion__KeydialK20-Bluetooth program to be attached,
after which a single oversized report corrupts kernel heap memory.

Reproduced on Ubuntu 24.04 (6.8.0-134) and Ubuntu 26.10 (7.3.0-10) with
slub_debug=FZPU. Driving /dev/uhid: create a device whose largest report
is 8 bytes (64-byte scratch buffer), attach a hid_device_event program,
and send a 120-byte UHID_INPUT2. slub reports "Right Redzone overwritten"
on free via hid_bpf_disconnect_device; the same report with no program
attached, or at the exact 64-byte size, is clean. Also reproduced
end-to-end with the shipped Huion__KeydialK20-Bluetooth program
auto-attached by udev-hid-bpf 2.3.0, presenting the K20's Bluetooth ids.

The missing check was noted by automated review on this list on
2026-07-04 but left unaddressed; the copy is still unguarded in master.

Reject reports larger than the allocated buffer before the copy, the same
way an over-sized program return value is already rejected.

Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Alon Livne <alon@botanica.software>
---
Changes in v2:
- Resend with git send-email. v1 was whitespace-damaged by the mail client
  (tabs flattened, diff and hunk headers wrapped) and does not apply.

 drivers/hid/bpf/hid_bpf_dispatch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 6b467c7..ea56223 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -50,6 +50,9 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	if (!hdev->bpf.device_data)
 		return data;
 
+	if (unlikely(*size > hdev->bpf.allocated_data))
+		return ERR_PTR(-EINVAL);
+
 	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
 	memcpy(ctx_kern.data, data, *size);
 
-- 
2.56.0

