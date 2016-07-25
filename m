From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb - cleanup use of dev
Date: Mon, 25 Jul 2016 13:50:43 -0700
Message-ID: <20160725205043.GI27415@dtor-ws>
References: <1469472228-58912-1-git-send-email-briannorris@chromium.org>
 <20160725203151.GH27415@dtor-ws>
 <20160725204604.GA129467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35538 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbcGYUur (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 16:50:47 -0400
Content-Disposition: inline
In-Reply-To: <20160725204604.GA129467@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>

On Mon, Jul 25, 2016 at 01:46:05PM -0700, Brian Norris wrote:
> On Mon, Jul 25, 2016 at 01:31:51PM -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 25, 2016 at 11:43:48AM -0700, Brian Norris wrote:
> > > From: Douglas Anderson <dianders@chromium.org>
> > > 
> > > In cros_ec_keyb we stored "dev" in "struct cros_ec_keyb", but this was
> > > the EC's dev pointer and not the keyboard's.  Let's clean this up to
> > > make it the keyboard's dev pointer.  This could be useful in future
> > > patches but also has the nice effect of changing a few printouts to
> > > include the name of the keyboard device instead of the EC device, which
> > > seems more technically correct.
> > 
> > What is the difference in the output? Could you show old vs new example?
> 
> For instance, on a veyron Chromebook, I see this on bootup with v4.7:
> 
> # dmesg | grep -e cros-ec -e keyb
> [    0.539153] cros-ec-spi spi0.0: Chrome EC device registered
> [    1.224505] cros-ec-spi spi0.0: valid_keys[00] = 0x14
> [    1.224509] cros-ec-spi spi0.0: valid_keys[01] = 0xff
> [    1.224514] cros-ec-spi spi0.0: valid_keys[02] = 0xff
> [    1.224518] cros-ec-spi spi0.0: valid_keys[03] = 0xff
> [    1.224521] cros-ec-spi spi0.0: valid_keys[04] = 0xff
> [    1.224525] cros-ec-spi spi0.0: valid_keys[05] = 0xf5
> [    1.224529] cros-ec-spi spi0.0: valid_keys[06] = 0xff
> [    1.224533] cros-ec-spi spi0.0: valid_keys[07] = 0xa4
> [    1.224536] cros-ec-spi spi0.0: valid_keys[08] = 0xff
> [    1.224540] cros-ec-spi spi0.0: valid_keys[09] = 0xfe
> [    1.224544] cros-ec-spi spi0.0: valid_keys[10] = 0x55
> [    1.224548] cros-ec-spi spi0.0: valid_keys[11] = 0xfa
> [    1.224551] cros-ec-spi spi0.0: valid_keys[12] = 0xca
> [    1.224632] input: cros_ec as /devices/platform/ff110000.spi/spi_master/spi0/spi0.0/ff110000.spi:ec@0:keyboard-controller/input/input0
> 
> and this, with this patch applied:
> 
> # dmesg | grep -e cros-ec -e keyb
> [    0.539437] cros-ec-spi spi0.0: Chrome EC device registered
> [    1.224648] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[00] = 0x14
> [    1.224653] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[01] = 0xff
> [    1.224657] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[02] = 0xff
> [    1.224662] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[03] = 0xff
> [    1.224666] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[04] = 0xff
> [    1.224670] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[05] = 0xf5
> [    1.224674] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[06] = 0xff
> [    1.224678] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[07] = 0xa4
> [    1.224682] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[08] = 0xff
> [    1.224686] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[09] = 0xfe
> [    1.224690] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[10] = 0x55
> [    1.224694] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[11] = 0xfa
> [    1.224698] cros-ec-keyb ff110000.spi:ec@0:keyboard-controller: valid_keys[12] = 0xca
> [    1.224779] input: cros_ec as /devices/platform/ff110000.spi/spi_master/spi0/spi0.0/ff110000.spi:ec@0:keyboard-controller/input/input
> 
> (both are done with an added '#define DEBUG', since that's easier than fiddling
> with dynamic debug prints)
> 
> I think it's important to see the "cros-ec-keyb" driver name, and the
> specific device name is a nice bonus.
> 
> Do you want to paste something like this into the commit description, or
> should I resend?

Yes, I munged the commit message a tiny bit, thank you.

-- 
Dmitry
