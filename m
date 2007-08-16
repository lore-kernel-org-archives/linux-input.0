From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH V2 1/3] ACPI video hotkey: add new input key codes for ACPI video hotkey events
Date: Wed, 15 Aug 2007 23:16:26 -0400
Message-ID: <200708152316.26433.lenb@kernel.org>
References: <1186780041.6830.57.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1186780041.6830.57.camel@rzhang-asus.sh.intel.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Zhang Rui <rui.zhang@intel.com>, linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

Thanks for refreshing Luming's patch series, Rui.

<added linux-input list>

I have only minor feedback: on the actual key-codes.
It seems to me that we should define keys for events that are in the spec
rather than leaving two of them as UNKNOWN just because the text machine
on hand doesn't have them.


On Friday 10 August 2007 17:07, Zhang Rui wrote:
> From: Yu Luming <luming.yu@intel.com>
> 
> Add keycode for ACPI video hotkey event.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  include/linux/input.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6.23-rc2/include/linux/input.h
> ===================================================================
> --- linux-2.6.23-rc2.orig/include/linux/input.h
> +++ linux-2.6.23-rc2/include/linux/input.h
> @@ -553,6 +553,11 @@ struct input_absinfo {
>  #define KEY_BRL_DOT7		0x1f7
>  #define KEY_BRL_DOT8		0x1f8
>  
> +#define KEY_VIDEO_NEXT		0x1f9
> +#define KEY_VIDEO_PREV		0x1fa
> +#define KEY_BRIGHTNESS_ZERO	0x1fb
> +#define KEY_BRIGHTNESS_OFF	0x1fc
> +

should we also define KEY_VIDEO_CYCLE_MODE?
(though i'm not sure, exactly, how this is supposed to differ from KEY_VIDEO_NEXT...)

should we also define KEY_BRIGHTNESS_CYCLE?
(acts like KEY_BRIGHTNESSUP, but it goes to min after it hits max.)

>  /* We avoid low common keys in module aliases so they don't get huge. */
>  #define KEY_MIN_INTERESTING	KEY_MUTE
>  #define KEY_MAX			0x1ff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
