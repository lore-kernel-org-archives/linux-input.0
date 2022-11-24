Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D94C433FE
	for <linux-input@archiver.kernel.org>; Thu, 24 Nov 2022 15:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiKXPTy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Nov 2022 10:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKXPTJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Nov 2022 10:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DF16F0F7
        for <linux-input@vger.kernel.org>; Thu, 24 Nov 2022 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669302989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVpzZ9PuKYYYwbqGuIV03fYvtpDzSokFyED3tXA9BEI=;
        b=CoG6sDvyAH33hagPv4mXJpilRRmJiC0QiKv4ZRwc6WXkj+EJoHqaSLIqrpP8UVnX1HVnPH
        jtbB8vl0E78RuamI9scY9vNIkRwL6QuqqWtRn2Gm+4SYtBYtOqikM/6ZfOrqawZTV/5Kbv
        77cbMm+oX1x2vrQH9P1wYSkqxtoNJ/A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-nlR9u26LOHi58kiUJjaWYA-1; Thu, 24 Nov 2022 10:16:28 -0500
X-MC-Unique: nlR9u26LOHi58kiUJjaWYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B97293C01E0F;
        Thu, 24 Nov 2022 15:16:27 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06D4940C2064;
        Thu, 24 Nov 2022 15:16:25 +0000 (UTC)
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
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC hid v1 09/10] selftests: hid: ensure the program is correctly pinned
Date:   Thu, 24 Nov 2022 16:16:02 +0100
Message-Id: <20221124151603.807536-10-benjamin.tissoires@redhat.com>
In-Reply-To: <20221124151603.807536-1-benjamin.tissoires@redhat.com>
References: <20221124151603.807536-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Turns out that if bpffs was not mounted, the test was silently passing.

So ensure it passes, but also force the mount of the bpffs in vmtest.sh
so we get passing results.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/hid_bpf.c | 3 ++-
 tools/testing/selftests/hid/vmtest.sh | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 4bdd1cfa7d13..3ae544bf24fe 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -712,7 +712,8 @@ TEST_F(hid_bpf, test_attach_detach)
 
 	/* pin the program and immediately unpin it */
 #define PIN_PATH "/sys/fs/bpf/hid_first_event"
-	bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	err = bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	ASSERT_OK(err) TH_LOG("error while calling bpf_program__pin");
 	remove(PIN_PATH);
 #undef PIN_PATH
 	usleep(100000);
diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index f124cf6b0d0f..bd60f65acb72 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -108,8 +108,10 @@ EOF
 	if [[ "${debug_shell}" != "yes" ]]
 	then
 		touch ${OUTPUT_DIR}/${LOG_FILE}
-		command="set -o pipefail ; ${command} 2>&1 | tee ${OUTPUT_DIR}/${LOG_FILE}"
+		command="mount bpffs -t bpf /sys/fs/bpf/; set -o pipefail ; ${command} 2>&1 | tee ${OUTPUT_DIR}/${LOG_FILE}"
 		post_command="cat ${OUTPUT_DIR}/${LOG_FILE}"
+	else
+		command="mount bpffs -t bpf /sys/fs/bpf/; ${command}"
 	fi
 
 	set +e
-- 
2.38.1

