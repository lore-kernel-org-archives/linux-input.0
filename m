From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add battery quirk for USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO
 keyboard
Date: Wed, 17 Dec 2014 09:03:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412170903120.1680@pobox.suse.cz>
References: <1418744242.3923.1.camel@ntlworld.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40722 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbaLQID2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 03:03:28 -0500
In-Reply-To: <1418744242.3923.1.camel@ntlworld.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karl Relton <karllinuxtest.relton@ntlworld.com>
Cc: linux-input@vger.kernel.org

On Tue, 16 Dec 2014, Karl Relton wrote:

> Apple bluetooth wireless keyboard (sold in UK) has always reported zero
> for battery strength no matter what condition the batteries are actually
> in. With this patch applied (applying same quirk as other Apple
> keyboards), the battery strength is now correctly reported.
> 
> Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>

Applied to for-3.19/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs
