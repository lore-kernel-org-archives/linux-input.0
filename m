Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=136.144.184.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530538;
	b=dRI1qUqJP3gJFC1jW2TwAMi2R/spD/dvQoInyf2al6Gw5+SIdL5WD2gBJh1cTBVmsp+s
	 ZgN/pDtuCU2CPcakKR4JC9bY+3BhbH2ICmc8OQ8tPQGmF20pnpvkXWyn3YQ8bHvaNafEM
	 qZLtAQWgG5RdZrpVjl8oZD68t+bELND+Eo3rtt/3FWIpZ/qCrZe8NCrCym/DQm86vDmZR
	 V0oTtSNA9k8o0T551Toyl7l5AL6Oyouqb8awr14QMED+o8Bo6fQhx9TE8NNl7sxTND11R
	 3qsvE67+IoqB6TwXYZ6c+uV4FYGzVPL89Q4pSaGqhm1F5VPdGHbR47GL7kBS48NGtMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530538;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Date:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=5Ezp610wX1sirY3VguKSuZPmo0qSwFA6RzZrz3JHB+g=;
	b=HkjEL04iSscYpCT6lbqg0lVPplIhi0avyoEtGKh+JWJGFjtOOy/EVEwrovBADJQqQyDP
	 ObG7vh2cTTJ7eQDYnODE5OGzCLH5c7nFek2mGKsmlV/hKvz+Kszg8n4KWAksxyMzlNJXK
	 x53N/VEQHyQG0yiyTp5l8NABEPxBGxzPB5pEu9rj6kiHLBHknCbDv3mp2SJNUr+t1vwAB
	 Zdi9tUTYNlMnJz1wv5p+vviROV4WApZJaR/u4cZokNOjzfIrnZ2Thscitgu0nZdXnhloi
	 Gb/rcPi5CBgIdQO2k8UEjcGLiXyHxoktAq9J0rYQJsiPkUxm4yxRl64ySmTsND5BJVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=willow-media.nl;
	spf=pass smtp.mailfrom=willow-media.nl;
	dkim=pass header.d=willow-media.nl header.i=@willow-media.nl header.a=rsa-sha256 header.s=dkim header.b=Ci6Y00AY;
	arc=none smtp.remote-ip=136.144.184.39
