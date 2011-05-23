From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-multitouch: cosmetic changes, sort classes and
 devices
Date: Mon, 23 May 2011 11:18:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105231118390.28291@pobox.suse.cz>
References: <1305899974-5641-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48757 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab1EWJS7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 05:18:59 -0400
In-Reply-To: <1305899974-5641-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 20 May 2011, Benjamin Tissoires wrote:

> This patch sorts the defs for the MT_CLS. I choose to split
> generic classes and device specific ones to be able to add
> more generic classes in the future.
> 
> It also put eGalax devices at their right place (alphabetically)
> in mt_devices.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
> 
> Hi Jiri,
> 
> If you want, you can apply this one too. No semantic changes,
> just some sorting and corrections in KConfig.

OK, I like this fixup. Thanks Benjamin, applied.

-- 
Jiri Kosina
SUSE Labs
