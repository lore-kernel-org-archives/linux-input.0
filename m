From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sun, 31 Dec 2017 02:54:55 +0800
Message-ID: <c9f4591f-c40f-deb2-f379-310f159c06cb@canonical.com>
References: <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de> <20171230150235.GA19890@kroah.com>
 <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
 <20171230152616.GA26378@kroah.com>
 <0eb65344-d160-bb14-723a-1d06ac3e1b33@canonical.com>
 <20171230155358.GE23284@marax.lan.yath.de>
 <02082a9b-8fdd-0878-0daa-ead72743d5fd@canonical.com>
 <20171230181625.GA1687@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdL3SzC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 13:55:02 -0500
In-Reply-To: <20171230181625.GA1687@marax.lan.yath.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

The patch[2] is recognized to ""ImPS/2 Generic Wheel Mouse""
Please refer to link:
https://lkml.org/lkml/2017/8/21/558
Which mentioned my commit can resolve his issue.

Your scroll mode is workable by libinput and that is not enabled by
kernel driver.
People who used "xorg-input-evdev" will *NOT* enable scroll mode.

Lenovo delivered some different touchpads/trackpoint, sometimes with
broken firmwares.
I have helped one person:edvard.holst@gmail.com who had investigated
trackpoint bug for long time, he mentioned the your link[1] long time
ago. Finally it's firmware didn't respond anything through PS/2 command.

LEN009a/LEN0072 do have some difference, but for your log and e-mail, I
didn't see any difference.
