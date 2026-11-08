Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173822;
	b=TbAqhNdY8IJdPvuqu2wzD7+Etv8E1DN10iLEDiq3CzGcu8pqvdt/26LwMdMAoibQY+kB
	 z7fo361ymVvuMuU6/9LQrS3eW72PjcMkNq/5MoN4DUIbmTr/iy4IZqBYkd55lSUbU8YJP
	 u6c+Y+SaeR66Grs8LP2wh10VCJ8A7uef2+eRAte/Oe1c7OqxoVCh5UpT1gwuATkCMh/L6
	 725nZwsoVK1NJAkwK9RwfTMQtLjqEbIo8RzxjN6BcmdIgShkr8Nr9DPYkgXgHG+nNRBHw
	 LM4GT4iTjMuODm0oCa2XMbMg+9AyszxTGiuFjiDdA/zvqDjAF9Tlp72YrwjPn/IudXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ytnzf6VXxBICp1pG+WcFKQAeNWKQrJq47ffcZ2o26I8=;
	b=LElab36Uv/yQV5R2eF6t8vRngrgTlD0IOzCdU7jkgraeKw8bhprPEtYybAvuIZg6RSJJ
	 z0WaLqk1+zryK5kg3d535rWySlFPL6q/lWB9MMX7Toq2zRTAa9Mp9mpYpWed+10bQFgeJ
	 sfTK6b4KyUqhP3QURuj1hAY6nQTfb6T7VgKRTTHT24dN9lDuIHZh3k7tl6ugbs0eDg+pO
	 cndWC4o/H3xisVeV1uINKGJh2m8EiVqcywGpWmYdjXaW7DaHH8ut0CSTfVv9cSrnS7thA
	 gMNiJ+7T9rVAg3QtmE+IrIHxYmNEGslcyWjy5SbC3NvIVR81IIwD6cNRTtu+uvStJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k7fI5pG4;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A24606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 21:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A24606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k7fI5pG4
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so2298285e9.3
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173820; x=1794778620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytnzf6VXxBICp1pG+WcFKQAeNWKQrJq47ffcZ2o26I8=;
        b=k7fI5pG4uo55lbPEW3NEz7FyUKtUQcZKULR/CxTPToc4ALjBs2GlYauuwaNpuePIMI
         uJcnFsRVubheyEiEKN0cMUOGFhJZYTOd/DheiUx/aKyfvkyeW0YMYUUmnuUTEHY1gfIB
         32eLHnMHKclCuN+6UOS0JeBxgeT000I23E3p74SqgSrg81Dsb/gIzNOD/Rs6wOjaOfYJ
         Q7oBqD9H5eGRNvGnfWRlp5zMascAmo6jCT/Kt48TNZFQJtyI/M5jkgSmjWaev24ZO77w
         /1+KPZbHqa8Dp4UualDb8//G/rZUta4WEJFlYb1e1qMVX0jupbcp177VPSeLyQy+iXhc
         jXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173820; x=1794778620;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ytnzf6VXxBICp1pG+WcFKQAeNWKQrJq47ffcZ2o26I8=;
        b=bl6MX/WP6sViLAOdcUo70voUjrLIMUfgDAw7jnGIldUQAeFsuMx5Bc7BlmojjvnCfh
         P61bDtYBjn+sTdm/GB5pb3M2Kx1RD14915B5N+eK/IL8ntobhlgeWR9iOyxiOztQQ+Hr
         WCMTfMzuiXwYux2n/G4eu9hWJ/PXWncIJrHGsLJTnBf3gDpHuZdNSjzdVY2efyy8nQ5x
         3OatdoY3RKZ02o4cvd4AdR/yL2MokZGYCsjpuixb/XZJ2CsgCSFuPjw+SqbyZjReoKDk
         KC3JGfnXaN/XgkFcEOd9W8QcXYp4Z+WvDcC5u7/sx6RodrDtz07Fsl6HZRaZumUQ1Onc
         24Fg==
X-Forwarded-Encrypted: i=1; AL+hErEO4iokDe68pvEMpREsYkJlallflG+QunsIrsaNyl0dJxr/siYv4PK7HZGJZWI9B6z1fw7UOL2eIckcEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/n3JJvyH5sJyQSNDbFKHzjyxP3sIfiQ5WCxyrnX5PUAOpUA+G8
	ft9NwJPvWwqrEfTdKKH+Y+GJcEE5/Prd/fNu48eOVvsMYdT443r+b34k
