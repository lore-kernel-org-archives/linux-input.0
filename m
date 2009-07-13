From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Input driver for Twinhan USB 6253:0100 remote control
Date: Mon, 13 Jul 2009 13:21:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907131316420.10476@wotan.suse.de>
References: <20090408072935.GA27920@dtor-d630.eng.vmware.com> <200904131931.24009.dmitry.torokhov@gmail.com> <49E4B678.9030508@rtr.ca> <200904140945.14652.dmitry.torokhov@gmail.com> <49E4C9CF.5060504@rtr.ca> <alpine.LNX.2.00.0904151022170.13028@wotan.suse.de>
 <49E5EAD7.7000309@rtr.ca> <alpine.LNX.2.00.0904161123180.13028@wotan.suse.de> <20090712182026.7a09c736@neptune.home> <alpine.LNX.2.00.0907131048110.10476@wotan.suse.de> <20090713113157.701ba027@neptune.home>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-1772455402-1247483934=:10476"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40167 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755339AbZGMLVX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 07:21:23 -0400
In-Reply-To: <20090713113157.701ba027@neptune.home>
Content-ID: <alpine.LNX.2.00.0907131319470.10476@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Mark Lord <lkml@rtr.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-1772455402-1247483934=:10476
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0907131319471.10476@wotan.suse.de>

On Mon, 13 Jul 2009, Bruno Prémont wrote:

> > > +	// set_bit(EV_REP, hi->input->evbit);
> > Why is this commented out?
> That was a remaining line from basing on hid-gyration.c Don't know what 
> it does, looks like related to key repeating but I've not read enough of 
> HID/Input code to find out. (all my tests were run with it commented 
> out, so I will drop it unless there is a good reason to uncomment it)

Yes, EV_REP is a flag which signals whether the keys produced by the 
device in question should be auto-repreated.

> With my patch it seems the mappings don't show up for EVIOCGKEYCODE:
> 
> int codes[2];
> for (codes[0] = 0; codes[0] < 1024; codes[0]++)
>   if (ioctl(evdev, EVIOCGKEYCODE, codes) >= 0) {
>     // display
>   } else
>     break;
> 
> Code block above only displays for codes[0] == 0:
>  codes = { 0, 388 /* KEY_TEXT */ }
> 
> For all other values of codes[0] ioctl returns EINVAL.
> 
> Is this expected or should complete mapping table be returned
> as it is for generic PS2 PC keyboard (if so, what changes does the
> patch need for it)?

The HID core's perception of scancode is the actual HID usage as reported 
by the device, inlcuding the page number.

I.e. for your device, the usages would be in 0x70004 - 0x70052 range, not 
0-1024 (which is what your current code is checking for).

Also, looking at the patch again -- could you please keep the usage 
numbers sorted in the switch-case in twinhan_input_mapping(), so that it's 
more readable and compatible with other drivers?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--168427776-1772455402-1247483934=:10476--
