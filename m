Return-Path: <SRS0=fHkP=EK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C960AC2D0A3
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AEA206D4
	for <linux-input@archiver.kernel.org>; Wed,  4 Nov 2020 16:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naJ5FeJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgKDQZ6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbgKDQZD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Nov 2020 11:25:03 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488BC0401C4
        for <linux-input@vger.kernel.org>; Wed,  4 Nov 2020 08:25:00 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k10so21376011wrw.13
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2020 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwivgBdOs0zmcrd9rmzAZ3rcWWFWu9L80hhGgYgWXJ4=;
        b=naJ5FeJamZo4YFDvgyLGDdleJMHz+mOfR7xKKotIM//fvW4EGFDfXiNL/W1SBwtArU
         h82/fTZWWy+mhOqv1Ge/tf5IVIGnVx9RGmcLimmjoghPo7/HSX8py00JJ8yy+6rJs3kX
         l4w+bxtTF9Z0KsOXRZGk75ekO/OgGSwH5u4jFW3FGxuLBFV7a8QKnHS3mDDIF9PbcwOV
         1JnxBeG3/3kUFpFnFskEbN65TmXUErcPAYKYunK9qQ1tnNjQwJcTzjXhSCW5FvuJgSDd
         OBBKFgs21L/EOUYJVQQtvaycqaOBN7mwPvVKdHzzoF5bLnkspt9WdSQvReKB28zDG93i
         WYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwivgBdOs0zmcrd9rmzAZ3rcWWFWu9L80hhGgYgWXJ4=;
        b=qe9ZxjlHkQvUlazJCCkqNx26039XlD3gFZV0svm45e3OE5dRyRzmwhYAdwMpp6Kztm
         XQmyd6KU3y8eO5yVdKHAbwrYMFKHOaS06KbzeNiSps7hTcl3kEp93gZGOdq4vGqK5edc
         tipzandWXqjvbqDPNUIhK99yCaLSePLBVfyYvIH1FYR74E+lD8gMH7kuLyPVs702SUEx
         Ea+jJvWicM3iImenmXusSka13RkzGIGbBbK2usC9agUHtJ7UREPu/wfBFHa4yupBBu0L
         x6DZb4CYfFI8Uy5WmE1vx1+b121KwSSkRpoEAHDcausLjYyHZzG/mRIbFjd6hMznd9FK
         /J1w==
X-Gm-Message-State: AOAM530HPzjJt3/ExSfXeW04O33TYos/jUMNQjqqUSU2KNKuMef1R/Z8
        Lu8AjaFyEocfffbC3/EygFjllQ==
X-Google-Smtp-Source: ABdhPJwcC4S76QfH0IR6FW9cTE9tEsUkIsqeLxigoDJLm+uDBrv2Bzx7usaQ58fUHHC/fN/KKE8vYQ==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr2312563wrt.255.1604507099368;
        Wed, 04 Nov 2020 08:24:59 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christopher Heiny <cheiny@synaptics.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 14/20] input: rmi4: rmi_i2c: Provide some missing descriptions for struct members
Date:   Wed,  4 Nov 2020 16:24:21 +0000
Message-Id: <20201104162427.2984742-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/rmi4/rmi_i2c.c:39: warning: Function parameter or member 'client' not described in 'rmi_i2c_xport'
 drivers/input/rmi4/rmi_i2c.c:39: warning: Function parameter or member 'supplies' not described in 'rmi_i2c_xport'
 drivers/input/rmi4/rmi_i2c.c:39: warning: Function parameter or member 'startup_delay' not described in 'rmi_i2c_xport'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/rmi4/rmi_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index a95c2c9bcab4c..50305fcfbef59 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -17,12 +17,16 @@
  * struct rmi_i2c_xport - stores information for i2c communication
  *
  * @xport: The transport interface structure
+ * @client: The I2C client device structure
  *
  * @page_mutex: Locks current page to avoid changing pages in unexpected ways.
  * @page: Keeps track of the current virtual page
  *
  * @tx_buf: Buffer used for transmitting data to the sensor over i2c.
  * @tx_buf_size: Size of the buffer
+ *
+ * @supplies: Array of voltage regulators
+ * @startup_delay: Milliseconds to pause after powering up the regulators
  */
 struct rmi_i2c_xport {
 	struct rmi_transport_dev xport;
-- 
2.25.1

