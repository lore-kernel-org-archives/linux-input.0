From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: multitouch: do not use pointers towards hid-core
Date: Thu, 7 Feb 2013 15:14:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302071514340.16860@pobox.suse.cz>
References: <1360149047-23061-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60557 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab3BGOPC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:15:02 -0500
In-Reply-To: <1360149047-23061-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 6 Feb 2013, Benjamin Tissoires wrote:

> The previous implementation registered a pointer towards hid-core
> to the value of contact count. This is not safe and may be difficult
> to debug if hid-core ever changes its implementation.
> The use of regular indexes is a better choice.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Applied this one on top of the previous hid-multitouch patchset. Thanks,

-- 
Jiri Kosina
SUSE Labs
