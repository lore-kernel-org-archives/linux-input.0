Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275F45040E
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590138; cv=pass; b=uIBzyoDCvmCUQys93HZvQAgeEeL5Lou7FTNjuP6B17s62lDclsn4bJzscEj2CYWaeRmXx4NpbEZdfBc/3AfUumcQ3Js4tQKwCFPqHbHaw/d0Jbsx6tX/IxkmNXK8ahjoPwiqBLcNmz3NjuWlKndiPTIWq9fUZmskSSyQEXWU6z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590138; c=relaxed/simple;
	bh=kdJgTd5rY149S1Msp9M3j0a9987uOIPMhmMnO3D1HvY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c3/+7N1rZK1ICI5tsqXsLndusYUBkV25CGKKtwQl5OPI+71j2zQLJa/9CTnBsQkUGfkGV/8pt2iwCRkNCLL1hkVMi6vFB48/aY/Mge/CkF1LJzbssSchH7EmvTCVynZ/5/aBs9sazGNhAthxnCsdCFNpMAkUTVFUvpO0OZIgowA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAvobFuG; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAvobFuG"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78569cf871bso74809137.2
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 13:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789590125; cv=none;
        d=google.com; s=arc-20260327;
        b=O69IgdxBmrLYG8uijbTM2NRhYtq2gvZz7MewzT9HqtkOibBaU3k7wHmJBFAXcg5B+D
         520K0VCID1VflnfRo5GtVGwkYU7VL+Jg/6FWTHlsYMQTVsJ5hkooqLc8KZpRKcSLk5Aa
         FNe26VNNLFyENAq4wFOSpTjrVMCtJfsEHVegFwza8yEphoniV38Wcwj0p6C0ydh5OWtT
         AC6ikXiFMs9NEQxj+2GpVPxcOFEGCt/6JYwqr5/xOltyH7L0924cksdNpa/G6mPFssgq
         8+6YZHlL5Aq/2mZTmbCt+sqZvkgyEdl/45AyztPpZii9ogyvZ8r50PHzLHqdgZM5ugrc
         a/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=X508gO9QzsqGjUOOIEWC+XAT+CM9lZN1Ny8JfFxT69E=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=fHfUew7qAIYzK1t40JTJQaUNhfDsBM8+kUAMbtHD2fLjorl4jHkNvfN4+pVke5vGC/
         PSoYQLpW1cyf+KvzkgzwcDrn60yL35qD6R0idjpg5tO/KZY0d7ILn3yZrLwTAfO42Wk8
         8orYqhzjne09xFiIy+G4gqziSHjCXOplWwd0ehhTlJn+zX6yt7ivhvaKOioTsvYQBIq/
         hAmMAKCJnv6gCiIE6CDFGwYGwUdZ741UOPSFx4yiAgADoj2DG87mCZWA5M/nW5tMzoUc
         70BRfsanZDvlI6clsO+ZEQ+7WRoMjrEtp256Bqm8FtUmK9CKC2HVV0N73S8dLOSDRBSQ
         +SEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789590125; x=1790194925; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X508gO9QzsqGjUOOIEWC+XAT+CM9lZN1Ny8JfFxT69E=;
        b=sAvobFuG6xaQ2XJoyRQsAf5DcyeW5rZnzEN8fGCsLhPPQQonP51ol7OAD25CdHXfQh
         m65hrKuv0JN0xuPSSbFk2srPbjyy98zJqd1HkdpjPQLW3l6/M3xLDB68LntEfQGR5EMV
         m+ItyEpRkZmGpI+ChfkrFjJ3KwLCABFxPc9OfDNO1By1y+/GjRsks5g+Kw4zB6RniBEY
         qD2fo2UqQShCdpzk5EdnibP/f8jaML5+413XkOo2bT4eDHeUjY4SjGqjACITE4LwsQHr
         nPfyUXn9awkNeeWaKRHLuLeh4PhKVODG3wHE3GMCaiDQ9V3o/KhWSKHcjeOlb4eo10jv
         AwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789590125; x=1790194925;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X508gO9QzsqGjUOOIEWC+XAT+CM9lZN1Ny8JfFxT69E=;
        b=yA8AtUffcC/LngAsViDVi8lQBSEXyKaFIORyyVUPxwvagyshP3SG3O5PpJNxCDi6QC
         QSs/MYwoeuD8WEf5xU9u7DoELTm0O9diljzkNgJtLNSLmFAWwqJH+fP2qanio6a4nxx4
         /JbAbMaEYALJoTKscLsEy48/izwX3dnI6SbRZzX2Wi+F4EOffYBUKc94ftWs7GP4sxPF
         C/MxE+kxFX6QrmHfq0z5tKH1Ln/x8t6ShX1dhsRam3beml95Wz9sYhx4XZH7OtaajqHQ
         Ki/E2teSFdpRUz73rU7yn1nhrPsTTzx2aZQcl6gTbx5hthrPaN5JXHoYiCwNgsXptT1V
         s6pQ==
