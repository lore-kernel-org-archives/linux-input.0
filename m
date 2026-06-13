Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5936A35B
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373088; cv=none; b=rIPgIHLu90NHTmrt5rBE0Om4+rlNo7aSNm51xTUSyIMunHVdCDqutrcekkQw/1/pTXHNqQuPYuVQPkiJDT4oIPLA8DdDVUI+4JB3RR4JOp0hPhdGesfAPcjti0MaD1pDOLCfY3/YiGUv3USPGz8ynA/Ka3PKyHb9qC0jXZhe5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373088; c=relaxed/simple;
	bh=6tSOvpqyz2Bc7r7T3aWZVCZeGYXnXoTGEVEMNOaYt1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1PbRezwTXRYu0fuR2TpZc+sJ8XAD+Tqs+ifmeowJh9VU4BLRLMBPQutpNdxZ7eAuEd36M1RBIg3hxGeL18ih04xNac7ctcwhzxXWNqnRNM4yT/8/cw3QfHwLUZxsjCCC57P96KOAPBKYXYJRAh4Uu1wgd3QFbQgpktvSnPEKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hITItcFa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hITItcFa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b7866869so19979155e9.2
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781373084; x=1781977884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DS1pnl+syxSzdT4GkVLB/Lh+dmf0MQETfuTiGJN6BZo=;
        b=hITItcFaFsy7khylrloA1jTrG6wimxBAmE+DpG4T5SwUeLvonGQIFC/Rp5cFjiony5
         5zNcHv7kYkNeFsrcoJb1ACCS4AiW/uNIEShnFs9ZAojVj0cqnxFJHU4iT9JggOQPMPZS
         OVNGwcwKHLC830AbLWhbBK4844F6i9SvVzYVjIKjbfROISwVN+Avn5wVLmCJMsR7iq+/
         1UXT0Z4oQNsC2p1RxyZj6Ph7n5RMvunBWibnN1zlev2IsxciseAP3l3n/RkRmM6OuInK
         o0YN6xUqbO1S2ThxkX2IHQQFPfhnWl+5LjWwFcT8/oeaj/iZNENtovvcmj77pPUCJHrf
         7BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781373084; x=1781977884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS1pnl+syxSzdT4GkVLB/Lh+dmf0MQETfuTiGJN6BZo=;
        b=a3nEqUBtxXsNoH38ujnQ/Ir7f5ClNSMcVPLBNwD2mSKw1PbMEdDlMlr7i3Q5kG3R80
         hmlTTxhr5QKJ1hi4yRBgeYP8Z7bCvVpJO4smy627IwX7B8ZZWnd6G8oFApvgCUxVdqIB
         1XT2qs+dXuwpeYjs3H941O9Xfh7Uz93OjJV2ELLAHrnAab4VDz815mW+yeWwxA7znGvk
         Ml0XbX6SvEFkbPSeIGx3ogdgVza5jAiGxZ0+F7/DfzHcFiVGazFQ6e/kou7N9rLymG7X
         wHbcdKzrbF0Q21BCp2JZ3bTxOrY6Kfhb3mqj7QyNa3remVSOmYs8dBd2Zl6oySOwUcuu
         WnPA==
X-Gm-Message-State: AOJu0YwSNUh707CEaAJn2iJF0XW4RuVnfcZe2LtVaG11SwkP235fnCgy
	EjBF1GRDaHcYInsN3b9DxlN1eNl5KAFkisjIV2NdSl1Xzow4wVp3CfJhn6ADnTw+1Xk=
