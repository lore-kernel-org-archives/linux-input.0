From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Sat, 16 Jun 2012 17:25:45 -0500
Message-ID: <20120616222545.GA1660@burratino>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
 <20120614212335.GA4210@burratino>
 <CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
 <20120615002705.GA7140@burratino>
 <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60786 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892Ab2FPWZy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jun 2012 18:25:54 -0400
Received: by obbtb18 with SMTP id tb18so6085227obb.19
        for <linux-input@vger.kernel.org>; Sat, 16 Jun 2012 15:25:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Nils Kanning <nils@kanning.de>

Hi Ping,

Ping Cheng wrote:

> Here is an update on my testing (for hardware, I have to test to be
> sure). The result shows driver in upstream and 3.2.20 both work with
> TPC2FG.

Again, thanks much for this.

Nils (cc-ed) tested Linus's "master" branch (3.5-rc2+) this morning.
The outcome:

| I built the kernel from the git repository as you described. The tablet
| does not work. 
|
| lsusb -t gives:
| Port 5: Dev 5, If 0, Class=HID, Driver=, 12M
|
| The dmesg output is attached. The two input files mentioned in this
| file, which are related to the wacom tablet, are not there after
| booting.

Logs at [1].

For comparison, v3.4.2 works fine.  v3.4.2 plus some unrelated
Intuous5 support patches (9fee619505bd + f860e581fd47 + 9b5b95dd516a +
ae584ca47328) also works fine.

Nils also tested v3.4.2 plus the following patch.

  f393ee2b814e Input: wacom - retrieve maximum number of touch points
               from the HID usage table when it is supported

The exact patch used is at [2].  That produced:

| Linux video capture interface: v2.00
| ------------[ cut here ]------------
| kernel BUG at mm/slab.c:505!
| invalid opcode: 0000 [#1] SMP 
[...]
| Pid: 579, comm: modprobe Not tainted 3.4.2-amd64 #1 LENOVO 42992QG/42992QG
[...]
| Call Trace:
|  [<ffffffff810ef84e>] ? kfree+0x50/0x6c
|  [<ffffffffa04029cd>] ? wacom_probe+0x52c/0x957 [wacom]
|  [<ffffffffa006866b>] ? usb_probe_interface+0xf2/0x15d [usbcore]

which is "BUG_ON(!PageSlab(page))" in page_get_cache() and represents
a free of an invalid pointer.

Full log at [3].

Known problem?  Any ideas for tracking it down?

Thanks again and hope that helps,
Jonathan

[1] http://bugs.debian.org/677164#87
[2] http://bugs.debian.org/677164#50
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=77;filename=dmesg_0001;att=1;bug=677164
