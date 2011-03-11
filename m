From: Richard Nauber <richard.nauber@googlemail.com>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Fri, 11 Mar 2011 07:02:06 +0100
Message-ID: <1299823326.1910.11.camel@itzy>
References: <20110308080414.GA2888@polaris.bitmath.org>
	 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	 <20110308091434.GA3282@polaris.bitmath.org>
	 <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
	 <20110308094630.GA3396@polaris.bitmath.org> <1299627518.2306.47.camel@itzy>
	 <20110309082455.GA3166@polaris.bitmath.org>
	 <AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
	 <20110309092337.GC3824@polaris.bitmath.org>
	 <AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
	 <20110309114038.GA9143@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44665 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1CKGCQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 01:02:16 -0500
Received: by wya21 with SMTP id 21so2138014wya.19
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2011 22:02:15 -0800 (PST)
In-Reply-To: <20110309114038.GA9143@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi,

Except for a missing comma, Henriks patch works fine for me and I would
be glad to have it submitted. So feel free to add my SIGNED-OFF-BY.
(Or should I repost the patch?)

Greetings and thanks to all,
Richard

--- snip ---

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 57575ff..ee01e65 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -131,7 +131,7 @@ struct mt_class mt_classes[] = {
        { .name = MT_CLS_EGALAX,
                .quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
                        MT_QUIRK_VALID_IS_INRANGE |
-                       MT_QUIRK_EGALAX_XYZ_FIXUP
+                       MT_QUIRK_EGALAX_XYZ_FIXUP,
                .maxcontacts = 2,
                .sn_move = 4096,
                .sn_pressure = 32,


