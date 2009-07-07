From: Hector Martin <hector@marcansoft.com>
Subject: Hold and Volume Notify keys
Date: Tue, 07 Jul 2009 17:06:45 +0200
Message-ID: <4A536485.2030503@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:54127 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144AbZGGPOc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2009 11:14:32 -0400
Received: from [192.168.3.171] (85.Red-88-24-251.staticIP.rima-tde.net [88.24.251.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.marcansoft.com (Postfix) with ESMTPSA id 598141E8009
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2009 17:06:46 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Newer Acer laptops have a touch-sensitive media panel thing which
produces keyboard events. There's a Hold key so it looks like I need a
KEY_HOLD. However, the key on this laptop acts as a hardware toggle
switch and produces two different keyboard scancodes: one when the hold
is engaged, and one when it is disengaged. It is useful for userspace to
distinguish between the two to properly interact with the volume
controls in particular. I'm not sure if adding a KEY_HOLDON and a
KEY_HOLDOFF is the right thing to do, though.

The volume slider on the media panel normally produces the usual
volume-up/down , but when it is configured in non-legacy mode (where
software can interact with it and control it) it instead produces a
single "volume event notification" key when anything changes. Looks like
I also need a key event for that (KEY_VOLUMENOTIFY? I'm open to any
suggestions).

Also, what numbers should I pick for the new KEY_ events? Is there an
established convention or do I just pick some unused region within the
KEY_* area?


-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

