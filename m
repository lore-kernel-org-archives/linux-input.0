Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4C320CBE;
	Sat,  4 Jul 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783186822; cv=none; b=camcEPWGJNiFGUCGX56tLdxk1vDhbyyhlIhvlIvc9iXfYMqTk9uZscsUQD34yuDypn7Mzv9+3lYxoKEBqn8tmiYqy0CMmMsq6z+CwEbjGuY/m8NH2k2XmZrw0/uDNmNnTuEbV6FkwjrNukA6QUM0c7+s6AgLZoWa0TPulRnroIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783186822; c=relaxed/simple;
	bh=DWbkslxHMADOUgRluJf+wQjvmpEQBatBWbdRXL9kVcQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LVaD7oQJKlCFgNhTlMotyTA39XJguaPTjilt3Gx7Mnk4ShsQs3ryaj00cnqQGmdD2HJ55BiYcqSh3K2X0ggnScP0qxXXb5FksXu8/+V6xOf88apiIsCLMA9xvjdOup0f3n2Sr0CuRrflURR3OlxKXZVTWTE5dlaavDR+yFUaikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1101b.com; spf=pass smtp.mailfrom=1101b.com; dkim=pass (2048-bit key) header.d=1101b.com header.i=@1101b.com header.b=VT8QnU4A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dx0Ius3h; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1101b.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1101b.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1101b.com header.i=@1101b.com header.b="VT8QnU4A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dx0Ius3h"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9BF11400070;
	Sat,  4 Jul 2026 13:40:19 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-05.internal (MEProxy); Sat, 04 Jul 2026 13:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1101b.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783186819;
	 x=1783273219; bh=c6ErFOhyiSAgS5xzYmdBXMKeyU4kUTyWiCfCJApddxs=; b=
	VT8QnU4A0uxM4AfpJj28/VA/F/gmxWIYZcO3iZovVAyKI89xPbxQco3gmby+6dzc
	ka4TUEefpWabquQEBKrhrhjzpsAZnxgiV5UqmTmSFtLuZsPMeEdSrs3ppnFie9qM
	705AqNxNOKUK2J5OwjwTciB2EfILZn5RM/jNR90g1DUKifPwM2wnCOOART9eihvk
	DDWnWu9HZooC6ku+XDPZfEUbiZEHoWQbO0yboFSCtU8/ZHshQbkOt2VwcVW6vnvi
	8g6glYRptBzunbA1U8AtsjzzhVuFOsf7ch913scwUsg/ARIutq9vJrUuHvHHgv2Q
	zhnd7kZV8ONE4C0jNoCl+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783186819; x=
	1783273219; bh=c6ErFOhyiSAgS5xzYmdBXMKeyU4kUTyWiCfCJApddxs=; b=D
	x0Ius3hqKzz9aikZwN1dd/NxUnuIVxwJvuSZ81Vy7b5SsEAfimktQ4XvapKhegpg
	7m37n3YOgOnU/ZoZurK5lbXMeWZ+EqZglI9SsN1uy1Md6PMiPqm2NA90SPXAPuK4
	i1rntvypIKRkKrYiK6WdhAOaVDs4XDtuqymnjkFoMr4xpcFGkuNPLZew5OZFxE2e
	xC6m+yQ8B74C9av8Z+WZYeu1QpVxhE/MlnvS/NXhT7sbO4VRDlk14R2OEoxyhDdv
	BPey5pPPBBRxrp7ACqR3PYIWvi4I+EXnFGNPoUDAFD4PjUGgod+1h6qnAAOnyYbE
	SbOccM9dr9KOBBBrqGwjQ==
X-ME-Sender: <xms:gkVJavO2ZPemD-WWRxuQnxbl6M8dYn3SXCegm5p1b6uewzLdR7ig1A>
    <xme:gkVJakwL0w_-C2DarEGsbBWxeOfjaClytxBOI88b2ppUCrlBI0XJPdXpC_eHDoDLd
    aK_LpAUsRbQhQn3j9xRxrairtcK_ChcWXQohFeWLow7zpZ3Zz2Uj5bu>
X-ME-Proxy-Cause: dmFkZTE+StxmT2autHCo3PGYI4ricye8fv2U+q13iv3xQgifz6p8cBM/cQuDhioCHvEicf
    YYeM3Kl0MmmM/FhqnNt2wHHUpjgJPTF3cBCP2p9MDse2yyy4lD23wsOGAjUkX6+M8QmyAS
    19erpnqqWGcVq7KhVrR9eBEPDEmXAfnU1Snqg5OldpZFzRD+ZQB7ZAtDHIWtvCZ51udtWB
    tn43Ae8SpBnPQdVs3tlzmaZ34rh2cUi1EBElGuHEuxUq5JadD0EI2vpBYbW0yG2BhNW1uB
    wfFw8VsDxPRyJDtHS0L8kTunYZmbxg/D86Lx2WID2qUAyNGSxkNwFCTgaKHgme7pmTxxDO
    jyCpYRg7keaBOvldLNcE/mpuvWXWLAaidwFrQj2hJjwKhVm+rTo3w37AvCr0w47uOohHSd
    r9KcinOfdKlYXZljYSjM3mG9HQrSZx15lWi3AWihm0+9cHt5zj3vSkt92NLv5sdBElbUl8
    PRDPv9hhKAo2M0e5tiYYQpc145lSq0m3tlIbNMvnqpBdtW3WRRx+8GpNgeQFKw7RMbq1Th
    PuhXWFxm83xQD2GNDl4IPh3yIRAScVw4ir6gcUG+eRSpMZzIEAJ1YTWHHln/thIN/g3/jL
    N84ajr2u01tvY7JyQOL31rIbXMFPxe1MPFhCVPKxhZ0e4JJbtv+vUcCUNsKA
