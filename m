Return-Path: <SRS0=I0bg=24=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C176AC282DD
	for <linux-input@archiver.kernel.org>; Tue,  7 Jan 2020 19:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95233214D8
	for <linux-input@archiver.kernel.org>; Tue,  7 Jan 2020 19:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6JC31Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgAGTsW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:48:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgAGTsW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2020 14:48:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so54619wmc.3;
        Tue, 07 Jan 2020 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AatB6SnFG8u2SLLdhFsdVidlt+oz2jmCm0IaxJ6W8Rg=;
        b=S6JC31IgPS1HgpRe+vaG49HHlOjrjBUAkzo6BezIYnfUteL6HEYNpq1uPFRv+vsutm
         TbgcGeJ6kpW3D8EKPAHuieaMxHSNzszYDp/4UmjF/ROYhNFlteT8mer+aQBLXDEf+wue
         nEqy8IDecjNGhe7OpjJEzXGwCAwZc1LMBwKNZ27b3PF+x/Zb/bBdbUp9X8k75KGV7JyG
         36788O+adECfVv+gzq4BEahG0g0yTSv0Q/tMKzLCTYeeWwKeuS8iJBinnzhVcP6xXirH
         fnQz8SDH5w8E+KC2JIm9IO22SKVCjM8q1yj7CW+jvU1VD93AOYdBGhjs0wctgZMVK71M
         nP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AatB6SnFG8u2SLLdhFsdVidlt+oz2jmCm0IaxJ6W8Rg=;
        b=JnF9U3tNSoyxhR4jb9Jd/k1+I6SZnidW/EOmC1BEeseIdbpcp866vA1yf2FooiNUy7
         6TUHUXtCwqQjUCNap9XC1rU5pkmll6S/54nXtnXsywzBEeoQmbIxKfTnxBV/I4e/OgNH
         UA9+ds2Yx08En+vpq95VzSM050KM2q0MqP7NXyVcgspAEY1jDg5x1XyMmtKHgeSk9hLC
         eIgibu1qI2NjBJyuwS67Vjuyw3Pl9/+Ae6Zb1Ot2q1ZuchS+ceMPp+B9JZoPCeKnJFug
         cPYlpCs7yc8DUD51PSs84RHsObSgHSrVsiso8qAGC7Y1bg9xmrEOmM/zrrgAq13G5MoG
         u3KA==
X-Gm-Message-State: APjAAAUPuyEAbdoO19T8VjEQoe8t+FIhXKkw9WMBKkSskY9+QodRzUUj
        1cXsM3sg+vbS0d69v4TrYOk=
X-Google-Smtp-Source: APXvYqxdA3ILZlLTG11JZaKjfRImWav+Oi8dOSq5VC2PGlj2crlSU/CYQ0FxNUtdDZmZK6UqGYio1w==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr18925wmb.155.1578426500298;
        Tue, 07 Jan 2020 11:48:20 -0800 (PST)
Received: from localhost.localdomain (10.pool85-61-15.dynamic.orange.es. [85.61.15.10])
        by smtp.gmail.com with ESMTPSA id w17sm1162516wrt.89.2020.01.07.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:48:19 -0800 (PST)
From:   Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH] HID: steam: Fix input device disappearing
Date:   Tue,  7 Jan 2020 20:48:13 +0100
Message-Id: <20200107194813.162038-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The `connected` value for wired devices was not properly initialized,
it must be set to `true` upon creation, because wired devices do not
generate connection events.

When a raw client (the Steam Client) uses the device, the input device
is destroyed. Then, when the raw client finishes, it must be recreated.
But since the `connected` variable was false this never happended.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8dae0f9b819e..6286204d4c56 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -768,8 +768,12 @@ static int steam_probe(struct hid_device *hdev,
 
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
 		hid_info(hdev, "Steam wireless receiver connected");
+		/* If using a wireless adaptor ask for connection status */
+		steam->connected = false;
 		steam_request_conn_status(steam);
 	} else {
+		/* A wired connection is always present */
+		steam->connected = true;
 		ret = steam_register(steam);
 		if (ret) {
 			hid_err(hdev,
-- 
2.24.1

