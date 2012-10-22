From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] Support Elan Touchscreen eKTF product.
Date: Mon, 22 Oct 2012 09:07:05 -0700
Message-ID: <20121022160705.GC13791@core.coreip.homeip.net>
References: <1350424679-20725-1-git-send-email-scott.liu@emc.com.tw>
 <87hapnnp5t.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87hapnnp5t.fsf-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jian-Jhong Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Cc: Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jesse <jesse-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Vincent Wang <vincent.wang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Paul <paul.liang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 22, 2012 at 11:47:42AM +0800, Jian-Jhong Ding wrote:
> Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org> writes:
> > +
> > +struct mt_device {
> > +	struct mt_slot curdata;	/* placeholder of incoming data */
> > +	__u8 num_received;	/* how many contacts we received */
> > +	__u8 num_expected;	/* expected last contact index */
> > +	__u8 maxcontacts;
> > +	bool curvalid;		/* is the current contact valid? */
> > +	struct mt_slot *slots;
> > +};
> 
> With Benjamin's i2c-hid implimentation, is it possible to make
> hid-multitouch not depend on USBHID and reuse it to drive this device?

Exactly. Before looking any further - is this the same part that Tom Lin
posted a driver for earlier this summer?

Thanks.

-- 
Dmitry
