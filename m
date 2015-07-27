From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: core: do not reject devices when they declare too
 many usages
Date: Mon, 27 Jul 2015 14:43:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507271443280.925@pobox.suse.cz>
References: <1437753742-3210-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49642 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbbG0Mnr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 08:43:47 -0400
In-Reply-To: <1437753742-3210-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?ISO-8859-15?Q?Simon_W=F6rner?= <mail@simon-woerner.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 24 Jul 2015, Benjamin Tissoires wrote:

> Some device present proprietary collections with a usage min of 0x00 and
> a usage max of 0xffff. hid-core currently reject them while most of the
> time this is harmless.
> Let's ignore the exceeding usages, and hope for the best.

Okay, why not, this should be really harmless.

Applied to for-4.3/upstream.

Thanks,

-- 
Jiri Kosina
SUSE Labs
