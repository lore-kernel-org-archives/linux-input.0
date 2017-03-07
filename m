From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint flag
 for 74 03 28 devices
Date: Tue, 7 Mar 2017 09:58:13 -0800
Message-ID: <20170307175813.GC13740@dtor-ws>
References: <78be095c-a7ae-328d-dd0a-b8470dfc1318@canonical.com>
 <20170304161509.GI4609@TopQuark.net>
 <CAM67p+6UpxCNd23rkajZZL7Oyk1c658BEzLOXpABA0etE-A_tA@mail.gmail.com>
 <20170305175619.GJ4609@TopQuark.net>
 <20170305180841.GK4609@TopQuark.net>
 <KAWPR01MB10928839D5E4608128F925B5C72C0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170307021758.GM4609@TopQuark.net>
 <KAWPR01MB1092FD2304E3F2BC7E7C6305C72F0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35545 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdCGSIm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 13:08:42 -0500
Content-Disposition: inline
In-Reply-To: <KAWPR01MB1092FD2304E3F2BC7E7C6305C72F0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Paul Donohue <linux-kernel@paulsd.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, Joseph Salisbury <joseph.salisbury@canonical.com>, "ben@smart-cactus.org" <ben@smart-cactus.org>, "mhocko@suse.com" <mhocko@suse.com>, "pali.rohar@gmail.com" <pali.rohar@gmail.com>, "rydberg@bitmath.org" <rydberg@bitmath.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Masaki,

On Tue, Mar 07, 2017 at 08:40:20AM +0000, Masaki Ota wrote:
> Hi, Paul,
> 
> I have modified the source code. 
> 
> There are three issues.
> #1. E7=73 03 28 Button pad device is not assigned "ALPS_BUTTONPAD" Flag correctly.
> #2. E7=73 03 28 devices are not assigned " ALPS_DUALPOINT" Flag correctly.
> #3. E7=73 03 28 device cursor speed is slow.
> 
> Actually, the cause is all the same.
> E7=73 03 28 device does not get correct information from OTP.
> OTP is the device information byte. I specified correct bit.
> 
> Then, I think it is also the issue.
> #4. Stick Pointer cursor speed is fast.
> 
> I will check Stick parameter.

Could you please submit this as a proper patch now that we have
confirmation that it works? Also, I wonder if V8PLUS should be full
protocol instead of a flag.

Thanks.

-- 
Dmitry
