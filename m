From: Aaron Armstrong Skomra <skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] Input: wacom: Override
	'pressure_max' with value from HID_USAGE_PRESSURE
Date: Thu, 27 Feb 2014 10:27:53 -0800
Message-ID: <CAEoswT2+6gnWneAWnKp6KfT1dU_uiMhVku2Xxq25dpYKuaxJkw@mail.gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
	<1391107728-1306-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6479199249915809824=="
Return-path: <linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1391107728-1306-2-git-send-email-killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============6479199249915809824==
Content-Type: multipart/alternative; boundary=047d7b6dbd9abf03b304f3677ac3

--047d7b6dbd9abf03b304f3677ac3
Content-Type: text/plain; charset=ISO-8859-1

Tested-by: Aaron Skomra <Aaron.Skomra-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org>


On Thu, Jan 30, 2014 at 10:48 AM, Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> The 0xEC sensor is used in multiple tablet PCs and curiously has
> versions that report 256 levels of pressure (Samsung Slate 7)
> as well as versions that report 1024 levels (Lenovo Thinkpad Yoga).
> To allow both versions to work properly, we allow the value of
> HID_USAGE_PRESSURE reported to override pressure_max.
>
> Signed-off-by: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/tablet/wacom_sys.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/input/tablet/wacom_sys.c
> b/drivers/input/tablet/wacom_sys.c
> index 5be6177..611fc39 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -24,6 +24,7 @@
>  #define HID_USAGE                      0x09
>  #define HID_USAGE_X                    ((HID_USAGE_PAGE_DESKTOP << 16) |
> 0x30)
>  #define HID_USAGE_Y                    ((HID_USAGE_PAGE_DESKTOP << 16) |
> 0x31)
> +#define HID_USAGE_PRESSURE             ((HID_USAGE_PAGE_DIGITIZER << 16)
> | 0x30)
>  #define HID_USAGE_X_TILT               ((HID_USAGE_PAGE_DIGITIZER << 16)
> | 0x3d)
>  #define HID_USAGE_Y_TILT               ((HID_USAGE_PAGE_DIGITIZER << 16)
> | 0x3e)
>  #define HID_USAGE_FINGER               ((HID_USAGE_PAGE_DIGITIZER << 16)
> | 0x22)
> @@ -465,6 +466,14 @@ static int wacom_parse_hid(struct usb_interface *intf,
>                                         wacom_retrieve_report_data(intf,
> features);
>                                 i++;
>                                 break;
> +
> +                       case HID_USAGE_PRESSURE:
> +                               if (pen) {
> +                                       features->pressure_max =
> +
> get_unaligned_le16(&report[i + 3]);
> +                                       i += 4;
> +                               }
> +                               break;
>                         }
>                         break;
>
> --
> 1.8.5.3
>
>


-- 
Aaron Skomra
skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
503-208-5430

--047d7b6dbd9abf03b304f3677ac3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Aaron Skomra &lt;<a href=3D"mailto:Aaron.Skomra=
@wacom.com">Aaron.Skomra-JeGq9vS6aD4AvxtiuMwx3w@public.gmane.org</a>&gt;</div><div class=3D"gmail_extra">=
<br><br><div class=3D"gmail_quote">On Thu, Jan 30, 2014 at 10:48 AM, Jason =
Gerecke <span dir=3D"ltr">&lt;<a href=3D"mailto:killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targe=
t=3D"_blank">killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The 0xEC sensor is used in multiple tablet P=
Cs and curiously has<br>
versions that report 256 levels of pressure (Samsung Slate 7)<br>
as well as versions that report 1024 levels (Lenovo Thinkpad Yoga).<br>
To allow both versions to work properly, we allow the value of<br>
HID_USAGE_PRESSURE reported to override pressure_max.<br>
<br>
Signed-off-by: Jason Gerecke &lt;<a href=3D"mailto:killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ki=
llertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=A0drivers/input/tablet/wacom_sys.c | 9 +++++++++<br>
=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_=
sys.c<br>
index 5be6177..611fc39 100644<br>
--- a/drivers/input/tablet/wacom_sys.c<br>
+++ b/drivers/input/tablet/wacom_sys.c<br>
@@ -24,6 +24,7 @@<br>
=A0#define HID_USAGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x09<br>
=A0#define HID_USAGE_X =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((HID_USAGE_P=
AGE_DESKTOP &lt;&lt; 16) | 0x30)<br>
=A0#define HID_USAGE_Y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((HID_USAGE_P=
AGE_DESKTOP &lt;&lt; 16) | 0x31)<br>
+#define HID_USAGE_PRESSURE =A0 =A0 =A0 =A0 =A0 =A0 ((HID_USAGE_PAGE_DIGITI=
ZER &lt;&lt; 16) | 0x30)<br>
=A0#define HID_USAGE_X_TILT =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((HID_USAGE_PAGE_DI=
GITIZER &lt;&lt; 16) | 0x3d)<br>
=A0#define HID_USAGE_Y_TILT =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((HID_USAGE_PAGE_DI=
GITIZER &lt;&lt; 16) | 0x3e)<br>
=A0#define HID_USAGE_FINGER =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((HID_USAGE_PAGE_DI=
GITIZER &lt;&lt; 16) | 0x22)<br>
@@ -465,6 +466,14 @@ static int wacom_parse_hid(struct usb_interface *intf,=
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 wacom_retrieve_report_data(intf, features);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_USAGE_PRESSURE:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pen) {<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 features-&gt;pressure_max =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 get_unaligned_le16(&amp;report[i + 3]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 i +=3D 4;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.8.5.3<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr"><div>Aaron Skomra<br></div><div><a href=3D"mailto:skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">skomra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br></div>503-208-5430<br></div>
</div>

--047d7b6dbd9abf03b304f3677ac3--


--===============6479199249915809824==
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
--===============6479199249915809824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6479199249915809824==--
