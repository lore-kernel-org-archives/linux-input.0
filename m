From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming
 Keyboard
Date: Thu, 9 Feb 2012 22:33:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202092231420.24127@pobox.suse.cz>
References: <4D55AE81.3030805@freemail.hu> <20120126002100.GA4495@burratino> <4F21C49D.2010906@freemail.hu> <20120126213939.GA5179@burratino> <4F230A1A.7080508@freemail.hu> <20120128071223.GA27331@burratino> <4F299010.5090009@freemail.hu>
 <alpine.LNX.2.00.1202012104030.18918@pobox.suse.cz> <4F2AEF30.5080805@freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37020 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083Ab2BIVdZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Feb 2012 16:33:25 -0500
In-Reply-To: <4F2AEF30.5080805@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: zitev <zitev@freemail.hu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 2 Feb 2012, zitev wrote:

> 0003:060B:2270.0004/
> 0003:060B:2270.0005/
> 0003:1044:7A02.0001/
> 0003:1044:7A02.0002/
> 0003:1044:7A02.0003/

Apparently the '0004' one is a keyboard interface.

[ ... snip ... ]
> "cat /sys/kernel/debug/hid/0003\:060B\:2270.0004/rdesc
> 05 01 09 06 a1 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08
> 81 01 95 03 75 01 05 08 19 01 29 03 91 02 95 05 75 01 91 01 95 06 75 08 26 ff
> 00 05 07 19 00 29 91 81 00 09 00 15 00 26 ff 00 75 08 95 08 b1 00 c0
> 
>   INPUT[INPUT]
>     Field(0)
>       Application(GenericDesktop.Keyboard)
>       Usage(8)
>         Keyboard.00e0
>         Keyboard.00e1
>         Keyboard.00e2
>         Keyboard.00e3
>         Keyboard.00e4
>         Keyboard.00e5
>         Keyboard.00e6
>         Keyboard.00e7
>       Logical Minimum(0)
>       Logical Maximum(1)
>       Report Size(1)
>       Report Count(8)
>       Report Offset(0)
>       Flags( Variable Absolute )
>     Field(1)
>       Application(GenericDesktop.Keyboard)
>       Usage(146)
>         Keyboard.0000
>         Keyboard.0001
>         Keyboard.0002
>         Keyboard.0003
>         Keyboard.0004
>         Keyboard.0005
>         Keyboard.0006
>         Keyboard.0007
>         Keyboard.0008
>         Keyboard.0009
>         Keyboard.000a
>         Keyboard.000b
>         Keyboard.000c
>         Keyboard.000d
>         Keyboard.000e
>         Keyboard.000f
>         Keyboard.0010
>         Keyboard.0011
>         Keyboard.0012
>         Keyboard.0013
>         Keyboard.0014
>         Keyboard.0015
>         Keyboard.0016
>         Keyboard.0017
>         Keyboard.0018
>         Keyboard.0019
>         Keyboard.001a
>         Keyboard.001b
>         Keyboard.001c
>         Keyboard.001d
>         Keyboard.001e
>         Keyboard.001f
>         Keyboard.0020
>         Keyboard.0021
>         Keyboard.0022
>         Keyboard.0023
>         Keyboard.0024
>         Keyboard.0025
>         Keyboard.0026
>         Keyboard.0027
>         Keyboard.0028
>         Keyboard.0029
>         Keyboard.002a
>         Keyboard.002b
>         Keyboard.002c
>         Keyboard.002d
>         Keyboard.002e
>         Keyboard.002f
>         Keyboard.0030
>         Keyboard.0031
>         Keyboard.0032
>         Keyboard.0033
>         Keyboard.0034
>         Keyboard.0035
>         Keyboard.0036
>         Keyboard.0037
>         Keyboard.0038
>         Keyboard.0039
>         Keyboard.003a
>         Keyboard.003b
>         Keyboard.003c
>         Keyboard.003d
>         Keyboard.003e
>         Keyboard.003f
>         Keyboard.0040
>         Keyboard.0041
>         Keyboard.0042
>         Keyboard.0043
>         Keyboard.0044
>         Keyboard.0045
>         Keyboard.0046
>         Keyboard.0047
>         Keyboard.0048
>         Keyboard.0049
>         Keyboard.004a
>         Keyboard.004b
>         Keyboard.004c
>         Keyboard.004d
>         Keyboard.004e
>         Keyboard.004f
>         Keyboard.0050
>         Keyboard.0051
>         Keyboard.0052
>         Keyboard.0053
>         Keyboard.0054
>         Keyboard.0055
>         Keyboard.0056
>         Keyboard.0057
>         Keyboard.0058
>         Keyboard.0059
>         Keyboard.005a
>         Keyboard.005b
>         Keyboard.005c
>         Keyboard.005d
>         Keyboard.005e
>         Keyboard.005f
>         Keyboard.0060
>         Keyboard.0061
>         Keyboard.0062
>         Keyboard.0063
>         Keyboard.0064
>         Keyboard.0065
>         Keyboard.0066
>         Keyboard.0067
>         Keyboard.0068
>         Keyboard.0069
>         Keyboard.006a
>         Keyboard.006b
>         Keyboard.006c
>         Keyboard.006d
>         Keyboard.006e
>         Keyboard.006f
>         Keyboard.0070
>         Keyboard.0071
>         Keyboard.0072
>         Keyboard.0073
>         Keyboard.0074
>         Keyboard.0075
>         Keyboard.0076
>         Keyboard.0077
>         Keyboard.0078
>         Keyboard.0079
>         Keyboard.007a
>         Keyboard.007b
>         Keyboard.007c
>         Keyboard.007d
>         Keyboard.007e
>         Keyboard.007f
>         Keyboard.0080
>         Keyboard.0081
>         Keyboard.0082
>         Keyboard.0083
>         Keyboard.0084
>         Keyboard.0085
>         Keyboard.0086
>         Keyboard.0087
>         Keyboard.0088
>         Keyboard.0089
>         Keyboard.008a
>         Keyboard.008b
>         Keyboard.008c
>         Keyboard.008d
>         Keyboard.008e
>         Keyboard.008f
>         Keyboard.0090
>         Keyboard.0091
>       Logical Minimum(0)
>       Logical Maximum(255)
>       Report Size(8)
>       Report Count(6)
>       Report Offset(16)
>       Flags( Array Absolute )
>   OUTPUT[OUTPUT]
>     Field(0)
>       Application(GenericDesktop.Keyboard)
>       Usage(3)
>         LED.NumLock
>         LED.CapsLock
>         LED.ScrollLock
>       Logical Minimum(0)
>       Logical Maximum(1)
>       Report Size(1)
>       Report Count(3)
>       Report Offset(0)
>       Flags( Variable Absolute )
>   FEATURE[FEATURE]
>     Field(0)
>       Application(GenericDesktop.Keyboard)
>       Usage(8)
>         Keyboard.0000
>         Keyboard.0000
>         Keyboard.0000
>         Keyboard.0000
>         Keyboard.0000
>         Keyboard.0000
>         Keyboard.0000
>         Keyboard.0000
>       Logical Minimum(0)
>       Logical Maximum(255)
>       Report Size(8)
>       Report Count(8)
>       Report Offset(0)
>       Flags( Array Absolute )

