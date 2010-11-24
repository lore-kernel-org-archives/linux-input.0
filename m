From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/4] Add acer wmi hotkey events support
Date: Wed, 24 Nov 2010 19:28:03 +0000
Message-ID: <201011241928.04174.carlos@strangeworlds.co.uk>
References: <1290620379-10133-1-git-send-email-jlee@novell.com> <1290620379-10133-2-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1290620379-10133-2-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: mjg59@srcf.ucam.org, corentin.chary@gmail.com, dmitry.torokhov@gmail.com, tiwai@novell.com, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>, Corentin Chary <corentincj@iksaif.net>
List-Id: linux-input@vger.kernel.org

On Wednesday 24 November 2010 17:39:36 Lee, Chun-Yi wrote:
> Add acer wmi hotkey event support. Install a wmi notify handler to
> transfer wmi event key to key code, then send out keycode through acer
> wmi input device to userland.
> 
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> Acked-by: Dmitry Torokhov <dtor@mail.ru>
> Acked-by: Thomas Renninger <trenn@suse.de>
> Acked-by: Jiri Benc <jbenc@suse.cz>

Please fix the typo. Otherwise:

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

[..]

> +static const struct key_entry acer_wmi_keymap[] = {
> +	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
> +	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
> +	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
> +	{KE_KEY, 0x22, {KEY_PROG2} },    /* Aracade */

s/Aracade/Arcade/
