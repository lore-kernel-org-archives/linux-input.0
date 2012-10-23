From: Jian-Jhong Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Subject: Re: [PATCH v1] Support Elan Touchscreen eKTF product.
Date: Tue, 23 Oct 2012 10:14:32 +0800
Message-ID: <87pq4aq6if.fsf@emc.com.tw>
References: <1350424679-20725-1-git-send-email-scott.liu@emc.com.tw> <87hapnnp5t.fsf@emc.com.tw> <20121022160705.GC13791@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121022160705.GC13791-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jesse <jesse-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Vincent Wang <vincent.wang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Paul <paul.liang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> On Mon, Oct 22, 2012 at 11:47:42AM +0800, Jian-Jhong Ding wrote:
>> With Benjamin's i2c-hid implimentation, is it possible to make
>> hid-multitouch not depend on USBHID and reuse it to drive this device?
>
> Exactly. Before looking any further - is this the same part that Tom Lin
> posted a driver for earlier this summer?

No.  Tom's driver was only for trackpads, this is probably for some
touch panel.  The controller ICs may have some similarities, but the
firmware is developed independently, though both somewhat conform to the
HID over I2C protocol.

Thanks,
-JJ
> Thanks.
>
> -- 
> Dmitry
