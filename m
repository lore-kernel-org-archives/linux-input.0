From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] HID: usbkbd: return proper error code
Date: Wed, 31 Aug 2016 13:33:41 -0300
Message-ID: <CAOMZO5D7OW73GjqyAWD8Vap4cpY-VcvDwORJDqj8h3cq8Cg=rw@mail.gmail.com>
References: <1472660901-1912-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472660901-1912-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 31, 2016 at 1:28 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Use proper error code instead of using -1 on failure to allocate
> memory. We may use the error code later in the caller.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/hid/usbhid/usbkbd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
> index 9a332e6..ee53359 100644
> --- a/drivers/hid/usbhid/usbkbd.c
> +++ b/drivers/hid/usbhid/usbkbd.c
> @@ -249,15 +249,15 @@ static void usb_kbd_close(struct input_dev *dev)
>  static int usb_kbd_alloc_mem(struct usb_device *dev, struct usb_kbd *kbd)
>  {
>         if (!(kbd->irq = usb_alloc_urb(0, GFP_KERNEL)))
> -               return -1;
> +               return -ENOMEM;

While you are it, the code would look better like this:

kbd->irq = usb_alloc_urb(0, GFP_KERNEL)
if (!kbd->irq)
    return -ENOMEM;
