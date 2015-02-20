From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 2/6] thinkpad_acpi: Factor out get/set adaptive kbd mode
Date: Thu, 19 Feb 2015 21:22:57 -0800
Message-ID: <20150220052257.GC790@fury.dvhart.com>
References: <1424292815.32581.46.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424292815.32581.46.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 18, 2015 at 09:53:35PM +0100, Bastien Nocera wrote:

Please provide a commit message. There is always something to say beyond what is
in the subject. In this case, I suggest the motivation and justification for the
change.

While I appreciate the abstraction, it makes the code at the call site easier to
read, note that you added more code than you removed.

So, please provide a justificaiton.

Under no circumstances will I accept a patch without a commit message body.

> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 61 ++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 80db3ce..a6dd017 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -3480,6 +3480,32 @@ const int adaptive_keyboard_modes[] = {
>  static bool adaptive_keyboard_mode_is_saved;
>  static int adaptive_keyboard_prev_mode;
>  
> +static int adaptive_keyboard_get_mode(void)
> +{
> +	u32 mode = 0;

acpi_evalf second argument takes an "int" and this function returns "int". Is
there a reason to use u32 for mode?

...

> @@ -3509,39 +3535,28 @@ static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
>  			new_mode = adaptive_keyboard_prev_mode;
>  			adaptive_keyboard_mode_is_saved = false;
>  		} else {
> -			if (!acpi_evalf(
> -					hkey_handle, &current_mode,
> -					"GTRW", "dd", 0)) {
> -				pr_err("Cannot read adaptive keyboard mode\n");
> +			current_mode = adaptive_keyboard_get_mode();
> +			if (current_mode < 0)
>  				return false;
> -			} else {
> -				new_mode = adaptive_keyboard_get_next_mode(
> -						current_mode);
> -			}
> +			new_mode = adaptive_keyboard_get_next_mode(
> +					current_mode);

This now fits on one line I believe.

...

-- 
Darren Hart
Intel Open Source Technology Center
