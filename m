From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/6] thinkpad_acpi: Factor out get/set adaptive kbd mode
Date: Fri, 20 Feb 2015 14:54:01 +0100
Message-ID: <1424440441.4347.6.camel@hadess.net>
References: <1424292815.32581.46.camel@hadess.net>
	 <20150220052257.GC790@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220052257.GC790@fury.dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2015-02-19 at 21:22 -0800, Darren Hart wrote:
> On Wed, Feb 18, 2015 at 09:53:35PM +0100, Bastien Nocera wrote:
> 
> Please provide a commit message. There is always something to say beyond what is
> in the subject. In this case, I suggest the motivation and justification for the
> change.
> 
> While I appreciate the abstraction, it makes the code at the call site easier to
> read, note that you added more code than you removed.
> 
> So, please provide a justificaiton.

Sure, done.

> Under no circumstances will I accept a patch without a commit message body.
> 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 61 ++++++++++++++++++++++--------------
> >  1 file changed, 38 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 80db3ce..a6dd017 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -3480,6 +3480,32 @@ const int adaptive_keyboard_modes[] = {
> >  static bool adaptive_keyboard_mode_is_saved;
> >  static int adaptive_keyboard_prev_mode;
> >  
> > +static int adaptive_keyboard_get_mode(void)
> > +{
> > +	u32 mode = 0;
> 
> acpi_evalf second argument takes an "int" and this function returns "int". Is
> there a reason to use u32 for mode?

Used int, done.

> > @@ -3509,39 +3535,28 @@ static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scancode)
> >  			new_mode = adaptive_keyboard_prev_mode;
> >  			adaptive_keyboard_mode_is_saved = false;
> >  		} else {
> > -			if (!acpi_evalf(
> > -					hkey_handle, &current_mode,
> > -					"GTRW", "dd", 0)) {
> > -				pr_err("Cannot read adaptive keyboard mode\n");
> > +			current_mode = adaptive_keyboard_get_mode();
> > +			if (current_mode < 0)
> >  				return false;
> > -			} else {
> > -				new_mode = adaptive_keyboard_get_next_mode(
> > -						current_mode);
> > -			}
> > +			new_mode = adaptive_keyboard_get_next_mode(
> > +					current_mode);
> 
> This now fits on one line I believe.

Nope, 81 characters. I've kept it as-is.
