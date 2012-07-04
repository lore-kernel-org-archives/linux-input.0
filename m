From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2 v2] HID: magicmouse: Removing report_touches switch
Date: Wed, 4 Jul 2012 20:41:57 +0200
Message-ID: <20120704184157.GA272@polaris.bitmath.org>
References: <1341341621-15560-1-git-send-email-miletus@chromium.org>
 <4FF35597.7020408@canonical.com>
 <20120704074049.GA380@polaris.bitmath.org>
 <CAGS+omDHQkWdmETOwaDu3nkAQEhJeNkLDdDmF+4N=XDTO6+FWg@mail.gmail.com>
 <20120704083841.GA722@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:33683 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab2GDSle (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 14:41:34 -0400
Content-Disposition: inline
In-Reply-To: <20120704083841.GA722@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Andrew de los Reyes <adlr@chromium.org>

> The input events stop coming when I have more than four fingers on the
> pad, but they start again if I remove the excess fingers. As if the
> transport layer chokes on messages longer than some value...

Yep, that's it. On my system, something sets the L2CAP MTU to a
whopping 48 bytes, and the code below, from l2cap_core.c,

	switch (chan->mode) {
	case L2CAP_MODE_BASIC:
		/* If socket recv buffers overflows we drop data here
		 * which is *bad* because L2CAP has to be reliable.
		 * But we don't have any other choice. L2CAP doesn't
		 * provide flow control mechanism. */

		if (chan->imtu < skb->len)
			goto drop;

silently ignores packets larger than that value. Duh.

Henrik
