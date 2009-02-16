From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: xpad.c - Xbox 360 wireless and sysfs support
Date: Mon, 16 Feb 2009 08:13:31 -0800
Message-ID: <20090216161331.GB5008@kroah.com>
References: <5aa163d00902142008g138826br80d3ea989e7af691@mail.gmail.com> <200902160931.34771.oliver@neukum.org> <5aa163d00902160522r3a22412je3f5202076f57a0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5aa163d00902160522r3a22412je3f5202076f57a0a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 16, 2009 at 08:22:05AM -0500, Mike Murphy wrote:
> On Mon, Feb 16, 2009 at 3:31 AM, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org> wrote:
> ...
> >
> > 1. You need to check the returns of sscanf
> 
> Will add... this is currently preliminary and not very well tested.
> 
> > 2. This is very ugly:
> >
> > +/* read-only attrs */
> > +static ssize_t xpad_show_int(struct xpad_data *xd, struct xpad_attribute *attr,
> > +       char *buf)
> > +{
> > +       int value;
> > +       if (!strcmp(attr->attr.name, "controller_number"))
> > +               value = xd->controller_number;
> > +       else if (!strcmp(attr->attr.name, "pad_present"))
> > +               value = xd->pad_present;
> > +       else if (!strcmp(attr->attr.name, "controller_type"))
> > +               value = xd->controller_type;
> > +       else
> > +               value = 0;
> > +       return sprintf(buf, "%d\n", value);
> > +}
> 
> The above code is basically following the example in
> samples/kobject/kset-example.c. I broke the rest of the sysfs stuff
> out such that it uses separate functions for show/store, which
> definitely looks cleaner. However, given the large amount of code that
> results, I'm starting to think that re-factoring and pulling the sysfs
> code out to a separate file might be useful.
> 
> >
> > 3. Possible memory leak in error case:
> >
> > +static struct xpad_data *xpad_create_data(const char *name, struct kobject *parent) {
> > +       struct xpad_data *data = NULL;
> > +       int check;
> > +
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return NULL;
> > +
> > +       check = kobject_init_and_add(&data->kobj, &xpad_ktype, parent, "%s", name);
> > +       if (check) {
> > +               kobject_put(&data->kobj);
> > +               return NULL;
> > +       }
> >
> 
> My understanding from Documentation/kobject.txt is that the
> kobject_put in the 2nd error check will set the kobj's reference
> counter to zero, eventually causing the kobject core to call my
> cleanup function for the ktype (xpad_release) and free the memory.

That is correct.

The bigger question is why are you using a struct kobject in the first
place?  As you are a device, just use a struct device.  What are you
trying to do in sysfs here to make you want to use a "raw" kobject in a
driver?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
