From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification
 implementation
Date: Sun, 7 Oct 2012 21:03:59 +0200
Message-ID: <20121007210359.29f40ecf@endymion.delvare>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com>
	<20121007162838.01f36b7c@endymion.delvare>
	<CAN+gG=E3nmXZ9RL3wN2tvKqSOu5hWYLXLf+Z=ag7VvZGJfhQ-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=E3nmXZ9RL3wN2tvKqSOu5hWYLXLf+Z=ag7VvZGJfhQ-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 7 Oct 2012 18:57:36 +0200, Benjamin Tissoires wrote:
> On Sun, Oct 7, 2012 at 4:28 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Fri, 14 Sep 2012 15:41:43 +0200, benjamin.tissoires wrote:
> >> +     u16 readRegister = ihid->hdesc.wDataRegister;
> >
> > This is missing le16_to_cpu().
> 
> I agree this is awful, but not putting it allows me to not have to
> check the endianness when I'm using it.
> But I may be totally wrong on this.

I'm afraid I don't follow you. I want to see:

	u16 readRegister = le16_to_cpu(ihid->hdesc.wDataRegister);

If you don't do that, your driver is broken on bigendian systems. And
there's no need to "check the endianness when you're using it", the
above should be enough for things to work just fine.

-- 
Jean Delvare
