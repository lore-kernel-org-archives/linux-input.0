From: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Wed, 10 Jul 2013 15:35:25 -0600
Message-ID: <CANLsYky3UsEL0-WS7y98CfU4raUxgsxkYydPu7O8aRnS==u2mQ@mail.gmail.com>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
 <1372349605-4500-2-git-send-email-mathieu.poirier@linaro.org>
 <20130627162820.GA12070@core.coreip.homeip.net>
 <51CC7CD5.5090508@linaro.org>
 <20130627182500.GB12961@core.coreip.homeip.net>
 <51CC8786.1070200@linaro.org>
 <20130628060945.GA17523@core.coreip.homeip.net>
 <51CD8D4A.10207@linaro.org> <20130710151457.D0B863E1168@localhost>
 <20130710165247.GA22992@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2302606808394689025=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130710165247.GA22992-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-team-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--===============2302606808394689025==
Content-Type: multipart/alternative; boundary=047d7b6da6ac3de0d204e12f0e12

--047d7b6da6ac3de0d204e12f0e12
Content-Type: text/plain; charset=ISO-8859-1

On 10 July 2013 10:52, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Wed, Jul 10, 2013 at 04:14:57PM +0100, Grant Likely wrote:
> > On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier <
> mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > > On 13-06-28 12:09 AM, Dmitry Torokhov wrote:
> > > >>>> I do not agree.  We want the binding to be generic and not tied
> > > >>>> specifically to the keyreset functionality.  As such
> 'input-keyset' or
> > > >>>> 'input-keychord' are more appropriate.
> > > >>>
> > > >>> The binding is defined specifically for sysrq and specifically to
> > > >>> perform reset action.
> > > >>
> > > >> Yes for now but as the examples in the binding show, it is easy to
> > > >> envision how other drivers could use it.
> > > >
> > > > I think you over-complicate things here. Unlike matrix-keypad
> binding,
> > > > where you have a common parsing code, here we have an individual
> driver.
> > > > I really do not see anyone else using such sequences or chords as
> such
> > > > processing should be done in userspace. Sysrq is quite an exception.
> > >
> > > To be honest I don't have a very strong opinion on the binding.  I made
> > > it as generic as possible on the guidance of the DT people.  Let's see
> > > what they think of it.
> >
> > Hi Mathieu,
> >
> > As per our conversation just now at Connect, the binding should probably
> > look like this:
> >
> > Sysrq keyset binding:
> >
> > The /chosen node can contain a linux,input-keyset-sysrq child node to
> > define a set of keys that will generate a sysrq when pressed together.
>
> Hmm, we would have only one such node, /sysrq, or /linux,sysrq,
> whatever. The sysrq setting is system-wide and applicable to all
> devices. Given that it is used only on mobile, where there not that
> many input devices (a few keys and touchscreen) I do not believe we
> should consider adding per-device settings.
>

Putting the binding in the "chosen" node is definitely a system wide
setting.  If I didn't interpret your comment properly, please get back to
me.


>
> >
> > Required properties:
> > keyset: array of keycodes
>
> Please, let's call it 'key-reset-seq', because it is exactly the reset
> sequence. There won't be any additional sequences or chords as those
> should be handled in userspace, sysrq is a special case here.
>


I'm not strongly opinionated on that front but I think it should, at least,
include the some clue about the driver it ties to.  What do you think
about: "linux,sysrq-reset-seq" ?


> > timeout-ms: duration keys must be pressed together in microseconds
> > before generating a sysrq
> >
>
> Thanks.
>
> --
> Dmitry
>

--047d7b6da6ac3de0d204e12f0e12
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 10 July 2013 10:52, Dmitry Torokhov <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">dmitry.torokhov@gm=
ail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">On Wed, Jul 10, 2013 at 04:14:57PM +0100, Grant Likely wro=
te:<br>

&gt; On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier &lt;<a href=3D"mai=
lto:mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt; wrote:<b=
r>
&gt; &gt; On 13-06-28 12:09 AM, Dmitry Torokhov wrote:<br>
&gt; &gt; &gt;&gt;&gt;&gt; I do not agree. =A0We want the binding to be gen=
eric and not tied<br>
&gt; &gt; &gt;&gt;&gt;&gt; specifically to the keyreset functionality. =A0A=
s such &#39;input-keyset&#39; or<br>
&gt; &gt; &gt;&gt;&gt;&gt; &#39;input-keychord&#39; are more appropriate.<b=
r>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; The binding is defined specifically for sysrq and sp=
ecifically to<br>
&gt; &gt; &gt;&gt;&gt; perform reset action.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Yes for now but as the examples in the binding show, it =
is easy to<br>
&gt; &gt; &gt;&gt; envision how other drivers could use it.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I think you over-complicate things here. Unlike matrix-keypa=
d binding,<br>
&gt; &gt; &gt; where you have a common parsing code, here we have an indivi=
dual driver.<br>
&gt; &gt; &gt; I really do not see anyone else using such sequences or chor=
ds as such<br>
&gt; &gt; &gt; processing should be done in userspace. Sysrq is quite an ex=
ception.<br>
&gt; &gt;<br>
&gt; &gt; To be honest I don&#39;t have a very strong opinion on the bindin=
g. =A0I made<br>
&gt; &gt; it as generic as possible on the guidance of the DT people. =A0Le=
t&#39;s see<br>
&gt; &gt; what they think of it.<br>
&gt;<br>
&gt; Hi Mathieu,<br>
&gt;<br>
&gt; As per our conversation just now at Connect, the binding should probab=
ly<br>
&gt; look like this:<br>
&gt;<br>
&gt; Sysrq keyset binding:<br>
&gt;<br>
&gt; The /chosen node can contain a linux,input-keyset-sysrq child node to<=
br>
&gt; define a set of keys that will generate a sysrq when pressed together.=
<br>
<br>
Hmm, we would have only one such node, /sysrq, or /linux,sysrq,<br>
whatever. The sysrq setting is system-wide and applicable to all<br>
devices. Given that it is used only on mobile, where there not that<br>
many input devices (a few keys and touchscreen) I do not believe we<br>
should consider adding per-device settings.<br></blockquote><div><br></div>=
<div>Putting the binding in the &quot;chosen&quot; node is definitely a sys=
tem wide setting. =A0If I didn&#39;t interpret your comment properly, pleas=
e get back to me.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">
<br>
&gt;<br>
&gt; Required properties:<br>
&gt; keyset: array of keycodes<br>
<br>
Please, let&#39;s call it &#39;key-reset-seq&#39;, because it is exactly th=
e reset<br>
sequence. There won&#39;t be any additional sequences or chords as those<br=
>
should be handled in userspace, sysrq is a special case here.<br></blockquo=
te><div><br></div><div>=A0</div><div>I&#39;m not strongly opinionated on th=
at front but I think it should, at least, include the some clue about the d=
river it ties to. =A0What do you think about: &quot;linux,sysrq-reset-seq&q=
uot; ?</div>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
<br>
&gt; timeout-ms: duration keys must be pressed together in microseconds<br>
&gt; before generating a sysrq<br>
&gt;<br>
<br>
Thanks.<br>
<span class=3D""><font color=3D"#888888"><br>
--<br>
Dmitry<br>
</font></span></blockquote></div><br></div></div>

--047d7b6da6ac3de0d204e12f0e12--

--===============2302606808394689025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2302606808394689025==--
