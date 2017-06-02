From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Fri, 2 Jun 2017 09:29:07 +0200
Message-ID: <20170602072907.GK1293@mail.corp.redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
 <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
 <1496345185.2570.3.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496345185.2570.3.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dave Hansen <dave.hansen@intel.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jun 01 2017 or thereabouts, Bastien Nocera wrote:
> On Thu, 2017-06-01 at 11:06 -0700, Dave Hansen wrote:
> > On 03/27/2017 07:59 AM, Benjamin Tissoires wrote:
> > > this is finally a rework of the series that provides kernel
> > > power_supply
> > > for hidpp devices.
> > > 
> > > This will allow upower to not handle those devices anymore and to
> > > have more
> > > immediate reportng of the device to the system.
> > 
> > FWIW, I'm on Ubuntu 14.04, and upower *is* reporting my mouse battery
> > as
> > if it were a laptop battery.  It's mostly garbage, and always reports
> > 0%, which makes upower always tell me my laptop is 2/3 charged (I
> > have 2
> > real batteries).

Well, the exported battery might be sending levels instead of
pourcentages. And upower needs to be upgraded to handle those :(

> > 
> > Is this expected?
> 
> You need to either disable the feature for the kernel, or upgrade to
> the latest git master of UPower. Mixing both won't work. Use the devkit
> mailing-list if you need a release of UPower.
> 

Bastien, is is possible to have a simple udev rule that tells upower to
ignore the battery device if builtin_power_supply is there?
That way we can tell people running old upower to use this to be sure to
ignore the kernel device and just rely on the upower hidpp support?

Cheers,
Benjamin
