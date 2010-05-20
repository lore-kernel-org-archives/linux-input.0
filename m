From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH][RFC] input: Add KEY_MIC_MUTE
Date: Thu, 20 May 2010 11:50:28 -0500
Message-ID: <1274374228.24413.150.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53889 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0ETQui (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 12:50:38 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OF8x9-0001da-HO
	for <linux-input@vger.kernel.org>; Thu, 20 May 2010 17:50:35 +0100
Received: from adsl-70-249-74-11.dsl.austtx.swbell.net ([70.249.74.11] helo=[10.1.106.184])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <jerone.young@canonical.com>)
	id 1OF8x9-0001uZ-33
	for linux-input@vger.kernel.org; Thu, 20 May 2010 17:50:35 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Today Lenovo Thinkpads are coming with a new key for muting the
microphone. They started this with the T400s & it is now on T410(s)/510,
W510/W710, L412/512, X100e, Edge 13/14/15 Thinkpads. Currently 12
models, with more coming in the foreseeable future.

I want to define a keycode for microphone mute to be able take advantage
of this key in userspace.

The only issue is I'm not sure the best code to use, or if these are
defined from somewhere else? Here is what I propose .. though feedback
would be greatly appreciated.

Signed-off-by: Jerone Young <jerone.young@canonical.com>


diff --git a/include/linux/input.h b/include/linux/input.h
index 746d426..ca5373a 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -377,6 +377,8 @@ struct input_absinfo {
 
 #define KEY_WIMAX              246
 
+#define KEY_MICROPHONE_MUTE           247     /* mute microphone */
+
 /* Range 248 - 255 is reserved for special needs of AT keyboard driver
*/
 
 #define BTN_MISC               0x100


