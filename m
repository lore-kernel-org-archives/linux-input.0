From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] HID: Use multitouch driver for Type Covers
Date: Tue, 05 Apr 2016 14:42:14 +0200
Message-ID: <1459860134.22718.3.camel@hadess.net>
References: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
	 <1450451202.24419.13.camel@hadess.net> <5674B41A.3090904@stu.hosei.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5674B41A.3090904@stu.hosei.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>, jikos@kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2015-12-19 at 10:34 +0900, Akihiko Odaki wrote:
> No, it doesn't work.

According to:
https://github.com/jimdigriz/debian-mssp4

Running "kbd_mode -u" afterwards would fix the Caps-Lock key not
working. I have no idea what the wider consequence of this would be
though[1].

Anything we can do in the kernel to have that working by default?

[1]: kbd_mode calls=C2=A0ioctl(fd, KDSKBMODE, K_UNICODE) with fd being =
the
console's fd.

> On 12/19/2015 12:06 AM, Bastien Nocera wrote:
> >=20
> > On Mon, 2015-12-14 at 21:50 +0900, Akihiko Odaki wrote:
> > >=20
> > > Use multitouch driver instead of microsoft one for Microsoft
> > > Surface
> > > Type Covers.
> > >=20
> > > By using MT_CLS_EXPORT_ALL_INPUTS, the keyboards function as well
> > > as
> > > the multitouch pads do.
> > >=20
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>
> > All the multimedia keys work, and MT support also works, on my
> > Surface
> > 3 cover (045e:07de).
> >=20
> > *But* the Caps-Lock key's LED doesn't light up anymore. Can you
> > verify
> > it does on yours as well?
> >=20
> > Cheers
> >=20
