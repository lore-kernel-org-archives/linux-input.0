From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v10] leds: USB: HID: Add support for MSI GT683R led panels
Date: Mon, 23 Jun 2014 14:24:32 -0400
Message-ID: <20140623182432.GB30831@kroah.com>
References: <20140623161723.GA20421@kroah.com>
 <1403543808-8228-1-git-send-email-janne.kanniainen@gmail.com>
 <20140623182324.GA30831@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140623182324.GA30831@kroah.com>
Sender: linux-leds-owner@vger.kernel.org
To: Janne Kanniainen <janne.kanniainen@gmail.com>
Cc: johan@kernel.org, jkosina@suse.cz, cooloney@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 23, 2014 at 02:23:24PM -0400, Greg KH wrote:
> On Mon, Jun 23, 2014 at 08:16:48PM +0300, Janne Kanniainen wrote:
> > +	ret = sysfs_create_group(&led->hdev->dev.kobj, &gt683r_attribute_group);
> > +	if (ret) {
> > +		hid_err(hdev, "failed to create sysfs attributes\n");
> > +		goto fail;
> > +	}
> 
> No, you need to set the attribute group _before_ you call
> led_classdev_register, as that is where the device will be created in
> sysfs.  Surely the other led drivers already do this?  I'm almost afraid
> to go look...

Yes, they do it already, set .dev_attr_group and you should be fine.

thanks,

greg k-h
