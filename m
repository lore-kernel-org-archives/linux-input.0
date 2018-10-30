From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Date: Wed, 31 Oct 2018 10:54:30 +1100
Message-ID: <20181030235430.GF30863@us.netrek.org>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181030102610.GC21529@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

G'day Pavel,

On Tue, Oct 30, 2018 at 11:26:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75
> > > 
> > > I didn't test it yet -- will do when I get home in the evening. But
> > > chances are it's good enough and I guess you'd be able to get it
> > > working even if I messed up some details.
> 
> Instruction say make, but you really need to do make zImage and make
> mmp2-olpc-xo-1-75.dtb .
> 
> Instructions say "make -j", which is nice way to crash a machine. I
> suggest "make -j 8" :-).
> 
> Ok, I think I followed the instructions. I am using empty root
> filesystem, just with /boot -- want to see kernel messages first
> before I mess with the userland.
> 
> But I don't get kernel messages during boot:
> 
> OLPC 1B1, 512 MiB memory...
> OpenFirmware Q4C02 EC Frimware 0.3.02
> 
> Type any key to interrupt...
> (but keys do not interrupt anything, ouch).
> Warning... partition type is 0xb...
> Boot device: /usb/disk:\boot\olpc.fth Arguments:
> Boot device ....
> Warning... partition type is 0xb...

That firmware has problems with USB drives.  Please upgrade to Q4D38.
Quickest tested method is http://wiki.laptop.org/go/Upgrading_firmware

I'm firmware releaser and signer.

> And that's it, cursor and no kernel messages.
> 
> Any ideas?
> 
> Could I get prepared binary zImage for testing?
> 
> Thanks,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
James Cameron
http://quozl.netrek.org/
