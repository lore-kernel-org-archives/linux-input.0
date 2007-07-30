From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch] Refresh lid state on resume
Date: Mon, 30 Jul 2007 17:21:30 +0200
Message-ID: <1185808891.18821.25.camel@queen.suse.de>
References: <1184670921.8890.2.camel@work>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1184670921.8890.2.camel@work>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Hughes <hughsient@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Kay Sievers <kay.sievers@vrfy.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-input@vger.kernel.org

On Tue, 2007-07-17 at 12:15 +0100, Richard Hughes wrote:
> On resume we need to refresh the lid status as we will not get an event if
> the lid opening was what triggered the suspend.
> This manifests itself in users never getting a "lid open" event when a
> suspend happens because of lid close on hardware that supports wake on
> lid open. This makes userspace gets very confused indeed.
> Patch inline (and also attached) forces a check of the lid status in the
> resume handler.
Is this a general problem on all machines?
Or does this only happen if "shutdown" suspend mode is used?
AFAIK AML code (only on some machines? or only in suspend functions
which are not invoked in shutdown mode?) checks for LID state change and
invokes a notify(LID0,0x80) (or similar).
If this only happens in shutdown mode then IMO this is not needed ->
working around a workaround makes not much sense.
I could imagine a lot machines let it up to OS to check for LID state
change, then this one should be added.

Thanks,

    Thomas

> Signed-off-by: Richard Hughes <richard@hughsie.com>
> ---
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cb4110b..fd3473b 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -68,6 +68,7 @@ MODULE_LICENSE("GPL");
>  
>  static int acpi_button_add(struct acpi_device *device);
>  static int acpi_button_remove(struct acpi_device *device, int type);
> +static int acpi_button_resume(struct acpi_device *device);
>  static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
>  static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
>  
> @@ -77,6 +78,7 @@ static struct acpi_driver acpi_button_driver = {
>  	.ids = "button_power,button_sleep,PNP0C0D,PNP0C0C,PNP0C0E",
>  	.ops = {
>  		.add = acpi_button_add,
> +		.resume = acpi_button_resume,
>  		.remove = acpi_button_remove,
>  	},
>  };
> @@ -487,6 +489,29 @@ static int acpi_button_remove(struct acpi_device *device, int type)
>  	return 0;
>  }
>  
> +/* this is needed to learn about changes made in suspended state */
> +static int acpi_button_resume(struct acpi_device *device)
> +{
> +	struct acpi_button *button;
> +	struct acpi_handle *handle;
> +	struct input_dev *input;
> +	unsigned long state;
> +
> +	button = device->driver_data;
> +	handle = button->device->handle;
> +	input = button->input;
> +
> +	/*
> +	 * On resume we send the state; if it matches to what input layer
> +	 * thinks then the event will not even reach userspace.
> +	 */
> +	if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
> +						NULL, &state)))
> +		input_report_switch(input, SW_LID, !state);
> +
> +	return 0;
> +}
> +
>  static int __init acpi_button_init(void)
>  {
>  	int result;
