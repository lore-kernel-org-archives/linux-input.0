Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B9392C34
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698210; cv=none; b=Sso5cTmf5w/cy2uI8C83Zt8lHutL5r0JstvmFG7Nr84OonIlQzFZSuOm+pXIKW/INWjLOLjifZl08BbtqRwEpfM7Mm7Y/B+d41y5lduC+3qcOjHOrMxzZtqCJozsjuIvrq6mJkWpumxUG9vf71IWSFkBDye6XY4zUp7MDV0kyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698210; c=relaxed/simple;
	bh=RFEf8IYq4v+ikaPaoUXCrhjTWoc7Z5CIERRm46tiiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CLYvnyWeKirkCJgoEIQlrrVKrBu2rJJFhxrOJt+wxoVcf5YVp4ixGPGrgM57kmx09Gh2ctQaGz7xAZL7rHXols0L3l1wihMnadhhzRY90YLSg1BNtK8/x9unQjCvjF+j1OPQkCXwMEjwe4ya/koNYssMxy6UaTuoopBIVgm7ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDVaN2W3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDVaN2W3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b9328c4aso42148715ad.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781698209; x=1782303009; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tpzzfxLfZW1PyEdQDh4T1jXcK7z7dtTYUe2xpOZsGM=;
        b=KDVaN2W30SJVeTyvPsnrPFQnBjsbOSkXIPYMhMQGyK2WM9N7MAEEJY1R8oYp6O+0ou
         QW6xJGuQgjpBIzEDAu0Ln3fo+QOPGgjr0x0AeuwwzTmQdZ1UZGULmpTgbR+mQ6MiDHSd
         mzLCa4tUTJk9QPP1nObgVNwldz8X4z0MMiWcwIci08A9JwWnP/OKnuiHyzGFVg4ZSKrM
         t7jAMh5i2uO9tqolCQj3Yp46IiV2xG/jUSym9eOq+tjSSatjPMsgJDGeMf3etVho33Qr
         lGWgng18ksfNVcxXkkkAshioZOEnCKgvSRm4z3kd0E0xw/FlFWzHj2R4QWKzxK0hLr1G
         Vo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781698209; x=1782303009;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tpzzfxLfZW1PyEdQDh4T1jXcK7z7dtTYUe2xpOZsGM=;
        b=s3Wi85k+cdncLbJORRuZIeZgGy0QnPruEWViP8PeLifJo1cbn1cKFmCsoumxvGNfeH
         hTsgFk1gbV+FfKzs1BqLCv57aG6hWzXaXhermGdiyjvXYPCVuIsXPXlPvdK9elfeJgFz
         ufgYb7ddxCXjKpUpS/Jr1Ggmxf+fDX5W/tJz/jQoCS62EjZ6PX/i/ss+ilI+QlXZV+FR
         9th+wkIG8i0dwh94BtVJMl++epm0Cts8qO/ekW/mF/AnzNQ88MVKp0LU/X0jHGBMiZDm
         blkQCTa1xI6wABcNwSGfpoLvgO+awgMgKFadPVxqbr7JLPhcA2A/Ob8Gu7GvryJl0Blf
         nnLg==
X-Gm-Message-State: AOJu0Yyy+UYlp2CrlJqL+VhjJG6kEX9tE6XbImlIszjAJ3v/TXP0m4XR
	F27t64cTg304CQKOOiuIC58gEdBMOap6XiM9+lA2CfFy/4WAHBwr+Ng1
X-Gm-Gg: AfdE7cksxP7DhWcW2L9G5GG3dVlV74+qSLG5mgjrss2nMH9RZZ/TE6IXjQlNUkK1EZn
	jrZbIo8xNm77A+KMMDtllGttjGn3xY2nsZ6zQn55yipVnRlP25RzCeFXnNmE9v5KcrNo99eqUdw
	0PNO1JmURCiH6mqTJfbLuUsDg1AN++5/EJpUbYWhZ/07VoP0nWBFQQRipcS3JSNaWW+3bkYY57g
	aAVKKBSd308fQ5bBFzmuNY5lsDAwryu94uAEsqpGbkjvbJUcYoEc8H170uEkH7JewG7w+DB/Rt+
	m60E9PxMJ0tw6o0OTIAO/VPYaSByypTjg2q3q4imokdMu/YwUxIsBi/hYFX52Y2l8w1CxSfskRR
	n/+dh0jFHlg3VAzSQ5ti/Q/QBW+hGH73SpT5Ex0QUChaJf1mgGO4i3Ilx7AmbCV2R0ERXZxmhav
	Kr0chFguB/VHpIdWd3kdrCveqaYj6omNsdYAtqBQ==
X-Received: by 2002:a17:902:ce88:b0:2bf:23c3:34ba with SMTP id d9443c01a7336-2c6bc23126emr32885275ad.28.1781698208468;
        Wed, 17 Jun 2026 05:10:08 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a1878426sm46884895ad.64.2026.06.17.05.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:10:07 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Hans de Goede <hansg@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: hid-lg-g15: possible use-after-free of devm data via work scheduled
 from a report
Date: Wed, 17 Jun 2026 20:10:05 +0800
Message-ID: <178169820506.2930960.12219303668828186338@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I think the lg-g15 driver can read freed memory on disconnect. I would
appreciate it if you could check my reading before I send a patch.

The per device state is allocated with devm in lg_g15_probe().

	g15 = devm_kzalloc(&hdev->dev, sizeof(*g15), GFP_KERNEL);

That struct contains a work item, and the report handlers schedule it
straight from device input. For example in lg_g15_event().

	/* Backlight cycle button pressed? */
	if (data[1] & 0x80)
		schedule_work(&g15->work);

The same schedule_work(&g15->work) call also runs in lg_g15_v2_event() and
lg_g510_leds_event(). The worker lg_g15_leds_changed_work() does a
container_of() back to g15 and dereferences g15->mutex and g15->leds.

The driver has a probe but no remove callback, and there is no
cancel_work_sync() anywhere in the file. So if a report schedules the work
and the keyboard is then removed, devm frees g15 while the work is still
pending or running, and the worker touches the freed object.

The attacker model is a Logitech G15 class keyboard that sends one report
with the backlight cycle bit set and then disconnects. That can be a
malicious device or an unlucky unplug.

I reproduced the freed while pending pattern under KASAN on 7.1-rc7. The
workqueue picked up the orphaned work after the object was freed, and KASAN
reported a slab-use-after-free read.

The fix I tried is a small remove callback that cancels the work before the
devm teardown frees g15.

	static void lg_g15_remove(struct hid_device *hdev)
	{
		struct lg_g15_data *g15 = hid_get_drvdata(hdev);

		if (g15)
			cancel_work_sync(&g15->work);

		hid_hw_stop(hdev);
	}

and wiring it up with .remove = lg_g15_remove. The g15 NULL guard mirrors the
existing check in lg_g15_raw_event().

Does this look like a real issue to you, and is the remove plus
cancel_work_sync the approach you would want? If so I am happy to send a
proper patch with a Fixes tag against 97b741aba918.

Thanks,
Maoyi
https://maoyixie.com/
