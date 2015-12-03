From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: psmouse - rename ps2pp_init() to ps2pp_detect()
Date: Thu, 3 Dec 2015 09:34:40 +0100
Message-ID: <565FFEA0.7050304@redhat.com>
References: <20151202192555.GA25587@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151202192555.GA25587@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 02-12-15 20:25, Dmitry Torokhov wrote:
> This makes Logitech PS2++ protocol implementation consistent with
> the naming in other protocols. Also mark the stub as "static inline"
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Much better / less confusing then the old code :)

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

hans



> ---
>
> V2: add forgotten drivers/input/mouse/logips2pp.c file.
>
>   drivers/input/mouse/logips2pp.c    | 2 +-
>   drivers/input/mouse/logips2pp.h    | 4 ++--
>   drivers/input/mouse/psmouse-base.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
> index 136e222..422da1c 100644
> --- a/drivers/input/mouse/logips2pp.c
> +++ b/drivers/input/mouse/logips2pp.c
> @@ -325,7 +325,7 @@ static void ps2pp_set_model_properties(struct psmouse *psmouse,
>    * that support it.
>    */
>
> -int ps2pp_init(struct psmouse *psmouse, bool set_properties)
> +int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
>   {
>   	struct ps2dev *ps2dev = &psmouse->ps2dev;
>   	unsigned char param[4];
> diff --git a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
> index 0c186f0..bf62945 100644
> --- a/drivers/input/mouse/logips2pp.h
> +++ b/drivers/input/mouse/logips2pp.h
> @@ -12,9 +12,9 @@
>   #define _LOGIPS2PP_H
>
>   #ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
> -int ps2pp_init(struct psmouse *psmouse, bool set_properties);
> +int ps2pp_detect(struct psmouse *psmouse, bool set_properties);
>   #else
> -inline int ps2pp_init(struct psmouse *psmouse, bool set_properties)
> +static inline int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
>   {
>   	return -ENOSYS;
>   }
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index e909c6e..90d9218 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -699,7 +699,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>   		.type		= PSMOUSE_PS2PP,
>   		.name		= "PS2++",
>   		.alias		= "logitech",
> -		.detect		= ps2pp_init,
> +		.detect		= ps2pp_detect,
>   	},
>   #endif
>   	{
>
