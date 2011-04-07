From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Thu, 07 Apr 2011 18:01:39 +0100
Message-ID: <4D9DEDF3.1090502@cam.ac.uk>
References: <20110407181800.27b441b1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34717 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab1DGRAA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Apr 2011 13:00:00 -0400
In-Reply-To: <20110407181800.27b441b1@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Matthew Garrett <mjg@redhat.com>, Andy Ross <andy.ross@windriver.com>, Corentin Chary <corentin.chary@gmail.com>

On 04/07/11 17:18, Anisse Astier wrote:
> 
> Pegatron Lucid tablet sends an ACPI hotkey event(0xEA) when the
> accelerometer detects coarse orientation change. My initial thought was
> to just translate this event into KEY_DIRECTION, which seems to be the
> norm from what we can see in hp-wmi driver. (See patch below for an
> implementation.)
> 
> But this isn't just a key per se like on the HP touchsmart tablet, this
> is an event that is triggered when the device is rotated.
> 
> This could be defined as a new Misc (EV_MSC) event:
> MSC_ORIENTATION_CHANGED ?
> 
> Or we could use the upcoming IIO subsystem which is supposed to be for
> sensors, but then we'd have a mismatch between the device based on ACPI
> with firmware in the middle (driver submitted by Andy Ross) and the
> purpose of IIO ("SPI or I2C device").
Don't take that too literally. It's examples of types of bus IIO sensors use.
Having said this, if your main use is user input then it should probably be
handled through input rather than IIO anyway.

> 
> Maybe I'm over-thinking this and this might be just right:
> 
> From: Anisse Astier <anisse@astier.eu>
> Subject: [PATCH RFC] asus-laptop: Send input key for tablet rotation on Pegatron Lucid Tablet
> 
> Pegatron Lucid tablet sends ACPI event on coarse orientation changes.
> Translate this into KEY_DIRECTION input event.
> 
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Cc: Matthew Garrett <mjg@redhat.com>
> Cc: Andy Ross <andy.ross@windriver.com>
> Cc: Corentin Chary <corentin.chary@gmail.com>
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
> Please note that this patch depends on Andy Ross's first patch in order for
> asus-laptop to bind with the tablet.
> 
> Regards,
> 
> Anisse
> ---
>  drivers/platform/x86/asus-laptop.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 5c23b20..decb958 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -312,6 +312,8 @@ static const struct key_entry asus_keymap[] = {
>  	{KE_KEY, 0xc4, { KEY_KBDILLUMUP } },
>  	{KE_KEY, 0xc5, { KEY_KBDILLUMDOWN } },
>  	{KE_KEY, 0xb5, { KEY_CALC } },
> +	/* Pegatron Lucid tablet specific */
> +	{KE_KEY, 0xEA, { KEY_DIRECTION } }, /* Orientation changed */
>  	{KE_END, 0},
>  };
>  

