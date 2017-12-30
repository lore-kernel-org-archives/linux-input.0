From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 21:54:39 +0800
Message-ID: <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
References: <20171228091125.GA743@marax.lan.yath.de>
 <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdL3Nyt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 08:54:49 -0500
In-Reply-To: <20171230095705.GA1861@marax.lan.yath.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

I believe it should be a firmware issue on trackpoint.

There are several ways to set the speed & sensitivity:
1, udev hwdb/rules;
2, xorg conf;
3, GUI;

It seems users are rarely to use sysfs directly, so the bug is still there.

Regards,
Aaron

On 12/30/2017 05:57 PM, Sebastian Schmidt wrote:
> On Sat, Dec 30, 2017 at 02:43:16PM +0800, Aaron Ma wrote:
>> Please try:
>> $ xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -1
>>
>> The last value of speed can be -1 to 1.
> 
> Ah. That indeed changes the speed, thanks!
> 
> However, please let me ask again: Isn’t the sysfs interface supposed to
> work, too? I’ve got my problem resolved for Xorg now, but about every
> article on the internet refers to the sysfs interface for changing the
> speed, cf. <https://www.google.com/search?q=trackpoint+speed>.
> 
> I’m also fine with the assertion that Lenovo shipped a broken firmware,
> but I’d expect some warning in dmesg then and a reasonable fallback (to
> a regular PS/2 mouse?) then. Can we at least agree that there is a
> driver bug that ought to be fixed or a firmware bug that ought to be
> worked around?
> 
> Thanks,
> Sebastian
> 
