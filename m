From: Jaikumar Ganesh <jaikumarg@gmail.com>
Subject: Re: Magic trackpad issues on 3.0
Date: Mon, 15 Aug 2011 19:40:25 -0700
Message-ID: <CACMz=xjei1aDWBLYtd7OwtUrsMTNkbJhdXQgLO=wxe0OoRchcA@mail.gmail.com>
References: <CACMz=xjmL=voNMk4usxT+Y6z1D_nncvJ34Y_w1PuqBNAE-4phg@mail.gmail.com>
 <CAOU-OAJW7F58n5OHydhXzfgUxt1jeBKyEPcg6DOyiFNMHJjQGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53500 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab1HPCkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 22:40:45 -0400
Received: by gxk21 with SMTP id 21so3552834gxk.19
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 19:40:45 -0700 (PDT)
In-Reply-To: <CAOU-OAJW7F58n5OHydhXzfgUxt1jeBKyEPcg6DOyiFNMHJjQGQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi Michael:

On Mon, Aug 15, 2011 at 7:03 PM, Michael Poole <mdpoole@troilus.org> wr=
ote:
> On Mon, Aug 15, 2011 at 4:18 PM, Jaikumar Ganesh wrote:
>> Folks,
>> =A0 This is with regard to the issue:
>>
>> http://www.spinics.net/lists/linux-input/msg15334.html
>>
>> As mentioned in that thread we were ignoring the EIO return value ea=
rlier.
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dc=
ommit;h=3Dc3a4924565e2eecf2539871abd123d35be6d76d5
>>
>> reverted the commit back, because
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dc=
ommit;h=3D7f4f0572df6c8eaa6a587bc212b0806ff37380dd
>> fixed the issue with the Bluetooth stack with 1.1 Bluetooth devices.
>>
>> However, I am seeing the same problem with an Apple Trackpad which i=
s
>> 2.0 Bluetooth device. It worked fine before because we were ignoring
>> the EIO.
>>
>> The Error code is the same as mentioned in the thread above: Invalid
>> Report ID while calling the Set Feature Report call.
>>
>> So to the driver authors:
>>
>> In magicmouse_probe function, the report id is set to d7. __u8
>> feature[] =3D { 0xd7, 0x01 };
>>
>> Is it guaranteed that all Apple devices will have 0xd7 as the report
>> Id. Why are we not reading the report ID from the report descriptor
>> since its an optional feature ?
>
> The report descriptor does not include that feature report. =A0There =
are
> a number of commands for Apple's Magic Mouse and Magic Trackpad that
> are not listed in the standard HID descriptor.

Has Apple documented this anywhere ? Will every Apple trackpad support =
it ?
Should we continue to have some fail-safe like the EIO fix ?

>
> Michael Poole
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
