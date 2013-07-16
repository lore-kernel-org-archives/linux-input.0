From: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] Input: sysrq - DT binding for key sequence
Date: Tue, 16 Jul 2013 16:24:38 -0600
Message-ID: <CANLsYkzgHqnuDq46JEJH713jrnD8rAAG_2wLbKJCAOGLpw+e4g@mail.gmail.com>
References: <1373902598-10062-1-git-send-email-mathieu.poirier@linaro.org>
 <51E4B35D.8020000@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6032580236146745071=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51E4B35D.8020000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-team-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

--===============6032580236146745071==
Content-Type: multipart/alternative; boundary=047d7b3a87504e336e04e1a8710e

--047d7b3a87504e336e04e1a8710e
Content-Type: text/plain; charset=ISO-8859-1

On 15 July 2013 20:43, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 07/15/2013 10:36 AM, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> > From: "Mathieu J. Poirier" <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >
> > Adding a simple device tree binding for the specification of key
> sequences.
> > Definition of the keys found in the sequence are located in
> > 'include/uapi/linux/input.h'.
> >
> > For the sysrq driver, holding the sequence of keys down for a specific
> amount of time
> > will reset the system.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> > changes for v4:
> >   - Moved seach of reset sequence nodes to a single call.
> > ---
> >  .../devicetree/bindings/input/input-reset.txt      | 34 ++++++++++++++
> >  drivers/tty/sysrq.c                                | 54
> ++++++++++++++++++++++
> >  2 files changed, 88 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/input/input-reset.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/input-reset.txt
> b/Documentation/devicetree/bindings/input/input-reset.txt
> > new file mode 100644
> > index 0000000..79504af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/input-reset.txt
> > @@ -0,0 +1,34 @@
> > +Input: sysrq reset sequence
> > +
> > +A simple binding to represent a set of keys as described in
> > +include/uapi/linux/input.h.  This is to communicate a
> > +sequence of keys to the sysrq driver.  Upon holding the keys
> > +for a specified amount of time (if specified) the system is
> > +sync'ed and reset.
> > +
> > +Key sequences are global to the system but all the keys in a
> > +set must be coming from the same input device.
> > +
> > +The /chosen node should contain a 'linux,sysrq-reset-seq' child
> > +node to define a set of keys.
> > +
> > +Required property:
> > +sysrq-reset-seq: array of keycodes
> > +
> > +Optional property:
> > +timeout-ms: duration keys must be pressed together in microseconds
>
> milliseconds (ms) or microseconds (us)?
>
>
Right, milliseconds.