Received: from balder.willow-media.nl (balder.willow-media.nl [136.144.184.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007C606A326
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 10:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D007C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=willow-media.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willow-media.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=willow-media.nl header.i=@willow-media.nl header.a=rsa-sha256 header.s=dkim header.b=Ci6Y00AY
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3A7B266325;
	Sun, 01 Nov 2026 11:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willow-media.nl;
	s=dkim; t=1793530528;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5Ezp610wX1sirY3VguKSuZPmo0qSwFA6RzZrz3JHB+g=;
	b=Ci6Y00AYz8EKvZOXhMLJPsJTZORR4CRINvNRrN3CyEpUkUBKOW4/A/lmJt0AOPcEb6LP+1
	7A+L6N96nmbBB2kPhO66+xSoR7teH+3FbyU9MvceMHMBDx14rsEc/sf2BX/FCIEIcSpxHq
	5g4gm9ezOWzO8ofccVjPADXSuJgVT10=
From: "Peter Hagen" <peter@willow-media.nl>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org
Subject: [PATCH] HID: multitouch: add MT_CLS_WIN_8_NO_CONFIDENCE for
 FocalTech FTCS0038
Message-ID: <hylki-zzduu7fX5YckqKR0wf@willow-media.nl>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 01 Nov 2026 10:55:26 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

The FocalTech FTCS0038 touchpad (HID vendor 0x2808, product 0x0106) found
in the Lenovo Yoga 7 2-in-1 14IML9 intermittently drops the HID confidence
bit on valid touches. As a WIN8-class PTP touchpad, hid-multitouch forwards
those contacts to userspace as MT_TOOL_PALM, and libinput suppresses them
entirely: the cursor freezes for ~1s mid-gesture and drags/text selection
break off.

Add a MT_CLS_WIN_8_NO_CONFIDENCE class, identical to MT_CLS_WIN_8 minus
the confidence handling, and assign it to the FTCS0038. With the quirk
unset the driver never registers ABS_MT_TOOL_TYPE, so all contacts are
reported as fingers and the unreliable firmware confidence bit is ignored.

The same false-confidence behaviour has been reported for other FocalTech
touchpads (e.g. 0x2808:0x0231 in ASUS VivoBooks), but the class is
assigned per device for now to keep the change minimal. The firmware also
occasionally emits genuine coordinate jumps; those still reach userspace
and are handled by libinput's jump detection, unchanged by this patch.

Tested on a Lenovo Yoga 7 2-in-1 14IML9 (kernel 7.2.11): palm-related
freezes gone, drag/select/scroll fully smooth; the remaining discarded
jump reports were imperceptible.

Signed-off-by: Peter Hagen <peter@willow-media.nl>
Assisted-by: opencode:glm-5.3
---
This patch and this commit message were largely written by an AI coding
agent (see the Assisted-by tag). Following
Documentation/process/coding-assistants.rst and
Documentation/process/generated-content.rst, a summary of the AI
assistance:

- problem finding: the false-confidence behaviour of this touchpad was
 diagnosed in an AI-assisted session, tracing the HID_DG_CONFIDENCE ->
 MT_QUIRK_CONFIDENCE -> MT_TOOL_PALM chain in drivers/hid/
 hid-multitouch.c and the matching palm suppression and jump detection
 in libinput;
- patch authorship: the diff and this message were generated by the
 agent after reading the relevant code paths in the v7.2.11 sources;
 no other portions of the patch are AI-derived;
- build and verification: the patched module was built out-of-tree
 against Fedora's kernel-devel 7.2.11-200.fc44 and tested live on the
 affected laptop by the submitter (see the Tested-on note above).

The submitter reviewed the patch, ran the hardware testing and takes
full responsibility for the contribution.

 drivers/hid/hid-ids.h | 3 +++
 drivers/hid/hid-multitouch.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -216,6 +216,7 @@
 #define MT_CLS_WIN_8_NO_STICKY_FINGERS 0x0017
 #define MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU 0x0018
 #define MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE 0x0019
+#define MT_CLS_WIN_8_NO_CONFIDENCE 0x001a

 /* vendor specific classes */
 #define MT_CLS_3M 0x0101
@@ -347,6 +348,19 @@
 MT_QUIRK_WIN8_PTP_BUTTONS |
 MT_QUIRK_KEEP_LATENCY_ON_CLOSE,
 .export_all_inputs =3D true },
+ /*
+ * Same as MT_CLS_WIN_8, but without the confidence check:
+ * some devices intermittently report low confidence on valid
+ * touches, which would be forwarded to userspace as palms.
+ */
+ { .name =3D MT_CLS_WIN_8_NO_CONFIDENCE,
+ .quirks =3D MT_QUIRK_ALWAYS_VALID |
+ MT_QUIRK_IGNORE_DUPLICATES |
+ MT_QUIRK_HOVERING |
+ MT_QUIRK_CONTACT_CNT_ACCURATE |
+ MT_QUIRK_STICKY_FINGERS |
+ MT_QUIRK_WIN8_PTP_BUTTONS,
+ .export_all_inputs =3D true },

 /*
 * vendor specific classes
@@ -2751,6 +2765,12 @@
 USB_VENDOR_ID_ASUSTEK,
 USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO) },

+ /* FocalTech FTCS0038 touchpad (Lenovo Yoga 7 2-in-1 14IML9) */
+ { .driver_data =3D MT_CLS_WIN_8_NO_CONFIDENCE,
+ HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+ USB_VENDOR_ID_FOCALTECH,
+ USB_DEVICE_ID_FOCALTECH_FTCS0038) },
+
 /* Generic MT device */
 { HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY_ID, HID_ANY_ID) },

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -511,6 +511,9 @@
 #define USB_VENDOR_ID_FLATFROG 0x25b5
 #define USB_DEVICE_ID_MULTITOUCH_3200 0x0002

+#define USB_VENDOR_ID_FOCALTECH 0x2808
+#define USB_DEVICE_ID_FOCALTECH_FTCS0038 0x0106
+
 #define USB_VENDOR_ID_FUTABA 0x0547
 #define USB_DEVICE_ID_LED_DISPLAY 0x7000

