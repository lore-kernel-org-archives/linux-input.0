From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V3 1/3] ACPI video hotkey: add new input key code for ACPI video hotkey events
Date: Thu, 23 Aug 2007 15:32:42 -0400
Message-ID: <200708231532.42908.lenb@kernel.org>
References: <1187605427.2920.140.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1187605427.2920.140.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Zhang Rui <rui.zhang@intel.com>, dmitry.torokhov@gmail.com
Cc: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, mjg59@srcf.ucam.org, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

Thanks for the refreshed patch series, Rui.
I've added it to acpi-test.

Still waiting on an ACK from Dmitry on the input.h definitions.

-Len

On Monday 20 August 2007 06:23, Zhang Rui wrote:
> From: Yu Luming <luming.yu@intel.com>
> 
> Add keycode for ACPI video driver hotkey events.
> 
> Signed-off-by: Yu Luming <luming.yu@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  include/linux/input.h |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-2.6.23-rc3/include/linux/input.h
> ===================================================================
> --- linux-2.6.23-rc3.orig/include/linux/input.h
> +++ linux-2.6.23-rc3/include/linux/input.h
> @@ -553,6 +553,13 @@ struct input_absinfo {
>  #define KEY_BRL_DOT7		0x1f7
>  #define KEY_BRL_DOT8		0x1f8
>  
> +#define KEY_DISPLAY_CYCLE	0x1f9
> +#define KEY_VIDEO_NEXT		0x1fa
> +#define KEY_VIDEO_PREV		0x1fb
> +#define KEY_BRIGHTNESS_CYCLE	0x1fc
> +#define KEY_BRIGHTNESS_ZERO	0x1fd
> +#define KEY_DISPLAY_OFF		0x1fe
> +
>  /* We avoid low common keys in module aliases so they don't get huge. */
>  #define KEY_MIN_INTERESTING	KEY_MUTE
>  #define KEY_MAX			0x1ff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
