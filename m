Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959213C108E
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910738; cv=none; b=jsscxZrwDCohJ5otbokLokiSuNNnXzKTwF5GUccNcvGXLQV1iSFN7xz1HaDcEdGU5ehYp2TA2wQZ+tubq2AKdQxQbmPoMQc64w9ai6gS09AZQNMujXUNrmH+G8mtcsdeYjRcIiOk7M+4osGrnVZjiVuAnDK8AUmHrDodlIgjDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910738; c=relaxed/simple;
	bh=jZMhu7HC7qnvFbvRiiWFvsm4kZOOXDYJi6RYjgHBRRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hDC8FWrjG2l1kcLC9m9GDaIYWjfzlQ8gKlIM/Yybvnw+ZUu549PTFIt9SgA7n/IsMQlNxhwCGgZYjN8jf0+1ZmxLpmB6WedjJYUpxzBZti/wwWpvo77LE8BOorgykr7/MnSF3cQRdiIvqMcybSWjbcdmwhJACTKghHyBKQa8hOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nL1gauho; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aajiIQVg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nL1gauho";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aajiIQVg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755ktuC1680446
	for <linux-input@vger.kernel.org>; Wed, 5 Aug 2026 06:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ky5pRYzAyzZLC3Y2k+cL2U
	ur+MhpUqYqiAULy69UrK0=; b=nL1gauhoh4N07mLr1PCFP5Y5JyuLIgOKdZnhnv
	lWX7jZxADHq7w832t+XYGiI+4I1/ujjwD385eGBdkZsZAE6a63DsjlNSXzhQepOf
	0Ya3M4xEdB8UaFVQSf3dxDgW1jP5hQAY7QJvuHX3w2cvFaq4l0IET6wkEWRCfZwo
	Zj/TYvFAM6jPZ9nnYKjccgI7ctLQLYVOzZ4OfoFAlmx0pyWNNry7Uf5pWejc4lF8
	rYXxxLoG+GFRklWo9B6ViYPpFflCvjIThcU0bJ6pnrPcnHPXuv4ZpjRDfRzVL4tU
	4syvMnRtLSpEvITopGFowxLiEiqq5aNTarei1YJGaosJXbpA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuk9u38j1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 06:18:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a67b16217so1027101b3a.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785910735; x=1786515535; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ky5pRYzAyzZLC3Y2k+cL2Uur+MhpUqYqiAULy69UrK0=;
        b=aajiIQVgfWtR4nJiBcF0Qag7qHTu6tn9QWU1JGODPONjLEfeBnqB7V62H0KrkSYYkU
         VY+KWMmDDre+G7nt0V0xwg75MU6QIfkdYXmV4dN9/8m1IUQUv/5nNz5oifVWVIMcbKP3
         zonOpErSom44JGr6aMMCaASuXUCmX7Wld/mHO29aH0ebWWu2qkbWnP02LeDVd70u2L7O
         r1WheJ0wiUbjIOtvT/LpZozcEtYGxMYXB1xo51RZEm13vzuX6cOXs6B8XD1MRkYyWjJ4
         qFHpFb083M9IiKxe6RjqIiDZ+5zIPHpIeZvAU42asfV8Fu9p7Rn+1vz8E4pyozpupXqZ
         r5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910735; x=1786515535;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ky5pRYzAyzZLC3Y2k+cL2Uur+MhpUqYqiAULy69UrK0=;
        b=dlDFql6DB0B5tg3uTwx3fMwbv74U2M1wS3QjHa+rQTt0OrrZC7vUJm8Ajz2mk5O+zp
         VVYkXCSTRmo6449O2qbofGhgwU5XzuiZ0f78pqdk9seX5/b7RX6kxjkcpGjqtNcqGH0e
         8RKv7mgF1AQgownQAqYpJ6jbGo9N6/pT7+C/yaWK3TvUbN7/+eVCH82BlWr3pOK28E8z
         PFJgUcvmVlvmqjZANlSiIawk67Z2T9sr6EcSRM23IeQ3d204PfVkFka446NoZ6wgSbs1
         6I/AIhRDvw5ByHJOI3v39sHv/MLWgK5dxLHtJca4aaJraNQd8dggAzxoiXhzWL8q2PU/
         duJQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKjRolBjnE01uCZP0I0lEglEHsM2Q1iGXUAgOtzw6+ZLJaU+wRpqFhaYm3O73fcOITWsgD1UZrvlANHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEBCCPsI9XKCs8HFI/Qc7kXVsrugPBaYuDokvcHPLHynKq5Se
	n78PXhKjFllAnNj/oIC65IdPxgFIw/BJBejonx/hPZ/8DEmPHR9O2lsC6MAhK6BZ9EYmk5c9Ncf
	zCJVPGG/0trZgDj81WQ1fLXge43F1nq0Uqeabw2NNp3sJxjDV7OkxDy7GBhvloUtdSQ==
