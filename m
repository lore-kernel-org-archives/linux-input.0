From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2 35/37] input: add a EV_SW event for ratchet switch
Date: Wed, 5 Apr 2017 22:03:03 +1000
Message-ID: <20170405120303.GA21280@jelly>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:63230 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbdDEMD1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Apr 2017 08:03:27 -0400
Content-Disposition: inline
In-Reply-To: <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Stuart Yoder <stuart.yoder@nxp.com>, "David S. Miller" <davem@davemloft.net>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Florian Fainelli <f.fainelli@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Ping Cheng <pinglinux@gmail.com>, Douglas Anderson <dianders@chromium.org>, Kamil Debski <kamil@wypas.org>

On Tue, Apr 04, 2017 at 09:22:35AM -0300, Mauro Carvalho Chehab wrote:
> Some mouses have a switch on their wheel, allowing to switch

isnt' the plural of mouse mice? (non-native english speaker myself)

> between ratchet or free wheel mode. Add support for it.

s/or/and/

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  Documentation/input/event-codes.rst    | 16 ++++++++++++++++
>  include/linux/mod_devicetable.h        |  2 +-
>  include/uapi/linux/input-event-codes.h |  4 +++-
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index 0c8591d39bc6..93f14f0ddb3d 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -239,6 +239,22 @@ Upon resume, if the switch state is the same as before suspend, then the input
>  subsystem will filter out the duplicate switch state reports. The driver does
>  not need to keep the state of the switch at any time.
>  
> +A few EV_SW codes have special meanings:
> +
> +* SW_RATCHET:
> +
> +  - Some mouses have a special switch at their wheel that allows to change
> +    from free wheel mode to ratchet mode.

"between free wheel mode and ratchet mode"

> +
> +    When such switch is ratchet mode (ON state), the wheel will offer some

s/such/the/

> +    resistance for movements movement. It will also provide a tactile
> +    feedback when scrolled.

this is too specific, you cannot guarantee that all devices in the future
have exactly that behaviour. I would just skip the second sentence.

> +
> +    When pressed while in ratchet mode, the wheel will switch to free wheel
> +    mode (OFF state). In this mode, it will offer no resistance to wheel
> +    movements nor any tactile feedback. Pressing again returns to ratchet
> +    mode.

nack to this, this is your device but not all future devices will have this
behaviour. e.g. some devices have the ratchet switch below (i.e. south of)
the weel. Just describe the effect the switch has, not the physical
behaviour.

Cheers,
   Peter

> +
>  EV_MSC
>  ------
>  
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 8850fcaf50db..038cddf1436a 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -292,7 +292,7 @@ struct pcmcia_device_id {
>  #define INPUT_DEVICE_ID_LED_MAX		0x0f
>  #define INPUT_DEVICE_ID_SND_MAX		0x07
>  #define INPUT_DEVICE_ID_FF_MAX		0x7f
> -#define INPUT_DEVICE_ID_SW_MAX		0x0f
> +#define INPUT_DEVICE_ID_SW_MAX		0x1f
>  
>  #define INPUT_DEVICE_ID_MATCH_BUS	1
>  #define INPUT_DEVICE_ID_MATCH_VENDOR	2
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 23b2d377af59..a3eafd0527f1 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -782,7 +782,9 @@
>  #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
>  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
>  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
> -#define SW_MAX			0x0f
> +#define SW_RATCHET		0x10  /* set = ratchet mode,
> +					 unset: free wheel */
> +#define SW_MAX			0x1f
>  #define SW_CNT			(SW_MAX+1)
>  
>  /*
> -- 
> 2.9.3
> 