X-Gm-Gg: AYBFou1W5GbCqAmuUpDUZ3UgvIBISKLnTs3IEjt4qrN21Tmrl2Sjq/spdZa7oWMBUjy
	VTQvEz3HC9YQC5HahZfBI/orPUBdjE1ozkc8/V5ynKorU6taviJWLXIUPC43t+8N1krkYbb8Rgh
	OSd4uLE0tGpmgBxLrcoIyJETsAlT+C3GTnGlFSZMwSFfRc5re2fQydVaqz4KcMUgXCwZrg8FlCg
	6FyqwgddVFoxtPj/R4uLbHyHqtAX0+EUNWJM6MyJL2wAVgEddB8j6Kq5CuBIdDgU77P6mTv0Ioj
	ENE8kXJUQCDDQJ0PxS0KvluxejCxjtRcXoNlFMjOd+s7me3R0W4/yQiPpKQXvAxpSE/b82c5wow
	N4sa0faD+HPGqCKObbCEhdZ2lIVnj23jh4Ghtrn7gx1yhk1PiSCktjtDKb7vDyTehPpNtbFKdFf
	IANnRxBAdMYnNyEdNG1U/YKVwIJd/DnZOBWQHf30HUhcR6rW3qEER55x1ipDb4VQMTQkk/VTLaK
	YT7Im24SBLmr7xJ9WnUBOcxa7ZDfC8+ryfPZJladSbvYjDquCDzItDZNuVNRVzLRZSkCjhZjbH/
	R7+JpB2izVbil/Flpxl2Yo33Niayus/waVgwh/Y90elGTwawSWBmo92lcH9s
X-Received: by 2002:a05:600c:4eca:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4b94d762f98mr43434335e9.1.1794173820341;
        Sun, 08 Nov 2026 13:37:00 -0800 (PST)
