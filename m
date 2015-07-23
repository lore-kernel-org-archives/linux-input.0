From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Thu, 23 Jul 2015 07:19:59 +0200
Message-ID: <55B0797F.1030004@suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz>
 <20150721170133.GA39076@dtor-ws> <20150721210850.GA13242@amd>
 <55AF96B3.8070507@suse.cz> <alpine.LNX.2.00.1507222054000.1141@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58668 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbbGWFUE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 01:20:04 -0400
In-Reply-To: <alpine.LNX.2.00.1507222054000.1141@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 07/22/2015 08:55 PM, Jiri Kosina wrote:
> On Wed, 22 Jul 2015, Vlastimil Babka wrote:
> 
> [ ... snip ... ]
>> The mouse has 3 green leds and one red to indicate battery status, but I think
>> they operate autonomously.
> 
> It's possible that the mouse is presenting them in the report descriptor 
> though (and maybe it's even possible to control them from the host).
> 
> Could you please provide contents of
> 
> 	/sys/kernel/debug/hid/<device>/rdesc

For the record, below. I wonder why there's two more "LED.?" lines (7) than the
warnings I get (5)?

gusiac:~ # cat /sys/kernel/debug/hid/0003\:046D\:C50E.0003/rdesc
05 01 09 02 a1 01 09 01 a1 00 05 09 19 01 29 08 15 00 25 01 95 08 75 01 81 02 05
01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03 81 06 c0 05 0c 0a 38 02 95 01 81 06
09 3c 15 00 25 01 75 01 95 01 b1 22 95 07 b1 01 05 08 09 4b 15 00 25 01 95 08 75
01 81 02 05 09 19 09 29 10 81 02 c0

  INPUT[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(8)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(8)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(3)
        GenericDesktop.X
        GenericDesktop.Y
        GenericDesktop.Wheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(3)
      Report Offset(8)
      Flags( Variable Relative )
    Field(2)
      Application(GenericDesktop.Mouse)
      Usage(1)
        Consumer.HorizontalWheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(1)
      Report Offset(32)
      Flags( Variable Relative )
    Field(3)
      Application(GenericDesktop.Mouse)
      Usage(8)
        LED.GenericIndicator
        LED.GenericIndicator
        LED.GenericIndicator
        LED.GenericIndicator
        LED.GenericIndicator
        LED.GenericIndicator
        LED.GenericIndicator
        LED.GenericIndicator
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(8)
      Report Offset(40)
      Flags( Variable Absolute )
    Field(4)
      Application(GenericDesktop.Mouse)
      Usage(8)
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(8)
      Report Offset(48)
      Flags( Variable Absolute )
  FEATURE[FEATURE]
    Field(0)
      Application(GenericDesktop.Mouse)
      Usage(1)
        Consumer.003c
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute NoPreferredState )

Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
Button.0004 ---> Key.SideBtn
Button.0005 ---> Key.ExtraBtn
Button.0006 ---> Key.ForwardBtn
Button.0007 ---> Key.BackBtn
Button.0008 ---> Key.TaskBtn
GenericDesktop.X ---> Relative.X
GenericDesktop.Y ---> Relative.Y
GenericDesktop.Wheel ---> Relative.Wheel
Consumer.HorizontalWheel ---> Relative.HWheel
LED.GenericIndicator ---> LED.Misc
LED.GenericIndicator ---> LED.?
LED.GenericIndicator ---> LED.?
LED.GenericIndicator ---> LED.?
LED.GenericIndicator ---> LED.?
LED.GenericIndicator ---> LED.?
LED.GenericIndicator ---> LED.?
LED.GenericIndicator ---> LED.?
Button.0009 ---> Key.?
Button.000a ---> Key.?
Button.000b ---> Key.?
Button.000c ---> Key.?
Button.000d ---> Key.?
Button.000e ---> Key.?
Button.000f ---> Key.?
Button.0010 ---> Key.?

