From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: serio: make HYPERV_KEYBOARD depend on SERIO_I8042=y
Date: Wed, 13 Aug 2014 05:24:35 +0000
Message-ID: <EE124450C0AAF944A40DD71E61F878C9925D21@SINEX14MBXC417.southpacific.corp.microsoft.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <20140812032148.GB6867@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920A1C@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812060108.GA13231@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C9920EAF@SINEX14MBXC417.southpacific.corp.microsoft.com>
 <20140812175435.GA22386@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140812175435.GA22386@core.coreip.homeip.net>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: linux-input@vger.kernel.org

> -----Original Message-----
> From: Dmitry Torokhov
> Sent: Wednesday, August 13, 2014 1:55 AM
> > > > To decouple the dependency between the hyperv-keyboard and i8042
> > > > modules, I suppose we probably have to re-implement hyperv-
> keyboard by
> > > > using input_allocate_device(), input_register_device(), and using
> > > > input_report_key() to pass the key strokes to the high level.
> > >
> > > Yes, that would be the best thing to do,
> 
> Why? The backend still delivers AT keyboard data, so why does it make
> sense to write a new driver instead of making sure you can load
> atkbd/libps2 even without i8042 loaded?

Hi Dmitry,
Thanks for pointing this out!
I didn't realize input_report_key() can't accept AT keyboard scan codes.

> > The issue is: the latest Arch Linux release doesn't have a working (virtual)
> > keyboard when it runs as Generation 2 hyper-v guest -- when it runs as
> > a "traditional" Generation 1 hyper-v guest, everything works fine.
> > I hope this patch can temporarily help Arch users if they find the issue
> > and if they can rebuild the kernel.
> 
> The Arch users can simply select to build i8042 into the kernel as a
> workaround.
I agree.

> The proper solution is to allow loading libps2 module even if i8042 did
> not find its device. I wish I could simply drop this i8042_lock_chip and
> stuff, but unfortunately i8042 ports are not truly independent. We need
> to figure a way for libps2 to engage locking in i8042 if the driver is
> loaded, otherwise just ignore it.
> 
> Dmitry
Yeah, this seems the right solution.

How about this:
in libps2.c let's add  and export a function pointer
i8042_lock_chip_if_port_owner: it is used to replace the current 
	if (i8042_check_port_owner(ps2dev->serio))
		i8042_lock_chip();
The function pointer has a default value NULL, and in i8042.c: i8042_init()
we set the function pointer if an i8042 device is found?

Thanks,
-- Dexuan
