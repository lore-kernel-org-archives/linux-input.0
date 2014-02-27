From: Aaron Armstrong Skomra <skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] Input: wacom: Handle 1024
	pressure levels in wacom_tpc_pen
Date: Thu, 27 Feb 2014 10:28:15 -0800
Message-ID: <CAEoswT2hhv0T84Qao-R4740LQQWZG4_x5AsFqbFpe=-bZw9W1A@mail.gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
	<1391107728-1306-4-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1490858217429971937=="
Return-path: <linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1391107728-1306-4-git-send-email-killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============1490858217429971937==
Content-Type: multipart/alternative; boundary=20cf307abdab12ab3804f3677c04

--20cf307abdab12ab3804f3677c04
Content-Type: text/plain; charset=ISO-8859-1

Tested-by: Aaron Skomra <Aaron.Skomra-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org>


On Thu, Jan 30, 2014 at 10:48 AM, Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> Some tablet PC sensors (e.g. the 0xEC found in the Thinkpad
> Yoga) report more than 256 pressure levels and will experience
> wraparound unless the full range is read.
>
> Signed-off-by: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/tablet/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c
> b/drivers/input/tablet/wacom_wac.c
> index 9ff5613..ae1437b 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1087,7 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
>                 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>                 input_report_abs(input, ABS_X, le16_to_cpup((__le16
> *)&data[2]));
>                 input_report_abs(input, ABS_Y, le16_to_cpup((__le16
> *)&data[4]));
> -               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) <<
> 8) | data[6]);
> +               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x03) <<
> 8) | data[6]);
>                 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>                 input_report_key(input, wacom->tool[0], prox);
>                 return 1;
> --
> 1.8.5.3
>
>


-- 
Aaron Skomra
skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
503-208-5430

--20cf307abdab12ab3804f3677c04
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Aaron Skomra &lt;<a href=3D"mailto:Aaron.Skomra=
@wacom.com">Aaron.Skomra-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org</a>&gt;</div><div class=3D"gmail_extra">=
<br><br><div class=3D"gmail_quote">On Thu, Jan 30, 2014 at 10:48 AM, Jason =
Gerecke <span dir=3D"ltr">&lt;<a href=3D"mailto:killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targe=
t=3D"_blank">killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Some tablet PC sensors (e.g. the 0xEC found =
in the Thinkpad<br>
Yoga) report more than 256 pressure levels and will experience<br>
wraparound unless the full range is read.<br>
<br>
Signed-off-by: Jason Gerecke &lt;<a href=3D"mailto:killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ki=
llertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/input/tablet/wacom_wac.c | 2 +-<br>
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_=
wac.c<br>
index 9ff5613..ae1437b 100644<br>
--- a/drivers/input/tablet/wacom_wac.c<br>
+++ b/drivers/input/tablet/wacom_wac.c<br>
@@ -1087,7 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, data[1=
] &amp; 0x10);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpup=
((__le16 *)&amp;data[2]));<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpup=
((__le16 *)&amp;data[4]));<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, ((data[=
7] &amp; 0x01) &lt;&lt; 8) | data[6]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, ((data[=
7] &amp; 0x03) &lt;&lt; 8) | data[6]);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, data[1] =
&amp; 0x05);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, wacom-&gt;tool[0], =
prox);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.5.3<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr"><div>Aaron Skomra<br></div><div><a href=3D"mailto:skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br></div>503-208-5430<br></div>
</div>

--20cf307abdab12ab3804f3677c04--


--===============1490858217429971937==
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
--===============1490858217429971937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1490858217429971937==--
