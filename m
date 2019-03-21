From: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/7] Input: document meanings of KEY_SCREEN and KEY_ZOOM
Date: Thu, 21 Mar 2019 09:17:31 -0300
Message-ID: <20190321091731.7b34fc63@coco.lan>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Em Fri, 18 Jan 2019 15:30:31 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> It is hard to say what KEY_SCREEN and KEY_ZOOM mean, but historically DVB
> folks have used them to indicate switch to full screen mode. Later, they
> converged on using KEY_ZOOM to switch into full screen mode and KEY)SCREEN
> to control aspect ratio (see Documentation/media/uapi/rc/rc-tables.rst).
> 
> Let's commit to these uses, and define:
> 
> - KEY_FULL_SCREEN (and make KEY_ZOOM its alias)
> - KEY_ASPECT_RATIO (and make KEY_SCREEN its alias)
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to apply via your tree.

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
> 
> Please let me know how we want merge this. Some of patches can be applied
> independently and I tried marking them as such, but some require new key
> names from input.h
> 
>  include/uapi/linux/input-event-codes.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index ae366b87426a..bc5054e51bef 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -439,10 +439,12 @@
>  #define KEY_TITLE		0x171
>  #define KEY_SUBTITLE		0x172
>  #define KEY_ANGLE		0x173
> -#define KEY_ZOOM		0x174
> +#define KEY_FULL_SCREEN		0x174	/* AC View Toggle */
> +#define KEY_ZOOM		KEY_FULL_SCREEN
>  #define KEY_MODE		0x175
>  #define KEY_KEYBOARD		0x176
> -#define KEY_SCREEN		0x177
> +#define KEY_ASPECT_RATIO	0x177	/* HUTRR37: Aspect */
> +#define KEY_SCREEN		KEY_ASPECT_RATIO
>  #define KEY_PC			0x178	/* Media Select Computer */
>  #define KEY_TV			0x179	/* Media Select TV */
>  #define KEY_TV2			0x17a	/* Media Select Cable */



Thanks,
Mauro
