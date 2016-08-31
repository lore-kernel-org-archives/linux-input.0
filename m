From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Wed, 31 Aug 2016 07:32:43 -0700
Message-ID: <1472653963.12515.8.camel@linux.intel.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca>
         <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
         <alpine.LNX.2.00.1608242313540.22028@cbobk.fhfr.pm>
         <4ab0f3f3-43e3-f815-dd7b-9f6aa0bf6833@kernel.org>
         <CACxGe6s9Xo8wBbTsro7RZjtXp=30a9tz6sxKkT9TyQDmoO+Vwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6s9Xo8wBbTsro7RZjtXp=30a9tz6sxKkT9TyQDmoO+Vwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <glikely@secretlab.ca>, Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2016-08-31 at 15:19 +0100, Grant Likely wrote:
> On Wed, Aug 24, 2016 at 10:23 PM, Jonathan Cameron <jic23@kernel.org>
> wrote:
> > 
> > On 24/08/16 22:14, Jiri Kosina wrote:
> > > 
> > > On Wed, 24 Aug 2016, Grant Likely wrote:
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > v2:
> > > > > > - Overview in documentation show analogy with usbhid
> > > > > > implementation
> > > > > > - sparse errors for statics. Also pointed by Jiri
> > > > > > - Clearly marking exported function header file. Clean up
> > > > > > all exports
> > > > > > unused inteface functions
> > > > > > - Changed to tristate from boolean as pointed by Jiri:
> > > > > > this required remove/unload functions
> > > > > > - Prevent crash when ISH enabled on non supported platform
> > > > > > - Break client.c to smaller part by seprating buffer
> > > > > > allocations
> > > > > > - move bus register/unregister to ishtp module
> > > > > > - There is only one config symbol INTEL_ISH_HID, removed
> > > > > > silent
> > > > > > config for TRANSPORT and IPC
> > > > > Tested-by: Grant Likely <grant.likely@secretlab.ca>
> > > > > 
> > > > > On an HP Spectre x360 laptop using v4.7-rc5.
> > > > Hey Srinivas. Any progress on this patch series?
> > > The HID part (with patch #5 omitted) should be in linux-next
> > > through
> > > hid.git already.
> > > 
> > The one IIO patch was pulled by Greg KH last night so hit linux
> > next
> > today.  Hence all on it's way by the sound of it!
> Nice!
> 
> Unfortunately, I've just hit a new bug after updating to v4.8-rc4.
> 4.7.0-rc6 works fine.
> 
> The kernel boots, and the driver loads, but the orientations are
> wrong. It appears that the X/Y is getting swapped:
> 
> Normal orientation: display rotated 90 degrees CW
> Rotated 90 degrees CW: display normal orientation
> Rotated 180 degrees (upside down): display rotated 90 degrees CCW
> Rotated 90 degrees CCW: display rotated 180 degrees
> 
This is  also observed in all non ISH platforms too. I bisected it to
some commit, which I don't know how this impacts. Yesterday I sent
email to the list. Try reverting this, you should be fine.

 commit 703b5faf22fbddf984a361e6555f3a03fdba63d9
> Author: George Spelvin <linux@sciencehorizons.net>
> Date:   Fri Jun 10 00:22:12 2016 -0400
>
>     fs/dcache.c: Save one 32-bit multiply in dcache lookup
>
>     Noe that we're mixing in the parent pointer earlier, we
>     don't need to use hash_32() to mix its bits.  Instead, we can
>     just take the msbits of the hash value directly.
>
>     For those applications which use the partial_name_hash(),
>     move the multiply to end_name_hash.
>
>     Signed-off-by: George Spelvin <linux@sciencehorizons.net>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


Thanks,
Srinivas


> Cheers,
> g.
