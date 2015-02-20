From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/6] thinkpad_acpi: Remember adaptive kbd presence
Date: Fri, 20 Feb 2015 14:51:06 +0100
Message-ID: <1424440266.4347.5.camel@hadess.net>
References: <1424292808.32581.45.camel@hadess.net>
	 <20150220050843.GB790@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20150220050843.GB790@fury.dvhart.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2015-02-19 at 21:08 -0800, Darren Hart wrote:
> On Wed, Feb 18, 2015 at 09:53:28PM +0100, Bastien Nocera wrote:
> > Rather than checking on each suspend and resume whether the laptop
> > has an adaptive keyboard, check when the driver is initialised.
> 
> Reasonable.
> 
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 38 ++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index c3d11fa..80db3ce 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> ...
> > @@ -3226,6 +3227,13 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
> >  	if (!tp_features.hotkey)
> >  		return 1;
> >  
> > +	/* does it have an adaptive keyboard, like
> > +	 * the Lenovo Carbon X1 2014 (2nd gen) */
> 
> Please follow CodingStyle here:
> 
> /*
>  * Sentence formatting.
>  * Second line.
>  */
> 
> The above is a question, just state what you're doing:
> 
> /*
>  * Check if we have an adaptive keyboard, like on the
>  * Lenovo Carbon X1 2014 (2nd Gen).
>  */

Done.

> > +	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
> > +		if ((hkeyv >> 8) == 2)
> > +			tp_features.has_adaptive_kbd = true;
> > +	}
> > +
> >  	quirks = tpacpi_check_quirks(tpacpi_hotkey_qtable,
> >  				     ARRAY_SIZE(tpacpi_hotkey_qtable));
> >  
> > @@ -3834,28 +3842,22 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
> >  
> >  static void hotkey_suspend(void)
> >  {
> > -	int hkeyv;
> > -
> >  	/* Do these on suspend, we get the events on early resume! */
> >  	hotkey_wakeup_reason = TP_ACPI_WAKEUP_NONE;
> >  	hotkey_autosleep_ack = 0;
> >  
> >  	/* save previous mode of adaptive keyboard of X1 Carbon */
> > -	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
> > -		if ((hkeyv >> 8) == 2) {
> > -			if (!acpi_evalf(hkey_handle,
> > -						&adaptive_keyboard_prev_mode,
> > -						"GTRW", "dd", 0)) {
> > -				pr_err("Cannot read adaptive keyboard mode.\n");
> > -			}
> > +	if (tp_features.has_adaptive_kbd) {
> > +		if (!acpi_evalf(hkey_handle,
> > +					&adaptive_keyboard_prev_mode,
> > +					"GTRW", "dd", 0)) {
> > +			pr_err("Cannot read adaptive keyboard mode.\n");
> >  		}
> >  	}
> >  }
> >  
> >  static void hotkey_resume(void)
> >  {
> > -	int hkeyv;
> > -
> >  	tpacpi_disable_brightness_delay();
> >  
> >  	if (hotkey_status_set(true) < 0 ||
> > @@ -3870,14 +3872,12 @@ static void hotkey_resume(void)
> >  	hotkey_poll_setup_safe(false);
> >  
> >  	/* restore previous mode of adapive keyboard of X1 Carbon */
> > -	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
> > -		if ((hkeyv >> 8) == 2) {
> > -			if (!acpi_evalf(hkey_handle,
> > -						NULL,
> > -						"STRW", "vd",
> > -						adaptive_keyboard_prev_mode)) {
> > -				pr_err("Cannot set adaptive keyboard mode.\n");
> > -			}
> > +	if (tp_features.has_adaptive_kbd) {
> > +		if (!acpi_evalf(hkey_handle,
> > +					NULL,
> > +					"STRW", "vd",
> > +					adaptive_keyboard_prev_mode)) {
> 
> You've saved a level of indentation, please group the arguments into fewer
> lines, should be two instead of four.
> 
> Otherwise, looks good.

Done.
