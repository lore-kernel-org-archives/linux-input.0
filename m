From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2 v2] HID: magicmouse: Removing report_touches switch
Date: Wed, 4 Jul 2012 10:38:41 +0200
Message-ID: <20120704083841.GA722@polaris.bitmath.org>
References: <1341341621-15560-1-git-send-email-miletus@chromium.org>
 <4FF35597.7020408@canonical.com>
 <20120704074049.GA380@polaris.bitmath.org>
 <CAGS+omDHQkWdmETOwaDu3nkAQEhJeNkLDdDmF+4N=XDTO6+FWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:39226 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2GDIiU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 04:38:20 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omDHQkWdmETOwaDu3nkAQEhJeNkLDdDmF+4N=XDTO6+FWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Andrew de los Reyes <adlr@chromium.org>

Hi Daniel,

> What Bluetooth host controller are you using?

It is a USB device (0a5c:4500), part of a BCM2046 sitting in a MacBook
Air. The driver is btusb.

> Which part are you testing (Magic TP or mouse)?

Magic trackpad.

> I've been trying to test these patches on a Magic Trackpad using two
> computers, with two different ath3k parts.
> On one of them, the BT communication freezes immediately after the
> first report with 3 fingers.
> On the other, it reports all 10 fingers, just fine.

Interesting. Clearly not a HID problem, then.

> The only difference I can tell is the version of the Atheros Bluetooth chip.
> 
> What does your freeze look like?

The input events stop coming when I have more than four fingers on the
pad, but they start again if I remove the excess fingers. As if the
transport layer chokes on messages longer than some value...

Thanks,
Henrik
