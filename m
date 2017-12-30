From: Sebastian Schmidt <yath@yath.de>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 15:40:40 +0100
Message-ID: <20171230144040.GB23284@marax.lan.yath.de>
References: <20171228091125.GA743@marax.lan.yath.de>
 <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:47610 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbdL3Okv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 09:40:51 -0500
Content-Disposition: inline
In-Reply-To: <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Sat, Dec 30, 2017 at 10:17:55PM +0800, Aaron Ma wrote:
> Sorry, I don't know anything about the firmware software.
> So you can NOT expect me to fix the firmware issue.

You changed trackpoint.c in ec667683c532c93fb41e100e5d61a518971060e2 to,
according to the commit message, “support version 2 and 3”. Even though
I don’t understand the change, because according to the comment next to
TP_MAGIC_IDENT (and the code in trackpoint.c), the version is reported
in param[1], not in param[0]. Also it’s called “MAGIC_IDENT” and not
“SUPPORTED_FIRMWARE_VERSIONS”.

> I have helped answer all the question I can.
> I don't know why you blame me like this.

Because reverting your commit fixes the issue for me. In fact, I was
just starting to reverse engineer the differences between firmware
versions 3 and 4, when I noticed a file called
“Alps_Pointing-Device_Updater_amd64_1_4.exe”, and all the other binaries
also saying only “ALPS” and not “Synaptics”, in the
trackpoint_fw_updater_1.0.0.9.zip update package (for model 20HR). Are
you actually certain that Gen5 X1s do always contain a Synaptics
Trackpoint and not some models an ALPS one? Does changing the speed on
your FW version 0x03 or 0x02 work at all?

I’m suspecting that by changing the TP_MAGIC_IDENT to supposedly newer
firmware versions you just made that driver wrongly recognize an ALPS
trackpoint as whatever trackpoint.c is for.

And I am, in fact, upset, since you don’t appear to be supporting the
code you have written, even though it causes regressions. Then you ask
me to install a kernel that includes a keylogger without any warning
whatsoever and now “yeah, sysfs is barely used, just use GNOME”. Who
else should I blame, please?

Thanks,
Sebastian
