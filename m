From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Tue, 3 Jan 2012 09:57:42 -0800
Message-ID: <20120103175742.GB1041@core.coreip.homeip.net>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
 <1325484557-27695-1-git-send-email-olof@lixom.net>
 <CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
 <20120103154317.GA27061@quad.lixom.net>
 <CAPnjgZ3xN8+Ve28bcg1OQ4mv5rWvA-9ijP57UsuMQ5D1d=7Xxw@mail.gmail.com>
 <20120103162929.GY2914@n2100.arm.linux.org.uk>
 <20120103164431.GA31647@core.coreip.homeip.net>
 <20120103170615.GZ2914@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120103170615.GZ2914-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, U-Boot Mailing List <u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org>, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 03, 2012 at 05:06:15PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 03, 2012 at 08:44:32AM -0800, Dmitry Torokhov wrote:
> > On Tue, Jan 03, 2012 at 04:29:30PM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Jan 03, 2012 at 08:22:21AM -0800, Simon Glass wrote:
> > > > Can the Linux key codes fit in 8 bits?
> > > 
> > > That depends on your point of view.
> > > 
> > > If you hack on X, then the answer is yes and you ignore the squeels of
> > > your users when certain key presses get misinterpreted.  (The Psion LX
> > > platform, otherwise known as the Netbook Pro, suffered with this problem.)
> > > 
> > > If you are a kernel hacker, the answer is no, because key codes currently
> > > go all the way to 0x300.
> > 
> > For bootloader environment 0-255 range is probably sufficient though,
> > the upper keys are somewhat recent additions to the maps...
> 
> I assume you deem 'recent' to mean 8 years ago - they've been there since
> at least 2.6.9, which is where the problem I refer to above was first
> noticed.

Well, what's 8 years ;) On a more serious note keys above 255 are really
the extended set - keys of remote controls, camera control, touchpad,
various aplication launchers, etc that are not very interesting for
bootloader. But, as Olof mentioned, the encoding must be sufficient for
Linux as well as bootloader, so limiting it is not a good idea.

-- 
Dmitry
