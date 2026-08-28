Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC253F787B
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910588; cv=none; b=WKQSc01rBvgYxTuBqDy7cBwZAymVE8oMCXqtQwJ2AF8+Wv5QC5ZHElBvdEIrK/o+iAxwajjoxXrOdUEdoz+BHvt9UDQuYCYNWrldt+44A/IEm5Dtu0VD1UYIQPegb929e6Ia7adbybv7kEh9szF8/Gf3NGaE6lm2xs5MZw3Hv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910588; c=relaxed/simple;
	bh=UfX/VZAbb9MiaHqAuge1t7Yg3AdH2rRALezQYvqgGbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R8bTI+votbPX6Qi2qzjuN5rnhLy0OsR/7hq2bw145thV6pL0RDgMcRmPRwUlebxA8bc1oLr9Cl+Y+pR0HPZlZeO8qxayOTqC8lX+Vh68fnRs5wBps/TWqttX5DP50Z8V84j+jegqhIcMiauHQp57W56F1kyhy0APsrETpTsKV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RnW71Wsj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fJvLpzU5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RnW71Wsj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJvLpzU5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66TvA2761908
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 09:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xjhWodfBwaGvCcHRv1IRif
	J/k8PHq34//wXyMh5PdiY=; b=RnW71Wsjph/wz7kVvccyKAfrRXWLtbolWqva9D
	os5PnV4btuHe+cNpddNj5RuooEvSDRosNquV4ZJMqQVUOuMRKIIO1FEBoYxeqvoJ
	XrcepNnYxl1ZBdAYSJ5VhxDzpxf475VY3AKsPLWf36vN9LnFpzwfU8xYY8HW3z9i
	jlyxYe3807Q0VBSM4y6ycqemD291+YUSOyLz93Bik31krcHrJUZpmzIf8puN+Jd9
	WOrTvL+5AUX7Li9ajv8qjnEVwC6pVUe58xO6OfzxKgcUxeNZl7+VhANmh1dMyPRs
	9eqOcvDJu/QCxp6oHnTrd3lrCUxYkKUajlHw22U/jnDT/TUg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p90md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 09:49:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so1112924a12.3
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787910575; x=1788515375; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xjhWodfBwaGvCcHRv1IRifJ/k8PHq34//wXyMh5PdiY=;
        b=fJvLpzU5htFPpfbJZogJZcGC3znLiasAKPYOeXriCilK77XCcb0BLbl5CQaIi8D9vI
         6E0qwyFysz9WgiUBzv8D4gEIXiaCMHRCTwDvYQz99erF/SXzI28W6v/ZXYOdl7YHnRHh
         d4Q/+Oa9B3O+a3LXhDODGZ1ryKFmTUTOLQl7VhsDEoSegpt+SoGsnhahM5XcszqG6CTg
         WWZh2JlrzQrInCw7dupzydsFHesDgL3XpiSIXc054dON6hjaKrGE5+ijorjK+mtj5SwO
         YJdy3+bXfxpGf7qLNwml+xtG+VN9QOo2XSWKYqnW26WQyvit26hrZYo+XExxXkSSTNzy
         knRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910575; x=1788515375;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xjhWodfBwaGvCcHRv1IRifJ/k8PHq34//wXyMh5PdiY=;
        b=Vh7lbIv5/XCR75cT69o/OUuvm6Yz465Xrhjvd1mjA4HrgT9AO4LyXb8jfbFQ6SEkrC
         3+kUYCzb1sY7Oyd5vsBCfQoa+Z7x33lvLqEkWcO+9DJLaWKHKQT+5dWaxr9cJbnwKVRr
         4MtDElku0rTq6vDN3AyjMiH4nycDfe3S/+9hTMZMcu7VHRScLTSKEKY5YFp3ubdas3T1
         LjXvqcMga+mQ0S+y0x5CMymdP9g/Z2zeWAnAEAdumFKYmsDmhmtp77w6DOnq5m5OyU7z
         OP73fHAYGE/oJ8tDI2E8b6rdNRWMWo+bEfaLEneJKC/03OT9kKrRRpox9DPs72dXZleH
         exoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5mqrX0tosx8TfLmo6lPBfT8FM2vEUVMqOxtreDiblNUlzayN0IyoM9aHuspiQJ3mQvxNklHR1uCcXmw==@vger.kernel.org
X-Gm-Message-State: AFuF++mZF9b6ypHg0SQ50Oe9bcG/AUQp9YetCGPoVRd+FqT8LVcGYU/B
	uNzi/lJuww+l4FiR24CrvWvqyGd40kpFbpgZWU/A7cHOM4C7qBlgO4i4jB7Pm4rB2r1DbzHtbGs
	vOTZzOHYjebpBoaHxv9JdPewaM9SCVNe6UlL+REjMC0+lMoKvagYUH7uSnTbWDCiuBg==
