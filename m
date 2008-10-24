From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Always report a sync event after a lid state change
Date: Fri, 24 Oct 2008 15:37:12 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810241529110.3056@localhost.localdomain>
References: <20081023212833.GA1923@ziggurat.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_O5EWDgsZ4J9blA+RglaIGw)"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <20081023212833.GA1923@ziggurat.research.nokia.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Guillem Jover <guillem.jover@nokia.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_O5EWDgsZ4J9blA+RglaIGw)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

Dmitry,

Looking around the tree, the other calls to
input_report_switch() and input_report_key()
are all followed by input_sync().

I guess we didn't understand the API when we added
these calls to button.c?

Looks like the other users of input_report_* in
drivers/acpi and drivers/misc are okay,
with the exception of toshiba_acpi.c --
the most neglected driver we have,
so I"ll do the same to that one?

Ack?

thanks,
-Len


On Fri, 24 Oct 2008, Guillem Jover wrote:

> Currently not always an EV_SYN event is reported to userland
> after the EV_SW SW_LID event has been sent. This is easy to verify
> by using “input-events” from input-utils and just closing and opening
> the lid.
> 
> Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
> ---
>  drivers/acpi/button.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 1dfec41..59352d9 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -262,6 +262,7 @@ static int acpi_lid_send_state(struct acpi_button *button)
>  		return -ENODEV;
>  	/* input layer checks if event is redundant */
>  	input_report_switch(button->input, SW_LID, !state);
> +	input_sync(button->input);
>  	return 0;
>  }
>  
> @@ -285,8 +286,8 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>  			input_report_key(input, keycode, 1);
>  			input_sync(input);
>  			input_report_key(input, keycode, 0);
> +			input_sync(input);
>  		}
> -		input_sync(input);
>  
>  		acpi_bus_generate_proc_event(button->device, event,
>  					++button->pushed);
> -- 
> 1.6.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_O5EWDgsZ4J9blA+RglaIGw)--
