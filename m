Return-Path: <SRS0=yERA=CR=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084F2C433E2
	for <linux-input@archiver.kernel.org>; Tue,  8 Sep 2020 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF222087D
	for <linux-input@archiver.kernel.org>; Tue,  8 Sep 2020 19:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2X5f9mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgIHTPM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731181AbgIHQEs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2020 12:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599581084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCe3x3xeIPJ+YtSzXJCB5qKhA+maNGJtGJqwK8qcIV0=;
        b=L2X5f9mJArVRqDwUzDdenpoqq4CG9U0mLUIlfT0HZsbu1apBvr2xsuDGMatJAcA0PTY8MZ
        uGrX4+ewIWksLs4e4dWjaJjjodaGmk+wQH/EPlB/MJKj1SxNhDduzHX7up2ZisusNnskx3
        UCq4ePvAtatoKKvwya2xdYukAlSSP4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-orjpzNd4MWaz31XM1_0aTQ-1; Tue, 08 Sep 2020 09:51:57 -0400
X-MC-Unique: orjpzNd4MWaz31XM1_0aTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BC9E802B75;
        Tue,  8 Sep 2020 13:51:54 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-188.ams2.redhat.com [10.36.114.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF5C827CC2;
        Tue,  8 Sep 2020 13:51:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        Mark Pearson <mpearson@lenovo.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH v2 1/4] Input: allocate keycodes for notification-center, pickup-phone and hangup-phone
Date:   Tue,  8 Sep 2020 15:51:44 +0200
Message-Id: <20200908135147.4044-2-hdegoede@redhat.com>
In-Reply-To: <20200908135147.4044-1-hdegoede@redhat.com>
References: <20200908135147.4044-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

New Lenovo Thinkpad models, e.g. the X1 Carbon 8th gen and the new T14 gen1
models have 3 new symbols / shortcuts on their F9-F11 keys (and the
thinkpad_acpi driver receives 3 new "scancodes" for these):

F9:  Has a symbol resembling a rectangular speech balloon, the manual says
     the hotkey functions shows or hides the notification center
F10: Has a symbol of a telephone horn which has been picked up from the
     receiver, the manual says: "Answer incoming calls"
F11: Has a symbol of a telephone horn which is resting on the receiver,
     the manual says: "Decline incoming calls"

We have no existing keycodes which are a good match for these, so
add 3 new keycodes for these.

I noticed that we have a hole in our keycodes between 0x1ba and 0x1c0
which does not seem to be reserved for any specific purpose, so these
new 3 codes use 0x1bc - 0x1be, instead of starting at 0x27b.

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/uapi/linux/input-event-codes.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 0c2e27d28e0a..b74821d09145 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -515,6 +515,9 @@
 #define KEY_10CHANNELSUP	0x1b8	/* 10 channels up (10+) */
 #define KEY_10CHANNELSDOWN	0x1b9	/* 10 channels down (10-) */
 #define KEY_IMAGES		0x1ba	/* AL Image Browser */
+#define KEY_NOTIFICATION_CENTER	0x1bc	/* Show/hide the notification center */
+#define KEY_PICKUP_PHONE	0x1bd	/* Answer incoming call */
+#define KEY_HANGUP_PHONE	0x1be	/* Decline incoming call */
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
-- 
2.28.0

