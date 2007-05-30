From: Brian Magnuson <bdmagnuson@gmail.com>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Tue, 29 May 2007 20:28:46 -0400
Message-ID: <20070530002846.GA8595@rcn.com>
References: <20070529043957.GB6157@rcn.com> <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Dimitri,

Thanks for taking the time to review.  My reponses are inline.

-Brian

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2007-05-29 20:03]:
> 
> Thnk you for the patch. Looking at the code I do not see one device
> supporintg multiple controllers... You have one input device per usb
> device/interface and the properties of said device are known
> beforehand. So I would just create and register input device right
> there in xboxrcvr_probe() and get rid of your build and teardown
> works. The fact that is it a wireless device and at transmitter may at
> times be out of range is not important.

Actually, I rather liked the fact that the input devices only show up when
there is a controller connected to the receiver, since there can be anywhere
from 0-4 controllers alive.  This way there are no device nodes for
non-existant controllers.

> 
> Overall I would like support for this wireless receiver to be
> incorporated into xpad.c driver.

Knew that was coming :).  Should be able to manage it.  Since the wireless
model returns a expanded data format it needs to be handled specially.
Another flag in the xpad_device struct?

> 
> I also have some more comments, see below.
> 
> >+
> >+static unsigned long debug = 0;
> 
> You do not need to initialize statig variables to 0. It only increases
> size of the image.

ok.

> 
> >+module_param(debug, ulong, 0644);
> >+MODULE_PARM_DESC(debug, "debug level");
> >+
> 
> >+
> >+       if(debug) {
> 
> Please use spaces between statement (if,for, while) and opening paren.
>.

ok.

> >+
> >+       /* Valid pad data */
> >+       if(!(sdata[1] & 0x1) || !xboxrcvr->open)
> >+               return;
> 
> Why are we generating interrupts if device is not used? Have the
> ->open() method submit urbs and then you don't need to check it here.

A side effect of submitting the int urb as soon as a pad is detected.

> 
> >+
> >+       /* FIXME: Yuck.  Need to make sure this doesn't get truncated */
> >+       usb_make_path(xboxrcvr->udev, path, sizeof(xboxrcvr->phys));
> >+       snprintf(xboxrcvr->phys, sizeof(xboxrcvr->phys), "%s/input%d", 
> >path, xboxrcvr->id);
> >+       snprintf(xboxrcvr->uniq, sizeof(xboxrcvr->uniq), "xpad%d", 
> >xboxrcvr->id >> 1);
> 
> Uniq is used to carry identificator unique for the device, not within
> a particular system. It is property of device itself and should not
> change if moved to a different box so do not try to come up with
> artificial data for it.

Removed.  That got put in early as something for udev to key off of.  Turns
out I don't need it anyway of course.

> 
> >+
> >+       input_dev->name     = xboxrcvr_device[0].name;
> 
> Hmm....
>

Heh.  That came from xpad.c which looped through the device IDs and then
attached the name of the matched device in the input dev.  Since my driver
only has one ID I removed that loop and put a 0 in there. :)

> >+       input_dev->phys     = xboxrcvr->phys;
> >+       input_dev->uniq     = xboxrcvr->uniq;
> >+       input_dev->cdev.dev = &(xboxrcvr->intf->dev);
> 
> Please use
> 
> input_dev->dev.parent = &xboxrcvr->intf->dev;
> 
> - input devices are meving moved from class_device to struct device.
> 
> >+       input_dev->private  = xboxrcvr;
> 
> input_set_drvdata(input_dev, xboxrcvr); And use input_get_drvdata()
> instead of accessing dev->private directly.

ok

> Dmitry

Thanks again,
-Brian
