Return-Path: <SRS0=cons=5I=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C0C4332B
	for <linux-input@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC7420409
	for <linux-input@archiver.kernel.org>; Mon, 23 Mar 2020 23:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="et1B+wP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCWXpT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:45:19 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:32830 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCWXpQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Mar 2020 19:45:16 -0400
Received: by mail-pj1-f73.google.com with SMTP id ng13so849142pjb.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2020 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Nt1NzwBOv+0yT5sCiw6dDGnfYenncnTIG2PE5hdU3M=;
        b=et1B+wP9LkYL30MUtIZIXL7mabpmsyXueZypWjPPj2Bku/RHTD1y+8nFSrJG4QsxJS
         OaUbstMHBg8Ls/rx+t5RdoM/OOiSpjqjP99H8qAcz8zaoR/WWFIGClA0YY1Z9u0w3DNh
         7FmwPcclAffI6nx0Ae55mAmEyis6jYHmOHcFAVqeJz4KPRwK7AyctDQqMvz8I3VqqWRs
         NAvEwIkCh1NyJ6L9lKa63hKNPCLyTqLAe6An5FvYGyGqD0gbdM9z/xdeJsbjpB3pftd/
         jhigxT35bxIej99rwMbTdxp+iuNaK707Y15Tk8mwkxEMHUalhQ1IvXQznIobsOHXN4ry
         /1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Nt1NzwBOv+0yT5sCiw6dDGnfYenncnTIG2PE5hdU3M=;
        b=Tqyy+LaQSzTAuXbH7Qb1t9zgltCzpZNEA+7GKoJJZ1VxP0PQrwBQC++sCDFut9tSf1
         A0mAVpLvWM6dc4DLTrQzAQ3/i6GP60LOKxbZ4ZpyNy+JJqQDdaIzY0xArVnfCvt4MZtt
         nD7PqVWpdNjhUeRvRLpOUD1J4KFhA7+p9DNKqzSSa25S6LtV1VfJb60TdaruVpSM5QX2
         GovGXVZR9MtGPGxgeOiaD7725utyfuIZdxXepkdpGuToBS/SRZKQcDkJu1urwExqcgaf
         flrC0ZOD8n3g5Y/OF0w6WYdvYMYE+ugWLflmNTTM+QTTp60r6hJCauze0nxTqwXgbhES
         tHZg==
X-Gm-Message-State: ANhLgQ0yW+vvFOkGNhA/c7+R0BKWw30T3HaOiBhw0pIUT1xPWhAwDXue
        41w7RCtWvxt0z6K02qLi297oFBj1at0r
X-Google-Smtp-Source: ADFU+vvPJ6+5Vbkq4pk8U+dO3lSHGSMt7IwxzYsEL+baO313m2V3EEjuYz3a6oks+uiP96WQo9FNWXQnSv75
X-Received: by 2002:a17:90b:282:: with SMTP id az2mr2023188pjb.13.1585007115675;
 Mon, 23 Mar 2020 16:45:15 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:45:03 -0700
In-Reply-To: <20200323234505.226919-1-rajatja@google.com>
Message-Id: <20200323234505.226919-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200323234505.226919-1-rajatja@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH RESEND 3/5] dt-bindings: input/atkbd.txt: Add binding for "function-row-physmap"
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
Change-Id: I1786a09258670ed9c782ec1b529e0e347cdfda8e
---
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

