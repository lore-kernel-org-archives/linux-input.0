From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] Make PNP IDs all uppercase
Date: Thu, 22 Jan 2009 23:03:38 +0000
Message-ID: <200901222303.41737.carlos@strangeworlds.co.uk>
References: <49733678.40006@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <49733678.40006@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Philipp Kohlbecher <xt28@gmx.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Vojtech Pavlik <vojtech@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, Hans Verkuil <hverkuil@xs4all.nl>, "David S. Miller" <davem@davemloft.net>, Jaroslav Kysela <perex@perex.cz>, Adam Belay <abelay@mit.edu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sunday 18 January 2009 14:02:32 Philipp Kohlbecher wrote:
> If I understand correctly, ACPI _HIDs (including PNP IDs) should be all
> uppercase, including the hex digits, cf. ACPI Specification 3.0b [1],
> pp. 162-3 and acpi_glb_hex_to_ascii[] in drivers/acpi/utilities/utglobal.c.

ACPI-WMI violates the spec here.

> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 8a8b377..79b8af7 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -84,7 +84,7 @@ static int acpi_wmi_add(struct acpi_device *device);
>
>   static const struct acpi_device_id wmi_device_ids[] = {
>   	{"PNP0C14", 0},
> -	{"pnp0c14", 0},
> +	{"PNP0C14", 0},
>   	{"", 0},
>   };
>   MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index 8473fe5..18c9335 100644

NAK to the ACPI-WMI changes. There really is a pnp0c14 and a PNP0C14, and 
removing the lower case version breaks ACPI-WMI on my laptop.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
