From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Introduces Plantronics driver to fix errant mouse
 events.
Date: Fri, 31 Oct 2014 16:53:42 -0700
Message-ID: <20141031235342.GA11631@dtor-ws>
References: <512A3191-0BAA-4E92-A863-66AFD2A16422@plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:39243 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbaJaXxr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 19:53:47 -0400
Received: by mail-ig0-f177.google.com with SMTP id hl2so1869663igb.4
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 16:53:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <512A3191-0BAA-4E92-A863-66AFD2A16422@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Cole, JD" <JD.Cole@plantronics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "bleung@chromium.org" <bleung@chromium.org>, "Junge, Terry" <Terry.Junge@plantronics.com>, "Dsouza, Sunil" <Sunil.Dsouza@plantronics.com>, "Wesselman, Tom" <Tom.Wesselman@plantronics.com>

Hi JD,

On Fri, Oct 31, 2014 at 07:20:13PM +0000, Cole, JD wrote:
> This version of the driver prevents Telephony pages which are not
> mapped as Consumer Control applications AND are not on the Consumer Page
> from being registered by the hid-input driver.
> 
> Signed-off-by: JD Cole <jd.cole@plantronics.com>
> ---
> drivers/hid/Kconfig           |    7 ++++
> drivers/hid/Makefile          |    1 +
> drivers/hid/hid-core.c        |    1 +
> drivers/hid/hid-ids.h         |    2 ++
> drivers/hid/hid-plantronics.c |   78 +++++++++++++++++++++++++++++++++++++++++
> include/linux/hid.h           |    3 ++
> 6 files changed, 92 insertions(+)
> create mode 100644 drivers/hid/hid-plantronics.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f42df4d..bf1c74e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -613,6 +613,13 @@ config HID_PICOLCD_CIR
>         ---help---
>           Provide access to PicoLCD's CIR interface via remote control (LIRC).
> 
> +config HID_PLANTRONICS
> +       tristate "Plantronics USB HID Driver"
> +       default !EXPERT
> +       depends on HID
> +       ---help---
> +       Provides HID support for Plantronics telephony devices.
> +

It looks like your MUA or MTA converted all TABs into spaces. Could you
please try resending?

Thanks!

-- 
Dmitry
