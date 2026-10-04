Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378E47208D
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138526; cv=pass; b=diKF4n7t5SLF9Vapdj4j2IPYnMmkakIf/yrOcH+Jh8SU2QtjdxqNKRbpkNVyJvZS1tAc+YzTyz2ealFAhELS1jioNlkdMUxVwCvDPm0nJhOBYX3+0sUoTTYnLVTAcb9fOff0lGvP3oB75iOxJFZDY9fFD3Rku4IgZ5+qBf8qVvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138526; c=relaxed/simple;
	bh=PxqfG3noaduioN/5mitkwhnMLpJEQJ7gOtF2dX/MVvE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rLYRg/zjcTW5X//vjxkNvnf9Gn1QQ7oFpwyoYhXdUS81utJew2yVs3z02XPqBsAhUZ4bqeRZCcafoXtxjExg+MdTzpFqJZVTSRkOicNh3qjzQVOm6V0hvvgaCO7vZq5lorvu7qtDWY4qQVLQoLEt2w2uRlrldA/RU4iAmSBoW/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdSmV9+q; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdSmV9+q"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a9bd4db6ccso1314101a12.0
        for <linux-input@vger.kernel.org>; Sun, 04 Oct 2026 11:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791138523; cv=none;
        d=google.com; s=arc-20260327;
        b=D6sKZjy/DTWfldW5lCnCyOlNpMbq9Lt8rW0cX6iWvddISEetELSEKkFGmVoJiL198o
         2OH+TwxkJV1C+avEi8H1tSw5/lUX489YLpu+IQy0b07cD8+97BVmEfADfaZgb0k1jbkB
         2T8khBHEztoB8jjncGjiVdOs6MzO8XONGn1HPXAjlRDe2pP7esIRQ1aJW2fYCTHbEO7h
         ++eQpVSWsUheOHKTAo5Dtluo3IPqdGBNVQ+OeQ6wh7hw3Yqh0M8GZ3iomcnmEf3/0smW
         l/gitoKM7O8CyelDj86blYqGTlvJwCuYcc+k9N06i5L+kmr6ddYqhmreXGCBZ8tSZM19
         xUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Z/qjIieeuv+RUMs2JiN8pEjWXIW5C5S+QNbM972WqYU=;
        fh=XN3IN7IFLqxBV+BC/SekM15S5ItBygoXovstbPrww3o=;
        b=KoaByBrWY7dapYiTXhZdj7GmuU4VyjRDn0Eww+bOYkQQw8zGfo9+FyhAgrQ/VFFeYV
         QjBZ9sXo5KznnOlhHy4hK14QKkGjGoqEJK4u2O7QpJdOLs0GwzrTPX172WDFt06LMvT/
         LCzJwJ2dBMCzzqb2NSfWTvyykI6kKKt7oiAH8CZa8QnSaMl5MmS3Bpog3sTdHu+FxLOo
         i56onAWzuCGcqCO5Q7wliRsj4oBJ1eyLHosvS0lJnjs+QhxDzSg0oMKMRXzDZKD5eQ8r
         st8JUIbSgZ4t6eJBaTGJm5WfKPKX3w+t3m7MQYJ0v67f8g+6taK4ephapMVhR3JuEUsU
         QneQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791138523; x=1791743323; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/qjIieeuv+RUMs2JiN8pEjWXIW5C5S+QNbM972WqYU=;
        b=ZdSmV9+qBrpVG/N2VFNcuORPBgCO5NliQ1iM8F204rzJj/VPVaIlgG+xMjJg6Z6EhM
         neEJQ6KdPjW7m7NuJy6iv64g3l3o4DiRPdNK7D5KNUeFkp3cO78gRyGb/ptI1UpMgK6P
         rc37cb+JxR0ta1y3cPxqaG7hMre9L6l9AtM+GItlWqrL2we7pYphByxeLS7/VsqtUrTq
         TMfRIim7ab5bmdv4vM30WroMMbR7M8oi8lmvaem/Ua9RBm+Rg6vTR3dGGHeDJNPW9/S/
         fd6QfO5peQZ7YCU6tH/TAb+0ZItjDdcbcLOGcTRi0jMrwXcqkzBm2EbRoiOQVhUG2IL3
         piNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138523; x=1791743323;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z/qjIieeuv+RUMs2JiN8pEjWXIW5C5S+QNbM972WqYU=;
        b=Ew8mhUm4r01hM1GDoYHEsrKdQi7jHLucEeqwJ6cqcdyyYD7yNpBQ+ORvh0/PRJdLj+
         VD0xcrTaLm0G1AOMEJmuYvjc1b7FLZMhYsmp1PN+mJUKW2wSKgln32+d8BQJ5adnlg0s
         86BQxtfcE2lWIHvpJnPDNd6H92lz3FSwAgM0nhVEYBHZL/+YFAPx7GcVghvzNPVAt7qY
         4OQyPXf0GFT6OZ03xq0MWae9evRvjVHyy/CedECqB4m/3nthEPoYWtKUJJ0qt0ZYpdDC
         cWJXshrhyFThXdwm90VmbWMx5++SCgM8sYmqX1viVMasPqSsC8yXqFVCsqZs5WTDrVEW
         uUDQ==
