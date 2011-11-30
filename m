From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: multitouch: merge quanta driver into
 hid-multitouch
Date: Wed, 30 Nov 2011 15:41:30 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111301541130.4648@pobox.suse.cz>
References: <1322568792-4432-1-git-send-email-benjamin.tissoires@enac.fr> <1322568792-4432-2-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53342 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755814Ab1K3Olc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Nov 2011 09:41:32 -0500
In-Reply-To: <1322568792-4432-2-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 29 Nov 2011, Benjamin Tissoires wrote:

> From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> 
> This patch merge the last old-style hid multitouch driver to
> the generic one.
> It also adds 2 more quanta pids.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/Kconfig          |    7 +-
>  drivers/hid/Makefile         |    1 -
>  drivers/hid/hid-ids.h        |    4 +-
>  drivers/hid/hid-multitouch.c |   23 +++-
>  drivers/hid/hid-quanta.c     |  261 ------------------------------------------

Excellent, good job. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
