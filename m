From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch to add NOGET for DMI/Acomdata
Date: Wed, 19 Mar 2008 16:51:32 -0700
Message-ID: <20080319165132.f831c344.zaitcev@redhat.com>
References: <20080319154331.c670489d.zaitcev@redhat.com>
	<Pine.LNX.4.64.0803200010200.19269@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:59673 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935952AbYCSXz7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 19:55:59 -0400
In-Reply-To: <Pine.LNX.4.64.0803200010200.19269@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, zaitcev@redhat.com

On Thu, 20 Mar 2008 00:11:05 +0100 (CET), Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 19 Mar 2008, Pete Zaitcev wrote:

> > This must be the weirdest failure yet. My external disk stops processing 
> > the storage commands the moment it receives a GET_REPORT. The firmware 
> > does not crash; if I do rmmod hid, then SET-INTERFACE restores normal 
> > operations. Still, I cannot live without the keyboard when I want backup 
> > my files. Adding the NOGET quirk fixes this problem for me.

> uhm ... how does the GET_REPORT get delivered to the external disk? Does 
> it have any interface that claims itself to be HID class?

It is very common for them to have a "one-touch backup" button.
Here's how its summary looks:

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 13 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0c0b ProdID=5fab Rev= 3.53
S:  Manufacturer=DMI     
S:  Product=WD5000AAKB-00UKA
S:  SerialNumber=001010055008053D0
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=ub
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=64ms

To tell you the truth, I just now noticed that the button does not
work. Kernel prints this:

hiddev96hidraw0: USB HID v1.10 Device [DMI      WD5000AAKB-00UKA] on usb-0000:00:13.5-3

But then the events do not get delivered. This is what happens
with DEBUG enabled in hid-core.c:

usb 2-3.2: new high speed USB device using address 3
  INPUT[INPUT]
    Field(0)
      Usage(2)
        ffa0.00a6
        ffa0.00a7
      Logical Minimum(-128)
      Logical Maximum(127)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT[OUTPUT]
    Field(0)
      Usage(2)
        ffa0.00a9
        ffa0.00a9
      Logical Minimum(-128)
      Logical Maximum(127)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
hiddev96: USB HID v1.10 Device [DMI      WD5000AAKB-00UKA] on usb-0000:05:04.3-3.2

I dunno, maybe the button is just broken somehow. But I'm only
interested in the storage function.

-- Pete
