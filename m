From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio: make HYPERV_KEYBOARD depend on SERIO_I8042=y
Date: Tue, 12 Aug 2014 10:54:35 -0700
Message-ID: <20140812175435.GA22386@core.coreip.homeip.net>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <20140812032148.GB6867@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920A1C@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812060108.GA13231@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920EAF@SINEX14MBXC417.southpacific.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <EE124450C0AAF944A40DD71E61F878C9920EAF@SINEX14MBXC417.southpacific.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 12, 2014 at 07:15:25AM +0000, Dexuan Cui wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Greg KH
> > > > What exactly needs to be done to fix this "correctly" that is going to
> > > > take too much work at the moment?
> > >
> > > To decouple the dependency between the hyperv-keyboard and i8042
> > > modules, I suppose we probably have to re-implement hyperv-keyboard by
> > > using input_allocate_device(), input_register_device(), and using
> > > input_report_key() to pass the key strokes to the high level.
> > 
> > Yes, that would be the best thing to do,

Why? The backend still delivers AT keyboard data, so why does it make
sense to write a new driver instead of making sure you can load
atkbd/libps2 even without i8042 loaded?

> > and shouldn't be that hard to
> > create an input driver, it's pretty simple code, right?
> Hi Greg,
> Thanks for the confirmation!
> I didn't use the APIs before. 
> I think I need a couple of days to code, test and debug it while I have many
>  things at hand at present. :-(
> 
> > > I'll have to need some time for further investigation and a new
> > > implementation. Before the new code is completely ready, IMHO the
> > > patch can help to avoid a bad user experience like Arch Linux working
> > > as a Generation 2 hyper-v guest.
> > 
> > You are still preventing Arch from working here, as the driver can't be
> > built at all, right?
> The driver can build(compile) fine.
> The issue is: the latest Arch Linux release doesn't have a working (virtual)
> keyboard when it runs as Generation 2 hyper-v guest -- when it runs as
> a "traditional" Generation 1 hyper-v guest, everything works fine.
> I hope this patch can temporarily help Arch users if they find the issue
> and if they can rebuild the kernel.

The Arch users can simply select to build i8042 into the kernel as a
workaround.

The proper solution is to allow loading libps2 module even if i8042 did
not find its device. I wish I could simply drop this i8042_lock_chip and
stuff, but unfortunately i8042 ports are not truly independent. We need
to figure a way for libps2 to engage locking in i8042 if the driver is
loaded, otherwise just ignore it.

Thanks.

-- 
Dmitry
