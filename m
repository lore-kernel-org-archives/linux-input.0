From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Dell XPS 13 9350 touchpad is busted in 4.12-rc
Date: Thu, 25 May 2017 10:25:18 +0300
Message-ID: <20170525072518.GM8541@lahna.fi.intel.com>
References: <CALCETrW3fuwiV82JrFkZ5ytb+VRPwpHDOvWBD4Q5zcWF_1ePcQ@mail.gmail.com>
 <alpine.LSU.2.20.1705250023170.26873@cbobk.fhfr.pm>
 <CALCETrUECMG+VerBSszA=__DG4Vj1xsWXdf51EdSHQym5M7HpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63619 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965670AbdEYHcA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 03:32:00 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrUECMG+VerBSszA=__DG4Vj1xsWXdf51EdSHQym5M7HpQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <btissoir@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Allen Hung <allen_hung@dell.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Ping Cheng <pingc@wacom.com>

On Wed, May 24, 2017 at 09:25:00PM -0700, Andy Lutomirski wrote:
> On Wed, May 24, 2017 at 3:26 PM, Jiri Kosina <jikos@kernel.org> wrote:
> > On Wed, 24 May 2017, Andy Lutomirski wrote:
> >
> >> I just build from Linus' tree from Saturday (ef82f1ad), and touchpad
> >> input is busted on my laptop.  The device is still there and evtest
> >> still shows events, but something is wrong and libinput either thinks
> >> I'm not moving at all or I'm trying to teleport to the edge of the
> >> screen.
> >>
> >> Is this a known problem or should I try to track it down?
> >
> > Did this work properly in 4.11?
> 
> I confess to not having tested 4.11, for 4.11-rc7 works.
> 
> >
> > Is this G11 based chipset? (IOW, is this device driven by wacom driver?).
> > If so, 6f107fab8 and/or 60a2218698 might be potential candidates.
> 
> I don't think so.
> 
> On a good kernel, I see:
> 
> /dev/input/event10:    DLL0704:01 06CB:76AE Touchpad
> 
> That thing is here, and the driver is hid-multitouch:
> 
> /sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL0704:01/0018:06CB:76AE.0001/input/input13
> 
> On 4.12-rc, I see a SynPC/2 Synaptics Touchpad instead, attached to
> i8042/serio1.
> 
> The culprit appears to be:
> 
> i2c_designware.1: controller timed out
> i2c_hid i2c-DLL0704:01: hid_descr_cmd failed
> 
> I'm wondering whether something like
> 9143059fafd4eebed2d43ffb5455178d4010e60a could be involved.

You need the following, I think:

https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=i2c/for-current&id=e2c824924cdb41528932c550647406ad81336b18