> > +before generating a sysrq
> > +
> > +Example:
> > +
> > + chosen {
> > +                linux,sysrq-reset-seq {
> > +                        keyset = <0x03
> > +                                  0x04
> > +                                  0x0a>;
> > +                        timeout-ms = <3000>;
> > +                };
> > +         };
> > +
> > +Would represent KEY_2, KEY_3 and KEY_9.
> > +
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index b51c154..01a8729 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/jiffies.h>
> > +#include <linux/of.h>
> >
> >  #include <asm/ptrace.h>
> >  #include <asm/irq_regs.h>
> > @@ -671,6 +672,50 @@ static void sysrq_detect_reset_sequence(struct
> sysrq_state *state,
> >       }
> >  }
> >
> > +static void sysrq_of_get_keyreset_config(void)
> > +{
> > +     unsigned short key;
> > +     struct device_node *np;
> > +     const struct property *prop;
> > +     const __be32 *val;
> > +     int count, i;
> > +
> > +     np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +     if (!np) {
> > +             pr_debug("No sysrq node found");
> > +             goto out;
> > +     }
> > +
> > +     prop = of_find_property(np, "keyset", NULL);
> > +     if (!prop || !prop->value) {
> > +             pr_err("Invalid input keyset");
> > +             goto out;
> > +     }
> > +
> > +     count = prop->length / sizeof(u32);
> > +     val = prop->value;
>
> None of the existing helpers to retrieve property arrays doesn't work here?
>

The problem here is that we never know how long the sequence will be.  As
such the 'of_property_read_uXY_array' functions won't work.  Or maybe
you're referring to another set of helpers... If so, please clarify.


>
> > +
> > +     if (count > SYSRQ_KEY_RESET_MAX)
> > +             count = SYSRQ_KEY_RESET_MAX;
> > +
> > +     /* reset in case a __weak definition was present */
> > +     sysrq_reset_seq_len = 0;
> > +
> > +     for (i = 0; i < count; i++) {
> > +             key = (unsigned short)be32_to_cpup(val++);
> > +             if (key == KEY_RESERVED || key > KEY_MAX)
> > +                     break;
> > +
> > +             sysrq_reset_seq[sysrq_reset_seq_len++] = key;
> > +     }
> > +
> > +     /* get reset timeout if any */
> > +     of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> > +
> > + out:
> > +     ;
> > +}
> > +
> >  static void sysrq_reinject_alt_sysrq(struct work_struct *work)
> >  {
> >       struct sysrq_state *sysrq =
> > @@ -688,6 +733,7 @@ static void sysrq_reinject_alt_sysrq(struct
> work_struct *work)
> >               input_inject_event(handle, EV_KEY, KEY_SYSRQ, 1);
> >               input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
> >
> > +
>
> spurious ws change


> >               input_inject_event(handle, EV_KEY, KEY_SYSRQ, 0);
> >               input_inject_event(handle, EV_KEY, alt_code, 0);
> >               input_inject_event(handle, EV_SYN, SYN_REPORT, 1);
> > @@ -903,6 +949,7 @@ static inline void sysrq_register_handler(void)
> >       int error;
> >       int i;
> >
> > +     /* first check if a __weak interface was instantiated */
> >       for (i = 0; i < ARRAY_SIZE(sysrq_reset_seq); i++) {
> >               key = platform_sysrq_reset_seq[i];
> >               if (key == KEY_RESERVED || key > KEY_MAX)
> > @@ -911,6 +958,13 @@ static inline void sysrq_register_handler(void)
> >               sysrq_reset_seq[sysrq_reset_seq_len++] = key;
> >       }
> >
> > +     /*
> > +      * DT configuration takes precedence over anything
> > +      * that would have been defined via the __weak
> > +      * interface
> > +      */
> > +     sysrq_of_get_keyreset_config();
> > +
> >       error = input_register_handler(&sysrq_handler);
> >       if (error)
> >               pr_err("Failed to register input handler, error %d",
> error);
> >
>
>

--047d7b3a87504e336e04e1a8710e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 15 July 2013 20:43, Rob Herring <span dir=3D"ltr">&lt;<a href=3D=
"mailto:robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 07/15/2013 10:36 AM, <a href=3D"mailto:ma=
thieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a> wrote:<br>
&gt; From: &quot;Mathieu J. Poirier&quot; &lt;<a href=3D"mailto:mathieu.poi=
rier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; Adding a simple device tree binding for the specification of key seque=
nces.<br>
&gt; Definition of the keys found in the sequence are located in<br>
&gt; &#39;include/uapi/linux/input.h&#39;.<br>
&gt;<br>
&gt; For the sysrq driver, holding the sequence of keys down for a specific=
 amount of time<br>
&gt; will reset the system.<br>
&gt;<br>
&gt; Signed-off-by: Mathieu Poirier &lt;<a href=3D"mailto:mathieu.poirier@l=
inaro.org">mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; changes for v4:<br>
&gt; =A0 - Moved seach of reset sequence nodes to a single call.<br>
&gt; ---<br>
&gt; =A0.../devicetree/bindings/input/input-reset.txt =A0 =A0 =A0| 34 +++++=
+++++++++<br>
&gt; =A0drivers/tty/sysrq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| 54 ++++++++++++++++++++++<br>
&gt; =A02 files changed, 88 insertions(+)<br>
&gt; =A0create mode 100644 Documentation/devicetree/bindings/input/input-re=
set.txt<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/bindings/input/input-reset.txt b=
/Documentation/devicetree/bindings/input/input-reset.txt<br>
&gt; new file mode 100644<br>
&gt; index 0000000..79504af<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/devicetree/bindings/input/input-reset.txt<br>
&gt; @@ -0,0 +1,34 @@<br>
&gt; +Input: sysrq reset sequence<br>
&gt; +<br>
&gt; +A simple binding to represent a set of keys as described in<br>
&gt; +include/uapi/linux/input.h. =A0This is to communicate a<br>
&gt; +sequence of keys to the sysrq driver. =A0Upon holding the keys<br>
&gt; +for a specified amount of time (if specified) the system is<br>
&gt; +sync&#39;ed and reset.<br>
&gt; +<br>
&gt; +Key sequences are global to the system but all the keys in a<br>
&gt; +set must be coming from the same input device.<br>
&gt; +<br>
&gt; +The /chosen node should contain a &#39;linux,sysrq-reset-seq&#39; chi=
ld<br>
&gt; +node to define a set of keys.<br>
&gt; +<br>
&gt; +Required property:<br>
&gt; +sysrq-reset-seq: array of keycodes<br>
&gt; +<br>
&gt; +Optional property:<br>
&gt; +timeout-ms: duration keys must be pressed together in microseconds<br=
>
<br>
milliseconds (ms) or microseconds (us)?<br>
<br></blockquote><div><br></div><div>Right, milliseconds.</div><div>=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
&gt; +before generating a sysrq<br>
&gt; +<br>
&gt; +Example:<br>
&gt; +<br>
&gt; + chosen {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0linux,sysrq-reset-seq {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keyset =3D &lt;0x03<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x04<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x0a&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout-ms =3D &lt;30=
00&gt;;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>
&gt; + =A0 =A0 =A0 =A0 };<br>
&gt; +<br>
&gt; +Would represent KEY_2, KEY_3 and KEY_9.<br>
&gt; +<br>
&gt; diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c<br>
&gt; index b51c154..01a8729 100644<br>
&gt; --- a/drivers/tty/sysrq.c<br>
&gt; +++ b/drivers/tty/sysrq.c<br>
&gt; @@ -44,6 +44,7 @@<br>
&gt; =A0#include &lt;linux/uaccess.h&gt;<br>
&gt; =A0#include &lt;linux/moduleparam.h&gt;<br>
&gt; =A0#include &lt;linux/jiffies.h&gt;<br>
&gt; +#include &lt;linux/of.h&gt;<br>
&gt;<br>
&gt; =A0#include &lt;asm/ptrace.h&gt;<br>
&gt; =A0#include &lt;asm/irq_regs.h&gt;<br>
&gt; @@ -671,6 +672,50 @@ static void sysrq_detect_reset_sequence(struct sy=
srq_state *state,<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static void sysrq_of_get_keyreset_config(void)<br>
&gt; +{<br>
&gt; + =A0 =A0 unsigned short key;<br>
&gt; + =A0 =A0 struct device_node *np;<br>
&gt; + =A0 =A0 const struct property *prop;<br>
&gt; + =A0 =A0 const __be32 *val;<br>
&gt; + =A0 =A0 int count, i;<br>
&gt; +<br>
&gt; + =A0 =A0 np =3D of_find_node_by_path(&quot;/chosen/linux,sysrq-reset-=
seq&quot;);<br>
&gt; + =A0 =A0 if (!np) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(&quot;No sysrq node found&quot;);<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 prop =3D of_find_property(np, &quot;keyset&quot;, NULL);<br>
&gt; + =A0 =A0 if (!prop || !prop-&gt;value) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Invalid input keyset&quot;);<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 count =3D prop-&gt;length / sizeof(u32);<br>
&gt; + =A0 =A0 val =3D prop-&gt;value;<br>
<br>
None of the existing helpers to retrieve property arrays doesn&#39;t work h=
ere?<br></blockquote><div><br></div><div>The problem here is that we never =
know how long the sequence will be. =A0As such the &#39;of_property_read_uX=
Y_array&#39; functions won&#39;t work. =A0Or maybe you&#39;re referring to =
another set of helpers... If so, please clarify.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +<br>
&gt; + =A0 =A0 if (count &gt; SYSRQ_KEY_RESET_MAX)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 count =3D SYSRQ_KEY_RESET_MAX;<br>
&gt; +<br>
&gt; + =A0 =A0 /* reset in case a __weak definition was present */<br>
&gt; + =A0 =A0 sysrq_reset_seq_len =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 for (i =3D 0; i &lt; count; i++) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 key =3D (unsigned short)be32_to_cpup(val++);=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (key =3D=3D KEY_RESERVED || key &gt; KEY_=
MAX)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 sysrq_reset_seq[sysrq_reset_seq_len++] =3D k=
ey;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 /* get reset timeout if any */<br>
&gt; + =A0 =A0 of_property_read_u32(np, &quot;timeout-ms&quot;, &amp;sysrq_=
reset_downtime_ms);<br>
&gt; +<br>
&gt; + out:<br>
&gt; + =A0 =A0 ;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static void sysrq_reinject_alt_sysrq(struct work_struct *work)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct sysrq_state *sysrq =3D<br>
&gt; @@ -688,6 +733,7 @@ static void sysrq_reinject_alt_sysrq(struct work_s=
truct *work)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_inject_event(handle, EV_KEY, KEY_SYS=
RQ, 1);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_inject_event(handle, EV_SYN, SYN_REP=
ORT, 1);<br>
&gt;<br>
&gt; +<br>
<br>
spurious ws change=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_inject_event(handle, EV_KEY, KEY_SYS=
RQ, 0);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_inject_event(handle, EV_KEY, alt_cod=
e, 0);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_inject_event(handle, EV_SYN, SYN_REP=
ORT, 1);<br>
&gt; @@ -903,6 +949,7 @@ static inline void sysrq_register_handler(void)<br=
>
&gt; =A0 =A0 =A0 int error;<br>
&gt; =A0 =A0 =A0 int i;<br>
&gt;<br>
&gt; + =A0 =A0 /* first check if a __weak interface was instantiated */<br>
&gt; =A0 =A0 =A0 for (i =3D 0; i &lt; ARRAY_SIZE(sysrq_reset_seq); i++) {<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 key =3D platform_sysrq_reset_seq[i];<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (key =3D=3D KEY_RESERVED || key &gt; KE=
Y_MAX)<br>
&gt; @@ -911,6 +958,13 @@ static inline void sysrq_register_handler(void)<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysrq_reset_seq[sysrq_reset_seq_len++] =3D=
 key;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* DT configuration takes precedence over anything<br>
&gt; + =A0 =A0 =A0* that would have been defined via the __weak<br>
&gt; + =A0 =A0 =A0* interface<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 sysrq_of_get_keyreset_config();<br>
&gt; +<br>
&gt; =A0 =A0 =A0 error =3D input_register_handler(&amp;sysrq_handler);<br>
&gt; =A0 =A0 =A0 if (error)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Failed to register input hand=
ler, error %d&quot;, error);<br>
&gt;<br>
<br>
</blockquote></div><br></div></div>

--047d7b3a87504e336e04e1a8710e--

--===============6032580236146745071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6032580236146745071==--
