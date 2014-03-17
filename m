From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?=
	<fernando_b1-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
Subject: Re: [PATCH] hid: fix bug destroying hidraw device files after parent
Date: Mon, 17 Mar 2014 12:14:24 +0900
Message-ID: <53266890.1040504@lab.ntt.co.jp>
References: <1393401084.4876.2.camel@nexus> <alpine.LNX.2.00.1402261101540.5466@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1402261101540.5466-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nestor Lopez Casado <nlopezcasad-VLMvL59Kb9lWk0Htik3J/w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Jiri,

On 02/26/2014 07:02 PM, Jiri Kosina wrote:
[...]
> Applied, thanks.
>
> I have slightly modified the patch title to make sure that it's obvious
> that what it fixes is actually a WARN_ON() splat.

Thank you.

Any chance we can get this to Linus before 3.14 comes out?
According to Linus, rc7 may be the last rc.

- Fernando
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