X-Gm-Gg: Acq92OEiy+U5AULcf3pbqTnGcaD2qi3JzAErsyqXRd9TGxZadMsls5cz4m+zCVsyK+e
	nDOmCbalxtIIpoxzyea4PXkCPXpIeU2EKkm44zD937KWlkzY4qHcqTlFLaJ6drmh87FU0GegbB1
	lErW5AVMfLj01WEOJZlAIoWs2rdDSOsJ2kd/JNbMfHSE8j5b6RMBc4IhThajlJHsci6A/okVpNd
	C10c5AuikhOYaapOYW9xnyHVvIyi8YvQg4DFrEfFJ81r75e3cF07fnDBuTeVlUr3xn2uRY8E4qP
	YDumuwrrVRrZABKLjt+fWwErFIr5POaFCUM9fkVDK1Y7BNKkRfhOke0xEMQprgSM+zt7GrFsS2C
	I5bQcJgEyzM5ChM1GhoH8NVkDBGUjql9jNWRne8TOQaYvBhY3AkdWkmZHFH9XMv95qRReBynIeY
	lqfIPRFcHMdQRnSFN76LuF/cmMzQ==
X-Received: by 2002:a05:600c:4693:b0:490:d9d0:51c8 with SMTP id 5b1f17b1804b1-490ec504d3bmr117602015e9.18.1781373083930;
        Sat, 13 Jun 2026 10:51:23 -0700 (PDT)
Received: from localhost ([2602:61:7351:e600:a1d0:8426:3923:d48d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490ea9563b8sm113364665e9.2.2026.06.13.10.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 10:51:23 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH 0/2] HID: logitech-hidpp: fix Signature M650 side button timing
Date: Sat, 13 Jun 2026 10:51:07 -0700
Message-ID: <20260613175109.44365-1-edouglas7358@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Logitech Signature M650 over Bluetooth exposes its side buttons in the
normal mouse report, but the reported BTN_SIDE/BTN_EXTRA events are short
click-like events emitted around button release rather than physical
press/release events with the real hold duration. The device appears to reserve
the held side-button state for a built-in gesture mode: holding a side button
long enough, or holding it while using the wheel for horizontal scrolling, can
mean the normal mouse report never emits a usable side-button press at all.
That makes the buttons unusable for standard Linux hold actions such as
push-to-talk, drag modifiers, or remapping rules that depend on key-up timing.

When HID++ 2.0 feature 0x1b04, SpecialKeysMseButtons /
REPROG_CONTROLS_V4, temporarily diverts the same controls, the device sends
diverted-control notifications with real press and release timing. This series
adds quirk-gated support for those notifications and enables it for the
Bluetooth Signature M650.

Before enabling diversion, the driver verifies that each mapped control is
present in the device's HID++ control table and is advertised as a divertable
mouse control.

The diverted M650 controls are reported as BTN_BACK and BTN_FORWARD. Logitech's
Signature M650 getting-started page labels these physical controls as
Back/Forward buttons and describes their default page-navigation behavior:
https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-Signature-M650

The reprogrammable-control support is per-product and parses the full HID++
divertedButtonsEvent pressed-control list, so it can support devices with more
buttons without relying on a single last-control release heuristic. Only the
Signature M650 opts in for now. Other Logitech devices should only be enabled
after their HID++ control IDs and divertedButtonsEvent behavior are captured
and verified.

There is evidence that this is not unique to the M650. A prior MX Anywhere 3
patch used the same HID++ feature to fix thumb buttons that only activated on
release, and Logitech documents side-button + wheel horizontal scrolling for
both the MX Anywhere 3/3S and Signature M650. Solaar's device reports and rules
documentation also show HID++ divertable back/forward controls on MX Master 3
and MX Master 3S class devices. This series remains conservative and only
enables the device tested here.

Tested with a Logitech Signature M650 L over Bluetooth, HID ID
0005:046D:B02A. Baseline evtest showed short release-time BTN_SIDE/BTN_EXTRA
events. Earlier local testing of the same HID++ diversion path showed real
hold-duration press/release events, including holds longer than 4 seconds for
both buttons.

Elliot Douglas (2):
  HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support
  HID: logitech-hidpp: enable reprogrammable buttons on Signature M650

 drivers/hid/hid-logitech-hidpp.c | 236 ++++++++++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 1 deletion(-)


base-commit: f0866517be9345d8245d32b722574b8aecccb348
-- 
2.54.0
