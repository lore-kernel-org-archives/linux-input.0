From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] HID: avoid sparse warning in HID_COMPAT_LOAD_DRIVER
Date: Tue, 16 Dec 2008 13:31:31 +0100
Message-ID: <4947a48f.08b6660a.34ca.ffffa1e8@mx.google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:20188 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbYLPMwe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 07:52:34 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1673909muf.1
        for <linux-input@vger.kernel.org>; Tue, 16 Dec 2008 04:52:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Impact: include a prototype for the exported function in the macro

Fix about 20 of this warnings:

  drivers/hid/hid-a4tech.c:162:1: warning: symbol 'hid_compat_a4tech' was not declared. Should it be static?

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 include/linux/hid.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 215035b..81aa84d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -793,6 +793,8 @@ dbg_hid(const char *fmt, ...)
 
 #ifdef CONFIG_HID_COMPAT
 #define HID_COMPAT_LOAD_DRIVER(name)	\
+/* prototype to avoid sparse warning */	\
+extern void hid_compat_##name(void);	\
 void hid_compat_##name(void) { }	\
 EXPORT_SYMBOL(hid_compat_##name)
 #else
-- 
1.5.6.3

