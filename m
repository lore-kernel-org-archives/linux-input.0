From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
 support  and add sysfs interface
Date: Mon, 2 Mar 2009 13:35:51 -0800
Message-ID: <20090302133551.1266f725.akpm@linux-foundation.org>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com>
	<20090302130425.23cc628d.akpm@linux-foundation.org>
	<20090302211820.GA21489@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090302211820.GA21489-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 2 Mar 2009 13:18:20 -0800
Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, Mar 02, 2009 at 01:04:25PM -0800, Andrew Morton wrote:
> > On Sat, 28 Feb 2009 23:53:03 -0500
> > Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org> wrote:
> > > ...
> > >
> > > +static ssize_t xpad_show_int(struct device *dev, struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	struct usb_xpad *xpad = to_xpad(dev);
> > > +	int value;
> > > +	if (attr == &dev_attr_rumble_enable)
> > > +		value = xpad->rumble_enable;
> > > +	else if (attr == &dev_attr_controller_number)
> > > +		value = xpad->controller_number;
> > > +	else if (attr == &dev_attr_controller_present)
> > > +		value = xpad->controller_present;
> > > +	else if (attr == &dev_attr_controller_type)
> > > +		value = xpad->controller_type;
> > > +	else if (attr == &dev_attr_left_trigger_full_axis)
> > > +		value = xpad->left_trigger_full_axis;
> > > +	else if (attr == &dev_attr_right_trigger_full_axis)
> > > +		value = xpad->right_trigger_full_axis;
> > > +	else
> > > +		return -EIO;
> > > +	return snprintf(buf, PAGE_SIZE, "%d\n", value);
> > > +}
> > 
> > The code's a bit unusual.  Most drivers don't have all that
> > if-then-else stuff.  They use a separate function for each sysfs file
> > and then they wrap it all up into a macro which emits all the data and
> > code for each file.
> 
> Yes, most don't, but that is because we used to not pass the attribute
> variable to the show/store functions.  It was added so that we could
> reduce the huge numbers of functions needed, to do stuff like this.  The
> hwmon drivers are examples of other drivers that do their show/store
> like this.
> 
> There's nothing wrong with it that I can see.
> 

OK.  I think.

- This approach will require a large number of edits each time an
  attribute is added/removed.

- otoh, removing nasty macros is always nice.

- This approach will generate slower code (which doesn't matter
  here).

- Was it demonstrated that this approach generates less code?


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
