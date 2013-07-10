From: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: Adding DT support for keyreset tuneables
Date: Wed, 10 Jul 2013 16:29:00 -0600
Message-ID: <CANLsYkw==yAEcwD9RAPCCHB0Y45Bo2MnfLSVP5s-g6kpAu9k4g@mail.gmail.com>
References: <1372349605-4500-1-git-send-email-mathieu.poirier@linaro.org>
 <20130710165247.GA22992@core.coreip.homeip.net>
 <CACxGe6s7b=qgUGM4-aZSaqVWFeD0hGeo2wVdSK1KSOGYbHUEsQ@mail.gmail.com>
 <3572203.AkEVm8LFzu@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1974197123071935689=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <3572203.AkEVm8LFzu-wUGeVx6es1+Q2O5dskk9LyLysJ1jNyTM@public.gmane.org>
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
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-team-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--===============1974197123071935689==
Content-Type: multipart/alternative; boundary=20cf3071ca4ee6dd3c04e12fcd03

--20cf3071ca4ee6dd3c04e12fcd03
Content-Type: text/plain; charset=ISO-8859-1

On 10 July 2013 16:20, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Wednesday, July 10, 2013 10:50:26 PM Grant Likely wrote:
> > On Wed, Jul 10, 2013 at 5:52 PM, Dmitry Torokhov
> >
> > <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On Wed, Jul 10, 2013 at 04:14:57PM +0100, Grant Likely wrote:
> > >> On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier
> <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > >> > On 13-06-28 12:09 AM, Dmitry Torokhov wrote:
> > >> > >>>> I do not agree.  We want the binding to be generic and not tied
> > >> > >>>> specifically to the keyreset functionality.  As such
> > >> > >>>> 'input-keyset' or
> > >> > >>>> 'input-keychord' are more appropriate.
> > >> > >>>
> > >> > >>> The binding is defined specifically for sysrq and specifically
> to
> > >> > >>> perform reset action.
> > >> > >>
> > >> > >> Yes for now but as the examples in the binding show, it is easy
> to
> > >> > >> envision how other drivers could use it.
> > >> > >
> > >> > > I think you over-complicate things here. Unlike matrix-keypad
> > >> > > binding,
> > >> > > where you have a common parsing code, here we have an individual
> > >> > > driver.
> > >> > > I really do not see anyone else using such sequences or chords as
> > >> > > such
> > >> > > processing should be done in userspace. Sysrq is quite an
> exception.
> > >> >
> > >> > To be honest I don't have a very strong opinion on the binding.  I
> made
> > >> > it as generic as possible on the guidance of the DT people.  Let's
> see
> > >> > what they think of it.
> > >>
> > >> Hi Mathieu,
> > >>
> > >> As per our conversation just now at Connect, the binding should
> probably
> > >> look like this:
> > >>
> > >> Sysrq keyset binding:
> > >>
> > >> The /chosen node can contain a linux,input-keyset-sysrq child node to
> > >> define a set of keys that will generate a sysrq when pressed together.
> > >
> > > Hmm, we would have only one such node, /sysrq, or /linux,sysrq,
> > > whatever. The sysrq setting is system-wide and applicable to all
> > > devices. Given that it is used only on mobile, where there not that
> > > many input devices (a few keys and touchscreen) I do not believe we
> > > should consider adding per-device settings.
> >
> > It's in /chosen, that isn't per-device.
> >
> > >> Required properties:
> > >> keyset: array of keycodes
> > >
> > > Please, let's call it 'key-reset-seq', because it is exactly the reset
> > > sequence. There won't be any additional sequences or chords as those
> > > should be handled in userspace, sysrq is a special case here.
> >
> > This is absolutely a linux-specific binding. It encodes the Linux
> > keycodes, and generates a linux meaning. I'm usually all about
> > carrying the OS-independent banner when defining DT bindings, but in
> > this case the linux prefix and sysrq reference is completely
> > appropriate.
>
> OK, I have no idea what "/chosen" actually means. What I am trying to say
> that there should be either "sysrq" or "linux,sysrq" node and that is what
> sysrq driver will be looking for.
>


Chosen pertains to system wide parameters that aren't related to hw
specific devices.  Correct, the driver will look exactly for
"linux,sysrq-reset-seq" in the "chosen" node and nowhere else.


>
> The entire node is Linux-specific and therefore there is no point in
> marking only one of the properties (the key sequence) Linux-specific while
> leaving other ones generic.
>
> Thanks.
>
> --
> Dmitry
>

