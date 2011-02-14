From: Steffen Barszus <steffenbpunkt@googlemail.com>
Subject: Add teletext/color keys - gyration remote - EU version
 (GYAR3101CKDE)
Date: Mon, 14 Feb 2011 19:53:48 +0100
Message-ID: <20110214195348.568f92b3@grobi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36234 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1BNS44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Feb 2011 13:56:56 -0500
Received: by bwz15 with SMTP id 15so5776124bwz.19
        for <linux-input@vger.kernel.org>; Mon, 14 Feb 2011 10:56:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Dear List/Jiri,

This patch adds support for 5 keys which can be found
only on the EU version of the gyration remote, which has been not
mapped before. 

Signed-off-by: Steffen Barszus <steffenbpunkt[AT]googlemail[DOT]com>
--- linux-2.6/drivers/hid/hid-gyration.c.orig	2010-09-13 08:16:36.353369149 +0200
+++ linux-2.6/drivers/hid/hid-gyration.c	2010-09-13 08:17:56.629965460 +0200
@@ -43,6 +43,11 @@ static int gyration_input_mapping(struct
 	case 0x048: gy_map_key_clear(KEY_MEDIA);	break;
 	case 0x049: gy_map_key_clear(KEY_CAMERA);	break;
 	case 0x04a: gy_map_key_clear(KEY_VIDEO);	break;
+	case 0x05a: gy_map_key_clear(KEY_TEXT);		break;
+	case 0x05b: gy_map_key_clear(KEY_RED);		break;
+	case 0x05c: gy_map_key_clear(KEY_GREEN);	break;
+	case 0x05d: gy_map_key_clear(KEY_YELLOW);	break;
+	case 0x05e: gy_map_key_clear(KEY_BLUE);		break;
 
 	default:
 		return 0;

