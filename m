From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 12340] New: [regression] USB keyboard no longer
 recognised
Date: Sun, 4 Jan 2009 11:53:51 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0901041151510.2418@twin.jikos.cz>
References: <bug-12340-10286@http.bugzilla.kernel.org/> <20090101011223.6a10dd66.akpm@linux-foundation.org> <495C8AE3.5000502@freemail.hu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-2111728325-1231066432=:2418"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <495C8AE3.5000502-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?N=E9meth_M=E1rton?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-2111728325-1231066432=:2418
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 1 Jan 2009, Németh Márton wrote:

> >> Steps to reproduce:
> >> 1. boot kernel with parameters "rw root=/dev/sdb1 log_buf_len=1M init=/bin/
> >> bash"
> >> 2. modprobe -k uhci_hcd
> >> 3. modprobe -k usbhid
> >> Current result in case of 2.6.27: USB keyboard starts to work
> >> Current result in case of 2.6.28: USB keyboard does not work
> > Is it input/HID, or USB?
> The same USB keyboard is working correctly with Clevo D410J laptop with 2.6.28,
> so I guess it might be an USB problem.

Why are you doing the modprobe by hand? Doesn't the module get autoloaded 
properly?

Anyway, in 2.6.28, this keyboard is driven by specialized 'hid-bright' 
driver. Does modprobing it by hand fix the problem?

-- 
Jiri Kosina
SUSE Labs

---1747641777-2111728325-1231066432=:2418--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
