From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer
 recognised
Date: Thu, 01 Jan 2009 10:20:35 +0100
Message-ID: <495C8AE3.5000502@freemail.hu>
References: <bug-12340-10286@http.bugzilla.kernel.org/> <20090101011223.6a10dd66.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090101011223.6a10dd66.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Andrew Morton wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Thu,  1 Jan 2009 00:52:59 -0800 (PST) bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=12340
>>
>>            Summary: [regression] USB keyboard no longer recognised
>>            Product: Drivers
>>            Version: 2.5
>>      KernelVersion: 2.6.28
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: USB
>>         AssignedTo: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
>>         ReportedBy: nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org
>>
>>
>> Latest working kernel version: 2.6.27
>> Earliest failing kernel version: 2.6.28
>> Distribution: 
>> Hardware Environment: ASUS Eee PC 901
>> Software Environment:
>> Problem Description:
>>
>> The USB keyboard was recognised an working with kernel 2.6.27 but not working
>> with 2.6.28.
>>
>> Steps to reproduce:
>> 1. boot kernel with parameters "rw root=/dev/sdb1 log_buf_len=1M init=/bin/
>> bash"
>> 2. modprobe -k uhci_hcd
>> 3. modprobe -k usbhid
>>
>> Current result in case of 2.6.27: USB keyboard starts to work
>> Current result in case of 2.6.28: USB keyboard does not work
>>
> 
> Is it input/HID, or USB?

The same USB keyboard is working correctly with Clevo D410J laptop with 2.6.28,
so I guess it might be an USB problem.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
