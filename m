From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Wed, 18 Feb 2015 21:34:20 -0200
Message-ID: <20150218233420.GB23265@khazad-dum.debian.net>
References: <1424292832.32581.49.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424292832.32581.49.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Feb 2015, Bastien Nocera wrote:
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

This one requires an ACK from the input maintainers, or no go...

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index b0a8130..affe40e 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -740,6 +740,16 @@ struct input_keymap_entry {
>  #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
>  #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
>  
> +#define KEY_CLIPPING_TOOL		0x252	/* Screenshot clipping tool */
> +#define KEY_CLOUD			0x253	/* Cloud Settings */
> +#define KEY_CAMERA_GESTURES		0x254	/* Toggle Camera gestures */
> +#define KEY_NEW_TAB			0x255	/* Open a new tab */
> +#define KEY_MICUP			0x256	/* Microphone Up */
> +#define KEY_MICDOWN			0x257	/* Microphone Down */
> +#define KEY_MICCANCEL_MODE		0x258	/* Toggle Microphone cancellation mode */
> +#define KEY_CAMERA_ZOOM_MODE		0x259	/* Toggle camera zoom mode */
> +#define KEY_ROTATE_DISPLAY		0x25a	/* Rotate screen by 90 degrees */
> +
>  #define KEY_KBDINPUTASSIST_PREV		0x260
>  #define KEY_KBDINPUTASSIST_NEXT		0x261
>  #define KEY_KBDINPUTASSIST_PREVGROUP		0x262

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
