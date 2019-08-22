From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: quirks: Disable runtime suspend on Microsoft Corp.
 Basic Optical Mouse v2.0
Date: Thu, 22 Aug 2019 18:04:44 +0800
Message-ID: <AD8A4135-0275-45B3-BEB9-031737A2C756@canonical.com>
References: <20190822091744.3451-1-kai.heng.feng@canonical.com>
 <1566467151.8347.23.camel@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566467151.8347.23.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Oliver,

at 17:45, Oliver Neukum <oneukum@suse.com> wrote:

> Am Donnerstag, den 22.08.2019, 17:17 +0800 schrieb Kai-Heng Feng:
>> The optical sensor of the mouse gets turned off when it's runtime
>> suspended, so moving the mouse can't wake the mouse up, despite that
>> USB remote wakeup is successfully set.
>>
>> Introduce a new quirk to prevent the mouse from getting runtime
>> suspended.
>
> Hi,
>
> I am afraid this is a bad approach in principle. The device
> behaves according to spec.

Can you please point out which spec it is? Is it USB 2.0 spec?

> And it behaves like most hardware.

So seems like most hardware are broken.
Maybe a more appropriate solution is to disable RPM for all USB mice.

> If you do not want runtime PM for such devices, do not switch
> it on.

A device should work regardless of runtime PM status.

> The refcounting needs to be done correctly.

Will do.

>
> This patch does something that udev should do and in a
> questionable manner.

IMO if the device doesn’t support runtime suspend, then it needs to be  
disabled in kernel but not workaround in userspace.

Kai-Heng

>
> 	Regards
> 		Oliver
