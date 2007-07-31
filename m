From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Enable GPEs before _WAK is called
Date: Tue, 31 Jul 2007 17:09:56 +0200
Message-ID: <200707311709.57806.rjw@sisk.pl>
References: <1184670921.8890.2.camel@work> <200707311542.27571.rjw@sisk.pl> <1185891971.18821.196.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1185891971.18821.196.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: trenn@suse.de
Cc: Richard Hughes <hughsient@gmail.com>, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Kay Sievers <kay.sievers@vrfy.org>, Stefan Seyfried <seife@suse.de>
List-Id: linux-input@vger.kernel.org

On Tuesday, 31 July 2007 16:26, Thomas Renninger wrote:
> On Tue, 2007-07-31 at 15:42 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 31 July 2007 12:42, Thomas Renninger wrote:
> > > On Tue, 2007-07-31 at 10:07 +0100, Richard Hughes wrote:
> > > > On Tue, 2007-07-31 at 11:08 +0200, Rafael J. Wysocki wrote:
> > > > > On Monday, 30 July 2007 17:33, Richard Hughes wrote:
> > > > > > On Mon, 2007-07-30 at 17:21 +0200, Thomas Renninger wrote:
> > > > > > > On Tue, 2007-07-17 at 12:15 +0100, Richard Hughes wrote:
[--snip--]
> > I wouldn't move that before _BFS, just in case someone actually implements it.
> Yes you are right, thanks.
> (ACPI spec):
> -----------
> OSPM will execute the _BFS control method before performing any other
> physical I/O or enabling any interrupt servicing upon returning
> from a sleeping state.
> -----------
> 
> Now it makes sense to have _BFS and _WAK, before it had not made a
> difference from BIOS programmer point of view to use _BFS or _WAK.
> 
> With some luck this fixes some other things, I remember a weird bug on
> (X60?) thinkpad:
> If you suspend to RAM you can wakeup with the blue FN key, after doing a
> suspend to disk and then doing a suspend to RAM the blue FN key does not
> wake the machine anymore from STR :)
> 
> Attached an updated patch (Rafael, I added your Acked from comments
> above. I just moved GPE enabling between _BFS and _WAK as you
> suggested, pls scream if you still find something bad).

I think the patch (below) is correct.

Greetings,
Rafael


> ------------
> 
> 
> Enable GPEs before calling _WAK on resume
> 
> It seems it's required to enable GPEs before _WAK.
> E.g. X60 triggers a LID related GPE instead of doing a Notify in WAK.
> Now the GPE reaches the kernel and the Notify for LID status
> change gets thrown from there.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ---
>  drivers/acpi/hardware/hwsleep.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.22.1/drivers/acpi/hardware/hwsleep.c
> ===================================================================
> --- linux-2.6.22.1.orig/drivers/acpi/hardware/hwsleep.c
> +++ linux-2.6.22.1/drivers/acpi/hardware/hwsleep.c
> @@ -576,13 +576,10 @@ acpi_status acpi_leave_sleep_state(u8 sl
>  		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
>  	}
>  
> -	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
> -	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
> -	}
> -	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
> -
>  	/*
> +	 * GPEs must be enabled before _WAK is called as GPEs
> +	 * might get fired there
> +	 *
>  	 * Restore the GPEs:
>  	 * 1) Disable/Clear all GPEs
>  	 * 2) Enable all runtime GPEs
> @@ -591,13 +588,19 @@ acpi_status acpi_leave_sleep_state(u8 sl
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
> -	acpi_gbl_system_awake_and_running = TRUE;
> -
>  	status = acpi_hw_enable_all_runtime_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
>  
> +	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
> +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> +		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
> +	}
> +	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
> +
> +	acpi_gbl_system_awake_and_running = TRUE;
> +
>  	/* Enable power button */
>  
>  	(void)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
