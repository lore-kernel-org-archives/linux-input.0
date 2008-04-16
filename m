From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 7/8] HID: move apple quirks
Date: Wed, 16 Apr 2008 15:45:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804161544490.12972@jikos.suse.cz>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com>
 <1207341357-17792-8-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:39709 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750802AbYDPNpe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 09:45:34 -0400
In-Reply-To: <1207341357-17792-8-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jslaby@suse.cz>

On Fri, 4 Apr 2008, Jiri Slaby wrote:

> Move them from core code to separate driver.
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/hid/Kconfig             |    7 +
>  drivers/hid/Makefile            |    1 +
>  drivers/hid/hid-apple.c         |  496 +++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c          |   33 +++-
>  drivers/hid/hid-input-quirks.c  |    8 -
>  drivers/hid/hid-input.c         |  218 +-----------------
>  drivers/hid/usbhid/hid-quirks.c |   43 ----
>  include/linux/hid.h             |   11 -
>  net/bluetooth/hidp/core.c       |   22 --

Hi Jiri,

how is the bluetooth quirk code removal related to the rest of the patch 
(apple quirks movement) please?

Thanks,

-- 
Jiri Kosina
SUSE Labs
