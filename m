From: Stefan Richter <stefanr-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org>
Subject: 3.0-rc6+: hid_report_raw_event -- unable to handle kernel paging
 request (during boot)
Date: Sun, 10 Jul 2011 14:47:36 +0200
Message-ID: <20110710144736.78e4abb6@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

I got the following once during a series of several boot-ups.
This is 3.0-rc6-71-g4dd1b49 x86-64 plus Alan Stern's
"USB: additional regression fix for device removal".

input: Logitech USB Receiver as /devices/pci0000:00/0000:0012.0/usb3/3-1/3-1:1.0/input/input0
generic-usb 0003:046D:C518.0001: input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:12.0-1/input0
BUG: unable to handle kernel paging request at ffff880215514048
IP: [<ffffffff812c5b86>] hid_report_raw_event+0x292/0x405
PGD 1622063 PUD 21f6fa067 PMD 21f7a5067 PIE 8000000215514160
Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
CPU 3
Modules linked in:

Pid: 0, comm: kworker/0:1 Not tainted 3.0.0-rc6 #14 System manufacturer System Product Name/M3A78-EM
RIP: 0010:[<ffffffff812c5b86>] [<ffffffff812c5b86>] hid_report_raw_event+0x292/0x405
RSP: 0018:ffff88021fd83c58 EFLAGS: 00010016
[...etc, screenshot available if necessary...]
Call Trace:
 <IRQ>
 [...] hid_input_report+0x1bb/0x1d8
 [...] hid_ctrl+0x99/0x146
 [...] usb_hcd_giveback_urb+0x5d/0x8d
 [...] finish_urb+0x9d+0xd6
 [...] takeback_td+0x45/0xff
 [...] ohci_irq+0x26f/0x3cf
 [...] usb_hci_irq+0x2f/0x7a
[...]
-- 
Stefan Richter
-=====-==-== -=== -=-=-
http://arcgraph.de/sr/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
