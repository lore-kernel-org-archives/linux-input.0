Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793538288;
	b=LfFOJA6R87FscwG+j4NxHBfv3Q1AxHrBLED5u0E8JIgRzcovXzahiwJds+7iTaLqp3ip
	 VXhr84WZhSyHsjZTjfKtLwPgOhQly1G2+9vpVHvHbQDOID7I3ToINUSXFtIvNFSrZNODC
	 1HCHelQc6qS/c1NQf0Vd9gylKtqXUXvEA8FhmBGH8RRrJYjiXF7TLueCy+ko8ONoUUhg3
	 5MZPF6pDzk/+z51XU3y/qCrnyHFVKS2aIcNf6dRNBGqLtxN/Qf1nR7Z+XcRf/PaOO6x9+
	 ajfbg48Ce+MuB/7/hgAW/jXHY5NZLKwHjaM9B1rBQviPkLZn2kmTFhdhn7JM6J5j1nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793538288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
	b=XE6ji23pITCYCpbr4l81UIxvK32yeNzUw7JRCmpyZCaSf54KeWjBa9C0+lOcqZWOYkbW
	 YT82f5tnH6e8VSWO8vRNT1riXkCh4M7dgvizZU8xTPH2O9En9QQ/UTm4sIWJn2l671vfZ
	 /CZgnLk/P4kms3HMIGgaSAQb61ACdDRIcC8Gckv4OWMPR6A3WNMyWtGDxCojp0CUblfIm
	 UxRNssm/nJHPiXLnm75IUJGJM91CPqys4T/qmXx67yGdjKIvmD0tgX47hOKsCcEsvG4lk
	 j0PgwSUNgoocN9SdcDYUJYDzWFFbmsJQ9p68mjECj8hilckkTH4gUylY6TyfiFTx8TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=botanica.software;
	spf=pass smtp.mailfrom=botanica.software;
	dkim=pass header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b=CgVeX7j2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EA606A325
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 13:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4EA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=botanica.software
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=botanica.software
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b=CgVeX7j2
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e96502e447so19653065ad.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 05:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793538287; cv=none;
        d=google.com; s=arc-20260327;
        b=TR1RyEuZbqMR5Qg8sf80hU/exZc197psIDHywrETkhY+R16QkGri29b3p0j5E3LB3s
         EsmMDvq5bf+1GZ0glowz6cG0KsE+UGjfc7/DOVvlLqK4Q4Ia14yB0QYEFgVMhnW5brWT
         K+dI5zu52bk4CZVYhzG7U+KgJGHl01VNnb2IZFog5qzjWXbDeAetTW1/8LqgSYaaRYNf
         l5P8ZpznlTAQVqXvIxxan6LlzPCv4c+8ZUbTC3ouyP6w1b/xFYrjuKSSAhSz5XZMji0c
         kkmeyVjF1RcoOC7lER08kuUTEvBowRrJi81tVJH1Jf5wjDhpmm4X54NvxB4NQ72whOVX
         HAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
        fh=n66fRaH5UHOsmPJDMF4lTlN2h7ga7TrB1r4oslOeWy4=;
        b=UeYglYM8xGnwt+gcqLBuZZ4WyEJA23VJb6VE0zsofSnMUk/lYXtp/XFAQD/KOgwGFf
         W5Xv0Jq264UGJjQcSnpD1tpXQNMtQ3WteEM6iFjwqskYFVrTP/gf5S0xwoNXGmSE/KtA
         vtVJKEYWoKGS4zY5ULst3rcVsfRzuuowObZsUgHmVUbFXNixj4tkfvXdzffL5ljjn5Ia
         SXXgxLVX+XN97C6vNtjKpuR5DpMFZdftFfLm7rMPIbI1V8a3KzAFMP2DLpTGKUabHZAI
         P3c+KX6pIp+WRcPu7LOZNPq+6dVBsjbPB5bZNMiDIwiySyeW4OJT/+JTaqfb7o2YQfJB
         p5+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=botanica.software; s=google; t=1793538287; x=1794143087; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
        b=CgVeX7j25hB/UE/rFkBA8D6RGwCTJO2wmKm6eyzGwU/q3BlxLlXbCm6xJSCpP/AXeb
         GXLoUNZZ1zyyah+sVjFXCW4nFJ8+jkoDeL2YGqwaF8FO2evuq4MKNHEy39J19VVo5C01
         WFKzpGeWp056ljqfnCtj2tNDF995bSeHxKn/98Hfl8C8hWw0VIpk6NuV85lvNxtR/9sy
         +EIuaEBAoZSqkUJF4/a7qdtsNv9ZC2Y3+oOz1ZG+uVi4FHB2jM/M8AQylolZqbDcBJIj
         mD4EINDjWDf/3I3Oc+9LVPSBaCq/ZZvz1mk6sdeOuXtvzJNgtvEYtyuBZuyri6k8WPrM
         BJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793538287; x=1794143087;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
        b=ipx4fzUKTAQt//FY+jNj91zmL64FlEuC7Yt84fDQIJJsx12SRuZMXS7IXupLYX8/vT
         i2f8SoYOk7/lcl3m4lREcCRjFUcU8mm78jEtTZ6X6hvGkWQ1sQeNY4/OY0A47GagRPxv
         9FL1HscNdWXf6zaQSkrE6f5JsFwP3IezIX9zs5Cz5+jLAny+TWm6t3vauQWlBw1O/1Cp
         og8EsHbjPubRDvG7UurMOMUCbWYHvEQ+9DqjSPwssVshw7NohwqB3g9zWWAJDhIKINou
         /RkBudlAgI9matXbm4dDbx3szwJ7FaEWZimj/wZpCHKDEGesF3XpvNCEMX7enO6QpwgG
         Q4nQ==
