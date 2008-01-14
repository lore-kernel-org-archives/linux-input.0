From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] ACPI: Put button input devices in correct place in sysfs
Date: Mon, 14 Jan 2008 22:25:58 +0000
Message-ID: <200801142225.59617.carlos@strangeworlds.co.uk>
References: <200711062051.59884.arvidjaar@mail.ru> <d120d5000711061247l5102875bg9d9b841086dd77b5@mail.gmail.com> <200711111142.52346.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200711111142.52346.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-input@vger.kernel.org

Len,

Andrey's patch to the ACPI button driver still hasn't been applied to the ACPI 
tree.

-Carlos

On Sunday 11 November 2007 08:42:45 Andrey Borzenkov wrote:
> Subject: [PATCH] Make real parent for ACPI button input devices
> From: Andrey Borzenkov <arvidjaar@mail.ru>
>
>
>
> Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
>
> ---
>
>  drivers/acpi/button.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 24a7865..6c5da83 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -449,6 +449,7 @@ static int acpi_button_add(struct acpi_device *device)
>  	input->phys = button->phys;
>  	input->id.bustype = BUS_HOST;
>  	input->id.product = button->type;
> +	input->dev.parent = &device->dev;
>
>  	switch (button->type) {
>  	case ACPI_BUTTON_TYPE_POWER:

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
