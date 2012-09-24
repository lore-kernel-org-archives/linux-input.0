From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Bug#685360: [PATCH 1/1] HID: Fix missing Unifying device issue
Date: Mon, 24 Sep 2012 11:30:28 +0200
Message-ID: <CAE7qMroQOxo7kci7roLbS5HXjpkyhRi=cj1WCoYtAPB328xNQg@mail.gmail.com>
References: <1348222894-6767-1-git-send-email-nlopezcasad@logitech.com> <20120923102318.GA12946@entuzijast.net>
Reply-To: Nestor Lopez Casado <nlopezcasad@logitech.com>, 685360@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=e89a8fb1ef18488c9b04ca6f3f96
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.685360.B685360.134847906114647@bugs.debian.org>
In-Reply-To: <20120923102318.GA12946@entuzijast.net>
List-URL: <http://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Josip Rodin <joy@debbugs.entuzijast.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 685360@bugs.debian.org, john.ettedgui@gmail.com, barz621@gmail.com, dh.herrmann@googlemail.com
List-Id: linux-input@vger.kernel.org

--e89a8fb1ef18488c9b04ca6f3f96
Content-Type: text/plain; charset=ISO-8859-1

Josip, this is a different issue from the one addressed with the patch.

1) Can you try it on a 3.2 kernel ?
2) The problem you describe, does it happen all the time ?

Thanks,
Nestor.

On Sun, Sep 23, 2012 at 12:23 PM, Josip Rodin <joy@debbugs.entuzijast.net>wrote:

> On Fri, Sep 21, 2012 at 12:21:34PM +0200, Nestor Lopez Casado wrote:
> > This patch fixes an issue introduced after commit 4ea5454203d991ec
> >
> > After that commit, hid-core silently discards any incoming packet
> > that arrives while any hid driver's probe function is being executed.
>
> I managed to test this now, on top of Linux 3.5, but it didn't fix my
> keyboard. I still get the same sequence of messages with hid.debug=1:
>
> +usb 5-2: new full-speed USB device number 3 using ohci_hcd
> +drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
> +drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 0
> +drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 0
> +drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
> +drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 1
> +drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 1
> +drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 2
> +drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 2
> +drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report
> wValue=0x0110 wIndex=0x0002 wLength=7
> +drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report
> wValue=0x0111 wIndex=0x0002 wLength=20
> +drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report
> wValue=0x0120 wIndex=0x0002 wLength=15
> +drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report
> wValue=0x0121 wIndex=0x0002 wLength=32
> +logitech-djreceiver 0003:046D:C52B.0005: claimed by neither input, hiddev
> nor hidraw
> +logitech-djreceiver 0003:046D:C52B.0005: logi_dj_probe:hid_hw_start
> returned error
>
> --
>      2. That which causes joy or happiness.
>

--e89a8fb1ef18488c9b04ca6f3f96
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Josip, this is a different issue from the one addressed with the patch.<div=
><br></div><div>1) Can you try it on a 3.2 kernel ?</div><div>2) The proble=
m you describe, does it happen all the time ?</div><div><br></div><div>Than=
ks,=A0</div>

<div>Nestor.=A0<br><br><div class=3D"gmail_quote">On Sun, Sep 23, 2012 at 1=
2:23 PM, Josip Rodin <span dir=3D"ltr">&lt;<a href=3D"mailto:joy@debbugs.en=
tuzijast.net" target=3D"_blank">joy@debbugs.entuzijast.net</a>&gt;</span> w=
rote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, Sep 21, 2012 at 12=
:21:34PM +0200, Nestor Lopez Casado wrote:<br>
&gt; This patch fixes an issue introduced after commit 4ea5454203d991ec<br>
&gt;<br>
&gt; After that commit, hid-core silently discards any incoming packet<br>
&gt; that arrives while any hid driver&#39;s probe function is being execut=
ed.<br>
<br>
</div>I managed to test this now, on top of Linux 3.5, but it didn&#39;t fi=
x my<br>
keyboard. I still get the same sequence of messages with hid.debug=3D1:<br>
<br>
+usb 5-2: new full-speed USB device number 3 using ohci_hcd<br>
+drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0<br>
+drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 0<br>
+drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 0<br>
+drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1<br>
+drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 1<br>
+drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 1<br>
+drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 2<br>
+drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 2<br>
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0x=
0110 wIndex=3D0x0002 wLength=3D7<br>
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0x=
0111 wIndex=3D0x0002 wLength=3D20<br>
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0x=
0120 wIndex=3D0x0002 wLength=3D15<br>
+drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0x=
0121 wIndex=3D0x0002 wLength=3D32<br>
+logitech-djreceiver 0003:046D:C52B.0005: claimed by neither input, hiddev =
nor hidraw<br>
+logitech-djreceiver 0003:046D:C52B.0005: logi_dj_probe:hid_hw_start return=
ed error<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
=A0 =A0 =A02. That which causes joy or happiness.<br>
</font></span></blockquote></div><br></div>

--e89a8fb1ef18488c9b04ca6f3f96--