X-Gm-Message-State: AFuF++mqoHjlUhhAgi1kzE0nwTExFzv4fp/fOd8BO9zH6H4TsJGVTfiw
	SU5nDiCGLGPtiScHZRx+UAEHFina8A8n0w9evx7mhZp1/m8f3eJNFxa9APrpL5Yc17Ow6RwmtgU
	eqrPENUEQnbwu7hvl1lBJbG8eMtCI/ocgMU/E
X-Gm-Gg: AYBFou1nl8bPTwaDCfm7qf5Y2ZSPOay1TjdHkNYv82dUE9AZb3gjsemXjpL+p94tXRx
	oBDCZtZhsyVMVh2ZC2vbW4umf6C0hy8nMrse9gtHbdeGvEMWrStO6beAEdmjQn2jCnuzCo1wenB
	4CwYqsD++5RToy4Wn3/u2HS84bYrV/6UGWF/4DV7/3QQeBVPE1MZrHUdKU4QGXImBWOToANfGnE
	+IxLPmYaQTnJOGwLtiIbWr7moRfy2nGSwzkLHUUmh+ixb4NRNZywoiqLepfN9xUBV3PySeKenWU
	GPFyP49iMfM4QP9fCo5VsTmXVdviDgMjPCiSPT/uLIBhhmpcmSloeVN/mymEPFWB
X-Received: by 2002:a05:6102:6446:b0:7a1:f7d2:e822 with SMTP id
 ada2fe7eead31-7a2049c5474mr197381137.27.1789590124640; Wed, 16 Sep 2026
 13:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Diego <diegodcr@gmail.com>
Date: Wed, 16 Sep 2026 14:21:52 -0600
X-Gm-Features: AcwNN1VXyLmbPWykBZdFDq8vsVeo5HpsdUy8ZM5ssFIwA8vQZKMNwdGVR3vWS58
Message-ID: <CAOABP4oa==MDxHfKiAVqxABo0M9s=CDG3VyhGDufeL=N9hdEeg@mail.gmail.com>
Subject: Goodix GT9110 second controller (GDIX1002:01, I2C3) never answers,
 stuck D3hot, dual-touchscreen x86 tablet
To: linux-input@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ac7134065b9f6be1"

--000000000000ac7134065b9f6be1
Content-Type: multipart/alternative; boundary="000000000000ac7133065b9f6bdf"

--000000000000ac7133065b9f6bdf
Content-Type: text/plain; charset="UTF-8"

Hi,

On a dual-touchscreen x86 tablet (Alder Lake-N N95, whitebox, generic
"Default string" DMI, two 2240x1400 BOE panels) the second of two
GDIX1002 touch controllers never probes under Linux. Both panels work
in Windows.

Working:  i2c-GDIX1002:00 on I2C2 (PCI 0000:00:15.2), ACPI D0,
          ID 9110, version 1050.
Dead:     i2c-GDIX1002:01 on I2C3 (PCI 0000:00:15.3), ACPI power_state
          stuck at D3hot (power_state sysfs is read-only).

Probe log (every boot and every manual re-bind):

  Goodix-TS i2c-GDIX1002:01: Error reading 1 bytes from 0x8140: -121 (x4)
  Goodix-TS i2c-GDIX1002:01: I2C communication failure: -121
  Goodix-TS i2c-GDIX1002:01: probe with driver Goodix-TS failed with error
-121

DSDT facts (disassembled, both TCS5 scopes structurally identical
except bus and pins):
  - Bottom (works): I2C2, addr 0x14, INT GNUM 0x090C0012, RST 0x090C0011
  - Top (dead):     I2C3, addr 0x14, INT GNUM 0x09080003, RST 0x09080002
  - _PS0/_PS3 are empty on both; no _DSD; INT is PullNone; _STA 0x0F both.

GPIO facts (gpiod line numbers decoded via the DSDT's own GNUM/GPCL,
cross-checked: the working device holds reset+irq as consumers):
  - Dead reset line orphaned as output with no consumer; dead INT reads 0.
  - Holding INT high during bind only moves the failure to
    "error -EBUSY: Failed to get irq GPIO" (expected: line contention),
    never past it.

Tried, all failed identically: manual bind x N, parent I2C controller
pinned to D0 (power/control=on), INT-high hold during probe.
Driver is goodix_ts (module, no parameters) and already pulses reset
with INT high on every probe, so this looks electrical: unpowered rail
or EC-gated power for the second controller, or wrong DSDT pins for
community 0x08. Needs vendor init knowledge or a quirk; DMI matching
won't work (generic whitebox), ACPI HID is GDIX1002 x2.

Journal excerpt and DSDT GDIX scopes attached. Happy to test patches
or provide acpidump/ssdt dumps, gpio/pinctrl state, or WMI GUID list.

Thanks.

--000000000000ac7133065b9f6bdf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On a dual-touchscreen x86 tablet (Alder Lake-N =
N95, whitebox, generic<br>&quot;Default string&quot; DMI, two 2240x1400 BOE=
 panels) the second of two<br>GDIX1002 touch controllers never probes under=
 Linux. Both panels work<br>in Windows.<br><br>Working: =C2=A0i2c-GDIX1002:=