X-Gm-Message-State: AFq9FYK9FXPFCJNswgd/LPy9sLIUhpmkKduE1VSZt2XhdnDJIOqRm0ag
	96F1WXeBKV0eVzWof9IQ8Lj5gCllfbZKQTWb1JGuEISfoWYpnySlsBTaGVqOEXBhJJmLEjHihuC
	6aKXEjI6aqKnxfBB8Q69j+qjR0xfHivlsPL6nQT4=
X-Gm-Gg: AYBFou3F57gjnVPo5XYajiJj3hSz2WEsVLp1ezk5x4YfaNMfqSS5GaIIIcjyOjgMeB4
	QManHPDCTfKDqnO+DNwop/IG5CJSwcFqmf4BzZpGdFhiPm21NVhYrFloq2JeRRuHarOrGnAubg9
	nxB3Ti7SMufoUQXQtTeM3f9/1V2ByZAoP1Y4EOKnYVTDuPOkqThICO0XnNsaKHHP1ZAkL9w8btJ
	YXWEnF4pOsfsyY+LDg9CtDzYImpoM2wiAbaQ9Lk//Sbd7Bkf7lLFKu+vln6+0xs8nWw+rm/J5nJ
	MQepSagmLdDJvOvRYa9sEwzw32Kz4BoTId7XhjBEH1LoGWVtPFEZqQ==
X-Received: by 2002:a05:6402:401e:b0:6aa:9fef:641c with SMTP id
 4fb4d7f45d1cf-6afada0d18amr4944144a12.28.1791138523028; Sun, 04 Oct 2026
 11:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bob West <standardmetalindustries@gmail.com>
Date: Sun, 4 Oct 2026 14:28:30 -0400
X-Gm-Features: AclHuK-XPsJ1B0aCUrUTVKstMSbWA4kWLloNsA4kTbBpKpuFXri5iRU8fvv0G9g
Message-ID: <CAOA39XYkQJPtT-_9yKPQ5WXNeDujhKR+xStxcY-=0GS1mLNLvg@mail.gmail.com>
Subject: [BUG] HID: intel-thc-hid: quicki2c probe intermittently fails with
 -EBUSY ("THC PIO is still busy!") on Lunar Lake (Lenovo Yoga 9 2-in-1 14ILL10)
To: linux-input@vger.kernel.org
Cc: even.xu@intel.com, xinpeng.sun@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Even, Xinpeng,

On my Lenovo Yoga 9 2-in-1 14ILL10 (Lunar Lake), the touchscreen/pen
(Wacom 056A:53E6 behind THC 8086:a848) intermittently fails to come up
at boot. intel_quicki2c probe fails with -EBUSY, and touch stays dead
for the rest of that boot. It failed on 2 of my last 8 boots, with the
same kernel and BIOS on good and bad boots. A reboot usually fixes it.

Hardware / software:
  Machine:  LENOVO 83LC, Yoga 9 2-in-1 14ILL10
  BIOS:     Q9CN28WW (11/04/2025)
  Kernel:   7.2.5-3-omarchy (Arch-based, x86_64)
  THC:      00:10.0 Touch Host Controller #0 ID1 [8086:a848], subsys [17aa:380a]

Failing boot:
  intel_quicki2c 0000:00:10.0: THC interrupt already quiesce
  intel_quicki2c 0000:00:10.0: THC PIO is still busy!
  intel_quicki2c 0000:00:10.0: Read THC I2C SubIP register failed -16,
offset 108
  intel_quicki2c 0000:00:10.0: QuickI2C device init failed
  intel_quicki2c 0000:00:10.0: probe with driver intel_quicki2c failed
with error -16

Working boot:
  intel_quicki2c 0000:00:10.0: THC interrupt already quiesce
  intel_quicki2c 0000:00:10.0: Can't find wake GPIO resource
  input: quicki2c-hid 056A:53E6 Touchscreen as
/devices/pci0000:00/0000:00:10.0/...
  intel_quicki2c 0000:00:10.0: Invalid packet, len (255 vs 16) report
id (0 vs 11)
  wacom 0001:056A:53E6.xxxx: hidraw: <UNKNOWN> HID v0.02 Mouse
[quicki2c-hid 056A:53E6]
  input: Wacom quicki2c-hid 056A:53E6 Pen / Finger ...

Once it is in the failed state, nothing I tried from userspace recovers it.
Every attempt gives the same "PIO is still busy" error:
  - modprobe -r / modprobe intel_quicki2c (repeated)
  - PCI function reset via sysfs (reset_method is "acpi")
  - PCI remove + rescan of 0000:00:10.0
  - s2idle suspend/resume (rtcwake -m freeze) with d3cold_allowed=1 and
    power/control=auto. The device stayed in D0, so it never lost power.

So it looks like THC_SS_CIP is left set by firmware, or by an earlier
PIO that never completes, and nothing short of a reboot clears it.
Would it be safe for probe to clear or reset the PIO sequencer (or retry
after an _RST of the touch IC) when CIP is already set at init? I'm happy
to test patches or collect more debug output (register dumps, dynamic
debug, full dmesg) on request.

Thanks,
Bob West
