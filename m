Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7633449B0D
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083714; cv=none; b=SPXVMfpdsA7jNLL7lzPJBGPeLgMGK+pLlkCyviQ0ICV4qCxuqLA/01is4zSigsZsTweIZKQZRV7IGbYyUHQdnVqIqlXGkJSRRRzso6mjPQ1U9mZ/xfx+Nvv2y8yMXkHGRJTcNdU1SdUAGfUHyiB6ij2WaahHJuVrXEoQVv8zD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083714; c=relaxed/simple;
	bh=R6AK7dQHatN/EGJBdvgFmvrcbFS4f0sk4D7CoXsPDr0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f7C0d/2ycy0xv3bZtJEOJRaOWBuTWR9aimtBpyMSCyErUnoGW6gG6Hi2VDNMufrlgpEUuADlj+TfSMZpG4VhSceXB0aCiOnGrWDKzkajwAjH7g3V/VQ51zeGvQMn0cwZ8M0tQ2TaaUE4Jo9IzJJHqSkheQYYT4dUEZJl7PrjGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GqK2D3/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bUIxXQnO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqK2D3/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bUIxXQnO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770GfBj3533333
	for <linux-input@vger.kernel.org>; Fri, 7 Aug 2026 06:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MbjI3enVhu9e1mM/DRlJHe
	uCjBiCSKcE83GyUKU52Xw=; b=GqK2D3/E4pM6QCKt56ja0Jp/wMOsL5plFYMmkx
	XePDSbOz+PrOPTU2DoWWItdsR4IhpzNwmUXNPIexq0SLm/VMO6Wci1xRHfIIuSgQ
	oRhRu7Qq0ocDmYdVPRCz6zcDLrREnAnJuC0AUq+/ezcg2zV34vKS6d/y39aKpSmi
	CH0Q3ysmP3zfVyT6KDG+5OENJBxfAcMdw7/Ow91bExp0OGVFKgyVW+m+/xkGKqFB
	nAgBQVix4b+1nGep8Edhc8N+am411ryTST0EO04fSS0lu02SlKyTUwCtFBOKHOxx
	i6IsCIKUtH3NaUqjE/9MDotnmUFMqPDOQ3mqKzmlkkYXUVlg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6ftmdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 07 Aug 2026 06:21:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so37410445ad.3
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786083710; x=1786688510; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MbjI3enVhu9e1mM/DRlJHeuCjBiCSKcE83GyUKU52Xw=;
        b=bUIxXQnOnVEL9SyBQi0iKTtHLZVEOUfm0TR8DKUT6o36H0oR/gmSkdagtrxnr3mjoH
         mYjywJ7V90Yf2y03jQcAmFb8xa0hRyaH3YuvlANRpqLtSSoQ7T3+uaKdqSpglkYN04eS
         1yXTgz36OVmoRzyjwM4+ssUYzR9tbZciLVa+XPscu7oiKUtJaPkAj9pgnz1zQnNa0Ixy
         X2c0XvG+sZCvEgLOA1gzsRcHE91oNJfX6i3CyGBlqR2phd9RJxS0sBcu7vTBftdSbkOb
         0oc1a8u1c8pyJl1Fb38zeZKa/B5L7EwgfCGg2lfwwNLLh/kjtIusDI2/7AfKBbShr3Lr
         525Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083710; x=1786688510;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MbjI3enVhu9e1mM/DRlJHeuCjBiCSKcE83GyUKU52Xw=;
        b=haIrRXAwpGNuw7+ZtaAtekZlVG5xKOEN7J5QzimoZAHoXSDj+N6LkFG3Pn1E68PUg0
         MTuTA/gDNkuPSoO4CcRAy9Pi+zNsQyIJnuSQCLKDYwMWce00KQZPrnTZq6/3rgmtj5g5
         7FddtwaRSnrEVSVj86Ga1dmhwKQgei1mL0GIHSboubsguOhXUOGHkko9m96esgaRsumv
         8koAez9C0INEKeH5X/Ut8SISQdj+sTLEn4prdIvS0Hl1Vnr6sLi5SOuVORLFvW/ZhAc+
         gcKvImDb3RcI0OR8x827KQFouoyQ0fC9z7XZMt5dAG5XRm4/PPJQ2YG/FAp1khIXLzA1
         3Mhg==