00 on I2C2 (PCI 0000:00:15.2), ACPI D0,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ID 9110, version 1050.<br>Dead: =C2=A0 =C2=A0 i2c-GDIX1002:01 on I2C3 (=
PCI 0000:00:15.3), ACPI power_state<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
tuck at D3hot (power_state sysfs is read-only).<br><br>Probe log (every boo=
t and every manual re-bind):<br><br>=C2=A0 Goodix-TS i2c-GDIX1002:01: Error=
 reading 1 bytes from 0x8140: -121 (x4)<br>=C2=A0 Goodix-TS i2c-GDIX1002:01=
: I2C communication failure: -121<br>=C2=A0 Goodix-TS i2c-GDIX1002:01: prob=
e with driver Goodix-TS failed with error -121<br><br>DSDT facts (disassemb=
led, both TCS5 scopes structurally identical<br>except bus and pins):<br>=
=C2=A0 - Bottom (works): I2C2, addr 0x14, INT GNUM 0x090C0012, RST 0x090C00=
11<br>=C2=A0 - Top (dead): =C2=A0 =C2=A0 I2C3, addr 0x14, INT GNUM 0x090800=
03, RST 0x09080002<br>=C2=A0 - _PS0/_PS3 are empty on both; no _DSD; INT is=
 PullNone; _STA 0x0F both.<br><br>GPIO facts (gpiod line numbers decoded vi=
a the DSDT&#39;s own GNUM/GPCL,<br>cross-checked: the working device holds =
reset+irq as consumers):<br>=C2=A0 - Dead reset line orphaned as output wit=
h no consumer; dead INT reads 0.<br>=C2=A0 - Holding INT high during bind o=
nly moves the failure to<br>=C2=A0 =C2=A0 &quot;error -EBUSY: Failed to get=
 irq GPIO&quot; (expected: line contention),<br>=C2=A0 =C2=A0 never past it=
.<br><br>Tried, all failed identically: manual bind x N, parent I2C control=
ler<br>pinned to D0 (power/control=3Don), INT-high hold during probe.<br>Dr=
iver is goodix_ts (module, no parameters) and already pulses reset<br>with =
INT high on every probe, so this looks electrical: unpowered rail<br>or EC-=
gated power for the second controller, or wrong DSDT pins for<br>community =
0x08. Needs vendor init knowledge or a quirk; DMI matching<br>won&#39;t wor=
k (generic whitebox), ACPI HID is GDIX1002 x2.<br><br>Journal excerpt and D=
SDT GDIX scopes attached. Happy to test patches<br>or provide acpidump/ssdt=
 dumps, gpio/pinctrl state, or WMI GUID list.<br><br>Thanks.</div>

--000000000000ac7133065b9f6bdf--
--000000000000ac7134065b9f6be1
Content-Type: text/plain; charset="US-ASCII"; name="goodix-dsdt-scopes.txt"
Content-Disposition: attachment; filename="goodix-dsdt-scopes.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mu4jpboi0>
X-Attachment-Id: f_mu4jpboi0

