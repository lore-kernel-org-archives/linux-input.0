From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Sat, 16 Jun 2012 19:43:58 -0500
Message-ID: <CAGzDe_YkhZGOLb-0xqmGDHV=rGujbBr9ohd-qkCty8=VMXr5rw@mail.gmail.com>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
	<20120614212335.GA4210@burratino>
	<CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
	<20120615002705.GA7140@burratino>
	<CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
	<20120616222545.GA1660@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42832 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab2FQAn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jun 2012 20:43:59 -0400
Received: by lbbgm6 with SMTP id gm6so3608199lbb.19
        for <linux-input@vger.kernel.org>; Sat, 16 Jun 2012 17:43:58 -0700 (PDT)
In-Reply-To: <20120616222545.GA1660@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, dmitry.torokhov@gmail.com, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Nils Kanning <nils@kanning.de>

On Sat, Jun 16, 2012 at 5:25 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Ping,
>
> Ping Cheng wrote:
>
>> Here is an update on my testing (for hardware, I have to test to be
>> sure). The result shows driver in upstream and 3.2.20 both work with
>> TPC2FG.
>
> Again, thanks much for this.
>
> Nils (cc-ed) tested Linus's "master" branch (3.5-rc2+) this morning.
> The outcome:
>
> | I built the kernel from the git repository as you described. The ta=
blet
> | does not work.
> |
> | lsusb -t gives:
> | Port 5: Dev 5, If 0, Class=3DHID, Driver=3D, 12M
> |
> | The dmesg output is attached. The two input files mentioned in this
> | file, which are related to the wacom tablet, are not there after
> | booting.
>
> Logs at [1].
>
> For comparison, v3.4.2 works fine. =A0v3.4.2 plus some unrelated
> Intuous5 support patches (9fee619505bd + f860e581fd47 + 9b5b95dd516a =
+
> ae584ca47328) also works fine.
>
> Nils also tested v3.4.2 plus the following patch.
>
> =A0f393ee2b814e Input: wacom - retrieve maximum number of touch point=
s
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 from the HID usage table when it is suppo=
rted
>
> The exact patch used is at [2]. =A0That produced:
>
> | Linux video capture interface: v2.00
> | ------------[ cut here ]------------
> | kernel BUG at mm/slab.c:505!
> | invalid opcode: 0000 [#1] SMP
> [...]
> | Pid: 579, comm: modprobe Not tainted 3.4.2-amd64 #1 LENOVO 42992QG/=
42992QG
> [...]
> | Call Trace:
> | =A0[<ffffffff810ef84e>] ? kfree+0x50/0x6c
> | =A0[<ffffffffa04029cd>] ? wacom_probe+0x52c/0x957 [wacom]
> | =A0[<ffffffffa006866b>] ? usb_probe_interface+0xf2/0x15d [usbcore]
>
> which is "BUG_ON(!PageSlab(page))" in page_get_cache() and represents
> a free of an invalid pointer.
>
> Full log at [3].
>
> Known problem? =A0Any ideas for tracking it down?
>
> Thanks again and hope that helps,
> Jonathan
>
> [1] http://bugs.debian.org/677164#87
> [2] http://bugs.debian.org/677164#50
> [3] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D77;filename=3D=
dmesg_0001;att=3D1;bug=3D677164

Its not obvious to me yet why patch [2] would cause the crash in log
[1].  The only reason I see for wacom_probe() to be calling kfree() is
in error case were its trying to unload the interface.  Since the
dmesg shows Pen loading, this is most likely crashing while processing
the Finger/touch interface.

That makes some sense because patch [2] adds logic that should only be
invoked on the touch interface.

Can you "rmmod wacom" and this run "lsusb -vvv" and email me directly
or post to debian bug report the section for Wacom?  I'd like to look
at HID report for MAXCONTACTS and other items for touch interface.  In
this part of patch [2]:

+			case HID_USAGE_CONTACTMAX:
+				wacom_retrieve_report_data(intf, features);
+				i++;
+				break;

that i++ may not be needed and may cause it to ignore an important
piece of data on this 0xE6 device.

Thats my only guess right now.  From here, you may need to sprinkle
the wacom_probe() function with a bunch of printk()'s to see exactly
which part is failing and requesting to jump to "fail1:" label.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
