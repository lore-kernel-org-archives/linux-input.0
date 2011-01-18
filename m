From: "W.A. GOOSSENS" <waltergoossens-CmkmPbn3yAE@public.gmane.org>
Subject: Antw:Re: [PATCH] alter_ps2: Add devicetree support
Date: Tue, 18 Jan 2011 16:25:37 +0100
Message-ID: <72c0b97741a709.4d35bf01@home.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6332131897944415996=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Language: nl
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--===============6332131897944415996==
Content-Language: nl
Content-Type: text/html; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=3Cdiv style=3D=22font-family=3A =27Times New Roman=27=3B font-size=3A 1=
6px=3B =22=3E=3Cdiv=3E=3Cbr /=3E=3C/div=3E=3Cdiv=3E=3Cbr /=3E=3C/div=3E=3C=
div=3EOp 18/01/11=2C =3Cb class=3D=22name=22=3EThomas Chou =3C/b=3E =26l=
t=3Bthomas=40wytron=2Ecom=2Etw=26gt=3B schreef=3A =3C/div=3E=3Cblockquot=
e cite=3D=22mid=3A4D35A307=2E5070706=40wytron=2Ecom=2Etw=22 class=3D=22i=
wcQuote=22 style=3D=22border-left=3A 1px solid =2300F=3B padding-left=3A=
 13px=3B margin-left=3A 0=3B=22 type=3D=22cite=22=3E=3Cdiv class=3D=22mi=
mepart text plain=22=3EOn 01/18/2011 07=3A27 AM=2C Walter Goossens wrote=
=3A=3Cbr /=3E=26gt=3B=26gt=3Bso=2C instead of trying to us a =27generic=27=
 value like =26quot=3Baltera=2Caltera=5Fps2=26quot=3B=3Cbr /=3E=26gt=3B=26=
gt=3Bwhich has a bunch of ambiguity about which hardware actually=3Cbr /=
=3E=26gt=3B=26gt=3Bimplements the behaviour=2C the values =26quot=3Balte=
ra=2Caltera=5Fps2-1=26quot=3B and=3Cbr /=3E=26gt=3B=26gt=3B=26quot=3Balt=
era=2Caltera=5Fps2-3=26quot=3B become the de-facto =27generic=27 values =
without any=3Cbr /=3E=26gt=3B=26gt=3Bmessiness or ambiguity about what t=
hey mean=2E=3Cbr /=3E=26gt=3B=26gt=3B=3Cbr /=3E=26gt=3B=26gt=3BPlus=2C e=
ach =2Edts file still specifies the exact version that is=3Cbr /=3E=26gt=
=3B=26gt=3Bimplemented on the board so that the driver can still fixup=3C=
br /=3E=26gt=3B=26gt=3Bversion-specific bugs if any are discovered in th=
e future=2E=3Cbr /=3E=26gt=3B=26gt=3B=3Cbr /=3E=26gt=3BAhh ok=2E=3Cbr /=3E=
=26gt=3BThat does look like a good solution=2E I=27ll try and cook somet=
hing up for=3Cbr /=3E=26gt=3Bthat=2E=3Cbr /=3E=3Cbr /=3EHi Walter=2C=3Cb=
r /=3E=3Cbr /=3ECan we use =26quot=3Bkind=26quot=3B and =26quot=3Bversio=
n=26quot=3B attribute of a sopcinfo file to build the match string=3F Th=
is way=2C your dts converter won=27t need update for each new component=2E=
=3Cbr /=3E=3Cbr /=3Eeg=2C=3Cbr /=3E=3Cbr /=3Ekind=3D=26quot=3Baltera=5Fa=
valon=5Fspi=26quot=3B version=3D=26quot=3B9=2E0=26quot=3B =3D=3D=26gt=3B=
 =26quot=3Baltera=26quot=3B=2C=26quot=3Bavalon-spi-9=2E0=26quot=3B=3Cbr =
/=3E=3Cbr /=3Ekind=3D=26quot=3Baltera=5Fup=5Favalon=5Fps2=5Fclassic=26qu=
ot=3B version=3D=26quot=3B6=2E1=26quot=3B =3D=3D=26gt=3B=3Cbr /=3E=A0 =26=
quot=3Baltera=26quot=3B=2C=26quot=3Bup-avalon-ps2-classic-6=2E1=26quot=3B=
=3Cbr /=3E=3C/div=3E=3C/blockquote=3E=3Cdiv=3EYes I am working on adding=
 the version stuff=2E I can not blindly =A0copy the =26quot=3Bkind=26quo=
t=3B string to the dts=2E One reason is that the names would become a bi=
t too long=2C another reason is the fact that I can not blinbdly prepent=
 =26quot=3Baltera=26quot=3B to all components created in sopcbuilder sin=
ce a lot of components are created by other parties=2E=3C/div=3E=3Cdiv=3E=
Further more components can be used on multiple platforms where and the =
component names would not always be the same=2E The opencores i2c and op=
encore ethernet cores are examples of cpres that can work with a microbl=
aze as well and chances are their naming will be different=2E=A0=3C/div=3E=
=3Cdiv=3EI can however create a =26quot=3Bfallback=26quot=3B rule were u=
nkown components are just added with the names the sopcinfo file=2C but =
that should not be the default in my opinion since this will very effect=
ively polute the namespace in an uncontrolable way=2E=3C/div=3E=3Cdiv=3E=
=3Cbr /=3E=3C/div=3E=3Cdiv=3EWalter=3C/div=3E=3Cblockquote cite=3D=22mid=
=3A4D35A307=2E5070706=40wytron=2Ecom=2Etw=22 class=3D=22iwcQuote=22 styl=
e=3D=22border-left=3A 1px solid =2300F=3B padding-left=3A 13px=3B margin=
-left=3A 0=3B=22 type=3D=22cite=22=3E=3Cdiv class=3D=22mimepart text pla=
in=22=3E=3Cbr /=3E- Thomas=3Cbr /=3E=3C/div=3E=3C/blockquote=3E=3C/div=3E

--===============6332131897944415996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6332131897944415996==--