X-ME-Proxy: <xmx:gkVJatffy2Nd6xt-inrGmoClPM4jFQoIlXJLaoUVY87ghjSsZUBzpg>
    <xmx:gkVJarouv4ZzIB-L9CNs_tv4ustog8sTAkVSCz_7fSPq4_6p4lVlZw>
    <xmx:gkVJanP94EvdV2tV8mDYJS0sc7M_bxN1Z4o81YQXYu583Zg10xmk9Q>
    <xmx:gkVJaugiUUpzDBKtW5Y9ecA37mPyRfDDcAf-PSdicvohBHL1oE6RAA>
    <xmx:g0VJag3rD8YxcwWvF-7eIQ64sxg5D8v9UOOS7pyJQWlzQbGO7mWFqs1Z>
Feedback-ID: ie2d94605:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D281BC40071; Sat,  4 Jul 2026 13:40:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiC--MccY7JJ
Date: Sat, 04 Jul 2026 10:39:51 -0700
From: "Colin Blower" <colin@1101b.com>
To: "Sriman Achanta" <srimanachanta@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Bastien Nocera" <hadess@hadess.net>, "Simon Wood" <simon@mungewell.org>,
 "Christian Mayer" <git@mayer-bgk.de>
Message-Id: <6dc4e54b-173b-4c39-911d-006f93664202@app.fastmail.com>
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
Subject: Re: [PATCH v5 0/9] HID: steelseries: split out Arctis driver and add Nova 7
 Gen2 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I can help test two other SteelSeries Arctis devices, the Nova 7
(0x2202) and Nova 7X (0x2206). I know support was dropped between
v3 and v4.

Link:
https://lore.kernel.org/lkml/20260623172310.272708-1-srimanachanta@gmail.com/#t
On Tue, 23 Jun 2026 13:23:00 -0400, Sriman Achanta wrote:
> Changes since v3:
...
> - Limit new device support to the Arctis Nova 7 Gen2 family, the only
>   hardware I can test.

I patched back in Nova 7X (0x2206) support locally (Archlinux 6.18.37-1-
lts) and it reports battery status with no obvious issues. I only
tested basic audio out and report of battery status via dongle. I'm
not sure what a complete test matrix would look like. I did not test
Nova 7 (0x2202).

Here is my patch on top of v5 in case it is relevant, but this is mostly
from what was dropped in v3. Not meant to be a clean submission, happy
to send a proper formatted patch if useful.
---
 drivers/hid/hid-ids.h                |  1 +
 drivers/hid/hid-quirks.c             |  1 +
 drivers/hid/hid-steelseries-arctis.c | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4856469da073..e5faaeb67c92 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1320,6 +1320,7 @@
 #define USB_DEVICE_ID_STEELSERIES_SRWS1        0x1410
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X   0x12b6
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_9     0x12c2
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X      0x2206
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026   0x22a1
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026 0x22a7
 #define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026 0x22a5
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 23f3590a83ab..57c72a6c29f3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -716,6 +716,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
+       { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X) },
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026) },
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026) },
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026) },
diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 31d31f3f4b0e..e5070b28018b 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -168,6 +168,16 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
                sd->battery_charging = false;
        }
 }
+static void steelseries_arctis_nova_7_parse_status(struct steelseries_device *sd, u8 *data, int size)
+{
+       if (size < 4)
+               return;
+       if (data[0] == 0xb0) {
+               sd->headset_connected = (data[1] == 0x03);
+               sd->battery_capacity = steelseries_map_capacity(data[2], 0x00, 0x04);
+               sd->battery_charging = (data[3] == 0x01);
+       }
+}

 static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_device *sd,
                                                        u8 *data, int size)
@@ -219,6 +229,13 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
        .parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 };

+static const struct steelseries_device_info arctis_nova_7_info = {
+       .sync_interface = 3,
+       .capabilities = SS_CAP_BATTERY,
+       .request_status = steelseries_arctis_nova_request_status,
+       .parse_status = steelseries_arctis_nova_7_parse_status,
+};
+
 /*
  * Headset wireless status and battery infrastructure
  */
@@ -599,6 +616,10 @@ static const struct hid_device_id steelseries_arctis_devices[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
                         USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
          .driver_data = (unsigned long)&arctis_9_info },
+       { /* SteelSeries Arctis Nova 7X (0x2206) */
+       HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
+                        USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X),
+         .driver_data = (unsigned long)&arctis_nova_7_info },
        { HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
                         USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026),
          .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
