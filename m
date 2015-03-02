From: ibm-acpi@hmh.eng.br
Subject: Re: [PATCH 2/4] thinkpad_acpi: Factor out get/set adaptive kbd mode
Date: Mon, 02 Mar 2015 14:12:52 -0300
Message-ID: <1425316372.517012.234430217.616C5BF5@webmail.messagingengine.com>
References: <1425303922.16791.33.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425303922.16791.33.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 2, 2015, at 10:45, Bastien Nocera wrote:
> Move the getting/setting of the adaptive keyboard mode to separate
> functions, so that we can reuse them later through sysfs attributes.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 61
>  ++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c
> b/drivers/platform/x86/thinkpad_acpi.c
> index 763aef0..5dea4c2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -3483,6 +3483,32 @@ static const int adaptive_keyboard_modes[] = {
>  static bool adaptive_keyboard_mode_is_saved;
>  static int adaptive_keyboard_prev_mode;
>  
> +static int adaptive_keyboard_get_mode(void)
> +{
> +       int mode = 0;
> +
> +       if (!acpi_evalf(hkey_handle, &mode, "GTRW", "dd", 0)) {
> +               pr_err("Cannot read adaptive keyboard mode\n");
> +               return -EIO;
> +       }
> +
> +       return mode;
> +}
> +
> +static int adaptive_keyboard_set_mode(int new_mode)
> +{
> +       if (new_mode < 0 ||
> +               new_mode > LAYFLAT_MODE)
> +               return -EINVAL;
> +
> +       if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd", new_mode)) {
> +               pr_err("Cannot set adaptive keyboard mode\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
>  static int adaptive_keyboard_get_next_mode(int mode)
>  {
>  	size_t i;
> @@ -3512,39 +3538,28 @@ static bool
> adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
>  			new_mode = adaptive_keyboard_prev_mode;
>  			adaptive_keyboard_mode_is_saved = false;
>  		} else {
> -                       if (!acpi_evalf(
> -                                       hkey_handle, &current_mode,
> -                                       "GTRW", "dd", 0)) {
> -                               pr_err("Cannot read adaptive keyboard
> mode\n");
> +                       current_mode = adaptive_keyboard_get_mode();
> +                       if (current_mode < 0)
>  				return false;
> -                       } else {
> -                               new_mode =
> adaptive_keyboard_get_next_mode(
> -                                               current_mode);
> -                       }
> +                       new_mode = adaptive_keyboard_get_next_mode(
> +                                       current_mode);
>  		}
>  
> -               if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd",
> new_mode)) {
> -                       pr_err("Cannot set adaptive keyboard mode\n");
> +               if (adaptive_keyboard_set_mode(new_mode) < 0)
>  			return false;
> -               }
>  
>  		return true;
>  
>  	case DFR_SHOW_QUICKVIEW_ROW:
> -               if (!acpi_evalf(hkey_handle,
> -                               &adaptive_keyboard_prev_mode,
> -                               "GTRW", "dd", 0)) {
> -                       pr_err("Cannot read adaptive keyboard mode\n");
> +               current_mode = adaptive_keyboard_get_mode();
> +               if (current_mode < 0)
>  			return false;
> -               } else {
> -                       adaptive_keyboard_mode_is_saved = true;
>  
> -                       if (!acpi_evalf(hkey_handle,
> -                                       NULL, "STRW", "vd",
> FUNCTION_MODE)) {
> -                               pr_err("Cannot set adaptive keyboard
> mode\n");
> -                               return false;
> -                       }
> -               }
> +               adaptive_keyboard_prev_mode = current_mode;
> +               adaptive_keyboard_mode_is_saved = true;
> +
> +               if (adaptive_keyboard_set_mode (FUNCTION_MODE) < 0)
> +                       return false;
>  		return true;
>  
>  	default:
> -- 
> 2.1.0
> 
> 
