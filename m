From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH][hid] Fix a NULL pointer dereference when we fail to allocate
 memory
Date: Sun, 22 Jul 2007 07:47:33 +0200
Message-ID: <46A2EF75.70700@gmail.com>
References: <200707220006.20359.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707220006.20359.jesper.juhl@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Haboustak <mike-@cinci.rr.com>, Andreas Gal <gal@uci.edu>, Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Jesper Juhl napsal(a):
>  drivers/hid/usbhid/hid-core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index b2baeae..3ff7468 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -743,7 +743,7 @@ static struct hid_device *usb_hid_configure(struct usb_interface *intf)
>  	hid->quirks = quirks;
>  
>  	if (!(usbhid = kzalloc(sizeof(struct usbhid_device), GFP_KERNEL)))

Out of curiosity, where is this freed?

-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
