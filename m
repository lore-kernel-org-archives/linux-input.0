From: jtd <jtdjtdjtd.business@gmail.com>
Subject: Re: [Toshiba Satellite P855-S5102] SynPS/2 Synaptics TouchPad Dead
Date: Fri, 11 Sep 2015 04:51:25 +0000
Message-ID: <55F25DCD.6000505@gmail.com>
References: <55F044C2.3030407@gmail.com>
 <CAKdAkRRU2kUS6tFeVk8p8gD1_qpGuBpzgNxkLNwtt-aM-Fx5HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36528 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbIKEvb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2015 00:51:31 -0400
Received: by padhk3 with SMTP id hk3so63464154pad.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 21:51:31 -0700 (PDT)
In-Reply-To: <CAKdAkRRU2kUS6tFeVk8p8gD1_qpGuBpzgNxkLNwtt-aM-Fx5HQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry,
Many thanks for your questions. With factory installed Windows 8,
TouchPad works. However, I run Ubuntu and have never had working
TouchPad with Ubuntu (from 3.13 kernel now up to 4.2).

Is there a way to check if my TouchPad key is ON/OFF?

Solutions I have tried unsuccessfully:

    Keypad solutions:
        F5
        Fn+F5
        pressing NumLock repeatedly during boot
    Modprobe solutions:
        sudo modprobe -r psmouse && sudo modprobe psmouse
        sudo modprobe -r psmouse && sudo modprobe psmouse proto=imps
        sudo modprobe -r psmouse && sudo modprobe psmouse proto=exps
    Kernel solutions (append to grub at end of quiet splash line):
        atkbd.reset i8042.nomux
        i8042.nopnp
        i8042.reset=1
    Missing Package solutions:
        sudo apt-get install xserver-xorg-input-synaptics
        sudo apt-get install gpointing-device-settings

I believe it is for these reasons that I was referred to kernel listserv.

If you have other thoughts or need more information, please let me know!
jtd


Dmitry Torokhov:
> On Wed, Sep 9, 2015 at 7:40 AM, jtd <jtdjtdjtd.business@gmail.com> wrote:
>> [1.]
>> [Toshiba Satellite P855-S5102] SynPS/2 Synaptics TouchPad Dead
>>
>> [2.]
>> I expect a mouse. Although xinput reports the TouchPad, it is not
>> functional. I cannot see a mouse cursor or click things.
> 
> Has it ever worked? Do you by a chance have a key that disables
> touchpad and it is pressed?
> 
> Thanks.
> 
