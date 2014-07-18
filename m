From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: rmi: only bind the hid-rmi driver to the mouse
 interface of composite USB devices
Date: Fri, 18 Jul 2014 09:07:05 -0400
Message-ID: <20140718130705.GB9108@mail.corp.redhat.com>
References: <1405638885-8014-1-git-send-email-aduggan@synaptics.com>
 <1405638885-8014-2-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405638885-8014-2-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Jul 17 2014 or thereabouts, Andrew Duggan wrote:
> On composite HID devices there may be multiple HID devices on separate interfaces, but hid-rmi
> should only bind to the mouse interface. One example is the Dell Venue 11 Pro's keyboard dock
> which contains a composite USB device with a HID touchpad and HID keyboard on separate intefaces.
> Since the USB Vendor ID is Synaptic's, hid-core is currently trying to bind hid-rmi to all\of
> the HID devices. This patch ensures that hid-rmi only binds to the mouse interface.
> 
> related bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=80091
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---

As mentioned in a private mail, Andrew told me that for now, each
touchpad using hid-rmi he has seen are using the boot mouse protocol, so
this patch will give us some space and will not break existing current
setups.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 8ed66fd..f10e768 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -783,7 +783,9 @@ static int hid_scan_report(struct hid_device *hid)
>  	* Vendor specific handlings
>  	*/
>  	if ((hid->vendor == USB_VENDOR_ID_SYNAPTICS) &&
> -	    (hid->group == HID_GROUP_GENERIC))
> +	    (hid->group == HID_GROUP_GENERIC) &&
> +	    /* only bind to the mouse interface of composite USB devices */
> +	    (hid->bus != BUS_USB || hid->type == HID_TYPE_USBMOUSE))
>  		/* hid-rmi should take care of them, not hid-generic */
>  		hid->group = HID_GROUP_RMI;
>  
> -- 
> 1.9.1
> 
