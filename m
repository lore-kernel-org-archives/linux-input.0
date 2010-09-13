From: Steffen Barszus <steffenbpunkt@googlemail.com>
Subject: Re: gyration remote - europe/QWERTZ version (GYAR3101CKDE)
Date: Mon, 13 Sep 2010 08:22:19 +0200
Message-ID: <20100913082219.2d8ebbbc@grobi>
References: <20100809083831.76426571@grobi>
	<AANLkTin4bsd4SAfy35SzaEMR-S+moALGcNMfzttmJQ6U@mail.gmail.com>
	<alpine.LNX.2.00.1008201111220.1019@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46168 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0IMG3R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 02:29:17 -0400
Received: by fxm16 with SMTP id 16so2929281fxm.19
        for <linux-input@vger.kernel.org>; Sun, 12 Sep 2010 23:29:15 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008201111220.1019@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

On Fri, 20 Aug 2010 11:12:18 +0200 (CEST)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Thu, 19 Aug 2010, Steffen Barszus wrote:
> 
> > Any chance someone can have a look or is something missing ? Is
> > this the wrong place ? Or just bad timing because of the merge
> > window ? Would love to see this incorporated.
> 
> Hi,
> 
> I haven't been CCed on your original mail, was I?

No

> Anyway, would you be able to send the patch properly to me, so that I 
> could apply it? (i.e. not line-wrapped and whitespace damaged, with
> proper Signed-off-by line, etc -- see Documentation/SubmittingPatches
> if in doubt).

Hope this time its correct. Please let me know if you miss something.

> Thanks,
> 

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

