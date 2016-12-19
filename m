From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: wacom: generic: add 5 tablet touch keys
Date: Mon, 19 Dec 2016 11:30:13 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191129190.19203@cbobk.fhfr.pm>
References: <1481930680-6023-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbcLSKaQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:30:16 -0500
In-Reply-To: <1481930680-6023-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, jason.gerecke@wacom.com, dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Fri, 16 Dec 2016, Ping Cheng wrote:

> Wacom Cintiq Pro [1] is a series of display tablets. They support
> 5 touch keys on the tablet. Those keys represent specific functions.
> They turn display off; bring up OSD; bring up On Screen Keyboard;
> bring up desktop control panel; and turn touch on/off.
> 
> The most left touch key, that turns display on/off, is controlled by
> firmware. When the display is on, the mode is set. Otherwise, the
> mode is off. So, it works like a switch. That's why we introduced a
> new switch: SW_INDIRECT. The switch defauts to INDIRECT instead of DIRECT
> was a request from useland, more specifically Gnome, developers.
> 
> Other four touch keys are true software keys. We use the existing
> KEY_BUTTONCONFIG and KEY_CONTROLPANEL for OSD and control panel. But,
> we have to request two new keys: KEY_ONSCREEN_KEYBOARD and KEY_MUTE_DEVICE
> since none of the existing keys support those two actions.
> 
> [1] http://www.wacom.com/en-us/products/pen-displays/wacom-cintiq-pro
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
> v3: Since no one has followed up with v2, let's add some more comments for
> SW_INDIRECT so we keep the offlist decision public ;).

[ ... snip ... ]

> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index d6d071f..32ef894 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -641,6 +641,9 @@
>   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
>   */
>  #define KEY_DATA			0x275
> +/* same as SW_MUTE_DEVICE but triggered by a key */
> +#define KEY_MUTE_DEVICE 		0x278
> +#define KEY_ONSCREEN_KEYBOARD		0x279
>  
>  #define BTN_TRIGGER_HAPPY		0x2c0
>  #define BTN_TRIGGER_HAPPY1		0x2c0
> @@ -781,7 +784,8 @@
>  #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
>  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
>  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
> -#define SW_MAX			0x0f
> +#define SW_INDIRECT		0x10  /* set = not a direct input device */
> +#define SW_MAX			0x1f

I'd like to have explicit Ack from Dmitry on these ... Dmitry?

Thanks,

-- 
Jiri Kosina
SUSE Labs