This looks like a proper report descriptor for keyboard, fine.

> "cat /sys/kernel/debug/hid/0003\:060B\:2270.0004/events
> (with pressing backspace)
> 
> report (size 8) (unnumbered) =  00 00 2a 00 00 00 00 00
> Keyboard.00e0 = 0
> Keyboard.00e1 = 0
> Keyboard.00e2 = 0
> Keyboard.00e3 = 0
> Keyboard.00e4 = 0
> Keyboard.00e5 = 0
> Keyboard.00e6 = 0
> Keyboard.00e7 = 0
> Keyboard.002a = 1
> 
> report (size 8) (unnumbered) =  00 00 00 00 00 00 00 00
> Keyboard.00e0 = 0
> Keyboard.00e1 = 0
> Keyboard.00e2 = 0
> Keyboard.00e3 = 0
> Keyboard.00e4 = 0
> Keyboard.00e5 = 0
> Keyboard.00e6 = 0
> Keyboard.00e7 = 0
> Keyboard.002a = 0
> 
> report (size 8) (unnumbered) =  00 00 2a 00 00 00 00 00
> Keyboard.00e0 = 0
> Keyboard.00e1 = 0
> Keyboard.00e2 = 0
> Keyboard.00e3 = 0
> Keyboard.00e4 = 0
> Keyboard.00e5 = 0
> Keyboard.00e6 = 0
> Keyboard.00e7 = 0
> Keyboard.002a = 1
> 
> report (size 8) (unnumbered) =  00 00 00 00 00 00 00 00
> Keyboard.00e0 = 0
> Keyboard.00e1 = 0
> Keyboard.00e2 = 0
> Keyboard.00e3 = 0
> Keyboard.00e4 = 0
> Keyboard.00e5 = 0
> Keyboard.00e6 = 0
> Keyboard.00e7 = 0
> Keyboard.002a = 0"

Good, backspace works as expected on 0004 interface. Now please provide 
output of the same file when pressing some of the non-working keys, let's 
say "A".

Thanks,

-- 
Jiri Kosina
SUSE Labs