X-Forwarded-Encrypted: i=1; AHgh+RqDcXZjCJh9fPRckjphYuxAY6UfmNo5wfk4hG2DihgE0ly11f2VUtj9FRvqfEzFe3wQe9PCRw9jQUMYgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ49oeOPgd4ehzizcVfJwbq+426NzPxqCf1ufvaVIUPggFZv4X
	a2FpCfefQdb5U0qd2WDbM3Jhf0WGm+AJxSC2Ueoy0frtD+QpoBKMcujwNjvmcnhJ21W8CrLrZTV
	wYB2dsxBf0KxMWi4QApXyJyqsFT6KEe+2ivqlbG/1zU8bkx8Nhqg2qJyewPq8X4aXNw==
X-Gm-Gg: AR+sD13Ehdh9xnYZLJSTiHG2Ll9zhMoH7JyUOunzmzES8iAvI5Gt80k6bnlBk9eCmpQ
	UppcLKRsoWkwwhvjXe4tMPYyA7z5ew0fObpO3mbELJh9UlaNQHOThS48HO8UqxEAutR6IqF4/s2
	LSC1XtGltQj24orwm24hu7J5uwnHdJE24U4Yzj3VA7rthMgMFdFtbugl050J9RHyj07yfsn5HW7
	QJAy5ugYh7TzMU+mW/aPX5ogKyKn+g/eYbMKWBvD7QK5tvETfm9ULTQC7brydNdckUtSjRc2mEJ
	3R36onBOf2wpA+9JTv5QCGjgEgZGJ6WYvJscUNfn3c2qNwV//Bk/IjMhi5i/9aUT9SFx2dr108A
	1VWWMtVzp2eQoBovwFayOicGxVrht72lWljOnsGKeLy/+Itd/BS1F
X-Received: by 2002:a17:90a:d443:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-3903c594637mr23020152a91.10.1786083710374;
        Thu, 06 Aug 2026 23:21:50 -0700 (PDT)
X-Received: by 2002:a17:90a:d443:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-3903c594637mr23020105a91.10.1786083709823;
        Thu, 06 Aug 2026 23:21:49 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24552sm1047301a91.10.2026.08.06.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:21:49 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v6 0/2] input: misc: Add an initial driver for haptics
 inside Qcom PMIH010x PMIC
Date: Thu, 06 Aug 2026 23:21:39 -0700
Message-Id: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHN5dWoC/33PwW7DIAwG4FepOI8KbAphp73HtEMAZ0FamjR00
 aYq7z6nl/ZAdrH0I/szvolCc6YiXg83MdOSSx7PHOzLQcS+PX+SzImzAAVWWW3lJY6DLNOQZd9
 O1xyLxBi9IxcAgQTPTTN1+eduvn9w7nO5jvPvfcWit9f/tEVLJRMYMgCJbDBvYynHy3f7xa3Dk
 YvY0AWeIDA1CBgKXuuGrOqQcAfCB+Q01iBkKHrUIbgYvOl2IPMMuRpkth+pjhQlVI3xO9DpATW
 qetqJIec0NBRCSpAq0Lquf1kbbnPdAQAA
