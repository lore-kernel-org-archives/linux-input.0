From: Harshit Jain <harshitjain6751@gmail.com>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date: Tue, 24 Jul 2018 01:47:14 +0530
Message-ID: <CAA47fTLQFiSFiDksiNMJjnFg6rO1xS1ceE=bvhQz7o6WNa3_CA@mail.gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com> <20180723133200.GA1167@kroah.com>
 <20180723171831.GC100814@dtor-ws> <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
 <20180723182412.GA2964@roeck-us.net> <5ac390c1cdf14656624dcc1f2816ab4d694d0d4f.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="000000000000da98bc0571b0542b"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ac390c1cdf14656624dcc1f2816ab4d694d0d4f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, trivial@kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--000000000000da98bc0571b0542b
Content-Type: text/plain; charset="UTF-8"

I ran a treewide script and changed them all to octal and built a kernel
which i am currently running on my machine, I have used DEVICE_ATTR_RO()
for 0444's where possible if i dont find any regressions I will post a
patch for review. I think i will be testing it at least for a week.

On Tue, Jul 24, 2018 at 12:00 AM, Joe Perches <joe@perches.com> wrote:

> On Mon, 2018-07-23 at 11:24 -0700, Guenter Roeck wrote:
> > There are much more urgent issues to fix there (such as, for example,
> > converting the "offending" drivers to the latest API, which would
> > magically cause most of the offenders to disappear).
>
> Perhaps posting a list of desired hwmon changes could help.
>
> Documentation/hwmon/submitting-patches does not seem to specify
> what the "latest API" is nor describe what changes would be
> required in older drivers.
>

--000000000000da98bc0571b0542b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I ran a treewide script and changed them all to octal and =
built a kernel which i am currently running on my machine, I have used DEVI=
CE_ATTR_RO() for 0444&#39;s where possible if i dont find any regressions I=
 will post a patch for review. I think i will be testing it at least for a =
week.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue=
, Jul 24, 2018 at 12:00 AM, Joe Perches <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:joe@perches.com" target=3D"_blank">joe@perches.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><span class=3D"">On Mon, 2018-07-23 at=
 11:24 -0700, Guenter Roeck wrote:<br>
&gt; There are much more urgent issues to fix there (such as, for example,<=
br>
&gt; converting the &quot;offending&quot; drivers to the latest API, which =
would<br>
&gt; magically cause most of the offenders to disappear).<br>
<br>
</span>Perhaps posting a list of desired hwmon changes could help.<br>
<br>
Documentation/hwmon/<wbr>submitting-patches does not seem to specify<br>
what the &quot;latest API&quot; is nor describe what changes would be<br>
required in older drivers.<br>
</blockquote></div><br></div>

--000000000000da98bc0571b0542b--
