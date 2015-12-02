From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 6/6] Input: psmouse - limit protocols that we try on
 passthrough ports
Date: Wed, 2 Dec 2015 16:21:30 +0100
Message-ID: <565F0C7A.1030608@redhat.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
 <1448774036-39040-7-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448774036-39040-7-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 29-11-15 06:13, Dmitry Torokhov wrote:
> PS/2 protocol is slow, and using it with pass-through port (where we
> encapsulate PS/2 into PS/2) is slower yet so it takes quite a bit of time
> to do full protocol discovery for device attached to a pass-through port.
> However, so far we have not see anything but trackpoints or basic PS/2
> mice on pass-through ports, so let's limit protocols that we probe there
> to Trackpoint, IntelliMouse Explorer, IntelliMouse, and bare PS/2 protocol,
> and avoid other extended protocols, such as Synaptics, ALPS, etc.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/input/mouse/psmouse-base.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index ee59b0e..e909c6e 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -119,6 +119,7 @@ struct psmouse_protocol {
>   	enum psmouse_type type;
>   	bool maxproto;
>   	bool ignore_parity; /* Protocol should ignore parity errors from KBC */
> +	bool try_passthru; /* Try protocol also on passthrough ports */
>   	const char *name;
>   	const char *alias;
>   	int (*detect)(struct psmouse *, bool);
> @@ -691,6 +692,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>   		.maxproto	= true,
>   		.ignore_parity	= true,
>   		.detect		= ps2bare_detect,
> +		.try_passthru	= true,
>   	},
>   #ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
>   	{
> @@ -728,6 +730,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>   		.maxproto	= true,
>   		.ignore_parity	= true,
>   		.detect		= intellimouse_detect,
> +		.try_passthru	= true,
>   	},
>   	{
>   		.type		= PSMOUSE_IMEX,
> @@ -736,6 +739,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>   		.maxproto	= true,
>   		.ignore_parity	= true,
>   		.detect		= im_explorer_detect,
> +		.try_passthru	= true,
>   	},
>   #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
>   	{
> @@ -777,6 +781,7 @@ static const struct psmouse_protocol psmouse_protocols[] = {
>   		.name		= "TPPS/2",
>   		.alias		= "trackpoint",
>   		.detect		= trackpoint_detect,
> +		.try_passthru	= true,
>   	},
>   #endif
>   #ifdef CONFIG_MOUSE_PS2_TOUCHKIT
> @@ -933,6 +938,11 @@ static bool psmouse_try_protocol(struct psmouse *psmouse,
>   	if (!proto)
>   		return false;
>
> +	if (psmouse->ps2dev.serio->id.type == SERIO_PS_PSTHRU &&
> +	    !proto->try_passthru) {
> +		return false;
> +	}
> +
>   	if (set_properties)
>   		psmouse_apply_defaults(psmouse);
>
>