Received: from SurfaceArch.localdomain ([207.188.128.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee247e9sm92178595e9.6.2026.11.08.13.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:36:59 -0800 (PST)
From: =?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: Sachi King <nakato@nakato.io>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
Subject: [PATCH v2 0/2] Fix MSHW0040 button driver selection on AMD Surface devices
Date: Sun,  8 Nov 2026 22:36:54 +0100
Message-ID: <20261108213656.13031-1-antoniovazquezblanco@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a rebase and rework of Sachi King's series from November 2021 [1].
It was reviewed then, the review was never acted on, and the thread went
quiet in March 2022. Sachi has confirmed they are happy for it to be
carried and no longer have the hardware. Both patches keep their original
authorship and sign-offs.

The problem, restated, because Hans asked for this in [1] and never got a
clear answer:

The AMD variants of the Surface Laptop 3 and 4 use the same MSHW0040 ACPI
device ID as the Intel Surface devices from the 5th generation on. Both
soc_button_array and surfacepro3_button match that ID and tell the groups
apart inside probe, by evaluating function 2 of the MSHW0040 _DSM, the OEM
Platform Revision, and treating a returned 0 as proof that the method is
absent. The AMD variants implement that function and legitimately return 0,
so both drivers draw the wrong conclusion, and surfacepro3_button binds
where soc_button_array should.

The sound test is whether the device implements that function at all, which
function 0 of the same _DSM advertises and acpi_check_dsm() reports.

To answer the question of which models are affected, every ACPI dump in
linux-surface/acpidumps [2] carrying MSHW0040 was surveyed, 32 models, for
UUID 6fd05c69-cde3-49f4-95ed-ab1665498035 revision 1:

  Model                        fn 0 mask fn 2 advertised
  Surface Book 1               0x03      no
  Surface Book 2               0x0d      yes
  Surface Book 3               0x0f      yes
  Surface Laptop 1             0x05      yes
  Surface Laptop 2             0x05      yes
  Surface Laptop 3 AMD         0x0f      yes
  Surface Laptop 3 Intel       0x0f      yes
  Surface Laptop 4 AMD         0x0f      yes
  Surface Laptop 4 Intel       0x0f      yes
  Surface Laptop 5             0x0f      yes
  Surface Laptop 6             0x0f      yes
  Surface Laptop 7 Qualcomm    0x0f      yes
  Surface Laptop Go 1          0x0f      yes
  Surface Laptop Go 2          0x0f      yes
  Surface Laptop Go 3          0x0f      yes
  Surface Laptop SE            0x0d      yes
  Surface Laptop Studio 1      0x0f      yes
  Surface Laptop Studio 2      0x0f      yes
  Surface Pro 10 Business      0x0f      yes
  Surface Pro 11 Qualcomm      0x0f      yes
  Surface Pro 4                no _DSM   no
  Surface Pro 5                0x0f      yes
  Surface Pro 6                0x0f      yes
  Surface Pro 7                0x0f      yes
  Surface Pro 7 Plus           0x0f      yes
  Surface Pro 8                0x0f      yes
  Surface Pro 9 5G             0x0f      yes
  Surface Pro 9 Intel          0x0f      yes
  Surface Pro X SQ1            0x0f      yes
  Surface Pro X SQ2            0x0f      yes
  Surface Studio 2             0x0d      yes
  Windows Dev Kit 2023         0x0f      yes
Exactly two do not advertise function 2, and they are exactly the two that
need surfacepro3_button:

  - Surface Pro 4: its MSHW0040 device carries no _DSM at all, only _HID
    and _STA.
  - Surface Book 1: it does carry the _DSM with this UUID, but function 0
    returns {0x03,0,0,0}, advertising functions 0 and 1 only. Function 1
    there is dGPU base attach and detach handling.

Worth noting that v1 said the devices needing surfacepro3_button "do not
have the _DSM". That is not true of the Surface Book 1, and the inaccuracy
is probably why the problem was hard to follow. The commit messages now
describe what is actually tested.

Changes in v2:
 - Dmitry: a returned 0 is no longer treated as invalid. acpi_check_dsm()
   makes the decision, and the revision is still evaluated and dev_dbg()'d
   afterwards, instead of that evaluation being removed.
 - Andy: the dev_dbg() of the OEM Platform Revision is kept, and the new
   comments use kernel comment style.
 - Hans: the commit messages now state which models load which driver and
   what each one's _DSM advertises, and the in-driver comments are
   expanded.
 - Rebased onto v7.4-rc2: surface_button_check_MSHW0040() now takes
   (struct device *, acpi_handle) and the driver has become a platform
   driver.

Not done, and I would welcome guidance. Hans also suggested replacing the
ACPI match with a DMI table plus MODULE_DEVICE_TABLE(dmi, ...), so that
surfacepro3_button stops auto-loading on machines that do not need it. That
is a larger change, independent of this fix, and the survey above suggests
the _DSM test is reliable across the whole range. That may be a good
follow-up if it is still wanted.

On merging: please do not separate the two patches. Both drivers match
MSHW0040 and discriminate only in probe, so with only one of them applied,
which driver claims the device on the AMD variants depends on module load
order. Hans asked for the same arrangement for his own two patch series in
2022, so either tree with an ack from the other would work.

On testing. Tested on a Surface Pro 4, which is the "no _DSM" side of the
check. Its own DSDT agrees with the survey above: the MSHW0040 device
carries only _HID and _STA, with no _DSM at all. With both patches applied,
MSHW0040 still binds surfacepro3_button, soc_button_array still declines,
exactly one input device is registered, and the volume keys still work. No
"OEM Platform Revision" line appears, which is the correct result here: on
this model both drivers return before reaching that evaluation.

That is a regression check, not a confirmation of the fix. On a Pro 4, v1,
v2 and current mainline all take the same path, because the _DSM is simply
absent and acpi_check_dsm() returns false. The Surface Book 1 is the case
that separates them and I do not have one.

Worth knowing, though: the out of tree linux-surface kernel has carried v1
of both patches since 2021-10-05 and still ships them today on its 6.19,
7.2 and 7.3 branches. This logic has therefore been in continuous use on
Surface hardware, including the AMD Laptops it fixes, for about four years.
The Pro 4 above had been running it before this test.

Neither I nor Sachi has an AMD Surface Laptop, so the half this actually
fixes is still untested by us directly. If anyone with an AMD Surface
Laptop 3 or 4 can test it, that would be very welcome.

[1] https://lore.kernel.org/all/20211109081125.41410-1-nakato@nakato.io/
[2] https://github.com/linux-surface/acpidumps

Sachi King (2):
  Input: soc_button_array - support AMD variant Surface devices
  platform/surface: surfacepro3_button: don't load on amd variant

 drivers/input/misc/soc_button_array.c         | 31 ++++++++++---------
 drivers/platform/surface/surfacepro3_button.c | 31 ++++++++++---------
 2 files changed, 34 insertions(+), 28 deletions(-)


base-commit: 8a65162514fbad21a2c58ffed65f42b27e92b163
-- 
2.56.0

