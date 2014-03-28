From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Fri, 28 Mar 2014 08:27:04 +0000
Message-ID: <20140328082704.GC6801@srcf.ucam.org>
References: <1395310330-3232-1-git-send-email-hdegoede@redhat.com>
 <20140320172159.GA27400@srcf.ucam.org>
 <20140328075655.GE22093@core.coreip.homeip.net>
 <20140328082004.GA6801@srcf.ucam.org>
 <20140328082452.GH22093@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140328082452.GH22093@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 28, 2014 at 01:24:52AM -0700, Dmitry Torokhov wrote:
> On Fri, Mar 28, 2014 at 08:20:04AM +0000, Matthew Garrett wrote:
> > On Fri, Mar 28, 2014 at 12:56:55AM -0700, Dmitry Torokhov wrote:
> > 
> > > I am still unsure if we shoudl be adding these new IDs to serio core...
> > > Can't the X driver take a peek at ACPI devices on it's own?
> > 
> > In the (admittedly unlikely) event of multiple PS/2 trackpads, how do 
> > you know which one corresponds to which ACPI device?
> 
> So far I have not seen a single instance of a laptop with 2 touchpads
> and I doubt external PS/2 ones will ever make come back.

Right, we can hack around it based on what we've seen so far. But it 
seems more attractive to fix it in such a way that we won't behave 
inappropriately even if someone does do something utterly unexpected in 
future. For instance, some ARM devices have i8042-like serio - if the 
underlying device is exposed in device tree, it'd be nice to be able to 
expose that to userspace without having to modify the core X code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
