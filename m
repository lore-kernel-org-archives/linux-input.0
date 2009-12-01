From: =?ISO-8859-1?Q?R=E9mi_Cattiau?= <remi@cattiau.com>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard) stopped
 functioning in kernels >= 2.6.28
Date: Tue, 01 Dec 2009 12:08:15 +0100
Message-ID: <4B14F91F.7080200@cattiau.com>
References: <bug-13411-10286@http.bugzilla.kernel.org/> <20090601202509.87f57ef9.akpm@linux-foundation.org> <alpine.LRH.2.00.0906021148140.29471@twin.jikos.cz> <200911282251.28780.bugzilla.kernel.org@starbase12.cjb.net> <alpine.LSU.2.00.0912011138510.1106@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sd-5685.dedibox.fr ([88.191.36.166]:35933 "EHLO
	sd-5685.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbZLALhQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2009 06:37:16 -0500
In-Reply-To: <alpine.LSU.2.00.0912011138510.1106@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Guido Dorssers <bugzilla.kernel.org@starbase12.cjb.net>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

I'll be @ home in 10 hours i'll check but it seems very ugly from those=
s=20
manufacturers. We may find a official list from some authorities about=20
that no ?

R=E9mi

Le 01/12/2009 11:40, Jiri Kosina a =E9crit :
> On Sat, 28 Nov 2009, Guido Dorssers wrote:
>
>   =20
>>> The problem apparently [1] is, that the vendor has been super-creat=
ive and
>>> assigned the same combination of idVendor/idProduct to completely
>>> different devices. Oh well.
>>>
>>> Remi, could you please check your device against the lsusb data pro=
vided
>>> in bugzilla to check whether there is any possibility to distinguis=
h these
>>> devices, so that we could put some ugly check in place probably?
>>>
>>> Thanks.
>>>
>>> [1] http://lkml.org/lkml/2009/2/10/434
>>>
>>>       =20
>> Hi all,
>>
>> A belated thanks for having pointed me into the right direction to g=
et my
>> barcodescanner operational. However, as a thought since the bug is s=
till
>> present, why not solve it with something as simple as making the bla=
cklisting
>> user-configurable instead of blacklisting valid HID devices on purpo=
se?
>>     =20
> Hi,
>
> actually, my current plan is to remove the blacklist entry for this
> combination of VID/PID completely, and let the user decide and unbind=
 the
> driver via sysfs eventually, if needed (maybe together with warning i=
n
> dmesg).
>
> As the vendor apparently messed up horribly, as far as I understand, =
I
> don't really see another option.
>
>   =20


--=20
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