--20cf3071ca4ee6dd3c04e12fcd03
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 10 July 2013 16:20, Dmitry Torokhov <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">dmitry.torokhov@gm=
ail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Wednesday, July 10, 2013 10:50:26 PM Gran=
t Likely wrote:<br>
&gt; On Wed, Jul 10, 2013 at 5:52 PM, Dmitry Torokhov<br>
&gt;<br>
&gt; &lt;<a href=3D"mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dmitry.torokhov@gmail=
.com</a>&gt; wrote:<br>
&gt; &gt; On Wed, Jul 10, 2013 at 04:14:57PM +0100, Grant Likely wrote:<br>
&gt; &gt;&gt; On Fri, 28 Jun 2013 07:19:06 -0600, Mathieu Poirier<br>
&lt;<a href=3D"mailto:mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">mathieu.poirier-QSEj5FYQhm5QFI55V6+gNQ@public.gmane.org=
g</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; On 13-06-28 12:09 AM, Dmitry Torokhov wrote:<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt;&gt; I do not agree. =A0We want the binding =
to be generic and not tied<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt;&gt; specifically to the keyreset functional=
ity. =A0As such<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt;&gt; &#39;input-keyset&#39; or<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt;&gt; &#39;input-keychord&#39; are more appro=
priate.<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt; The binding is defined specifically for sys=
rq and specifically to<br>
&gt; &gt;&gt; &gt; &gt;&gt;&gt; perform reset action.<br>
&gt; &gt;&gt; &gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; &gt;&gt; Yes for now but as the examples in the binding =
show, it is easy to<br>
&gt; &gt;&gt; &gt; &gt;&gt; envision how other drivers could use it.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; I think you over-complicate things here. Unlike mat=
rix-keypad<br>
&gt; &gt;&gt; &gt; &gt; binding,<br>
&gt; &gt;&gt; &gt; &gt; where you have a common parsing code, here we have =
an individual<br>
&gt; &gt;&gt; &gt; &gt; driver.<br>
&gt; &gt;&gt; &gt; &gt; I really do not see anyone else using such sequence=
s or chords as<br>
&gt; &gt;&gt; &gt; &gt; such<br>
&gt; &gt;&gt; &gt; &gt; processing should be done in userspace. Sysrq is qu=
ite an exception.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; To be honest I don&#39;t have a very strong opinion on t=
he binding. =A0I made<br>
&gt; &gt;&gt; &gt; it as generic as possible on the guidance of the DT peop=
le. =A0Let&#39;s see<br>
&gt; &gt;&gt; &gt; what they think of it.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi Mathieu,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; As per our conversation just now at Connect, the binding shou=
ld probably<br>
&gt; &gt;&gt; look like this:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Sysrq keyset binding:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The /chosen node can contain a linux,input-keyset-sysrq child=
 node to<br>
&gt; &gt;&gt; define a set of keys that will generate a sysrq when pressed =
together.<br>
&gt; &gt;<br>
&gt; &gt; Hmm, we would have only one such node, /sysrq, or /linux,sysrq,<b=
r>
&gt; &gt; whatever. The sysrq setting is system-wide and applicable to all<=
br>
&gt; &gt; devices. Given that it is used only on mobile, where there not th=
at<br>
&gt; &gt; many input devices (a few keys and touchscreen) I do not believe =
we<br>
&gt; &gt; should consider adding per-device settings.<br>
&gt;<br>
&gt; It&#39;s in /chosen, that isn&#39;t per-device.<br>
&gt;<br>
&gt; &gt;&gt; Required properties:<br>
&gt; &gt;&gt; keyset: array of keycodes<br>
&gt; &gt;<br>
&gt; &gt; Please, let&#39;s call it &#39;key-reset-seq&#39;, because it is =
exactly the reset<br>
&gt; &gt; sequence. There won&#39;t be any additional sequences or chords a=
s those<br>
&gt; &gt; should be handled in userspace, sysrq is a special case here.<br>
&gt;<br>
&gt; This is absolutely a linux-specific binding. It encodes the Linux<br>
&gt; keycodes, and generates a linux meaning. I&#39;m usually all about<br>
&gt; carrying the OS-independent banner when defining DT bindings, but in<b=
r>
&gt; this case the linux prefix and sysrq reference is completely<br>
&gt; appropriate.<br>
<br>
OK, I have no idea what &quot;/chosen&quot; actually means. What I am tryin=
g to say<br>
that there should be either &quot;sysrq&quot; or &quot;linux,sysrq&quot; no=
de and that is what<br>
sysrq driver will be looking for.<br></blockquote><div><br></div><div><br><=
/div><div>Chosen pertains to system wide parameters that aren&#39;t related=
 to hw specific devices. =A0Correct, the driver will look exactly for &quot=
;linux,sysrq-reset-seq&quot; in the &quot;chosen&quot; node and nowhere els=
e.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
The entire node is Linux-specific and therefore there is no point in<br>
marking only one of the properties (the key sequence) Linux-specific while<=
br>
leaving other ones generic.<br>
<br>
Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Dmitry<br>
</font></span></blockquote></div><br></div></div>

--20cf3071ca4ee6dd3c04e12fcd03--

--===============1974197123071935689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1974197123071935689==--
