From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer
 recognised
Date: Mon, 05 Jan 2009 08:31:00 +0100
Message-ID: <4961B734.80701@freemail.hu>
References: <bug-12340-10286@http.bugzilla.kernel.org/> <20090101011223.6a10dd66.akpm@linux-foundation.org> <495C8AE3.5000502@freemail.hu> <alpine.LRH.1.10.0901041151510.2418@twin.jikos.cz> <4960A5E2.2050601@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4960A5E2.2050601-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

N=E9meth M=E1rton wrote:
> Jiri Kosina wrote:
>> On Thu, 1 Jan 2009, N=E9meth M=E1rton wrote:
>>
>>>>> Steps to reproduce:
>>>>> 1. boot kernel with parameters "rw root=3D/dev/sdb1 log_buf_len=3D=
1M init=3D/bin/
>>>>> bash"
>>>>> 2. modprobe -k uhci_hcd
>>>>> 3. modprobe -k usbhid
>>>>> Current result in case of 2.6.27: USB keyboard starts to work
>>>>> Current result in case of 2.6.28: USB keyboard does not work
>>>> Is it input/HID, or USB?
>>> The same USB keyboard is working correctly with Clevo D410J laptop =
with 2.6.28,
>>> so I guess it might be an USB problem.
>> Why are you doing the modprobe by hand? Doesn't the module get autol=
oaded=20
>> properly?
>=20
> The modules were not autoloaded. This is a minimal test environment w=
ith only
> a few binaries in the root directory. Is the "modprobe" binary enough=
 for
> autoloading?

I just was able to try the situation: the modules are not autoloaded.

>> Anyway, in 2.6.28, this keyboard is driven by specialized 'hid-brigh=
t'=20
>> driver. Does modprobing it by hand fix the problem?
>=20
> I'll try the hid-bright module as soon as my laptop gets repaired.

Loading the hid-bright module handles the USB keyboard properly.
But it is still not clear for me why this module is not autoloaded?

Regards,

	M=E1rton N=E9meth

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
