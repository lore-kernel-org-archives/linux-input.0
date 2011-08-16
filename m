From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Magic trackpad issues on 3.0
Date: Mon, 15 Aug 2011 23:45:25 -0400
Message-ID: <CAOU-OA+c4SVrsfjNQo+3yC3KV3ite8oyV5JWZ+Bii1H-X8-fEA@mail.gmail.com>
References: <CACMz=xjmL=voNMk4usxT+Y6z1D_nncvJ34Y_w1PuqBNAE-4phg@mail.gmail.com>
	<CAOU-OAJW7F58n5OHydhXzfgUxt1jeBKyEPcg6DOyiFNMHJjQGQ@mail.gmail.com>
	<CACMz=xjei1aDWBLYtd7OwtUrsMTNkbJhdXQgLO=wxe0OoRchcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57586 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751253Ab1HPDp1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 23:45:27 -0400
Received: by wyg24 with SMTP id 24so4962171wyg.5
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 20:45:25 -0700 (PDT)
In-Reply-To: <CACMz=xjei1aDWBLYtd7OwtUrsMTNkbJhdXQgLO=wxe0OoRchcA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaikumar Ganesh <jaikumarg@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Mon, Aug 15, 2011 at 10:40 PM, Jaikumar Ganesh wrote:
> Hi Michael:
>
> On Mon, Aug 15, 2011 at 7:03 PM, Michael Poole <mdpoole@troilus.org> =
wrote:
>> On Mon, Aug 15, 2011 at 4:18 PM, Jaikumar Ganesh wrote:
>>> Folks,
>>> =A0 This is with regard to the issue:
>>>
>>> http://www.spinics.net/lists/linux-input/msg15334.html
>>>
>>> As mentioned in that thread we were ignoring the EIO return value e=
arlier.
>>>
>>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3D=
commit;h=3Dc3a4924565e2eecf2539871abd123d35be6d76d5
>>>
>>> reverted the commit back, because
>>>
>>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3D=
commit;h=3D7f4f0572df6c8eaa6a587bc212b0806ff37380dd
>>> fixed the issue with the Bluetooth stack with 1.1 Bluetooth devices=
=2E
>>>
>>> However, I am seeing the same problem with an Apple Trackpad which =
is
>>> 2.0 Bluetooth device. It worked fine before because we were ignorin=
g
>>> the EIO.
>>>
>>> The Error code is the same as mentioned in the thread above: Invali=
d
>>> Report ID while calling the Set Feature Report call.
>>>
>>> So to the driver authors:
>>>
>>> In magicmouse_probe function, the report id is set to d7. __u8
>>> feature[] =3D { 0xd7, 0x01 };
>>>
>>> Is it guaranteed that all Apple devices will have 0xd7 as the repor=
t
>>> Id. Why are we not reading the report ID from the report descriptor
>>> since its an optional feature ?
>>
>> The report descriptor does not include that feature report. =A0There=
 are
>> a number of commands for Apple's Magic Mouse and Magic Trackpad that
>> are not listed in the standard HID descriptor.
>
> Has Apple documented this anywhere ? Will every Apple trackpad suppor=
t it ?
> Should we continue to have some fail-safe like the EIO fix ?

Hi Jaikumar,

I do not believe Apple has documented the protocol anywhere, or makes
any guarantee of compatibility in future devices -- although forward
compatibility makes sense in terms of the installed base of drivers,
and I suspect any devices that use a different protocol would get
different device IDs.

I think the EIO fix should stay.

Michael Poole
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