NzU0MzMtICAgICAgICB7Cjc1NDM0LSAgICAgICAgICAgIEkyQ04gPSBTRFMyIC8qIFxTRFMyICov
Cjc1NDM1LSAgICAgICAgICAgIEkyQ1ggPSAweDAyCjc1NDM2LSAgICAgICAgfQo3NTQzNy0KNzU0
MzgtICAgICAgICBEZXZpY2UgKFRDUzUpCjc1NDM5LSAgICAgICAgewo3NTQ0MC0gICAgICAgICAg
ICBOYW1lIChfQURSLCBaZXJvKSAgLy8gX0FEUjogQWRkcmVzcwo3NTQ0MTogICAgICAgICAgICBO
YW1lIChfSElELCAiR0RJWDEwMDIiKSAgLy8gX0hJRDogSGFyZHdhcmUgSUQKNzU0NDItICAgICAg
ICAgICAgTmFtZSAoX0NJRCwgIkdESVgxMDAyIikgIC8vIF9DSUQ6IENvbXBhdGlibGUgSUQKNzU0
NDMtICAgICAgICAgICAgTmFtZSAoX1MwVywgWmVybykgIC8vIF9TMFc6IFMwIERldmljZSBXYWtl
IFN0YXRlCjc1NDQ0LSAgICAgICAgICAgIE1ldGhvZCAoX1BTMywgMCwgU2VyaWFsaXplZCkgIC8v
IF9QUzM6IFBvd2VyIFN0YXRlIDMKNzU0NDUtICAgICAgICAgICAgewo3NTQ0Ni0gICAgICAgICAg
ICB9Cjc1NDQ3LQo3NTQ0OC0gICAgICAgICAgICBNZXRob2QgKF9QUzAsIDAsIFNlcmlhbGl6ZWQp
ICAvLyBfUFMwOiBQb3dlciBTdGF0ZSAwCjc1NDQ5LSAgICAgICAgICAgIHsKNzU0NTAtICAgICAg
ICAgICAgfQo3NTQ1MS0KNzU0NTItICAgICAgICAgICAgTWV0aG9kIChfQ1JTLCAwLCBOb3RTZXJp
YWxpemVkKSAgLy8gX0NSUzogQ3VycmVudCBSZXNvdXJjZSBTZXR0aW5ncwo3NTQ1My0gICAgICAg
ICAgICB7Cjc1NDU0LSAgICAgICAgICAgICAgICBOYW1lIChTQlVGLCBSZXNvdXJjZVRlbXBsYXRl
ICgpCjc1NDU1LSAgICAgICAgICAgICAgICB7Cjc1NDU2LSAgICAgICAgICAgICAgICAgICAgSTJj
U2VyaWFsQnVzVjIgKDB4MDAxNCwgQ29udHJvbGxlckluaXRpYXRlZCwgMHgwMDA2MUE4MCwKNzU0
NTctICAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc2luZ01vZGU3Qml0LCAiXFxfU0IuUEMw
MC5JMkMyIiwKNzU0NTgtICAgICAgICAgICAgICAgICAgICAgICAgMHgwMCwgUmVzb3VyY2VDb25z
dW1lciwgLCBFeGNsdXNpdmUsCjc1NDU5LSAgICAgICAgICAgICAgICAgICAgICAgICkKNzU0NjAt
ICAgICAgICAgICAgICAgICAgICBHcGlvSW50IChFZGdlLCBBY3RpdmVCb3RoLCBFeGNsdXNpdmUs
IFB1bGxOb25lLCAweDAwMDAsCjc1NDYxLSAgICAgICAgICAgICAgICAgICAgICAgICJcXF9TQi5H
UEkwIiwgMHgwMCwgUmVzb3VyY2VDb25zdW1lciwgLAo3NTQ2Mi0gICAgICAgICAgICAgICAgICAg
ICAgICApCjc1NDYzLSAgICAgICAgICAgICAgICAgICAgICAgIHsgICAvLyBQaW4gbGlzdAo3NTQ2
NC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwCjc1NDY1LSAgICAgICAgICAgICAg
ICAgICAgICAgIH0KNzU0NjYtICAgICAgICAgICAgICAgICAgICBHcGlvSW8gKEV4Y2x1c2l2ZSwg
UHVsbERlZmF1bHQsIDB4MDAwMCwgMHgwMDAwLCBJb1Jlc3RyaWN0aW9uT3V0cHV0T25seSwKNzU0
NjctICAgICAgICAgICAgICAgICAgICAgICAgIlxcX1NCLkdQSTAiLCAweDAwLCBSZXNvdXJjZUNv
bnN1bWVyLCAsCjc1NDY4LSAgICAgICAgICAgICAgICAgICAgICAgICkKNzU0NjktICAgICAgICAg
ICAgICAgICAgICAgICAgeyAgIC8vIFBpbiBsaXN0Cjc1NDcwLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAweDAwMDAKNzU0NzEtICAgICAgICAgICAgICAgICAgICAgICAgfQo3NTQ3Mi0gICAg
ICAgICAgICAgICAgfSkKNzU0NzMtICAgICAgICAgICAgICAgIENyZWF0ZVdvcmRGaWVsZCAoU0JV
RiwgMHgzOCwgSU5UUCkKNzU0NzQtICAgICAgICAgICAgICAgIENyZWF0ZVdvcmRGaWVsZCAoU0JV
RiwgMHg1QiwgUlNUUCkKNzU0NzUtICAgICAgICAgICAgICAgIElOVFAgPSBHTlVNICgweDA5MEMw
MDEyKQo3NTQ3Ni0gICAgICAgICAgICAgICAgUlNUUCA9IEdOVU0gKDB4MDkwQzAwMTEpCjc1NDc3
LSAgICAgICAgICAgICAgICBSZXR1cm4gKFNCVUYpIC8qIFxfU0JfLlBDMDAuSTJDMi5UQ1M1Ll9D
UlMuU0JVRiAqLwo3NTQ3OC0gICAgICAgICAgICB9Cjc1NDc5LQo3NTQ4MC0gICAgICAgICAgICBN
ZXRob2QgKF9TVEEsIDAsIE5vdFNlcmlhbGl6ZWQpICAvLyBfU1RBOiBTdGF0dXMKNzU0ODEtICAg
ICAgICAgICAgewo3NTQ4Mi0gICAgICAgICAgICAgICAgUmV0dXJuICgweDBGKQo3NTQ4My0gICAg
ICAgICAgICB9Cjc1NDg0LSAgICAgICAgfQo3NTQ4NS0gICAgfQo3NTQ4Ni0KNzU0ODctICAgIFNj
b3BlIChfU0IuUEMwMC5JMkMzKQo3NTQ4OC0gICAgewo3NTQ4OS0gICAgICAgIE5hbWUgKEkyQ04s
IFplcm8pCjc1NDkwLSAgICAgICAgTmFtZSAoSTJDWCwgWmVybykKNzU0OTEtICAgICAgICBOYW1l
IChJMkNJLCAweDAzKQo3NTQ5Mi0gICAgICAgIE1ldGhvZCAoX0lOSSwgMCwgTm90U2VyaWFsaXpl
ZCkgIC8vIF9JTkk6IEluaXRpYWxpemUKNzU0OTMtICAgICAgICB7Cjc1NDk0LSAgICAgICAgICAg
IEkyQ04gPSBTRFMzIC8qIFxTRFMzICovCjc1NDk1LSAgICAgICAgICAgIEkyQ1ggPSAweDAzCjc1
NDk2LSAgICAgICAgfQo3NTQ5Ny0KNzU0OTgtICAgICAgICBEZXZpY2UgKFRDUzUpCjc1NDk5LSAg
ICAgICAgewo3NTUwMC0gICAgICAgICAgICBOYW1lIChfQURSLCBaZXJvKSAgLy8gX0FEUjogQWRk
cmVzcwo3NTUwMTogICAgICAgICAgICBOYW1lIChfSElELCAiR0RJWDEwMDIiKSAgLy8gX0hJRDog
SGFyZHdhcmUgSUQKNzU1MDItICAgICAgICAgICAgTmFtZSAoX0NJRCwgIkdESVgxMDAyIikgIC8v
IF9DSUQ6IENvbXBhdGlibGUgSUQKNzU1MDMtICAgICAgICAgICAgTmFtZSAoX1MwVywgWmVybykg
IC8vIF9TMFc6IFMwIERldmljZSBXYWtlIFN0YXRlCjc1NTA0LSAgICAgICAgICAgIE1ldGhvZCAo
X1BTMywgMCwgU2VyaWFsaXplZCkgIC8vIF9QUzM6IFBvd2VyIFN0YXRlIDMKNzU1MDUtICAgICAg
ICAgICAgewo3NTUwNi0gICAgICAgICAgICB9Cjc1NTA3LQo3NTUwOC0gICAgICAgICAgICBNZXRo
b2QgKF9QUzAsIDAsIFNlcmlhbGl6ZWQpICAvLyBfUFMwOiBQb3dlciBTdGF0ZSAwCjc1NTA5LSAg
ICAgICAgICAgIHsKNzU1MTAtICAgICAgICAgICAgfQo3NTUxMS0KNzU1MTItICAgICAgICAgICAg
TWV0aG9kIChfQ1JTLCAwLCBOb3RTZXJpYWxpemVkKSAgLy8gX0NSUzogQ3VycmVudCBSZXNvdXJj
ZSBTZXR0aW5ncwo3NTUxMy0gICAgICAgICAgICB7Cjc1NTE0LSAgICAgICAgICAgICAgICBOYW1l
IChTQlVGLCBSZXNvdXJjZVRlbXBsYXRlICgpCjc1NTE1LSAgICAgICAgICAgICAgICB7Cjc1NTE2
LSAgICAgICAgICAgICAgICAgICAgSTJjU2VyaWFsQnVzVjIgKDB4MDAxNCwgQ29udHJvbGxlcklu
aXRpYXRlZCwgMHgwMDA2MUE4MCwKNzU1MTctICAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVz
c2luZ01vZGU3Qml0LCAiXFxfU0IuUEMwMC5JMkMzIiwKNzU1MTgtICAgICAgICAgICAgICAgICAg
ICAgICAgMHgwMCwgUmVzb3VyY2VDb25zdW1lciwgLCBFeGNsdXNpdmUsCjc1NTE5LSAgICAgICAg
ICAgICAgICAgICAgICAgICkKNzU1MjAtICAgICAgICAgICAgICAgICAgICBHcGlvSW50IChFZGdl
LCBBY3RpdmVCb3RoLCBFeGNsdXNpdmUsIFB1bGxOb25lLCAweDAwMDAsCjc1NTIxLSAgICAgICAg
ICAgICAgICAgICAgICAgICJcXF9TQi5HUEkwIiwgMHgwMCwgUmVzb3VyY2VDb25zdW1lciwgLAo3
NTUyMi0gICAgICAgICAgICAgICAgICAgICAgICApCjc1NTIzLSAgICAgICAgICAgICAgICAgICAg
ICAgIHsgICAvLyBQaW4gbGlzdAo3NTUyNC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgw
MDAwCjc1NTI1LSAgICAgICAgICAgICAgICAgICAgICAgIH0KNzU1MjYtICAgICAgICAgICAgICAg
ICAgICBHcGlvSW8gKEV4Y2x1c2l2ZSwgUHVsbERlZmF1bHQsIDB4MDAwMCwgMHgwMDAwLCBJb1Jl
c3RyaWN0aW9uT3V0cHV0T25seSwKNzU1MjctICAgICAgICAgICAgICAgICAgICAgICAgIlxcX1NC
LkdQSTAiLCAweDAwLCBSZXNvdXJjZUNvbnN1bWVyLCAsCjc1NTI4LSAgICAgICAgICAgICAgICAg
ICAgICAgICkKNzU1MjktICAgICAgICAgICAgICAgICAgICAgICAgeyAgIC8vIFBpbiBsaXN0Cjc1
NTMwLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMDAKNzU1MzEtICAgICAgICAgICAg
ICAgICAgICAgICAgfQo3NTUzMi0gICAgICAgICAgICAgICAgfSkKNzU1MzMtICAgICAgICAgICAg
ICAgIENyZWF0ZVdvcmRGaWVsZCAoU0JVRiwgMHgzOCwgSU5UUCkKNzU1MzQtICAgICAgICAgICAg
ICAgIENyZWF0ZVdvcmRGaWVsZCAoU0JVRiwgMHg1QiwgUlNUUCkKNzU1MzUtICAgICAgICAgICAg
ICAgIElOVFAgPSBHTlVNICgweDA5MDgwMDAzKQo3NTUzNi0gICAgICAgICAgICAgICAgUlNUUCA9
IEdOVU0gKDB4MDkwODAwMDIpCjc1NTM3LSAgICAgICAgICAgICAgICBSZXR1cm4gKFNCVUYpIC8q
IFxfU0JfLlBDMDAuSTJDMy5UQ1M1Ll9DUlMuU0JVRiAqLwo3NTUzOC0gICAgICAgICAgICB9Cjc1
NTM5LQo3NTU0MC0gICAgICAgICAgICBNZXRob2QgKF9TVEEsIDAsIE5vdFNlcmlhbGl6ZWQpICAv
LyBfU1RBOiBTdGF0dXMKNzU1NDEtICAgICAgICAgICAgewo3NTU0Mi0gICAgICAgICAgICAgICAg
UmV0dXJuICgweDBGKQo3NTU0My0gICAgICAgICAgICB9Cjc1NTQ0LSAgICAgICAgfQo3NTU0NS0g
ICAgfQo3NTU0Ni0KNzU1NDctICAgIFNjb3BlIChfU0IuUEMwMC5JMkM0KQo3NTU0OC0gICAgewo3
NTU0OS0gICAgICAgIE5hbWUgKF9EU0QsIFBhY2thZ2UgKDB4MDIpICAvLyBfRFNEOiBEZXZpY2Ut
U3BlY2lmaWMgRGF0YQo3NTU1MC0gICAgICAgIHsKNzU1NTEtICAgICAgICAgICAgVG9VVUlEICgi
Zjg3YTZkMjMtMjg4NC00ZmU0LWE1NWYtNjMzZDllMzM5Y2UxIikgLyogVW5rbm93biBVVUlEICov
LCAKNzU1NTItICAgICAgICAgICAgUGFja2FnZSAoMHgwNCkKNzU1NTMtICAgICAgICAgICAgewo3
NTU1NC0gICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKNzU1NTUtICAgICAgICAgICAgICAg
IHsKNzU1NTYtICAgICAgICAgICAgICAgICAgICAiaWRsZS1sYXRlbmN5LXRvbGVyYW5jZSIsIAo3
NTU1Ny0gICAgICAgICAgICAgICAgICAgIDB4RkZGRgo3NTU1OC0gICAgICAgICAgICAgICAgfSwg
Cjc1NTU5LQo3NTU2MC0gICAgICAgICAgICAgICAgUGFja2FnZSAoMHgwMikKNzU1NjEtICAgICAg
ICAgICAgICAgIHsKNzU1NjItICAgICAgICAgICAgICAgICAgICAiU1MtYWN0aXZlLWxhdGVuY3kt
dG9sZXJhbmNlIiwgCjc1NTYzLSAgICAgICAgICAgICAgICAgICAgMHhGRkZGCjc1NTY0LSAgICAg
ICAgICAgICAgICB9LCAKNzU1NjUtCjc1NTY2LSAgICAgICAgICAgICAgICBQYWNrYWdlICgweDAy
KQo3NTU2Ny0gICAgICAgICAgICAgICAgewo3NTU2OC0gICAgICAgICAgICAgICAgICAgICJGTS1h
Y3RpdmUtbGF0ZW5jeS10b2xlcmFuY2UiLCAKNzU1NjktICAgICAgICAgICAgICAgICAgICAweEZG
RkYKNzU1NzAtICAgICAgICAgICAgICAgIH0sIAo3NTU3MS0KNzU1NzItICAgICAgICAgICAgICAg
IFBhY2thZ2UgKDB4MDIpCjc1NTczLSAgICAgICAgICAgICAgICB7Cjc1NTc0LSAgICAgICAgICAg
ICAgICAgICAgIkZNUC1hY3RpdmUtbGF0ZW5jeS10b2xlcmFuY2UiLCAKNzU1NzUtICAgICAgICAg
ICAgICAgICAgICAweEZGRkYKNzU1NzYtICAgICAgICAgICAgICAgIH0KNzU1NzctICAgICAgICAg
ICAgfQo3NTU3OC0gICAgICAgIH0pCjc1NTc5LSAgICB9Cjc1NTgwLQo3NTU4MS0gICAgU2NvcGUg
KF9TQi5QQzAwLkkyQzUpCjc1NTgyLSAgICB7Cjc1NTgzLSAgICAgICAgRGV2aWNlIChBQ01HKQo3
NTU4NC0gICAgICAgIHsKNzU1ODUtICAgICAgICAgICAgTmFtZSAoX0FEUiwgWmVybykgIC8vIF9B
RFI6IEFkZHJlc3MKNzU1ODYtICAgICAgICAgICAgTmFtZSAoX0hJRCwgIk1EQTY2NTUiKSAgLy8g
X0hJRDogSGFyZHdhcmUgSUQK
--000000000000ac7134065b9f6be1
Content-Type: text/plain; charset="US-ASCII"; name="goodix-journal.txt"
Content-Disposition: attachment; filename="goodix-journal.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mu4jpbpo1>
X-Attachment-Id: f_mu4jpbpo1

