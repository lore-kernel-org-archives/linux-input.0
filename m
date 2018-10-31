From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Date: Wed, 31 Oct 2018 14:37:46 +1100
Message-ID: <20181031033746.GF8698@us.netrek.org>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
 <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

G'day,

Success, see below.

On Tue, Oct 30, 2018 at 08:40:38PM +0100, Lubomir Rintel wrote:
> Hello Pavel,
> 
> On Tue, 2018-10-30 at 11:26 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75
> > > > 
> > > > I didn't test it yet -- will do when I get home in the evening.
> > > > But
> > > > chances are it's good enough and I guess you'd be able to get it
> > > > working even if I messed up some details.
> >
> > [...]
> > Could I get prepared binary zImage for testing?
> 
> https://github.com/hackerspace/olpc-xo175-buildroot/releases
> 
> Here's a SD card image that works for me. The topmost commit in the
> same repository is the build configuration that was used to generate
> it:
> 
> https://github.com/hackerspace/olpc-xo175-buildroot/commit/71783d599.patch
> 
> Note it is only going to boot off the SD card, because the root=
> argument is hardwired in the devicetree. Sorry about that -- I built
> the image before I noticed you're booting off an USB stick and I don't
> have the resources to regenerate the image at the moment.

Your image does boot for me - after changing features on
filesystem.

	http://dev.laptop.org/~quozl/y/1gHh5m.txt (dmesg)

dumpe2fs of your image filesystem features; has_journal ext_attr
resize_inode dir_index filetype flex_bg sparse_super large_file
huge_file dir_nlink extra_isize metadata_csum, and flags;
signed_directory_hash.

dumpe2fs of my image filesystem features; has_journal ext_attr
resize_inode dir_index filetype extent flex_bg sparse_super uninit_bg
dir_nlink extra_isize, and flags; unsigned_directory_hash.

Our OLPC OS builder uses "mkfs.ext4 -O dir_index,^huge_file", from
e2fsprogs 1.42.5.

I'll look at the microSD card errors; by trying another one.

Fantastic progress though, thanks!  Wish I were a full time kernel
developer, but so much else to do now.

> If this won't boot for you, we may need fixes for older FW.

Let me know what you need there; with a patch, and if it isn't too
extensive I could spin a new build.  We're not producing these models,
so I don't _have_ to keep the factory test code working.

https://github.com/quozl/openfirmware

-- 
James Cameron
http://quozl.netrek.org/
