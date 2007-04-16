From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 2/6] usbhid: move all quirk handling code and data to
 usb-quirks.[ch]
Date: Mon, 16 Apr 2007 11:14:29 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0704161109170.24673@twin.jikos.cz>
References: <Pine.LNX.4.64.0704111256240.28726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704111256240.28726@utopia.booyaka.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2007, Paul Walmsley wrote:

> @@ -1142,25 +715,14 @@ static struct hid_device *usb_hid_config
> 	struct usb_device *dev = interface_to_usbdev (intf);
> 	struct hid_descriptor *hdesc;
> 	struct hid_device *hid;
> -	__u32 quirks = 0;
> +	u32 quirks = 0;
> 	unsigned rsize = 0;
> 	char *rdesc;
> 	int n, len, insize = 0;
> 	struct usbhid_device *usbhid;
>
> -	/* Ignore all Wacom devices */
> -	if (le16_to_cpu(dev->descriptor.idVendor) == USB_VENDOR_ID_WACOM)
> -		return NULL;
> -	/* ignore all Code Mercenaries IOWarrior devices */
> -	if (le16_to_cpu(dev->descriptor.idVendor) == USB_VENDOR_ID_CODEMERCS)
> -		if (le16_to_cpu(dev->descriptor.idProduct) >= 
> USB_DEVICE_ID_CODEMERCS_IOW_FIRST &&
> -		    le16_to_cpu(dev->descriptor.idProduct) <= 
> USB_DEVICE_ID_CODEMERCS_IOW_LAST)
> -			return NULL;
> -
> -	for (n = 0; hid_blacklist[n].idVendor; n++)
> -		if ((hid_blacklist[n].idVendor == 
> le16_to_cpu(dev->descriptor.idVendor)) &&
> -			(hid_blacklist[n].idProduct == 
> le16_to_cpu(dev->descriptor.idProduct)))
> -				quirks = hid_blacklist[n].quirks;
> +	quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
> +				     le16_to_cpu(dev->descriptor.idProduct));
[...]
> +u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct)
> +{
> +	u32 quirks = 0;
> +	int n = 0;
> +
> +	/* Ignore all Wacom devices */
> +	if (idVendor == USB_VENDOR_ID_WACOM)
> +		return 0;
> +	/* ignore all Code Mercenaries IOWarrior devices */
> +	if (idVendor == USB_VENDOR_ID_CODEMERCS)
> +		if (idProduct >= USB_DEVICE_ID_CODEMERCS_IOW_FIRST &&
> +		    idProduct <= USB_DEVICE_ID_CODEMERCS_IOW_LAST)
> +			return 0;
> +
> +	for (; hid_blacklist[n].idVendor; n++)
> +		if (hid_blacklist[n].idVendor == idVendor &&
> +		    hid_blacklist[n].idProduct == idProduct)
> +			quirks = hid_blacklist[n].quirks;
> +
> +	return quirks;
> +}

Hi Paul,

actually, this seems wrong to me. In case of Wacom or IOWarrior devices, 
we want the usb_hid_configure() to return immediately, without claiming 
the device (and propagate -ENODEV through hid_probe()). That's what the 
original code does, and that is correct.

After you patch, the usb_hid_configure() proceeds both for Wacom and 
IOWarrior devices, just leaving the quirks mask empty. But that's not what 
it should do, right?

Thanks,

-- 
Jiri Kosina
