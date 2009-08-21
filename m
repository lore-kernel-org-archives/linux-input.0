From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Synaptics touchscreen for HTC Dream: check that smbus is
	available
Date: Fri, 21 Aug 2009 16:23:05 +0200
Message-ID: <20090821142305.GA1599@ucw.cz>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <20090721102153.GE4133@elf.ucw.cz> <5d5443650907210334k3f562cebsc665511a161c8639@mail.gmail.com> <20090808134049.GA13083@elf.ucw.cz> <20090817164759.43c39f2d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090817164759.43c39f2d.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon 2009-08-17 16:47:59, Andrew Morton wrote:
> On Sat, 8 Aug 2009 15:40:50 +0200
> Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> 
> > > >> Because this driver is using smbus i2c apis, it will be good to add
> > > >> that check too.
> > > >
> > > > So I should do something like
> > > >
> > > > if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> > > > __ __ __ __...
> > > >
> > > > in addition?
> > > 
> > > Yes.
> > 
> > Ok, here it is.
> > 
> > --- 
> > 
> > Check that SMBUS APIs are available in touchscreen driver.
> 
> Why?

Well, the touchscreen driver uses those APIs, and I was told I should
check. It does not matter for htc dream-like machines, but someone
might want  to run it on pc...

									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
