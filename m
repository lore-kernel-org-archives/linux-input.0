Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABAC54EBD
	for <linux-input@archiver.kernel.org>; Fri,  6 Jan 2023 10:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjAFKZQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 Jan 2023 05:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjAFKYj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2023 05:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CC06C28A
        for <linux-input@vger.kernel.org>; Fri,  6 Jan 2023 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673000633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztyIBIxcHYqumQP7zYVgFBLV7rCWswuTV76ikP7BGbs=;
        b=PSKlEvWZo0dA9soSutd8MrmpOeDo0tTlL6+9FbGY4nVg6+WhXVtG7SIwot46Vh4Xd+dKAz
        GggFyIBs1ae77PaB4AjQsrN0LCVk9CSJHmE0k0l8Upmw6q8d3mf2h2kwVX91wZZnHd48zY
        rbCZrB51jZywB956fL7oGOf5TLMmEbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231--5QtOql2NIGxdsUPGnnDIQ-1; Fri, 06 Jan 2023 05:23:49 -0500
X-MC-Unique: -5QtOql2NIGxdsUPGnnDIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A246A802C1C;
        Fri,  6 Jan 2023 10:23:48 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0731C15BAD;
        Fri,  6 Jan 2023 10:23:46 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH HID for-next v1 4/9] selftests: hid: ensure the program is correctly pinned
Date:   Fri,  6 Jan 2023 11:23:27 +0100
Message-Id: <20230106102332.1019632-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20230106102332.1019632-1-benjamin.tissoires@redhat.com>
References: <20230106102332.1019632-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Turns out that if bpffs was not mounted, the test was silently passing.

So ensure it passes by checking the mount command result.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/hid_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index d215bb492eb4..3b204a15e44b 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -640,7 +640,8 @@ TEST_F(hid_bpf, test_attach_detach)
 
 	/* pin the first program and immediately unpin it */
 #define PIN_PATH "/sys/fs/bpf/hid_first_event"
-	bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	err = bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	ASSERT_OK(err) TH_LOG("error while calling bpf_program__pin");
 	remove(PIN_PATH);
 #undef PIN_PATH
 	usleep(100000);
-- 
2.38.1

