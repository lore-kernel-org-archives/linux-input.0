From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer
 recognised
Date: Sun, 04 Jan 2009 13:04:50 +0100
Message-ID: <4960A5E2.2050601@freemail.hu>
References: <bug-12340-10286@http.bugzilla.kernel.org/> <20090101011223.6a10dd66.akpm@linux-foundation.org> <495C8AE3.5000502@freemail.hu> <alpine.LRH.1.10.0901041151510.2418@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail02a.mail.t-online.hu ([84.2.40.7]:53705 "EHLO
	mail02a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZADME4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Jan 2009 07:04:56 -0500
In-Reply-To: <alpine.LRH.1.10.0901041151510.2418@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

Jiri Kosina wrote:
> On Thu, 1 Jan 2009, N=E9meth M=E1rton wrote:
>=20
>>>> Steps to reproduce:
>>>> 1. boot kernel with parameters "rw root=3D/dev/sdb1 log_buf_len=3D=
1M init=3D/bin/
>>>> bash"
>>>> 2. modprobe -k uhci_hcd
>>>> 3. modprobe -k usbhid
>>>> Current result in case of 2.6.27: USB keyboard starts to work
>>>> Current result in case of 2.6.28: USB keyboard does not work
>>> Is it input/HID, or USB?
>> The same USB keyboard is working correctly with Clevo D410J laptop w=
ith 2.6.28,
>> so I guess it might be an USB problem.
>=20
> Why are you doing the modprobe by hand? Doesn't the module get autolo=
aded=20
> properly?

The modules were not autoloaded. This is a minimal test environment wit=
h only
a few binaries in the root directory. Is the "modprobe" binary enough f=
or
autoloading?

> Anyway, in 2.6.28, this keyboard is driven by specialized 'hid-bright=
'=20
> driver. Does modprobing it by hand fix the problem?

I'll try the hid-bright module as soon as my laptop gets repaired.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
