From: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: is it possible to temporarily not let user mode get hid input event
Date: Mon, 24 Feb 2014 13:37:46 +0100
Message-ID: <CANq1E4Tdf4QHtTy5HbFd_yEL1Z3ihWwHE-6JzEtT8GGsnRcBEQ@mail.gmail.com>
References: <CANudz+smSLiEtTRC4t7VxzshDAdR6D4E=zYVJHT8xw0w4JiwGw@mail.gmail.com>
	<CANq1E4SJDz2q0Rgn1f7u_b0w-mjVTte8=G2_qL38QnahDkUC1Q@mail.gmail.com>
	<CANudz+tdWrCLpARFQznQfhkF-r2J-STY68xdBJc+BK5C=tKsjA@mail.gmail.com>
	<CANq1E4QrVNQ1xjT7N5OPY1R3fM8Mc45B2GtpMjhYsKinCptZvg@mail.gmail.com>
	<CANudz+t4SXeWsDZ6jbVwYs9YxjXyBAfErnAUhiDf3FNOMyV+ww@mail.gmail.com>
	<CANq1E4QH7BRpfd_nDZ4JGE9xSHcDWpuWRK4BFhPRO4kbkKB_3Q@mail.gmail.com>
	<CANudz+t3uNCH0WxN-QU0aB78WWfS+Q-N-TDONGfmYdmucZbDoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANudz+t3uNCH0WxN-QU0aB78WWfS+Q-N-TDONGfmYdmucZbDoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: loody <miloody-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "open list:HID CORE LAYER" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi

On Mon, Feb 24, 2014 at 1:34 PM, loody <miloody-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Yes. For instance, you can run ./samples/uhid/uhid-example.c via ssh
>> to emulate a mouse. ssh keyboard input can then be used to generate
>> mouse-movement events.
> There is one embarrassing question :-)
> Would you please let me know how to cross-compile it ?
> I try below commands but failed
> #cd samples/uhid/
> #make CROSS_COMPILE=arm-v7a8v4r2-linux-gnueabi-
> make: *** No targets.  Stop.
>
> Thanks for your kind help,

Don't use the Makefile. Use gcc directly:
  gcc -o uhid-example -Wall samples/uhid/uhid-example.c

It's just one source file, you should be able to compile it on the
device. No idea how your cross-compiler works, so cannot help you
there.

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
