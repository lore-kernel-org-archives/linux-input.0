From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: Bug in i2c-core?
Date: Tue, 10 Mar 2015 02:21:40 +0200
Message-ID: <6018658.iFTJCkgHeH@avalon>
References: <54F0507F.6030804@armadeus.com> <20150304082237.GA2955@katana> <20150308082617.GA1904@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150308082617.GA1904@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?S=E9bastien?= SZYMANSKI <sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Wolfram,

On Sunday 08 March 2015 09:26:17 Wolfram Sang wrote:
> On Wed, Mar 04, 2015 at 09:22:37AM +0100, Wolfram Sang wrote:
> >>>> I am writing an I2C touchscreen driver for an i.MX6 based board. I
> >>>> compiled it as a module and when I unload it, I get the following
> >>>> warning:
> >>>> 
> >>>> # modprobe sx8654
> >>>> [   46.261494] input: SX8654 I2C Touchscreen as
> >>>> /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/in
> >>>> put1
> >>>> # rmmod sx8654
> >>>> [   76.435223] ------------[ cut here ]------------
> >>>> [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> >>>> remove_proc_entry+0x148/0x164()
> >>>> [   76.448582] remove_proc_entry: removing non-empty directory
> >>>> 'irq/208', leaking at least 'sx8654'
> >>> 
> >>> ...
> >>> 
> >>>> When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> >>>> client removal time) I don't get the warning.
> >>>> 
> >>>> Is this a bug in the i2c-core or am I doing something wrong in my
> >>>> driver?
> >>> 
> >>> Yes, this commit breaks all drivers using devm* for IRQ management on
> >>> OF-based systemsi because devm* cleanup happens in device code, after
> >>> bus's remove() method returns. I'd recommend reverting and finding a
> >>> better way (making cleanup a custom devm action as well?).
> >> 
> >> Ouch, my bad.
> >> 
> >> Wolfram, any opinion ? The original patch fixes a real bug, so we
> >> shouldn't just revert it.
> > 
> > Looking at it some more: What bug does it fix? Anything you experienced?

Good question, and I have to confess that I don't really remember :-/

> > I wonder if we really need e4df3a0 because I can't see where
> > platform_get_irq, the major user of of_irq_get, disposes the mapping.
> > irq_create_of_mapping() will return an already assigned mapping if
> > called twice.

I've reached the same conclusion after reading the code. I was concerned about 
resource leakage, but that doesn't seem to be an issue.

> > I don't know yet, though, if mappings are static or if a mapping can be
> > routed to another irq controller over some time because theoretically they
> > can be dynamically added/removed.
> > 
> > Adding Rob to CC as he wrote of_irq_get and put it into
> > platform_get_irq. Rob, we use of_irq_get() in the I2C core and the
> > question is now if we need to dispose the mapping and if so what would
> > be a good place for it so managed devices will not have their mappings
> > removed before the managed irq is removed.
> 
> Ping. Just so you know: Without further information, I will revert the
> patch in question around rc4/rc5. I'd still like to know if the
> non-disposing of the mapping in platform_get_irq() is intentional.

I'll defer that to Rob. I'm fine with the revert at the moment.

-- 
Regards,

Laurent Pinchart