X-Gm-Gg: AR+sD13q7h48odqyki4jEeBZaXsgVhsYcEnG9gDk9jVr4JP4tXr9l3RV80hfXLF05M2
	iGwe1RLFFVHw24cOAUEDofddbqsjYuDf5Vz3WFARex5GAerSj6+uSPvhkRxDWGjmDMOZENvrOWS
	Qu/kwBtWTNqdfMuNet0OfZGyeHj7CROeIj97M8KgcRodlHWubsOaO856nMi63QnnyJmdDnG8Xpi
	CIdmkdY5IxMWb0FTUBn3uGxq0ACms+y65+ZmMUsjXjZbCq5bHLIlNySHJ6CITlnvBivY4aPqr3W
	ws/K8NUX6yMihiQP/jIRCEFFOFdtvVkuKmjDo1h337G1iCSSbR44UlxkTpW1pejNxixuegKw0BF
	fgpA5RdQ+BnK6RJ3dSYip51KQkQP96cUycq6tHexmXnCCWLRIrY27
X-Received: by 2002:a05:6a21:3390:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3d2686a3386mr9620277637.10.1787910574620;
        Fri, 28 Aug 2026 02:49:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:3390:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3d2686a3386mr9620167637.10.1787910574020;
        Fri, 28 Aug 2026 02:49:34 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c57sm4851549eec.4.2026.08.28.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:49:33 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Subject: [PATCH v7 0/2] input: misc: Add an initial driver for haptics
 inside Qcom PMIH010x PMIC
Date: Fri, 28 Aug 2026 02:49:18 -0700
Message-Id: <20260828-qcom-spmi-haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ5ZkWoC/33QwW7DIAwG4FepOI8KDIGw095j2iGAWZCWJg1dt
 KnKu8/ppTmQXZB+hD/b3FnBOWNhr6c7m3HJJY8XCvblxELfXT6R50iZgQAjjDT8GsaBl2nIvO+
 mWw6FqxCcRetBATKqm2ZM+edhvn9Q7nO5jfPvo8Uit9v/tEVywSNo1AARjddvYynn63f3RU+HM
 x1sQxfYQaBrEBDknZQtGpEUqgNIPSErVQ1SBAWnpPc2eKfTAaT3kK1BeptIJBQYlWi1O4CaJ9S
 K6moNQdZKaNH7GCEeQGYPVT/bECRdChhiA6K62rquf29T7qomAgAA
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
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787910573; l=7897;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=UfX/VZAbb9MiaHqAuge1t7Yg3AdH2rRALezQYvqgGbA=;
 b=jrEP0VjomIgeeart8kpKLkcc51M67lQzus3E6hyYfd2SgdbkoIRgQ8mL/BOJY47cuH5220MbW
 sBYs0OuIxEmAIWCe07f0UWP0oc85/0pnQJbxgbuWYXf6U+LIYjieR5/
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-ORIG-GUID: At5C2SMtdi2M5gRNpBdxbddAixWp111u
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a9159af cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=wl7bymLZXRVIGl6rzDwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: At5C2SMtdi2M5gRNpBdxbddAixWp111u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MyBTYWx0ZWRfX6oYX7aXEVdwv
 Dozp6fxESTo8Fd+9WaW/5FFt0QgL1s37qsVvNH0nstqna7Dzh3lc0ByjWOA48jI4no4aGgVKuqN
 96tZ/cpAfynLH0YXanfD/709y1XiGZ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MyBTYWx0ZWRfX0SU5IMPMJdFz
 4on6pnbSi6iHjHikS4/SXrCBMrYVKFthaL7A6LIiKFd1YUEydlg3cYcw3BXA7SIc83uY6gUnQsB
 COB9nKHPQ+KcCNAFrNkU+8GN6+q39C+9GjZRYGojSFqm4eSXGguwV6eWOABARar3YI3JqGpVBjO
 1u2w8EBhqrhbwYFKPIpQQNwn07DCNUsPeDgxaLzKcQbygdMh0VF25rjN++2YW8ajAUaYkQSIFyQ
 OAaLKZripmBN81iMI8Wk70IhhXoDIktR1pEW/xGxXgbSyMixf/cj49U14f41ureKpg9vkf1YcBp
 ASZ14odh7+SGGcZsoeW8likykmZh0090DvwoC/z3RyGpahSLrXUNTunx3NyfBtTQmop+8r79ckN
 LptECJzx+5Dagwull7/iTvBvcePZ4u0PCBHa+kTNe28QAX9+VjIwTAVBr2kDGvI5zcWSwC7HQE3
 8svIImm/JsJspta8T4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280083

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
Changes in v7:
- In the binding change, add specific pmih0108 compatible in the parent node of
  the example for completeness. It doesn't change the schema itself so
  previous Reviewed-by is still retained.
- Remove checking "h->stop_timeline" agaist 0 value in haptics_stop_work()
  to ensure the stop when it's wrapped around to 0.
- Link to v6: https://patch.msgid.link/20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com

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

 .../bindings/input/qcom,spmi-haptics.yaml          |  139 +++
 drivers/input/misc/Kconfig                         |   11 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/qcom-spmi-haptics.c             | 1251 ++++++++++++++++++++
 4 files changed, 1402 insertions(+)
---
base-commit: 66725039f7090afe14c31bd259e2059a68f04023
change-id: 20260616-qcom-spmi-haptics-3cc97e7b232e

Best regards,
--  
Fenglin Wu <fenglin.wu@oss.qualcomm.com>

