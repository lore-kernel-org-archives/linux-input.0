From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification
 implementation
Date: Mon, 8 Oct 2012 16:42:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210081642080.28357@pobox.suse.cz>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com> <20121006220421.47f5fd56@endymion.delvare> <6F756B9E-DC87-4EF6-BB09-8A69A5F8C999@enac.fr> <20121006231111.6350c014@endymion.delvare> <alpine.LNX.2.00.1210062314110.27782@pobox.suse.cz>
 <alpine.LNX.2.00.1210062326150.27782@pobox.suse.cz> <914C6C58-5A3B-4F7D-94BE-EF6868ED5D9D@enac.fr> <CAN+gG=FOnFDn4BdEQUt0dbQRj-6PrhRzSOqM620xSM3DeTXt_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=FOnFDn4BdEQUt0dbQRj-6PrhRzSOqM620xSM3DeTXt_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty-rXV5z7KbLFk@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-15?Q?Fabien_Andr=E9?= <fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-2022-JP?Q?=1B$BN-2E=3DY=1B=28J?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, 7 Oct 2012, Benjamin Tissoires wrote:

> It seems that hid transport layers should go in drivers/hid.
> However, I don't like mixing the transport layer and the final
> drivers. Maybe this is the time to rework a little bit the tree.
> To minimize the moves, we could introduce:
> drivers/hid/busses/usb
> drivers/hid/busses/i2c
> drivers/hid/busses/bluetooth

Something like that, I would personally like. But I am not going to 
forcefully take it over without bluetooth guys agreeing on that as well.

-- 
Jiri Kosina
SUSE Labs