X-Change-ID: 20260616-qcom-spmi-haptics-3cc97e7b232e
To: linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786083708; l=7359;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=R6AK7dQHatN/EGJBdvgFmvrcbFS4f0sk4D7CoXsPDr0=;
 b=gUmJKYT03Po1Z+pl1CGOOqldJApwik5FYtpUAVv3i4D+5LzHYQPfOxlfaVDDerUQva1DJ9WsN
 nh8xtl4OdleANZjcEDp/VYhE3b2k5LpCuz3SP9GNFrNS5uOaVzQoG8J
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA0NSBTYWx0ZWRfXzwdQKsnUUp+x
 CrtElHDBbAFLmS/DOO1/OWThElJA+9afIJqlc69CaXnxnnEgL+TUXxcrlVnQmMT/S621VfeSzWB
 rBuZ0k4dsj0HsY4nNFhNbmMru2gEeYvj3pPHfn46qNL5bp9CiBcRkgAHoWp0JK+G96oeCs0BLkL
 W1nKGSKo5gRLkwyY+MRnuoLKJKEmBScF1L6CI97EgvZ+ZNfS+4PYB+4/1C0wMoD4oIN/OItPTL6
 syHyl/FKeNEvun+8OIaY+/1qHEZ1A3Sd0wWKfitg0lFpkJf5yH1Q4AUcZTn/5yhsuCA2sVd0tPP
 aMrAoIMTfVa/fcdBMtVjUQHtLRbpEJ8pHF6s83aYflr692qWFci53Uqq6J9ti/3Q6ibmo+OCfi/
 N3aDE2etJAONIcQogVqgp4v+3cK2MA6n50UzQIyT9VxfQ4yzuAquhLRVRIXBzNE2AOoJ7cuOjiz
 oApT8p9eap7hLEyDjdA==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a75797f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=wqtGLH9dRC1TDm73MfMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: _fYRpmeyrr2t1Dp7IhjCS0nLC04r9o0f
X-Proofpoint-GUID: _fYRpmeyrr2t1Dp7IhjCS0nLC04r9o0f
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA0NSBTYWx0ZWRfX/eiWsi6heR2F
 0NcGrZl9wdeF5Yd78KTzRnGMmw80IjH93j5ewXOwAz4CampFmifShxMJAUl4o9Gm+3458loVb72
 Yc1aXS6criTlYTRkwcJDBfPYCrG/GL4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070045

Qualcomm PMIH0108 PMIC has a haptics module inside and it could drive
a LRA actuator with several play modes, including: DIRECT_PLAY, FIFO,
PAT_MEM, SWR, etc. Add an initial driver to support two of the play
modes using the input force-feedback framework:

-- FF_CONSTANT effect for DIRECT_PLAY mode which drives sinusoidual
  waveforms with fixed period and amplitude, which would generate
  a constant vibration effect on the LRA actuator.

-- FF_PERIODIC effect with FF_CUSTOM for FIFO streaming mode, which
  can play an arbitrary waveform composed of a sequence of 8-bit
  samples at a configurable play rate.

Also, add the device node in the existing pmih0108 dtsi files, and enble
the haptics device for several boards by updating the vmax and
lra-period sttings according to the LRA components that mounted on each
of them.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Changes in v6:
Drop patch [2/3] as it has been applied in
  https://lore.kernel.org/linux-input/178602255123.2917765.7426706813083510078.b4-ty@b4/

Fixed Sashiko review comments:
- Add FF_SINE waveform support since FF_RUMBLE would be converted to FF_PERIODIC
  effect with FF_SINE waveform, and it is required to be supported. Also, clamp the
  FIFO play length with replay.length, also document the limitation of supporting
  replay.delay, u.periodic.magnitude and the envelope
- Add a separate worker to handle timeout stop, which gives a clear
  way to distinguish timeout stop requests from actual play stop requests.
- Replace disable_delayed_work_sync() in close() to cancel_delayed_work_sync()
  as it caused an issue that the work would be disabled permanently.
- Move haptics_enable_module(h, false) into the reset action(). Calling it
  in close() would desynchronize the runtime PM state and could cause issues
  if a play is triggered after close() and before the auto suspend timer
  expires.
- Link to v5: https://patch.msgid.link/20260804-qcom-spmi-haptics-v5-0-77128ebbdd2d@oss.qualcomm.com

Changes in v5:
Fixed review comments from Dmitry:
- Change to use "err" for the "ret" which hold error code
- Remove "haptics_queue_pending(...)" functtion and inline it into the
  caller.
- In haptics_fifo_empty_irq() when writing FIFO chunk failed, instead of
  stop the plan immediately, just clear the FIFO threshold to mask the
  interrupt.
- Add "lockdep_assert_held(&h->play_lock)" for the helper functions
  which require to be called when the lock is held.
- Add "gain_work" to handle set_gain() immediately.
- Set input device bus_type to "BUS_HOST".
- Move the remove teardown to input device close()
- Link to v4: https://patch.msgid.link/20260717-qcom-spmi-haptics-v4-0-b0fe0ed30849@oss.qualcomm.com

