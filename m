From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple key matrixes
Date: Tue, 3 Jan 2012 09:44:15 -0800
Message-ID: <CAOesGMjxS+AECmZu9pSusmhT+edXkrRYUnOSSs6QAJ7n45sRyA@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
	<CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
	<CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
	<20120102072121.GB13015@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120102072121.GB13015-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Simon Glass (sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org)" <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, Jan 1, 2012 at 11:21 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Wed, Dec 28, 2011 at 11:06:02PM -0800, Olof Johansson wrote:
>> On Wed, Dec 28, 2011 at 11:01 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org=
> wrote:
>> > Can we deprecate the Samsung format, and only allow it for that Sa=
msung
>> > device (and allow both there), and require a single format for any=
 other
>> > keyboard?
>>
>> I'm definitely ok with that. Thomas, Grant, Rob? The code in questio=
n
>> is queued for 3.3, so it hasn't been out in a real release yet.
>>
>> Adding Kukjin as well since it's getting merged through his tree.
>
> Yeah, I'm okay with that.
>
> BTW, please drop the "compatible" value for this binding. =A0This bin=
ding
> describes a common way of describing key mappings, but it isn't a com=
plete
> device binding in and of itself. =A0Rather, it is a binding used by o=
ther
> bindings; and as such no driver should ever bind against it directly.=
 =A0The
> samsung driver can continue to use the other format if it so desires;=
 there
> is no harm in it doing so.
>
> Instead, a driver that expects the binding can just call the
> matrix_keyboard_of_fill_keymap() library function without checking
> the compatible list.

The main reason I had it there today was to make it easier to do a
versioned binding in case of future revisions, but I guess it's not
worth the hassle.

So, in that case I will move out the fn management out of the common
code as well, and pass in the property name to
matrix_keyboard_of_fill_keymap. That way, the drivers that need to do
a fn-keymap can do so outside of the shared code (and it gets rid of
the FIXME in that case as well). Revised patch in a bit.


-Olof
