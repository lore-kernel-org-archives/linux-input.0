Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAE6C64E7A
	for <linux-input@archiver.kernel.org>; Thu, 26 Nov 2020 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EAB21D46
	for <linux-input@archiver.kernel.org>; Thu, 26 Nov 2020 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsUJkN4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgKZNgT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 26 Nov 2020 08:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390327AbgKZNgS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Nov 2020 08:36:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72253C0617A7
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2020 05:36:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so2191805wrn.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2020 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptuCzI/J/pK9IazFF47wcnYE5/wwDz9k/tG2ZC99w5I=;
        b=fsUJkN4/93Fz7NiE9jRzBq6Hfq0UT50vEbBIcuvpg45I4KmD6OMv4XyGsj5CG1LHWR
         fpgYzwiplcjwn/5uYkPtEUG+uwYsQnK79MkHbhgK3nJJZr+uN3nueq/yigjtR/QMJrv2
         k/y+vsocVqpob2Ytont14F9aBquqt4fo1DOPq70hvnmTT89r6pKYIW2F0aRqktGI4ZxK
         FTQdnQcz+pxlA/9IWWCY5DE0/Ugqt6IIj/1MjPZ7Pm3sklxAV10hSdnlpIsWxGUOlVK+
         a4u3z+me4ADzl7cZQ0mVvPf02q2rS/tYNdAgvf4hCOaiF4BvHo/+tCQlw2ynBkeqmE+M
         Cv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptuCzI/J/pK9IazFF47wcnYE5/wwDz9k/tG2ZC99w5I=;
        b=YQfU5YKVOKlCGwfK0juuzk/dGXgPvUHMhvIBPhR57mXpctuGOsUIYRP/G0JSdsHN88
         BZeg+V+ST+u4MMowfcQWjNykg426Q1QQCOL1q5X26xxxqtKb4uVjqS90Rodgd5IdUvMd
         HHmmKMXQ/nojQqH1WS3Bd3/9Xjpw0N32lxyML9l2PmYG9uYVxM6W2eByCDTN62Ur4+uc
         oZNSkSCN9p9HmoajaQlVLXTOKqLACJcsy9coUp7ZkAMnVw0hHIHtI5gGeCUNzdwkZVbX
         wvGdP3K7+hXdhYq6Pm8svUQTPKRizrhpJ1vmCkklC4h2XK1rElLUyUb6sch9ujBvaGMS
         fKxA==
X-Gm-Message-State: AOAM532IlzKtqna5bLSmvuZh1buqfPnzHvg6Egm1SC7QCxB5Ny+1yO34
        z6h9QXKYTQRFlbjxm0LZ+XsPzA==
X-Google-Smtp-Source: ABdhPJxwcnxrJ60FYcuBBWacWLhwXpwENFfsols49hd2U3IbbEunR/QQzoUJFwWbsF4dSCR5Ykp83w==
X-Received: by 2002:a5d:544e:: with SMTP id w14mr3906110wrv.227.1606397777236;
        Thu, 26 Nov 2020 05:36:17 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id l3sm9056280wrr.89.2020.11.26.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:36:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Daniel Ritz <daniel.ritz@gmx.ch>, linux-input@vger.kernel.org
Subject: [PATCH v2 3/4] input: touchscreen: usbtouchscreen: Remove unused variable 'ret'
Date:   Thu, 26 Nov 2020 13:36:06 +0000
Message-Id: <20201126133607.3212484-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133607.3212484-1-lee.jones@linaro.org>
References: <20201126133607.3212484-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/usbtouchscreen.c: In function ‘nexio_read_data’:
 drivers/input/touchscreen/usbtouchscreen.c:1052:50: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 397cb1d3f481b..c3b7130cd9033 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1049,7 +1049,7 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 	unsigned int data_len = be16_to_cpu(packet->data_len);
 	unsigned int x_len = be16_to_cpu(packet->x_len);
 	unsigned int y_len = be16_to_cpu(packet->y_len);
-	int x, y, begin_x, begin_y, end_x, end_y, w, h, ret;
+	int x, y, begin_x, begin_y, end_x, end_y, w, h;
 
 	/* got touch data? */
 	if ((pkt[0] & 0xe0) != 0xe0)
@@ -1061,7 +1061,7 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 		x_len -= 0x80;
 
 	/* send ACK */
-	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
+	usb_submit_urb(priv->ack, GFP_ATOMIC);
 
 	if (!usbtouch->type->max_xc) {
 		usbtouch->type->max_xc = 2 * x_len;
-- 
2.25.1