U2VwIDE2IDExOjE3OjEzIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAw
OiBzdXBwbHkgQVZERDI4IG5vdCBmb3VuZCwgdXNpbmcgZHVtbXkgcmVndWxhdG9yClNlcCAxNiAx
MToxNzoxMyBvbWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElYMTAwMjowMDogc3VwcGx5
IFZERElPIG5vdCBmb3VuZCwgdXNpbmcgZHVtbXkgcmVndWxhdG9yClNlcCAxNiAxMToxNzoxMyBv
bWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElYMTAwMjowMDogSUQgOTExMCwgdmVyc2lv
bjogMTA1MApTZXAgMTYgMTE6MTc6MTMgb21hcmNoeSBrZXJuZWw6IGlucHV0OiBHb29kaXggQ2Fw
YWNpdGl2ZSBUb3VjaFNjcmVlbiBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTUuMi9p
MmNfZGVzaWdud2FyZS4yL2kyYy0yL2kyYy1HRElYMTAwMjowMC9pbnB1dC9pbnB1dDEyClNlcCAx
NiAxMToxNzoxMyBvbWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElYMTAwMjowMTogc3Vw
cGx5IEFWREQyOCBub3QgZm91bmQsIHVzaW5nIGR1bW15IHJlZ3VsYXRvcgpTZXAgMTYgMTE6MTc6
MTMgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IHN1cHBseSBWRERJ
TyBub3QgZm91bmQsIHVzaW5nIGR1bW15IHJlZ3VsYXRvcgpTZXAgMTYgMTE6MTc6MTMgb21hcmNo
eSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IEVycm9yIHJlYWRpbmcgMSBieXRl
cyBmcm9tIDB4ODE0MDogLTEyMQpTZXAgMTYgMTE6MTc6MTMgb21hcmNoeSBrZXJuZWw6IEdvb2Rp
eC1UUyBpMmMtR0RJWDEwMDI6MDE6IEVycm9yIHJlYWRpbmcgMSBieXRlcyBmcm9tIDB4ODE0MDog
LTEyMQpTZXAgMTYgMTE6MTc6MTMgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEw
MDI6MDE6IEVycm9yIHJlYWRpbmcgMSBieXRlcyBmcm9tIDB4ODE0MDogLTEyMQpTZXAgMTYgMTE6
MTc6MTMgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IEVycm9yIHJl
YWRpbmcgMSBieXRlcyBmcm9tIDB4ODE0MDogLTEyMQpTZXAgMTYgMTE6MTc6MTMgb21hcmNoeSBr
ZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IEkyQyBjb21tdW5pY2F0aW9uIGZhaWx1
cmU6IC0xMjEKU2VwIDE2IDExOjE3OjEzIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdE
SVgxMDAyOjAxOiBwcm9iZSB3aXRoIGRyaXZlciBHb29kaXgtVFMgZmFpbGVkIHdpdGggZXJyb3Ig
LTEyMQpTZXAgMTYgMTM6Mzg6NDEgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEw
MDI6MDE6IHN1cHBseSBBVkREMjggbm90IGZvdW5kLCB1c2luZyBkdW1teSByZWd1bGF0b3IKU2Vw
IDE2IDEzOjM4OjQxIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAxOiBz
dXBwbHkgVkRESU8gbm90IGZvdW5kLCB1c2luZyBkdW1teSByZWd1bGF0b3IKU2VwIDE2IDEzOjM4
OjQxIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAxOiBFcnJvciByZWFk
aW5nIDEgYnl0ZXMgZnJvbSAweDgxNDA6IC0xMjEKU2VwIDE2IDEzOjM4OjQxIG9tYXJjaHkga2Vy
bmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAxOiBFcnJvciByZWFkaW5nIDEgYnl0ZXMgZnJv
bSAweDgxNDA6IC0xMjEKU2VwIDE2IDEzOjM4OjQxIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMg
aTJjLUdESVgxMDAyOjAxOiBFcnJvciByZWFkaW5nIDEgYnl0ZXMgZnJvbSAweDgxNDA6IC0xMjEK
U2VwIDE2IDEzOjM4OjQxIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAx
OiBFcnJvciByZWFkaW5nIDEgYnl0ZXMgZnJvbSAweDgxNDA6IC0xMjEKU2VwIDE2IDEzOjM4OjQx
IG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAxOiBJMkMgY29tbXVuaWNh
dGlvbiBmYWlsdXJlOiAtMTIxClNlcCAxNiAxMzozODo0MSBvbWFyY2h5IGtlcm5lbDogR29vZGl4
LVRTIGkyYy1HRElYMTAwMjowMTogcHJvYmUgd2l0aCBkcml2ZXIgR29vZGl4LVRTIGZhaWxlZCB3
aXRoIGVycm9yIC0xMjEKU2VwIDE2IDEzOjQwOjIyIG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMg
aTJjLUdESVgxMDAyOjAxOiBzdXBwbHkgQVZERDI4IG5vdCBmb3VuZCwgdXNpbmcgZHVtbXkgcmVn
dWxhdG9yClNlcCAxNiAxMzo0MDoyMiBvbWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElY
MTAwMjowMTogc3VwcGx5IFZERElPIG5vdCBmb3VuZCwgdXNpbmcgZHVtbXkgcmVndWxhdG9yClNl
cCAxNiAxMzo0MDoyMiBvbWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElYMTAwMjowMTog
RXJyb3IgcmVhZGluZyAxIGJ5dGVzIGZyb20gMHg4MTQwOiAtMTIxClNlcCAxNiAxMzo0MDoyMiBv
bWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElYMTAwMjowMTogRXJyb3IgcmVhZGluZyAx
IGJ5dGVzIGZyb20gMHg4MTQwOiAtMTIxClNlcCAxNiAxMzo0MDoyMiBvbWFyY2h5IGtlcm5lbDog
R29vZGl4LVRTIGkyYy1HRElYMTAwMjowMTogRXJyb3IgcmVhZGluZyAxIGJ5dGVzIGZyb20gMHg4
MTQwOiAtMTIxClNlcCAxNiAxMzo0MDoyMiBvbWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1H
RElYMTAwMjowMTogRXJyb3IgcmVhZGluZyAxIGJ5dGVzIGZyb20gMHg4MTQwOiAtMTIxClNlcCAx
NiAxMzo0MDoyMiBvbWFyY2h5IGtlcm5lbDogR29vZGl4LVRTIGkyYy1HRElYMTAwMjowMTogSTJD
IGNvbW11bmljYXRpb24gZmFpbHVyZTogLTEyMQpTZXAgMTYgMTM6NDA6MjIgb21hcmNoeSBrZXJu
ZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IHByb2JlIHdpdGggZHJpdmVyIEdvb2RpeC1U
UyBmYWlsZWQgd2l0aCBlcnJvciAtMTIxClNlcCAxNiAxMzo0Njo1NyBvbWFyY2h5IGtlcm5lbDog
R29vZGl4LVRTIGkyYy1HRElYMTAwMjowMTogc3VwcGx5IEFWREQyOCBub3QgZm91bmQsIHVzaW5n
IGR1bW15IHJlZ3VsYXRvcgpTZXAgMTYgMTM6NDY6NTcgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1U
UyBpMmMtR0RJWDEwMDI6MDE6IHN1cHBseSBWRERJTyBub3QgZm91bmQsIHVzaW5nIGR1bW15IHJl
Z3VsYXRvcgpTZXAgMTYgMTM6NDY6NTcgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJ
WDEwMDI6MDE6IEVycm9yIHJlYWRpbmcgMSBieXRlcyBmcm9tIDB4ODE0MDogLTEyMQpTZXAgMTYg
MTM6NDY6NTcgb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IEVycm9y
IHJlYWRpbmcgMSBieXRlcyBmcm9tIDB4ODE0MDogLTEyMQpTZXAgMTYgMTM6NDY6NTggb21hcmNo
eSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IEVycm9yIHJlYWRpbmcgMSBieXRl
cyBmcm9tIDB4ODE0MDogLTEyMQpTZXAgMTYgMTM6NDY6NTggb21hcmNoeSBrZXJuZWw6IEdvb2Rp
eC1UUyBpMmMtR0RJWDEwMDI6MDE6IEVycm9yIHJlYWRpbmcgMSBieXRlcyBmcm9tIDB4ODE0MDog
LTEyMQpTZXAgMTYgMTM6NDY6NTggb21hcmNoeSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEw
MDI6MDE6IEkyQyBjb21tdW5pY2F0aW9uIGZhaWx1cmU6IC0xMjEKU2VwIDE2IDEzOjQ2OjU4IG9t
YXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAxOiBwcm9iZSB3aXRoIGRyaXZl
ciBHb29kaXgtVFMgZmFpbGVkIHdpdGggZXJyb3IgLTEyMQpTZXAgMTYgMTQ6MDA6MTQgb21hcmNo
eSBrZXJuZWw6IEdvb2RpeC1UUyBpMmMtR0RJWDEwMDI6MDE6IHN1cHBseSBBVkREMjggbm90IGZv
dW5kLCB1c2luZyBkdW1teSByZWd1bGF0b3IKU2VwIDE2IDE0OjAwOjE0IG9tYXJjaHkga2VybmVs
OiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAxOiBzdXBwbHkgVkRESU8gbm90IGZvdW5kLCB1c2lu
ZyBkdW1teSByZWd1bGF0b3IKU2VwIDE2IDE0OjAwOjE0IG9tYXJjaHkga2VybmVsOiBHb29kaXgt
VFMgaTJjLUdESVgxMDAyOjAxOiBlcnJvciAtRUJVU1k6IEZhaWxlZCB0byBnZXQgaXJxIEdQSU8K
U2VwIDE2IDE0OjAwOjE0IG9tYXJjaHkga2VybmVsOiBHb29kaXgtVFMgaTJjLUdESVgxMDAyOjAx
OiBwcm9iZSB3aXRoIGRyaXZlciBHb29kaXgtVFMgZmFpbGVkIHdpdGggZXJyb3IgLTE2Cg==
--000000000000ac7134065b9f6be1--
