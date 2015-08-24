From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: quirks: add QUIRK_NOGET for an other TPV
 touchscreen
Date: Mon, 24 Aug 2015 14:02:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508241402070.25821@pobox.suse.cz>
References: <1440166688-4879-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44875 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbbHXMCU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2015 08:02:20 -0400
In-Reply-To: <1440166688-4879-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Blaine Lee <blaine.j.lee@medtronic.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 21 Aug 2015, Benjamin Tissoires wrote:

> Looks like 0x8882 needs the same quirk than 0x8883.
> Given that both devices claim they are "TPV OpticalTouchScreen" rename
> the 0x8883 to add its PID in the #define.
> 
> Reported-by: Blaine Lee <blaine.j.lee@medtronic.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.3/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

