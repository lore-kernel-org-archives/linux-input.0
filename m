Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB91C55ABD
	for <linux-input@archiver.kernel.org>; Thu, 12 Nov 2020 11:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACD422201
	for <linux-input@archiver.kernel.org>; Thu, 12 Nov 2020 11:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FztJ+8sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKLLCm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 12 Nov 2020 06:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgKLLCa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 12 Nov 2020 06:02:30 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F0C061A4E
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2020 03:02:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so5083994wmb.5
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2020 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDq1ucxwNVdiyOuGDpG3UuS4AQsRLKqvrJ8cBQ65tp8=;
        b=FztJ+8sXVteaVXQlm1MysT50leos1FgWA71xWpI6b3mwdJ/d/0+JXHOTe8qhRiYbwI
         EU+0NpeyNV3G3gR8P4TPI48MF+tY+7BYbiJSA2wHhPosXHVoYlZH7OIL9usqmtqgkjGT
         0zEbOY0mQ1sM3RR+AuS/PBKBrI9okpRyT6BRUYl5O86GEmsFlHD8WFtDWUJ4Ph3Be7DA
         mnSaqE91cvIPS/6egGhg++TjpAaxQwfZaRU1GJGe58FesqMy6zdOrwyRWBTkglbWn13i
         C/Hrp2aUvP+O4mlHL4x2gx6sCS2HO2LazlfJc+cXrGtjovpeRgOxeZ2DwgaGj9Wv+gpT
         IdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDq1ucxwNVdiyOuGDpG3UuS4AQsRLKqvrJ8cBQ65tp8=;
        b=a2iqh3ceGQiuCzNr/MlznLZ/GCBfhYp877SkckTnEJC/hK+Sp/ngmMbF2L5O+X5OKj
         giuQ9V0Wp7R3VX7syOLxlLFJMXvsm25zBLkgmbV60F3LJcFtzqKYEknYBgiFH2c2Yk38
         VKs+W8ZkkfffE/Tpcngm/89smmPAsz50zdNcTPKeUyPPToM8qqXOXAJnJDwroxN9ATLH
         y0XX1yoLLc5qUthRb+vD8inGWosf2Kvw6u4Tww0gBMyNIdIK/AWDQ2S9dO3UrsIjAuAu
         P+o27CI1Xeb45bWRzqZ41uO62LEE7zT12j2OdmK+MWMxjHJz58Qwk8LssoCaXc9rYA0M
         SXHw==
X-Gm-Message-State: AOAM532kSKA6xw5rgyY5mZViyUoQNCTdmcKZbYjMEjoq+mlgBk9CMNvG
        L+weadr2iTQrJB88K2WAffPaqg==
X-Google-Smtp-Source: ABdhPJz0T5vXUqEh/5sdw7ELKie10+1/9KTs/+Ako8UhqhB5cLmE0Rqj3oGMOPZqH9MDG/eNhqyVSg==
X-Received: by 2002:a1c:87:: with SMTP id 129mr9252628wma.34.1605178946051;
        Thu, 12 Nov 2020 03:02:26 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x81sm6515329wmg.5.2020.11.12.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:02:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH 14/15] input: keyboard: applespi: Provide missing struct 'message' descriptions
Date:   Thu, 12 Nov 2020 11:02:03 +0000
Message-Id: <20201112110204.2083435-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112110204.2083435-1-lee.jones@linaro.org>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'keyboard' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'touchpad' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'tp_info' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'tp_info_command' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'init_mt_command' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'capsl_command' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'bl_command' not described in 'message'
 drivers/input/keyboard/applespi.c:306: warning: Function parameter or member 'data' not described in 'message'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/keyboard/applespi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 14362ebab9a9d..8053a3d2ff635 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -286,6 +286,15 @@ struct command_protocol_bl {
  *		structure (after re-assembly in case of being split over
  *		multiple spi-packets), minus the trailing crc. The total size
  *		of the message struct is therefore @length + 10.
+ *
+ * @keyboard:		Keyboard message
+ * @touchpad:		Touchpad message
+ * @tp_info:		Touchpad info (response)
+ * @tp_info_command:	Touchpad info (CRC)
+ * @init_mt_command:	Initialise Multitouch
+ * @capsl_command:	Toggle caps-lock LED
+ * @bl_command:		Keyboard brightness
+ * @data:		Buffer data
  */
 struct message {
 	__le16		type;
-- 
2.25.1

