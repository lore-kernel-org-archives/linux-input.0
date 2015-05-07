From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Revert "HID: logitech-hidpp: support combo keyboard
 touchpad TK820"
Date: Thu, 7 May 2015 10:52:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071051160.8186@pobox.suse.cz>
References: <1430938891-28814-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbbEGIwH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 04:52:07 -0400
In-Reply-To: <1430938891-28814-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 6 May 2015, Benjamin Tissoires wrote:

> This reverts commit 3a61e97563d78a2ca10752902449570d8433ce76.

Revert seems to be the best way for 4.1 given the circumstances, I agree.

Queued in for-4.1/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs
