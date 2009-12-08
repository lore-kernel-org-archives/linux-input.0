From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: 08 Dec 2009 23:27:00 +0100
Message-ID: <BEVi1jXHqgB@lirc>
References: <20091207075100.GB24958@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966780AbZLHWd6@vger.kernel.org>
In-Reply-To: <20091207075100.GB24958@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, khc@pm.waw.pl, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

on 06 Dec 09 at 23:51, Dmitry Torokhov wrote:
[...]
>>> I suppose we could add MSC_SCAN_END event so that we can transmit
>>> "scancodes" of arbitrary length. You'd get several MSC_SCAN followed by
>>> MSC_SCAN_END marker. If you don't get MSC_SCAN_END assume the code is 32
>>> bit.
>>
>> And I set a timeout to know that no MSC_SCAN_END will arrive? This is
>> broken design IMHO.
>>

> EV_SYN signals the end of state transmission.

>> Furthermore lircd needs to know the length of the scan code in bits, not
>> as a multiple of 32.

> I really do not think that LIRCD is the type of application that should
> be using evdev interface, but rather other way around.

Well, all I'm asking is that lircd can keep using the LIRC interface for  
getting the scan codes. ;-)

Christoph
