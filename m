Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB8C61DA4
	for <linux-input@archiver.kernel.org>; Fri,  3 Mar 2023 23:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCCXjv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCCXjv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Mar 2023 18:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C5213DEC
        for <linux-input@vger.kernel.org>; Fri,  3 Mar 2023 15:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677886746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L3ylgBtssVDhhmOywBZWjMnNLtpF4ejFsajBAITSPKs=;
        b=RGg1C9O/WMN6ONhKGtkdaCnaDa2pkWg0mMz6Git8yhRjPvls92JSskI7UHplNlo7eMF9F3
        EScTk2bP6AtlVrfIgnyRiUwdSZqVrb57GRIIw7bNdDsJu6TqSckhTPBTvlxmBouFul9ciD
        eb5727Kp0cQbuuSsm/4knU0T5dHMrhU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-3SkJk10sMfOet9SKkVO8Tg-1; Fri, 03 Mar 2023 17:21:23 -0500
X-MC-Unique: 3SkJk10sMfOet9SKkVO8Tg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D458038041E0;
        Fri,  3 Mar 2023 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 341C1492C3E;
        Fri,  3 Mar 2023 22:21:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 0/2] Input: hideep - 2 HiDeep touchscreen patches
Date:   Fri,  3 Mar 2023 23:21:11 +0100
Message-Id: <20230303222113.285546-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dmitry,

Here are 2 patches for the HiDeep touchscreen driver,
new in v2 is the addition of the second patch, patch 1/2
really is just a resend.

Regards,

Hans


Hans de Goede (2):
  Input: hideep - Silence error in SW_RESET()
  Input: hideep - Optionally reset controller work mode to native HiDeep
    protocol

 .../bindings/input/touchscreen/hideep.txt     |  1 +
 drivers/input/touchscreen/hideep.c            | 23 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.39.1

