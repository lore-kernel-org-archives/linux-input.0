From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH 1/2] Support for Stantum multitouch panel
Date: Wed, 09 Dec 2009 22:49:03 +0100
Message-ID: <20091209214903.D3A5D9520B@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:48561 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbZLIV4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 16:56:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Extended IS_INPUT_APPLICATION to accept digitzers that are actual input devices (touchscreens, 
light pens, touch pads, white boards)

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -uprN a/include/linux/hid.h b/include/linux/hid.h
--- a/include/linux/hid.h	2009-12-03 04:51:21.000000000 +0100
+++ b/include/linux/hid.h	2009-12-08 22:30:46.000000000 +0100
@@ -662,7 +662,7 @@ struct hid_ll_driver {
 
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
-#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || (a == 0x000d0002))
+#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
 
 /* HID core API */
 
