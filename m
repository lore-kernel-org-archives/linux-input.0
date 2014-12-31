From: Christopher Head <chead@chead.ca>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Tue, 30 Dec 2014 16:57:39 -0800
Message-ID: <20141230165739.050cc0b9@kruskal.home.chead.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chead.ca ([162.250.190.135]:34389 "EHLO chead.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbaLaBEq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Dec 2014 20:04:46 -0500
Received: from chead.ca (localhost [127.0.0.1])
	by chead.ca (Postfix) with ESMTP id 925609FC90
	for <linux-input@vger.kernel.org>; Tue, 30 Dec 2014 16:57:42 -0800 (PST)
Received: from kruskal.home.chead.ca (d154-5-96-139.bchsia.telus.net [154.5.96.139])
	by chead.ca (Postfix) with ESMTPSA id 415E19F71F
	for <linux-input@vger.kernel.org>; Tue, 30 Dec 2014 16:57:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I tried your patch on my North American Das Keyboard 4. In N-key
rollover mode the patch fixes the backslash problem. Unfortunately,
with the patch applied, when in 6-key rollover mode (which, if I
remember correctly, uses a one-byte DATA VAR ABS for modifiers and a
six-byte DATA ARRAY ABS for other keys, as usual for keyboards), the
last typed key repeats forever even after being released.

(Apologies for the lack of In-Reply-To header; I am not subscribed to
the list so had no message to reply to. Please CC me in replies if
necessary.)
-- 
Christopher Head
