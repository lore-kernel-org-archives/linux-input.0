From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: Magic trackpad issues on 3.0
Date: Tue, 16 Aug 2011 11:48:30 -0700
Message-ID: <4E4ABB7E.8020505@gmail.com>
References: <CACMz=xjmL=voNMk4usxT+Y6z1D_nncvJ34Y_w1PuqBNAE-4phg@mail.gmail.com>	<CAOU-OAJW7F58n5OHydhXzfgUxt1jeBKyEPcg6DOyiFNMHJjQGQ@mail.gmail.com>	<CACMz=xjei1aDWBLYtd7OwtUrsMTNkbJhdXQgLO=wxe0OoRchcA@mail.gmail.com> <CAOU-OA+c4SVrsfjNQo+3yC3KV3ite8oyV5JWZ+Bii1H-X8-fEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54127 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab1HPSsg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 14:48:36 -0400
Received: by vxi9 with SMTP id 9so188591vxi.19
        for <linux-input@vger.kernel.org>; Tue, 16 Aug 2011 11:48:36 -0700 (PDT)
In-Reply-To: <CAOU-OA+c4SVrsfjNQo+3yC3KV3ite8oyV5JWZ+Bii1H-X8-fEA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Jaikumar Ganesh <jaikumarg@gmail.com>, linux-input@vger.kernel.org, jkosina@suse.cz

On 08/15/2011 08:45 PM, Michael Poole wrote:
> On Mon, Aug 15, 2011 at 10:40 PM, Jaikumar Ganesh wrote:
>> Hi Michael:
>>
>> On Mon, Aug 15, 2011 at 7:03 PM, Michael Poole <mdpoole@troilus.org> wrote:
>>> On Mon, Aug 15, 2011 at 4:18 PM, Jaikumar Ganesh wrote:
>>>> Folks,
>>>>   This is with regard to the issue:
>>>>
>>>> http://www.spinics.net/lists/linux-input/msg15334.html
>>>>
>>>> As mentioned in that thread we were ignoring the EIO return value earlier.
>>>>
>>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=c3a4924565e2eecf2539871abd123d35be6d76d5
>>>>
>>>> reverted the commit back, because
>>>>
>>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7f4f0572df6c8eaa6a587bc212b0806ff37380dd
>>>> fixed the issue with the Bluetooth stack with 1.1 Bluetooth devices.
>>>>
>>>> However, I am seeing the same problem with an Apple Trackpad which is
>>>> 2.0 Bluetooth device. It worked fine before because we were ignoring
>>>> the EIO.
>>>>
>>>> The Error code is the same as mentioned in the thread above: Invalid
>>>> Report ID while calling the Set Feature Report call.
>>>>
>>>> So to the driver authors:
>>>>
>>>> In magicmouse_probe function, the report id is set to d7. __u8
>>>> feature[] = { 0xd7, 0x01 };
>>>>
>>>> Is it guaranteed that all Apple devices will have 0xd7 as the report
>>>> Id. Why are we not reading the report ID from the report descriptor
>>>> since its an optional feature ?
>>>
>>> The report descriptor does not include that feature report.  There are
>>> a number of commands for Apple's Magic Mouse and Magic Trackpad that
>>> are not listed in the standard HID descriptor.
>>
>> Has Apple documented this anywhere ? Will every Apple trackpad support it ?
>> Should we continue to have some fail-safe like the EIO fix ?
> 
> Hi Jaikumar,
> 
> I do not believe Apple has documented the protocol anywhere, or makes
> any guarantee of compatibility in future devices -- although forward
> compatibility makes sense in terms of the installed base of drivers,
> and I suspect any devices that use a different protocol would get
> different device IDs.
> 
> I think the EIO fix should stay.

I just started to notice this issue last week. The Ubuntu 3.0.0-7 kernel
(the -# part is an ubuntu suffix) seems to work fine, but 3.0.0-8 does
not. I would guess a -stable patch is causing a regression, but the diff
stat from 3.0 to 3.0.1 doesn't show anything related to input, hid, or
bluetooth.

-- Chase
