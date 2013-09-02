From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] Input: introduce BTN/ABS bits for drums and
 guitars
Date: Mon, 2 Sep 2013 13:41:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309021341090.3796@pobox.suse.cz>
References: <1377537288-19289-1-git-send-email-dh.herrmann@gmail.com> <1377537288-19289-2-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48200 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab3IBLmB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Sep 2013 07:42:01 -0400
In-Reply-To: <1377537288-19289-2-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 26 Aug 2013, David Herrmann wrote:

> There are a bunch of guitar and drums devices out there that all report
> similar data. To avoid reporting this as BTN_MISC or ABS_MISC, we
> allocate some proper namespace for them. Note that most of these devices
> are toys and we cannot report any sophisticated physics via this API.
> 
> I did some google-images research and tried to provide definitions that
> work with all common devices. That's why I went with 4 toms, 4 cymbals,
> one bass, one hi-hat. I haven't seen other drums and I doubt that we need
> any additions to that. Anyway, the naming-scheme is intentionally done in
> an extensible way.
> 
> For guitars, we support 5 frets (normally aligned vertically, compared to
> the real horizontal layouts), a single strum-bar with up/down directions,
> an optional fret-board and a whammy-bar.
> 
> Most of the devices provide pressure values so I went with ABS_* bits. If
> we ever support devices which only provide digital input, we have to
> decide whether to emulate pressure data or add additional BTN_* bits.
> 
> If someone is not familiar with these devices, here are two pictures which
> provide almost all introduced interfaces (or try the given keywords
> with a google-image search):
>   Guitar: ("guitar hero world tour guitar")
>     http://images1.wikia.nocookie.net/__cb20120911023442/applezone/es/images/f/f9/Wii_Guitar.jpg
>   Drums: ("guitar hero drums")
>     http://oyster.ignimgs.com/franchises/images/03/55/35526_band-hero-drum-set-hands-on-20090929040735768.jpg
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Hi,

I have reviewed and like the implementation of 2/3 and 3/3, but I of 
course would like to have Ack from Dmitry for this, so that I could take 
it through my tree together with the rest of the patchset.

Dmitry, pretty please?

Thanks.

> ---
>  include/linux/mod_devicetable.h |  2 +-
>  include/uapi/linux/input.h      | 25 +++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 45e9214..329aa30 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -277,7 +277,7 @@ struct pcmcia_device_id {
>  #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
>  #define INPUT_DEVICE_ID_KEY_MAX		0x2ff
>  #define INPUT_DEVICE_ID_REL_MAX		0x0f
> -#define INPUT_DEVICE_ID_ABS_MAX		0x3f
> +#define INPUT_DEVICE_ID_ABS_MAX		0x4f
>  #define INPUT_DEVICE_ID_MSC_MAX		0x07
>  #define INPUT_DEVICE_ID_LED_MAX		0x0f
>  #define INPUT_DEVICE_ID_SND_MAX		0x07
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index d584047..76457ee 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -716,6 +716,14 @@ struct input_keymap_entry {
>  #define BTN_DPAD_LEFT		0x222
>  #define BTN_DPAD_RIGHT		0x223
>  
> +#define BTN_FRET_FAR_UP		0x224
> +#define BTN_FRET_UP		0x225
> +#define BTN_FRET_MID		0x226
> +#define BTN_FRET_LOW		0x227
> +#define BTN_FRET_FAR_LOW	0x228
> +#define BTN_STRUM_BAR_UP	0x229
> +#define BTN_STRUM_BAR_DOWN	0x22a
> +
>  #define BTN_TRIGGER_HAPPY		0x2c0
>  #define BTN_TRIGGER_HAPPY1		0x2c0
>  #define BTN_TRIGGER_HAPPY2		0x2c1
> @@ -829,8 +837,21 @@ struct input_keymap_entry {
>  #define ABS_MT_TOOL_X		0x3c	/* Center X tool position */
>  #define ABS_MT_TOOL_Y		0x3d	/* Center Y tool position */
>  
> -
> -#define ABS_MAX			0x3f
> +/* Drums and guitars (mostly toys) */
> +#define ABS_TOM_FAR_LEFT	0x40
> +#define ABS_TOM_LEFT		0x41
> +#define ABS_TOM_RIGHT		0x42
> +#define ABS_TOM_FAR_RIGHT	0x43
> +#define ABS_CYMBAL_FAR_LEFT	0x44
> +#define ABS_CYMBAL_LEFT		0x45
> +#define ABS_CYMBAL_RIGHT	0x46
> +#define ABS_CYMBAL_FAR_RIGHT	0x47
> +#define ABS_BASS		0x48
> +#define ABS_HI_HAT		0x49
> +#define ABS_FRET_BOARD		0x4a	/* Guitar fret board, vertical pos */
> +#define ABS_WHAMMY_BAR		0x4b	/* Guitar whammy bar (or vibrato) */
> +
> +#define ABS_MAX			0x4f
>  #define ABS_CNT			(ABS_MAX+1)
>  
>  /*
> -- 
> 1.8.4
> 

-- 
Jiri Kosina
SUSE Labs
