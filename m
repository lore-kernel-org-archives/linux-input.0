From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] HID: Add HID_CLAIMED_OTHER for non-generic drivers
Date: Mon, 16 Jul 2012 20:45:30 +0200
Message-ID: <20120716184530.GA407@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:44838 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2GPSoq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 14:44:46 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 50726DAB3
	for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 20:44:45 +0200 (CEST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi David,

Perhaps one should make hid-core warn instead of bailing out instead?
Something may need to be done to make sure everything works smoothly,
but really, why would hid-core mind keeping a device on the bus with a
non-standard io driver?

Thanks,
Henrik
