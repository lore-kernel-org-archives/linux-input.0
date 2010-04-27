From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] Actual code fixing Sixaxis
Date: Tue, 27 Apr 2010 10:52:04 +0100
Message-ID: <1272361924.17421.6787.camel@localhost.localdomain>
References: <1272318628.3269.44.camel@zony.bied.prout.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272318628.3269.44.camel-RYtM5sHUr3p6PoLMcel1OJkigfUh6rMo@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 2010-04-26 at 22:50 +0100, Marcin Tolysz wrote:
> Add change descriptor bit(works on any usb/bt device)
>  Make use of physical minimum and maximum while reporting values to userspace
>  Add mini howto comment next to replace hid code
>  Assume physical maximum is always signed allowing inverting axes by giving max < min
>  Swap a few bits in Sixaxis report as they have wrong(hid-wise) endianess
>  Sixaxis specific changes

Separate the sixaxis changes from the hid core changes.

>   and the most important bit modified HID descriptor:
>  05 01 09 04 A1 01 09 04 A1 02 85 01 75 08 95 01 80 05 09 75 01 95 04
>  14 25 01 09 0C 09 0A 09 09 09 0B 81 02 05 01 09 01 A1 02 75 01 14 25
>  01 95 04 09 90 09 92 09 91 09 93 81 02 C0 05 09 95 09 09 08 09 07 09
>  06 09 05 09 04 09 02 09 01 09 03 09 0D 81 02 75 01 95 0F 80 14 26 FF
>  00 35 80 45 7F 05 01 09 01 75 08 95 02 A0 09 30 09 31 81 02 C0 09 05
>  A0 09 32 09 33 81 02 C0 75 08 95 04 80 75 08 95 0C 09 46 34 44 81 02
>  75 08 95 0F 80 75 10 95 01 16 80 01 26 7F 02 45 80 35 7F 09 33 81 02
>  35 80 45 7F 09 34 81 02 95 02 14 26 00 04 36 01 FE 46 00 02 09 35 09
>  36 81 02 14 26 FF 00 34 46 FF 00 75 08 95 30 91 02 75 08 95 30 B1 02
>  C0 A1 02 85 02 75 08 95 30 B1 02 C0 A1 02 85 EE 75 08 95 30 B1 02 C0
>  A1 02 85 EF 75 08 95 30 B1 02 C0 C0
>   convert it into binary using eg. hex2bin.sh and save to
>    /lib/firmware/hid/0003:054C:0268:0111.bin

Add a documentation file for that, don't put it in the commit log.

> The two attachments are descriptor as .h file and in my own smart(I have a compiler written in Haskel form/to this format and it could possibly be released under GPL). 
> The descriptor is functional but it could be made better... the accelerometers work fine. 
> PS. as soon as BT(standard) will start working it will be sufficient to provide fixed HID description.

Again, too much information for a commit log, and line wrapping is 72
characters.

>  Signed-off-by: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/hid-core.c |   67 +++++++++++++++++++++++++++++++++++++++++++----
>  drivers/hid/hid-sony.c |   19 +++++++++++++
>  2 files changed, 80 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2e2aa75..bb40a19 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -27,6 +27,7 @@
>  #include <linux/wait.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/firmware.h>
>  
>  #include <linux/hid.h>
>  #include <linux/hiddev.h>
> @@ -333,10 +334,8 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
>  		return 0;
>  
>  	case HID_GLOBAL_ITEM_TAG_PHYSICAL_MAXIMUM:
> -		if (parser->global.physical_minimum < 0)
> -			parser->global.physical_maximum = item_sdata(item);
> -		else
> -			parser->global.physical_maximum = item_udata(item);
> +	/* always signed value, if it is less then minimum we need to invert axis */
> +		parser->global.physical_maximum = item_sdata(item);
>  		return 0;

Indentation.
 
>  	case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
> @@ -642,6 +641,10 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
>  	struct hid_item item;
>  	__u8 *end;
>  	int ret;
> +	const struct firmware *fw;
> +	int fw_fail;
> +	const char *file;
> +
>  	static int (*dispatch_type[])(struct hid_parser *parser,
>  				      struct hid_item *item) = {
>  		hid_parser_main,
> @@ -652,10 +655,39 @@ int hid_parse_report(struct hid_device *device, __u8 *start,
>  
>  	if (device->driver->report_fixup)
>  		device->driver->report_fixup(device, start, size);
> +	/* Now try to load a hid descriptor from a file firmware
> +	if succesful ignoring this fixup thing */
> +   /*
> +  Mini howto: fixing the descriptor:
> +  1) dump it from /debug/hid/!!device!!/rdesc
> +  2) copy 1st line &edit it
> +  3) convert to bin eg. cat descriptor.txt | hex2bin.sh > descriptor.bin

Has no place in the code itself.
<snip>
> +	if (fw_fail)
> +		pr_info("To relace HID descriptor place it in /lib/firmaware/%s\n", file);

firmaware?

<snip>
> +		pr_info("HID descriptor relaced with /lib/firmaware/%s\n", file);

Typo again.

<snip>
> +			if (!fw_fail)
> +				release_firmware(fw);

Won't that trigger udev's firmware code and popup PackageKit's firmware
downloader for each and every HID device?

<snip>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 7502a4b..3e094e4 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c

As mentioned, need a separate

> @@ -45,6 +45,24 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  }
>  
>  /*
> + * There is a few bits that has to be shifted around to make this report more compatibile with
> + * HID standard descriptions, and we want it to be parsable by standard driver
> + */
> +static int sony_raw_event(struct hid_device *hdev, struct hid_report *report, __u8 *rd, int size)
> +{
> + /* for sixaxis connected via usb. */
> +	if (rd[0] == 0x01 && size == 49) {
> +		swap(rd[41], rd[42]);
> +		swap(rd[43], rd[44]);
> +		swap(rd[45], rd[46]);
> +		swap(rd[47], rd[48]);
> +	}
> +
> +return 0;
> +}

Can't this be done for the BT one as well, rather than requiring a
modified firmware? (although the firmware hack could be useful as a
debugging tool).

Cheers
