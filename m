Return-Path: <SRS0=dHTn=4P=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EBC11D3D
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 18:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55386246A1
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 18:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj6V0kKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgB0SNI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:13:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38637 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB0SNH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Feb 2020 13:13:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so117445lfm.5;
        Thu, 27 Feb 2020 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IULXqhszyqMcQoMwWa2PsJp6mRVAsQrFJGxJ4oTw6uE=;
        b=Sj6V0kKLLBXQ2JRFY4cLp78TYxdyFDwzGgbbciprtwXmE1mQJfsv6vyZd5wDTZUDMU
         63B0rF9MxqH38mMu+VFN28uBjcmUVJVPGNv1R+pS+9AmRQxnIDspP01znTUUtpZ3f00W
         L8a9rmYmKwxF6H1zNnxse33OlhorUC+k6EAbxTND4KJKIvRx64Dh3ajcLr9edlKKkxec
         5EQdBbX3xLcUJEv6djgRFK7f11USPcr5SKQEc9PKW4wpbyTKodxm69LZB67rhKGCJtga
         G/gUFEDqEqxOkz+pP/8cV86IHj8r5ozrVmt0d3NEYN8/XcvyALM8PBLEYcHUwTn2tBxO
         X5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IULXqhszyqMcQoMwWa2PsJp6mRVAsQrFJGxJ4oTw6uE=;
        b=D936QbwEErlRZttL6t3qFjHJUMWbnXmIVNMOPlnBiX1KcGLI7lbe7cPOeE+x1Fqjmj
         jSQGLzlnvKC26emsm447jZ1mNkBsRrlQF/A6r9MklpBsy2SapEoKOMhVQEg6StsHMLFA
         7RJk0ANWLV2n8p9CmBvuQLSz2brSK2wH6tMobocVg3T6kc2G/vxXIuIIUq6efG4ZNKDH
         s9WTwAmV0c4o4udPUgmQkASJsqHRHI186GeXDjiKONbqxcS40+yy/7Zr4A40FXSnIUEa
         u7bwrNgd1k5ZDsS+Fp//kn0Pu/gbiYUt8liuTHhs3etbz6780GSIZ8CoAFXFi/2er5BX
         95DQ==
X-Gm-Message-State: ANhLgQ3AfOwoRe+abwne/uiGLPySTQLwP5H4WMic7xN9nIkUuxnAbzzW
        qC7m1hLviNbhUIM50ou2eQM=
X-Google-Smtp-Source: ADFU+vsC+ibuHd9fGINaxqkor4ZPzJbV9sKaelWlT3qvBtWEnDmNjmMwcJD566hVwaJ4G4qcT30O/A==
X-Received: by 2002:a19:c20b:: with SMTP id l11mr330559lfc.135.1582827185929;
        Thu, 27 Feb 2020 10:13:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id q4sm1478727ljm.51.2020.02.27.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:13:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RE-SEND v1] Input: atmel_mxt_ts - correct local variable type
Date:   Thu, 27 Feb 2020 21:12:49 +0300
Message-Id: <20200227181249.10037-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

GCC produces this warning when kernel compiled using `make W=1`:

  warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  if (byte_offset >= 0 && byte_offset < cfg->mem_size) {

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Added my own tested-by, since I actually use this driver.

 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ae60442efda0..bd0fc4b08608 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1287,8 +1287,8 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 {
 	struct device *dev = &data->client->dev;
 	struct mxt_object *object;
-	unsigned int type, instance, size, byte_offset;
-	int offset;
+	unsigned int type, instance, size;
+	int offset, byte_offset;
 	int ret;
 	int i;
 	u16 reg;
-- 
2.24.0

