From: zitev <zitev-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming Keyboard
Date: Wed, 01 Feb 2012 20:18:40 +0100
Message-ID: <4F299010.5090009@freemail.hu>
References: <4D55AE81.3030805@freemail.hu> <20120126002100.GA4495@burratino> <4F21C49D.2010906@freemail.hu> <20120126213939.GA5179@burratino> <4F230A1A.7080508@freemail.hu> <20120128071223.GA27331@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120128071223.GA27331@burratino>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

I did every step of test, but after testing the /tmp/mon.out file is=20
0byte (empty)

next task?


2012-01-28 08:12 keltez=E9ssel, Jonathan Nieder =EDrta:
> zitev wrote:
>
>> I attached the lsusb output!
> Perfect, thanks.
>
>> Bus 001 Device 004: ID 1044:7a02 Chu Yuen Enterprise Co., Ltd
> [...]
>>      bNumInterfaces          3
> [...]
>>      Interface Descriptor:
>>        bInterfaceClass         3 Human Interface Device
>>        iInterface              2 KB
> [...]
>>      Interface Descriptor:
>>        bInterfaceClass         3 Human Interface Device
>>        iInterface              3 Mouse
> [...]
>>      Interface Descriptor:
>>        bInterfaceClass         3 Human Interface Device
>>        iInterface              4 K8100 Interface
> Can you set up usbmon and get a trace of e.g., pressing, holding,
> then releasing the "a" key?  See Documentation/usb/usbmon.txt
> in the Linux source or the doc directory of the linux-doc-3.2
> package for details.
>
> It works roughly like this:
>
> 1. Mount debugfs and load the usbmon module:
>
>    mount -t debugfs debugfs /sys/kernel/debug
>    modprobe usbmon
>
> 2. Start tracing:
>
>    {
>      sleep 1; # one second of quiet
>      cat /sys/kernel/debug/usb/usbmon/1u>/tmp/mon.out&
>      sleep 20; # twenty seconds or so to run the test
>      kill $!; # and then stop collecting data
>    }
>
> 3. Somehow summarize the output.  If it is fairly small, an
> attachment is fine; otherwise, excerpts and maybe a link to a
> copy that can be downloaded online might work.
>
> Hope that helps,
> Jonathan
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
