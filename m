From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Q: weird hidraw behaviour
Date: Thu, 10 Oct 2013 12:39:39 +0300
Message-ID: <20131010093939.GH3521@intel.com>
References: <20130924085606.GI28875@intel.com>
 <CANq1E4TxGS4NSc3BOon2+zVwkvY2LQTmQowHxOJnypf860+-jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3454 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab3JJJeM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 05:34:12 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4TxGS4NSc3BOon2+zVwkvY2LQTmQowHxOJnypf860+-jw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Manoj Chourasia <mchourasia@nvidia.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, Oct 10, 2013 at 11:26:45AM +0200, David Herrmann wrote:
> Hi
> 
> On Tue, Sep 24, 2013 at 10:56 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Hi,
> >
> > I noticed that after commit 212a871a393 (HID: hidraw: correctly deallocate
> > memory on device disconnect) hidraw doesn't close the underlying hid device
> > when the device node is closed last time.
> >
> > For example I have a touch panel (HID over I2C) device with added debug
> > prints in i2c_hid_open()/i2c_hid_close():
> >
> >         # od -x /dev/hidraw0
> >         [   41.363813] i2c_hid 1-004c: i2c_hid_power lvl:32
> >         [   41.368464] i2c_hid 1-004c: i2c_hid_set_power
> >         [   41.372831] i2c_hid 1-004c: __i2c_hid_command: cmd=54 01 00 08
> >         [   41.451455] i2c_hid 1-004c: i2c_hid_open
> >         ^C
> >
> >         # od -x /dev/hidraw0
> >         [   58.420928] i2c_hid 1-004c: i2c_hid_power lvl:32
> >         [   58.425577] i2c_hid 1-004c: i2c_hid_set_power
> >         [   58.429945] i2c_hid 1-004c: __i2c_hid_command: cmd=54 01 00 08
> >         [   58.525276] i2c_hid 1-004c: i2c_hid_open
> >         ^C
> >
> > i2c_hid_close() is never called. Is this intended or am I missing
> > something?
> 
> I don't know whether it's intentional, but it is hardcoded this way
> now. Logic is, ->close() is called on hidraw_disconnect() that is,
> when hidraw is unloaded on a device. It no longer depends on
> user-space processes.
> 
> Any reason to change it back? It's no bug, so if no-one cares I'd
> leave it as it is now. Otherwise, we can try to change it again.

Well, if you open the device and close it from userspace, the device stays
opened forever. I'm not sure if that's the intention.

I think that fix for this was already merged.
