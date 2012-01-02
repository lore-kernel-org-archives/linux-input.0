From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Mon, 2 Jan 2012 00:21:21 -0700
Message-ID: <20120102072121.GB13015@ponder.secretlab.ca>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
 <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
 <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Simon Glass (sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org)" <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 28, 2011 at 11:06:02PM -0800, Olof Johansson wrote:
> On Wed, Dec 28, 2011 at 11:01 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Can we deprecate the Samsung format, and only allow it for that Samsung
> > device (and allow both there), and require a single format for any other
> > keyboard?
> 
> I'm definitely ok with that. Thomas, Grant, Rob? The code in question
> is queued for 3.3, so it hasn't been out in a real release yet.
> 
> Adding Kukjin as well since it's getting merged through his tree.

Yeah, I'm okay with that.

BTW, please drop the "compatible" value for this binding.  This binding
describes a common way of describing key mappings, but it isn't a complete
device binding in and of itself.  Rather, it is a binding used by other
bindings; and as such no driver should ever bind against it directly.  The
samsung driver can continue to use the other format if it so desires; there
is no harm in it doing so.

Instead, a driver that expects the binding can just call the
matrix_keyboard_of_fill_keymap() library function without checking
the compatible list.

g.
