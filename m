From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Tue, 29 May 2007 11:59:39 -0400
Message-ID: <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
References: <20070529043957.GB6157@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070529043957.GB6157@rcn.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Brian Magnuson <bdmagnuson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Brian,

On 5/29/07, Brian Magnuson <bdmagnuson@gmail.com> wrote:
> Hi,
>
> This patch implements a driver for the "Microsoft Xbox 360 Wireless Receiver
> for Windows" that was recently released.  It seems to mostly "just work" for
> the basics at this point and I'd like to get some feedback on it since this is
> my first attempt at driver development.
>
> It borrows heavily from xpad.c since it's basically the same controller with
> new wireless magic.  The difference being that the receiever can host multiple
> controllers through the same device and the driver manages them coming and
> going.  In particular I moved the input device creation/deletion out of the
> probe function and into workqueues kicked off by usb interrupts.  That would
> probably be a good place for prospective reviewers to start finding issues. :)
>

Thnk you for the patch. Looking at the code I do not see one device
supporintg multiple controllers... You have one input device per usb
device/interface and the properties of said device are known
beforehand. So I would just create and register input device right
there in xboxrcvr_probe() and get rid of your build and teardown
works. The fact that is it a wireless device and at transmitter may at
times be out of range is not important.

Overall I would like support for this wireless receiver to be
incorporated into xpad.c driver.

I also have some more comments, see below.

> +
> +static unsigned long debug = 0;

You do not need to initialize statig variables to 0. It only increases
size of the image.

> +module_param(debug, ulong, 0644);
> +MODULE_PARM_DESC(debug, "debug level");
> +

> +
> +       if(debug) {

Please use spaces between statement (if,for, while) and opening paren.

> +
> +       /* Valid pad data */
> +       if(!(sdata[1] & 0x1) || !xboxrcvr->open)
> +               return;

Why are we generating interrupts if device is not used? Have the
->open() method submit urbs and then you don't need to check it here.

> +
> +       /* FIXME: Yuck.  Need to make sure this doesn't get truncated */
> +       usb_make_path(xboxrcvr->udev, path, sizeof(xboxrcvr->phys));
> +       snprintf(xboxrcvr->phys, sizeof(xboxrcvr->phys), "%s/input%d", path, xboxrcvr->id);
> +       snprintf(xboxrcvr->uniq, sizeof(xboxrcvr->uniq), "xpad%d", xboxrcvr->id >> 1);

Uniq is used to carry identificator unique for the device, not within
a particular system. It is property of device itself and should not
change if moved to a different box so do not try to come up with
artificial data for it.

> +
> +       input_dev->name     = xboxrcvr_device[0].name;

Hmm....

> +       input_dev->phys     = xboxrcvr->phys;
> +       input_dev->uniq     = xboxrcvr->uniq;
> +       input_dev->cdev.dev = &(xboxrcvr->intf->dev);

Please use

input_dev->dev.parent = &xboxrcvr->intf->dev;

- input devices are meving moved from class_device to struct device.

> +       input_dev->private  = xboxrcvr;

input_set_drvdata(input_dev, xboxrcvr); And use input_get_drvdata()
instead of accessing dev->private directly.

-- 
Dmitry
