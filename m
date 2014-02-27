From: Aaron Armstrong Skomra <skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Input: wacom: References to
 'wacom->data' should use 'unsigned char*'
Date: Thu, 27 Feb 2014 10:28:02 -0800
Message-ID: <CAEoswT0hRqzTCw+V3eD5HL+VG-LLMXt5kW0dfjQRyNF6rN5=UQ@mail.gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
	<1391107728-1306-3-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3212176532965296515=="
Return-path: <linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1391107728-1306-3-git-send-email-killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxwacom-devel>
List-Post: <mailto:linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ping Cheng <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--===============3212176532965296515==
Content-Type: multipart/alternative; boundary=20cf3071cfd251c9e504f3677ba8

--20cf3071cfd251c9e504f3677ba8
Content-Type: text/plain; charset=ISO-8859-1

Tested-by: Aaron Skomra <Aaron.Skomra-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org>


On Thu, Jan 30, 2014 at 10:48 AM, Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> 'wacom->data' contains raw binary data and can lead to unexpected
> behavior if a byte under examination happens to have its MSB set.
>
> Signed-off-by: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/tablet/wacom_wac.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c
> b/drivers/input/tablet/wacom_wac.c
> index 05f371d..9ff5613 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -178,10 +178,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
>
>  static int wacom_dtu_irq(struct wacom_wac *wacom)
>  {
> -       struct wacom_features *features = &wacom->features;
> -       char *data = wacom->data;
> +       unsigned char *data = wacom->data;
>         struct input_dev *input = wacom->input;
> -       int prox = data[1] & 0x20, pressure;
> +       int prox = data[1] & 0x20;
>
>         dev_dbg(input->dev.parent,
>                 "%s: received report #%d", __func__, data[0]);
> @@ -198,10 +197,7 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
>         input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>         input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
>         input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> -       pressure = ((data[7] & 0x01) << 8) | data[6];
> -       if (pressure < 0)
> -               pressure = features->pressure_max + pressure + 1;
> -       input_report_abs(input, ABS_PRESSURE, pressure);
> +       input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) << 8) |
> data[6]);
>         input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>         if (!prox) /* out-prox */
>                 wacom->id[0] = 0;
> @@ -906,7 +902,7 @@ static int int_dist(int x1, int y1, int x2, int y2)
>  static int wacom_24hdt_irq(struct wacom_wac *wacom)
>  {
>         struct input_dev *input = wacom->input;
> -       char *data = wacom->data;
> +       unsigned char *data = wacom->data;
>         int i;
>         int current_num_contacts = data[61];
>         int contacts_to_send = 0;
> @@ -959,7 +955,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
>  static int wacom_mt_touch(struct wacom_wac *wacom)
>  {
>         struct input_dev *input = wacom->input;
> -       char *data = wacom->data;
> +       unsigned char *data = wacom->data;
>         int i;
>         int current_num_contacts = data[2];
>         int contacts_to_send = 0;
> @@ -1038,7 +1034,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac
> *wacom)
>
>  static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
>  {
> -       char *data = wacom->data;
> +       unsigned char *data = wacom->data;
>         struct input_dev *input = wacom->input;
>         bool prox;
>         int x = 0, y = 0;
> @@ -1074,10 +1070,8 @@ static int wacom_tpc_single_touch(struct wacom_wac
> *wacom, size_t len)
>
>  static int wacom_tpc_pen(struct wacom_wac *wacom)
>  {
> -       struct wacom_features *features = &wacom->features;
> -       char *data = wacom->data;
> +       unsigned char *data = wacom->data;
>         struct input_dev *input = wacom->input;
> -       int pressure;
>         bool prox = data[1] & 0x20;
>
>         if (!wacom->shared->stylus_in_proximity) /* first in prox */
> @@ -1093,10 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
>                 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>                 input_report_abs(input, ABS_X, le16_to_cpup((__le16
> *)&data[2]));
>                 input_report_abs(input, ABS_Y, le16_to_cpup((__le16
> *)&data[4]));
> -               pressure = ((data[7] & 0x01) << 8) | data[6];
> -               if (pressure < 0)
> -                       pressure = features->pressure_max + pressure + 1;
> -               input_report_abs(input, ABS_PRESSURE, pressure);
> +               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) <<
> 8) | data[6]);
>                 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>                 input_report_key(input, wacom->tool[0], prox);
>                 return 1;
> @@ -1107,7 +1098,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
>
>  static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>  {
> -       char *data = wacom->data;
> +       unsigned char *data = wacom->data;
>
>         dev_dbg(wacom->input->dev.parent,
>                 "%s: received report #%d\n", __func__, data[0]);
> --
> 1.8.5.3
>
>


-- 
Aaron Skomra
skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
503-208-5430

--20cf3071cfd251c9e504f3677ba8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Aaron Skomra &lt;<a href=3D"mailto:Aaron.Skomra=
@wacom.com">Aaron.Skomra-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org</a>&gt;</div><div class=3D"gmail_extra">=
<br><br><div class=3D"gmail_quote">On Thu, Jan 30, 2014 at 10:48 AM, Jason =
Gerecke <span dir=3D"ltr">&lt;<a href=3D"mailto:killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targe=
t=3D"_blank">killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&#39;wacom-&gt;data&#39; contains raw binary=
 data and can lead to unexpected<br>
behavior if a byte under examination happens to have its MSB set.<br>
<br>
Signed-off-by: Jason Gerecke &lt;<a href=3D"mailto:killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ki=
llertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/input/tablet/wacom_wac.c | 27 +++++++++------------------<br>
=A01 file changed, 9 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_=
wac.c<br>
index 05f371d..9ff5613 100644<br>
--- a/drivers/input/tablet/wacom_wac.c<br>
+++ b/drivers/input/tablet/wacom_wac.c<br>
@@ -178,10 +178,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)<br>
<br>
=A0static int wacom_dtu_irq(struct wacom_wac *wacom)<br>
=A0{<br>
- =A0 =A0 =A0 struct wacom_features *features =3D &amp;wacom-&gt;features;<=
br>
- =A0 =A0 =A0 char *data =3D wacom-&gt;data;<br>
+ =A0 =A0 =A0 unsigned char *data =3D wacom-&gt;data;<br>
=A0 =A0 =A0 =A0 struct input_dev *input =3D wacom-&gt;input;<br>
- =A0 =A0 =A0 int prox =3D data[1] &amp; 0x20, pressure;<br>
+ =A0 =A0 =A0 int prox =3D data[1] &amp; 0x20;<br>
<br>
=A0 =A0 =A0 =A0 dev_dbg(input-&gt;dev.parent,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;%s: received report #%d&quot;, __func=
__, data[0]);<br>
@@ -198,10 +197,7 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)<br>
=A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, data[1] &amp; 0x10);<b=
r>
=A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&amp;=
data[2]));<br>
=A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&amp;=
data[4]));<br>
- =A0 =A0 =A0 pressure =3D ((data[7] &amp; 0x01) &lt;&lt; 8) | data[6];<br>
- =A0 =A0 =A0 if (pressure &lt; 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features-&gt;pressure_max + pres=
sure + 1;<br>
- =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, pressure);<br>
+ =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, ((data[7] &amp; 0x01) &=
lt;&lt; 8) | data[6]);<br>
=A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, data[1] &amp; 0x05);<br>
=A0 =A0 =A0 =A0 if (!prox) /* out-prox */<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom-&gt;id[0] =3D 0;<br>
@@ -906,7 +902,7 @@ static int int_dist(int x1, int y1, int x2, int y2)<br>
=A0static int wacom_24hdt_irq(struct wacom_wac *wacom)<br>
=A0{<br>
=A0 =A0 =A0 =A0 struct input_dev *input =3D wacom-&gt;input;<br>
- =A0 =A0 =A0 char *data =3D wacom-&gt;data;<br>
+ =A0 =A0 =A0 unsigned char *data =3D wacom-&gt;data;<br>
=A0 =A0 =A0 =A0 int i;<br>
=A0 =A0 =A0 =A0 int current_num_contacts =3D data[61];<br>
=A0 =A0 =A0 =A0 int contacts_to_send =3D 0;<br>
@@ -959,7 +955,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)<br>
=A0static int wacom_mt_touch(struct wacom_wac *wacom)<br>
=A0{<br>
=A0 =A0 =A0 =A0 struct input_dev *input =3D wacom-&gt;input;<br>
- =A0 =A0 =A0 char *data =3D wacom-&gt;data;<br>
+ =A0 =A0 =A0 unsigned char *data =3D wacom-&gt;data;<br>
=A0 =A0 =A0 =A0 int i;<br>
=A0 =A0 =A0 =A0 int current_num_contacts =3D data[2];<br>
=A0 =A0 =A0 =A0 int contacts_to_send =3D 0;<br>
@@ -1038,7 +1034,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom=
)<br>
<br>
=A0static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)<b=
r>
=A0{<br>
- =A0 =A0 =A0 char *data =3D wacom-&gt;data;<br>
+ =A0 =A0 =A0 unsigned char *data =3D wacom-&gt;data;<br>
=A0 =A0 =A0 =A0 struct input_dev *input =3D wacom-&gt;input;<br>
=A0 =A0 =A0 =A0 bool prox;<br>
=A0 =A0 =A0 =A0 int x =3D 0, y =3D 0;<br>
@@ -1074,10 +1070,8 @@ static int wacom_tpc_single_touch(struct wacom_wac *=
wacom, size_t len)<br>
<br>
=A0static int wacom_tpc_pen(struct wacom_wac *wacom)<br>
=A0{<br>
- =A0 =A0 =A0 struct wacom_features *features =3D &amp;wacom-&gt;features;<=
br>
- =A0 =A0 =A0 char *data =3D wacom-&gt;data;<br>
+ =A0 =A0 =A0 unsigned char *data =3D wacom-&gt;data;<br>
=A0 =A0 =A0 =A0 struct input_dev *input =3D wacom-&gt;input;<br>
- =A0 =A0 =A0 int pressure;<br>
=A0 =A0 =A0 =A0 bool prox =3D data[1] &amp; 0x20;<br>
<br>
=A0 =A0 =A0 =A0 if (!wacom-&gt;shared-&gt;stylus_in_proximity) /* first in =
prox */<br>
@@ -1093,10 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)<br=
>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, data[1=
] &amp; 0x10);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpup=
((__le16 *)&amp;data[2]));<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpup=
((__le16 *)&amp;data[4]));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D ((data[7] &amp; 0x01) &lt;&lt; 8=
) | data[6];<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pressure &lt; 0)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features-&gt;pre=
ssure_max + pressure + 1;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, pressur=
e);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, ((data[=
7] &amp; 0x01) &lt;&lt; 8) | data[6]);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, data[1] =
&amp; 0x05);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, wacom-&gt;tool[0], =
prox);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
@@ -1107,7 +1098,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)<br>
<br>
=A0static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)<br>
=A0{<br>
- =A0 =A0 =A0 char *data =3D wacom-&gt;data;<br>
+ =A0 =A0 =A0 unsigned char *data =3D wacom-&gt;data;<br>
<br>
=A0 =A0 =A0 =A0 dev_dbg(wacom-&gt;input-&gt;dev.parent,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;%s: received report #%d\n&quot;, __fu=
nc__, data[0]);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.5.3<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr"><div>Aaron Skomra<br></div><div><a href=3D"mailto:skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br></div>503-208-5430<br></div>
</div>

--20cf3071cfd251c9e504f3677ba8--


--===============3212176532965296515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
--===============3212176532965296515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3212176532965296515==--