Changes in v4:
Fixed Sashiko AI review comments in the driver:
- In haptics_start_fifo(), remove the goto and do the clear in the error
  paths directly, also add a comment to explain that disabling the IRQ
  synchronously won't cause a deadlock.
- When data refilling failed in IRQ handler, stop the play and disable
  the IRQ to avoid the potential IRQ storming issue
- in play_work(), check if the effect_id in the request is the one which
  under playing before stopping the play.
- Link to v3: https://patch.msgid.link/20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com

Also, add trailers in the binding changes.

Changes in v3:

In the binding:
- Removed the ref for qcom,vmax-microvolt as the property with standard
  unit already has a ref in dtschema
- Added 'qcom,pmih0108-haptics' as a device-specific compatible

In the driver, fixed Sashiko AI review comments with below changes:
- Added a list to queue and serialize all of the request, which helps to
  avoid the races between playback(), which is protected by evdev's event_lock,
  and play_work(), which is protected by play_lock.
- Changed to use guard(mutex) or scoped_guard(mutex, ) for cleaner mutex logic
  usages, and update protection section to prevent race conditions.
- Added runtime pm control in haptics_stop() function, use it as an unified interface
  under the guard of 'play_lock' in play_work()/erase()/remove()/suspend(),
  to ensure the runtime pm control correctness in race conditions.
- Removed unnecessary stop play sequence in fifo_empty_irq() as the HW would
  automatically stop after the FIFO samples are played out.
- Added a common interface haptics_clear_effect() to clear the FIFO data with gaurd
  of 'fifo_lock', and use it before upload() and in erase() to prevent race
  condition.
- used __free() for safe memory cleanup
- Checked play_rate against negative value when loading FF_PERIOD effect
- Limited the custom_data length to 48K prevent potential OOM

- Link to v2: https://patch.msgid.link/20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com

Changes in v2:

Dropped dtsi change and I will resend them after the driver and binding changes get accepted.

Updated haptics binding and addressed review comments from Krzysztof and Konrad:
- Extended the description to clarify the 'PAT_MEM' mode (not yet supported in the driver)
  by comparing it with the 'FIFO' mode.
- Updated the compatible string to 'qcom,spmi-haptics' to match the file name and removed
  the PMIC wildcard.
- Simplified register names to 'cfg' and 'ptn'.
- Corrected the unit naming for the 'qcom,vmax-microvolt' property.
- Added an additional clarification for the 'qcom,lra-period-us' property.

Updated the driver to address review comments from Konrad and Julian:
- In haptics_write_fifo_chunk(), separated variable declaration and assignment, and added
  comments explaining the 4-byte and 1-byte FIFO writes.
- Replaced manual 'x * n / d' calculations with mult_frac().
- Switched to disable_irq() to prevent late IRQs after device removal.
- Replaced property reads with device_property_read_u32().
- Remove the 'INPUT' dependency in Kconfig

Updated the driver to address feedback from Sashiko AI:
- Guarded pm_runtime_resume()/suspend() with 'pm_ref_held' to prevent runtime PM reference leaks.
- Replaced spinlock with a mutex to protect FIFO data during playback and avoid calling
  sleepable regmap APIs under spinlock.
- Adjusted suspend/remove() sequence to stop playback before canceling work, and freed
  FIFO buffers to prevent potential memory leaks.
- In FF_PERIODIC handling, allocated 'fifo_data' before assigning data to ensure its
  consistency with 'data_len'.
- Registered the input device after enabling runtime PM.
- Unify to use 'h->dev' pointer in probe()

- Link to v1: https://patch.msgid.link/20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com

---
Fenglin Wu (2):
      dt-bindings: input: Add Qualcomm SPMI PMIC haptics
      input: misc: Add Qualcomm SPMI PMIC haptics driver

 .../bindings/input/qcom,spmi-haptics.yaml          |  136 +++
 drivers/input/misc/Kconfig                         |   11 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/qcom-spmi-haptics.c             | 1252 ++++++++++++++++++++
 4 files changed, 1400 insertions(+)
---
base-commit: 66725039f7090afe14c31bd259e2059a68f04023
change-id: 20260616-qcom-spmi-haptics-3cc97e7b232e

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

