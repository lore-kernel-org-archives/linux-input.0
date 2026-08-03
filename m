Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552E237713
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785733506; cv=none; b=oynVNItPUDkkDtcN9XZQZksYqLuXk+8aAlAmT/+pINf26KhpzUmVyXXheDRRTl56bg4hABuia9fQG9uDUTk4IFryIXgveeeVobU0Swg57EEDWWf6pYt25wz5mb0HICbu3ZWatpadUKykIyvFI2UgsHO6PJTw72PAg7spVhFG3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785733506; c=relaxed/simple;
	bh=bLZ0tDlP9e1x86mLC7eqs3JNZkooA6glLKbmx5Qz1DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjZwfCKxW4KE3xpY/IBsLP/K/s6Jb0idYgcmtZgVM3PCo+cxgqLcoF1eWUKfauCDE3HlwSJSleeeFkhUQhWIZ+nj0HAStvJVJCjcLpxsnD4Wo1ixR6RhC0YpFg7ft2UAcdBeu5m0sB5l1eLItBFOEob+EG1MZ38OtDpwjVtSAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBeDSauh; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBeDSauh"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e6a434cabso130124185a.1
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785733504; x=1786338304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEN3xiJe9hMVZB1h8h+hN6myMTpwcimZ+buwugtVTlE=;
        b=SBeDSauh11JgeXBwpOw3JqsBkIfHRGqrqMvMUUnW3RMdhxeBjBWkJzHiUj6A0ABap6
         mSdKcraFuUlEdnMSMebQJNtSiZBpLB8IdrOODG/Eov5UhHheNBi/x7bFcapS32sNLct7
         /mjFHrDIsWHfXYBJ56g/c/klyfn7o6xtTaOPzvchTGEYKFhLl1ko/Abws1Rj8nrJ8Zw6
         gqeR0GgVbCaMkPBcIzJfmGy3j4Q+C08dBJVvU0VvW7lZszC/j/PjpZjUO9pc+FT2S4Km
         YE8QcAegJphkU/8jRuPBFj6Ghni+tyPnaDnQY8d3EKQeiz08RECwqkrgcRDN4XLVNc0Q
         pFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785733504; x=1786338304;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEN3xiJe9hMVZB1h8h+hN6myMTpwcimZ+buwugtVTlE=;
        b=lyr/67T3WrqpWkzeAIyj9nl5obYnTnIdD0o9h2BCUExr94gYLkohh+j6ibm392rdt0
         cLRi1OL6FBWyYaYZXTuct9jB/Hy4kCaYr9l2VCm7LEdiNcaPd+Ox4EKI9yeNUYJ4Y/CE
         maDQnBLW4Idbx9bcZqlaztgs+Uz75Gv7HVEwgN6YDg6gDs/8m+ju5mdJ405RklM94dnq
         OMICD/1LDyYzjIRwZ1cybjTX3grjVUeZBaBJauDRKEAq3hNQE4V6AzQAzfFbPwu5RIxN
         HUXQXyzD8gqcL9/6kW8bsiAjyn3ONXRNCT58QREi2CO/h8XRyhH3KRSt4dT64pP4Ly8o
         PZjg==
X-Forwarded-Encrypted: i=1; AHgh+RouHNkwWs1W/73ZGKNhDY15fgl7089+KSDCcVWR+sNeMP0h0gAjZo0XxP1bfulMYM/e/0WIr1XAoI7Lsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuz+SOZGkB71YWBLb20QYgQxkvt5P1Xz8dt6Tm6blxLLiB9h9
	iCpJbM9wYZNFd3FpVMIBfbWW9SI+fl0lXMocOFemHo2KedQTKxJNEMKJ
X-Gm-Gg: AR+sD11lGpEOHaDOSlZI1FVEUL+dGsCSnAYc/qy4Ej/Md5EsM+V1zVWEihMYEYYdeaL
	ky5r29da70PwK2CgLhXPsjL3hDmaQUyxxwDoOB0bLxc/XrmesgiKOEL65NgSPFaNNwgDdZldEgP
	OC8htqkPKUNLExqd+yo2RHabBV83uwGaY9gQueWVOjgbTf6CXoRRy/F9t/7fWAFVAoaaAuCcsOH
	kqCmVmxOod/CcRw/rT+O3AYyADPX5gdYXbXEvSXZ6OUCtM89QFim1pyx0bitg2CS+MsvX5NRVfd
	34pI/rOcUGj77SERWqH/jcSB5uqieWk6ahUb9vLkshJaji8HX5XMaiT23UOFX/PTqICuCeLRTr0
	R2MA62HmVycZgeYu3N8qpkQLrZqUhN8g0w/gW65C/UuLQNv80uB4+/6lqCZg3qznvf79ogndp0T
	dJ8zpRR0jMZY88LrVS5fUElSgRPRqgLDbc9VMBXxBmM01ix2J/+wa44VxW4KBFOcFhRZ8IUihP6
	4sH/dIl6g==
