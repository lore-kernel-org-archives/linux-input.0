From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Wed, 17 Feb 2010 13:41:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002171333460.30967@pobox.suse.cz>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45278 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757204Ab0BQMlv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 07:41:51 -0500
In-Reply-To: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 17 Feb 2010, Jari Vanhala wrote:

> TWL4030 Vibrator implemented via HID Force Feedback interface. This uses 
> MFD TWL4030 codec and own workqueue.

Hi Jari,

thanks for the driver.

> Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com> ---
>  drivers/hid/Kconfig             |    8 +
>  drivers/hid/Makefile            |    1 +
>  drivers/hid/hid-twl4030-vibra.c |  292 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-twl4030-vibra.c

As the device doesn't seem to be registering itself on the HID bus at all, 
I am not sure we want to put it together with all the HID drivers. Maybe 
drivers/input/misc would be more appropriate?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
