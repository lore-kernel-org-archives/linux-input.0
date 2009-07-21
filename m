From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 12:21:53 +0200
Message-ID: <20090721102153.GE4133@elf.ucw.cz>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d5443650907151033w36008b71pe4b32bcea9489b75-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi!

> >> disable_irq_nosync or convert this to request_threaded_irq(...).
> >> Please see recent discussion on linux-input for MAX key switch
> >> controller.
> >
> > Do you have a link? (I replaced it with disable_irq_nosync, if that=
 is
> > enough...)
> >
>=20
> link: http://patchwork.kernel.org/patch/35515/

Thanks!

> >> > + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_=
=46UNC_I2C)) {
> >>
> >> check for SMBUS? I have added linux-i2c as this driver has i2c bit=
s,
> >> so not removing any code.
> >
> > I guess this driver is only probed on mach-pxa... on machines that
> > have the neccessary hardware.
>=20
> Because this driver is using smbus i2c apis, it will be good to add
> that check too.

So I should do something like

if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA)=
)
	...

in addition?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