X-Gm-Message-State: APuU4Z9iwyTlBZ71u3Be6ICoqL027fZICmWbaTfIZ/xuJhyyuPSc7FKn
	sTaoU3U/U4bEi5HsrHWb8yaA6COQgfK+5xBgrSVfvJ+GJaw+gTNnqLUy3S5oLL1P8N1itcvRtq8
	FzM+988T7+krRS66wf8Z7pWs8NaoYa6BvpZN43eIK3g==
X-Gm-Gg: AYBFou3p+cDtNK4JJFSm6GPc8HfJiHrkYTNt+QK4ZbqtxKkbIySiz6jcCVywWnpblKP
	ixx3vqgU++PgIvtxCSobVrioj+DLsNjCGGvGTmKFlcKyhZzca046wxpovQ5n7B+wxFBgjnCLfYZ
	k/0Xq7dft4z0vYivR7ax/scBh0zJ8DI1t4ly8Jnho1crm+xVc+SopE7ZugnVngWG8fMDNmZbC3G
	IXJFlBl+SQPqZhgN4cx40xNs/xQ7vyNFKOy1aPd+vKVD4w2GfR0Xf468Vtx+6pDQzjHogmW/AAK
	L63yqI0ejCSdy87lz5sYrBfsi75uZZma6AHtKj/AhmNEBLDQQa8uJH4xKt4yKWrH0nHj2aiHfg4
	o5aD/eHnMZ3CVFduTvQFSrlPAeBSywtBG5RtYF6b/ex9ha2aWwC8SkVB2AOMtv5YIy3bMllkNpE
	0ONCGHmSfqMmg4Ub5EpBiGc9r5x9V8E25KtC+VNIPP1S3OCJdPeuc8xAQ=
X-Received: by 2002:a17:902:d2d0:b0:2e9:5714:6082 with SMTP id
 d9443c01a7336-2eb3652031emr74872735ad.55.1793538286694; Sun, 01 Nov 2026
 05:04:46 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Alon Livne <alon@botanica.software>
Date: Sun, 1 Nov 2026 15:04:35 +0200
X-Gm-Features: AclHuK9ArFYWUdjusrpBxbq0GOsE8Xto7w81yu6lg2XoZBGhwFNoMbsmz8wtwCA
Message-ID: <CAL1NV=j_naY7Mf3BZtFR4OVQdHsxXurr4_6FF7RhJvxwF3Ma7A@mail.gmail.com>
Subject: [PATCH] HID: bpf: bound incoming report size in dispatch_hid_bpf_device_event()
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, 
	security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
 drivers/hid/bpf/hid_bpf_dispatch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c
b/drivers/hid/bpf/hid_bpf_dispatch.c
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -49,7 +49,10 @@ dispatch_hid_bpf_device_event(struct hid_device
*hdev, enum hid_report_type type,
  /* no program has been attached yet */
  if (!hdev->bpf.device_data)
  return data;

+ if (unlikely(*size > hdev->bpf.allocated_data))
+ return ERR_PTR(-EINVAL);
+
  memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
  memcpy(ctx_kern.data, data, *size);