X-Gm-Gg: AR+sD111JoR0pSty0h4TzmGkTDctR3U4a5NIlXBPNOGtq03YzjfY2bWbtb47Yw6i4C/
	D0eHMm5Aycm/arBU7Tp3CxydX/t2oIuDhgeCDKQSDJ6UWDoamO0vYFnOlAcIwzAMCgie5z3CM74
	rLz41jx4qLLY6ZnyXCJVyQULtxeKVFncBCMEjfxYHWKWUjk62BgA9ziemT1VL0TCKB8ObYSyzri
	rQfiE1gUQkhQ3FIIIA65Ut2A3FVvPkZjnIw/BBtH9Zu6np6B7HKZ4VIy65+bDwIfJ2/A2HP+HZz
	GQYYziyzGDJJJy2bl3yI2ovG9uoZRQfwrtrnHzDMc5c9SC1Gs1MXpzH9e1f0T/ixoAlEr0vJmag
	wdLti+dGnFM2+X1I62kqYJZbgoj/RywYyTDldLdDgJf0006S09oot
X-Received: by 2002:a05:6a00:1388:b0:845:dbdc:8652 with SMTP id d2e1a72fcca58-84f2e014143mr4720370b3a.2.1785910735185;
        Tue, 04 Aug 2026 23:18:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:1388:b0:845:dbdc:8652 with SMTP id d2e1a72fcca58-84f2e014143mr4720318b3a.2.1785910734690;
        Tue, 04 Aug 2026 23:18:54 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e30d660sm487801b3a.25.2026.08.04.23.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:18:54 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v5 0/3] input: misc: Add an initial driver for haptics
 inside Qcom PMIH010x PMIC
Date: Tue, 04 Aug 2026 23:18:11 -0700
Message-Id: <20260804-qcom-spmi-haptics-v5-0-77128ebbdd2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKPVcmoC/33OzQ7CIAwH8FdZOIuBFmF48j2Mh8E6R+I+HLpoz
 N5d5kUPm5cm/6b9tS8WaQgU2T57sYHGEEPXprDbZMzXRXsmHsqUGQjQQkvNr75reOybwOuivwU
 fOXpvDRkHCMTSXj9QFR4f83hKuQ7x1g3Pz4lRzt1/2ii54CUoUgAlaacOXYzb6724pNFmmwqb0
 RF+IFBLECTIWSlz0qJCwhUIv5CRuARhgrxF6ZzxzqpqBVK/kFmC1PyRqEhQiSJXdgGapukNQ4e
 kW5QBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785910733; l=6457;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=jZMhu7HC7qnvFbvRiiWFvsm4kZOOXDYJi6RYjgHBRRI=;
 b=4uaqNu0AaD/QrDusJHe9HOxaORAo5dQUK0aDTDkrFejaorSEIGPxHky2B5Dv9wUT9rwzmSZyo
 c1iUeDLJvRNDrNS+2seFBSRN3AsgjUMjwk539pCir/bhqjRCdVM6ntD
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=NInlPU6g c=1 sm=1 tr=0 ts=6a72d5cf cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=EEybSPFH-ufmgaaxbUgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: vVA6R6smihdGrxGfS6Uf2RKOMFPY_4__
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfX16XWie+/C5Bl
 alimIyo9MdYl4bRYSTyfJ74DwE6TkmQgTlz5RBDKVW1wWIXSU6ZVFF7/Hvc5t2ogyO2RLxsdMQt
 yHHoMNNdolHgFfHel6rhGyKGxlvJz3E=
X-Proofpoint-ORIG-GUID: vVA6R6smihdGrxGfS6Uf2RKOMFPY_4__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfX0JQK/UOzGhhP
 c90XmGBZSED2nOtfBB/np2HMKfcKjG174YJyDl/Q4qZLtZqJbr2S/aYaU3HN6A8Z1OMiz0Qi3d5
 7aZ93SBIHtADDWCaWu1HndPV/qtnCzfupIEUnNinzEvolTVuNLyemU6ResiOo/BcWsQ598op7H9
 QsVGyFnh1UfT+nb/EvQaFwAOy8NAE5wh9uW3G+1ThWuQvRW77JfrqpWtc4C6GhaROzsKR39zDkB
 6KUWmoE6RzY8Gq1mvezA2Ro3T9F4NAuX+ePTF3pC1/weqR9rgZM5ue3S7S0quV5Z4cEg/SwsjSX
 PJwEfDi87f9UDSoyZIypU+k1ulHRtQPUEl7DtHc8ZDOuCuNZOTO8LXI9DQMkuTMt6/oSpx3c4Vz
 7PdZBtXXe1rcBgb4mE9aU2EMtAPwBSvQQTK3uNEDSASGjA6skYIn8hfaspRRcOjw+0trWw/WSjt
 gp7jFC3eiHbVFElBh+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050047

Dependencies:
 - [patch 2/3] depends on [patch 1/3] and it should be applied after [patch 1/3]

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
Fenglin Wu (3):
      dt-bindings: input: Add Qualcomm SPMI PMIC haptics
      dt-bindings: mfd: qcom,spmi-pmic: Document haptics device
      input: misc: Add Qualcomm SPMI PMIC haptics driver

 .../bindings/input/qcom,spmi-haptics.yaml          |  136 +++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    4 +
 drivers/input/misc/Kconfig                         |   11 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/qcom-spmi-haptics.c             | 1231 ++++++++++++++++++++
 5 files changed, 1383 insertions(+)
---
base-commit: 66725039f7090afe14c31bd259e2059a68f04023
change-id: 20260616-qcom-spmi-haptics-3cc97e7b232e

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

