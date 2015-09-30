From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] HID: hiddev: fix returned errno code in hiddev_connect()
Date: Wed, 30 Sep 2015 15:34:09 +0530
Message-ID: <20150930100408.GA5576@sudip-pc>
References: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com>
 <560BB1CA.8090300@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560BB1CA.8090300@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 30, 2015 at 10:56:26AM +0100, Luis de Bethencourt wrote:
> On 30/09/15 10:52, Luis de Bethencourt wrote:
> > The driver is using -1 instead of the -ENOMEM defined macro to specify
> > that a buffer allocation failed. Since the error number is propagated,
> > the caller will get a -EPERM which is the wrong error condition.
> > 
> > Also, the smatch tool complains with the following warning:
> > hiddev_connect() warn: returning -1 instead of -ENOMEM is sloppy
> > 
> > Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> > ---
> >  drivers/hid/usbhid/hiddev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> > index 2f1ddca..c5290ff 100644
> > --- a/drivers/hid/usbhid/hiddev.c
> > +++ b/drivers/hid/usbhid/hiddev.c
> > @@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
> >  	}
> >  
> >  	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
> > -		return -1;
> > +		return -ENOMEM;
> >  
> >  	init_waitqueue_head(&hiddev->wait);
> >  	INIT_LIST_HEAD(&hiddev->list);
> > 
> 
> Hello,
> 
> I got an "Undelivered Mail Returned to Sender" from Jiri Kosina's
> jikos@kernel.com email address. This email is listed multiple times
> in the MAINTAINERS file, does he have a new address to update this
> file?
Its jikos@kernel.org

regards
sudip
