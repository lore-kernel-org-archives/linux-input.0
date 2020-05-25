Return-Path: <SRS0=resd=7H=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01105C433E0
	for <linux-input@archiver.kernel.org>; Mon, 25 May 2020 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D736C206B6
	for <linux-input@archiver.kernel.org>; Mon, 25 May 2020 23:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bQFUbSXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgEYXCK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 25 May 2020 19:02:10 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50576 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgEYXCJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 May 2020 19:02:09 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DAFD8891B1;
        Tue, 26 May 2020 11:02:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1590447725;
        bh=fH21vaeruc+kAM4fRkdYBDX8IezlA8s+rV2IxWRdUUQ=;
        h=From:To:Cc:Subject:Date;
        b=bQFUbSXvHUFXQUnOjO7zu2nuk/5dZTo2scG6o2aQjXG+HyKgSwBbP3qmCyE4fC9zQ
         bGDqRT2+Hkt1GbBtQpidXa6kEx9WD5GDHD3IZL1Q1ZAFzrTBJcxRIsEz+bu17qOdmF
         bCqTt2A+dHFVXflilJ157r+2BJxBjd5NbYGsMZ3A0tgy/MkFhWYXt4DS1/l4ErMgIW
         f4xm1khPvOi31Y9tXokMFC/LFPztkPgAinRtMGwNpEJKPk5aXd/Qc9SW021W054nNE
         BCprFdFeEOtDUppl8PZRJvmkZ4CCetB/vxwd2E1qoxAwI42upQzOGODJhghklm96RS
         TdjuT340RZEQA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ecc4e6c0000>; Tue, 26 May 2020 11:02:05 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id DE20F13ED4B;
        Tue, 26 May 2020 11:02:02 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D486C28006C; Tue, 26 May 2020 11:02:03 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] HID: logitech-dj: Fix spelling in comment
Date:   Tue, 26 May 2020 11:02:01 +1200
Message-Id: <20200525230201.14985-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Change 'unhandeled' to 'unhandled'.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.=
c
index ed9b1c1f460d..51e1305cc375 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -820,7 +820,7 @@ static void logi_dj_recv_queue_unknown_work(struct dj=
_receiver_dev *djrcv_dev)
 {
 	struct dj_workitem workitem =3D { .type =3D WORKITEM_TYPE_UNKNOWN };
=20
-	/* Rate limit queries done because of unhandeled reports to 2/sec */
+	/* Rate limit queries done because of unhandled reports to 2/sec */
 	if (time_before(jiffies, djrcv_dev->last_query + HZ / 2))
 		return;
=20
--=20
2.25.1

