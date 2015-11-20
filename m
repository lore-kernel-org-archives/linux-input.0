From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: add Logitech G710+ keyboard quirk NOGET
Date: Fri, 20 Nov 2015 10:21:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511201021370.20111@pobox.suse.cz>
References: <1448003428-7720-1-git-send-email-jimmy@boombatower.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51497 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161167AbbKTJV4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 04:21:56 -0500
In-Reply-To: <1448003428-7720-1-git-send-email-jimmy@boombatower.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jimmy Berry <jimmy@boombatower.com>
Cc: linux-input@vger.kernel.org

On Fri, 20 Nov 2015, Jimmy Berry wrote:

> Without quirk keyboard repeats '6' until volume control is used since it
> indicates the key is pressed without ever releasing.
> 
> Signed-off-by: Jimmy Berry <jimmy@boombatower.com>

Applied to for-4.4/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

