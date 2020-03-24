Return-Path: <SRS0=LU4O=5J=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8668C4332B
	for <linux-input@archiver.kernel.org>; Tue, 24 Mar 2020 12:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8071D20870
	for <linux-input@archiver.kernel.org>; Tue, 24 Mar 2020 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGKtJEH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCXMfn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:35:43 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35266 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbgCXMfn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Mar 2020 08:35:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id a8so10589666plm.2
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2020 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9qa8aAp+bZ6gg3RjZoXrpyNia4xdGEkV4pXAFPahzW4=;
        b=PGKtJEH2E9p0fcB03gDuNWbPXiQ/2waoPhihfZtac0gHwtFY6/Srthu+qCNEaA9hWX
         ZMDCQJbkHXBUeJdiKVFWL6GEKHGRuADWPn1x3IWiQiE69GsV53fMxXoFyaCvKeC6l+he
         +x0H2QwnOypxbtb3WWtcSB4G3hvSBZ6fzOseLpEoNaJb+ozK2cL+XtqvsBthu1M2wOzB
         svB7tDExbTn+kH1naAnmbBMWO2SLH3cW47kfDkXUoKA7lzbfzSg6Y+toJevOADg0gG5G
         S9963zRiHbFOWHS0bO5cRcPwjsQx7VI2Uq0i4OcUS1h0bAl1Pjjt19e0Zict/AZR9kQS
         rzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9qa8aAp+bZ6gg3RjZoXrpyNia4xdGEkV4pXAFPahzW4=;
        b=WKL4ojLU3eNXHaGo5HhBlw+F6rzT1b2Y5wHO04tO9KCkZxvv9cqLbrpJZdsE2FCZBP
         LN6upY1zVZoQprFGRUo+OdsJ4Bw09LkdWH+D1tg5FBMBmOYFZOWt3j1rExGe2PG0bADL
         j6DFOnJmezndjUBqv+7EcxF/YiE81iFedW2GY3M8tk7GTC+Q7wPJegGSMAg08U7KKfrs
         V+UKdbv3Hoi5u86u8vrbhWrjfuod+Y79rtoGxitNafkmqkHl8rkQu0H0BoRcem0rOMJv
         gICh4lIbjoNZS8TzL5AyX9xBP8eEXbqNK6CSsWdgIJNVICaBYbDFoqvukD/hAD9BrJhv
         A+RA==
X-Gm-Message-State: ANhLgQ2btcciBTSne1A0eM8INInLYW7oodNn6WBzlzSJkxNRhv1EcqTV
        ekGzMemz2+y1Xu/HqTcrM8fOTmrdCoa0
X-Google-Smtp-Source: ADFU+vsjCf2WCgjHPJYj99N2JWIuBp5ZMQN3hRm0xa06BAW6KPosWLcQBDeNjnYsynKKF8M5UcQ85Nk9wBQJ
X-Received: by 2002:a63:cb:: with SMTP id 194mr27725855pga.37.1585053342203;
 Tue, 24 Mar 2020 05:35:42 -0700 (PDT)
Date:   Tue, 24 Mar 2020 05:35:16 -0700
In-Reply-To: <20200324123518.239768-1-rajatja@google.com>
Message-Id: <20200324123518.239768-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200324123518.239768-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 3/5] dt-bindings: input/atkbd.txt: Add binding for "function-row-physmap"
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajat Jain <rajatja@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, furquan@google.com,
        dlaurie@google.com, bleung@google.com, zentaro@google.com,
        dbehr@google.com
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Create the documentation for the new introduced property, that
describes the function-row keys physical positions.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Remove the Change-Id from the commit log

 .../devicetree/bindings/input/atkbd.txt       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atkbd.txt

diff --git a/Documentation/devicetree/bindings/input/atkbd.txt b/Documentation/devicetree/bindings/input/atkbd.txt
new file mode 100644
index 0000000000000..816653eb8e98d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atkbd.txt
@@ -0,0 +1,34 @@
+Device tree bindings for AT / PS2 keyboard device
+
+Optional properties:
+
+	function-row-physmap:
+			An ordered array of the physical codes for the function
+			row keys. Arranged in order from left to right.
+
+Example:
+
+	This is a sample ACPI _DSD node describing the property:
+
+        Name (_DSD, Package () {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                        Package () { "function-row-physmap",
+                                Package () {
+                                        0xEA, /* T1 BACK */
+                                        0xE7, /* T2 REFRESH */
+                                        0x91, /* T3 FULLSCREEN */
+                                        0x92, /* T4 SCALE */
+                                        0x93, /* T5 SNIP */
+                                        0x94, /* T6 BRIGHTNESS_DOWN */
+                                        0x95, /* T7 BRIGHTNESS_UP */
+                                        0x96, /* T8 PRIVACY_SCRN_TOGGLE */
+                                        0x97, /* T9 KBD_BKLIGHT_DOWN */
+                                        0x98, /* T10 KBD_BKLIGHT_UP */
+                                        0xA0, /* T11 VOL_MUTE */
+                                        0xAE, /* T12 VOL_DOWN */
+                                        0xB0, /* T13 VOL_UP */
+                                }
+                        }
+                }
+        })
-- 
2.25.1.696.g5e7596f4ac-goog

