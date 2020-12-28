Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A56C43142
	for <linux-input@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BA8222F9
	for <linux-input@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgL1Wzz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbgL1UzA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Dec 2020 15:55:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9557C06179B;
        Mon, 28 Dec 2020 12:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ut9bABGWC1jsjzFpFRlCDxYQtxee7nxj5/jV/VNYK7Y=; b=VWj1smeQ7GlF5YUGH1riVLDy7g
        aJFaZUrwRBO0SFc7ClDV38IffzNz0VD9mTC4WdDtenQfNmWBCUFqsLmpFmeFW56pe1qa6KgU/fQG7
        5hyJ4cl3k1koHfnSRLdbYHgvn0D8XXhdDTXZZo8KDAsspScD77Sz8nBRsrIizAoWsNFcuBlprf16n
        JAaUgsXi5fp01xf15CW/aGg13ICXliMQQVq40hvIS0c7UYBHuKTvmzkJAC4R17DJURZKxTLNYIDS2
        h/99b+i7ajybvkYGaHGkeuhW0hvHeGtjth6XE7oWprizsGOinuKFZiIXQFj/e8zVLW2Iuy85jYsIU
        2MnrPYUQ==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktzWb-0002ml-IZ; Mon, 28 Dec 2020 20:53:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Alan Ott <alan@signal11.us>
Subject: [PATCH v2 5/8] Documentation: HID: hidraw editing & corrections
Date:   Mon, 28 Dec 2020 12:53:24 -0800
Message-Id: <20201228205327.1063-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201228205327.1063-1-rdunlap@infradead.org>
References: <20201228205327.1063-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


Do basic editing & correction to hidraw.rst:
- use "hidraw" consistently except at the beginning of a sentence
- add archive.org URL for signal11.us since the latter seems to be MIA
- use a list for 2 URLs so that they don't run together


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
---
v2: rebase & resend

 Documentation/hid/hidraw.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/hidraw.rst
+++ linux-next-20201201/Documentation/hid/hidraw.rst
@@ -21,7 +21,7 @@ Hidraw is the only alternative, short of
 these non-conformant devices.
 
 A benefit of hidraw is that its use by userspace applications is independent
-of the underlying hardware type.  Currently, Hidraw is implemented for USB
+of the underlying hardware type.  Currently, hidraw is implemented for USB
 and Bluetooth.  In the future, as new hardware bus types are developed which
 use the HID specification, hidraw will be expanded to add support for these
 new bus types.
@@ -31,9 +31,10 @@ create hidraw device nodes.  Udev will t
 directly under /dev (eg: /dev/hidraw0).  As this location is distribution-
 and udev rule-dependent, applications should use libudev to locate hidraw
 devices attached to the system.  There is a tutorial on libudev with a
-working example at:
+working example at::
 
 	http://www.signal11.us/oss/udev/
+	https://web.archive.org/web/2019*/www.signal11.us
 
 The HIDRAW API
 ---------------