X-Received: by 2002:a05:620a:2988:b0:92f:199:b035 with SMTP id af79cd13be357-934a06d57f7mr1420411085a.3.1785733503618;
        Sun, 02 Aug 2026 22:05:03 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c199b76sm584144585a.24.2026.08.02.22.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:05:03 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: pepemontfort@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	andfed.net@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH v2] HID: input: read battery capacity from its actual report offset
Date: Mon,  3 Aug 2026 01:04:57 -0400
Message-ID: <20260803050458.40134-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728201309.776026-1-pepemontfort@gmail.com>
References: <20260728201309.776026-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026, Jose Villaseñor Montfort wrote:
> Store the battery field's offset within the report at setup time and use
> it when querying, so the capacity is read from its real position.

I can reproduce this on a second model and a second transport, and the
report descriptor explains it exactly. Magic Trackpad 2 [Lightning]
(05ac:0265) over Bluetooth, 7.1.5, battery report 0x90:

  Field(0)  Usage(3): Power.Good, BatterySystem.Charging,
                      BatterySystem.FullyCharged
            Report Size(1)  Report Count(3)  Report Offset(0)
  Field(1)  Usage(1): BatterySystem.AbsoluteStateOfCharge
            Report Size(8)  Report Count(1)  Report Offset(8)

So the capacity lives at report_offset 8, i.e. buf[2], and buf[1] is the
flags byte -- the same layout you found on the 0324.

Sampling sysfs capacity and a raw HIDIOCGINPUT of report 0x90 side by
side, from the moment the trackpad reconnects over Bluetooth:

  00:50:36  sysfs=0    raw bytes: 90 00 4f
  00:50:42  sysfs=0    raw bytes: 90 00 4f
  [...]
  00:51:35  sysfs=0    raw bytes: 90 00 4f
  00:51:40  sysfs=79   raw bytes: 90 00 4f
  00:51:44  sysfs=79   raw bytes: 90 00 4f

The device says 0x4f (79%) in byte 2 throughout and never changes. For
64 seconds the kernel reports 0%, which is buf[1] with the trackpad
discharging (flags 0x00); your 3% is the same byte with the thing plugged
in (flags 0x03). At 00:51:40 the first battery report is parsed, status
becomes HID_BATTERY_REPORTED, and reads switch to the correctly parsed
value. Only the path changed, not the device.

I checked the offset semantics the patch relies on and they hold:

- struct hid_field documents report_offset as "bit offset in the report",
  and hid_report_raw_event() strips the report ID before parsing
  (cdata++/csize-- when the enum is numbered), so the offset is relative
  to the data after the ID. 1 + report_offset/8 is the right expression.

- The +1 also survives unnumbered reports, which was my first worry.
  usbhid_get_raw_report() states "Byte 0 is the report number. Report
  data starts at byte 1" and offsets the buffer when the number is 0;
  hidp_get_raw_report() likewise puts the report number in data[0]. Byte
  0 always holds the ID. Might be worth a line in the commit message,
  since it is the obvious objection.

- Growing the request from a fixed 4 to max(len, 4) is safe on Bluetooth:
  hidp_get_raw_report() copies min(skb->len, count) rather than failing
  on a size mismatch.

Two things I would raise, neither a blocker:

1. hidinput_setup_battery() only receives the field, so bat->report_offset
   is the offset of usage 0. hid_input_field() extracts usage n at
   report_offset + n * report_size, so a device that declares the state of
   charge as a non-first usage of a multi-usage field would still read the
   wrong byte. Not the case on either of our trackpads -- above, the
   capacity is the only usage in its field -- but the flags field right
   next to it is Size(1) x Count(3), so multi-usage fields are entirely
   normal in this same descriptor. hidinput_configure_usage() already has
   usage_index, and the feature-report loop has its index too, so storing
   field->report_offset + usage_index * field->report_size would close
   that without much churn. That said, I would not want to load scope onto
   a fix that is already correct for every device we know of and is headed
   for stable -- if you would rather keep this one minimal, I am happy to
   send that refinement as a follow-up on top of yours instead.

2. offset/8 plus a single-byte read assumes report_size == 8 and a
   byte-aligned offset. True here and true of the old hardcoded buf[1],
   so this is not a regression, but a device with a 16-bit or bit-packed
   capacity would read garbage silently. A guard that falls back rather
   than mis-reading might be worth it.

One observation that supports your "permanently 3%" case: the STATUS
branch of hidinput_get_battery_property() does not just query, it also
writes the queried value into bat->capacity and sets HID_BATTERY_QUERIED.
So on a power supply that nothing ever reports, the flags byte is cached
and stays, rather than being re-read as a transient. That is consistent
with the second supply on your 0324 sitting at 3% indefinitely.

For what it is worth on the duplicate-power-supply side: my 0265 over
Bluetooth declares AbsoluteStateOfCharge only in report 0x90 and gets a
single power supply, so the duplicate pair looks specific to the 0324
descriptor rather than common to Magic Trackpad 2.

Reviewed-by: Alec Hall <signshop.alec@gmail.com>

I have not built a patched hid.ko, so no Tested-by from me -- the above is
the unpatched behaviour plus a code read. Happy to test a v3 here over
both USB and Bluetooth if that is useful.
