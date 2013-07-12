From: Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 2/2] Bluetooth: hidp: remove wrong send_report at init
Date: Fri, 12 Jul 2013 11:09:23 +0100
Message-ID: <20130712100923.GA2065@joana>
References: <1373550090-30379-1-git-send-email-benjamin.tissoires@redhat.com>
 <1373550090-30379-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373550090-30379-3-git-send-email-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

* Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [2013-07-11 15:41:30 +0200]:

> The USB hid implementation does retrieve the reports during the start.
> However, this implementation does not call the HID command GET_REPORT
> (which would fetch the current status of each report), but use the
> DATA command, which is an Output Report (so transmitting data from the
> host to the device).
> The Wiimote controller is already guarded against this problem in the
> protocol, but it is not conformant to the specification to set all the
> reports to 0 on start.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  net/bluetooth/hidp/core.c | 14 --------------
>  1 file changed, 14 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

	Gustavo
