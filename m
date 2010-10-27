From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Wed, 27 Oct 2010 08:06:26 -0700
Message-ID: <99F91536-4413-430C-9932-7CEF6AB656DB@gmail.com>
References: <4C866913.3030201@triadsys.com> <4C8E6861.1070502@triadsys.com> <20101024144150.GV24091@const.famille.thibault.fr> <20101025045003.GA1438@core.coreip.homeip.net> <4CC58816.3090301@triadsys.com> <20101025180320.GA4725@const.famille.thibault.fr> <4CC6E9D8.8010201@triadsys.com> <20101026161820.GE13097@core.coreip.homeip.net> <4CC7426C.8040502@triadsys.com> <20101027091029.GB28895@core.coreip.homeip.net> <20101027120513.GT4725@const.famille.thibault.fr>
Reply-To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 594089@bugs.debian.org
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: multipart/alternative;
	boundary=Apple-Mail-3-647148214
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.594089.B594089.128819202414660@bugs.debian.org>
In-Reply-To: <20101027120513.GT4725@const.famille.thibault.fr>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Samuel Thibault <sthibault@debian.org>
Cc: Tom Vier <tom@triadsys.com>, "594089@bugs.debian.org" <594089@bugs.debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org


--Apple-Mail-3-647148214
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Oct 27, 2010, at 5:05 AM, Samuel Thibault <sthibault@debian.org> wrote:

> Dmitry Torokhov, le Wed 27 Oct 2010 02:10:29 -0700, a =C3=A9crit :
>> Also, based on evtest data I only see presses/releases for one key (Caps
>> Lock, Right Shift, etc.) I do not see the presses for the additional
>> keys in the evtest stream so I am baffled as to where the additional
>> scancode is coming from... Do you have some funky keymap loaded?
>> Anything interesting in dumpkeys?
>=20
> Err, since the duplicates appear in scancodes already, is the content of
> dumpkeys really involved?
>=20

Evtest data does not show any additional events, so the additional scancodes=
 must be coming from the legacy keyboard driver.=20

--=20
Dmitry



--Apple-Mail-3-647148214
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body bgcolor=3D"#FFFFFF"><div><span class=3D"Apple-style-span" style=3D=
"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-compositio=
n-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color=
: rgba(77, 128, 180, 0.230469); ">On Oct 27, 2010, at 5:05 AM, Samuel Thibau=
lt &lt;<a href=3D"mailto:sthibault@debian.org">sthibault@debian.org</a>&gt; w=
rote:</span><br></div><div><br></div><div></div><blockquote type=3D"cite"><d=
iv><span>Dmitry Torokhov, le Wed 27 Oct 2010 02:10:29 -0700, a =C3=A9crit :<=
/span><br><blockquote type=3D"cite"><span>Also, based on evtest data I only s=
ee presses/releases for one key (Caps</span><br></blockquote><blockquote typ=
e=3D"cite"><span>Lock, Right Shift, etc.) I do not see the presses for the a=
dditional</span><br></blockquote><blockquote type=3D"cite"><span>keys in the=
 evtest stream so I am baffled as to where the additional</span><br></blockq=
uote><blockquote type=3D"cite"><span>scancode is coming from... Do you have s=
ome funky keymap loaded?</span><br></blockquote><blockquote type=3D"cite"><s=
pan>Anything interesting in dumpkeys?</span><br></blockquote><span></span><b=
r><span>Err, since the duplicates appear in scancodes already, is the conten=
t of</span><br><span>dumpkeys really involved?</span><br><font class=3D"Appl=
e-style-span" color=3D"#000000"><font class=3D"Apple-style-span" color=3D"#0=
023A3"><br></font></font></div></blockquote><div><br></div>Evtest data does n=
ot show any additional events, so the additional scancodes must be coming fr=
om the legacy keyboard driver.&nbsp;<br><span class=3D"Apple-style-span" sty=
le=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-compo=
sition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-=
color: rgba(77, 128, 180, 0.230469); "><div><br><div>--&nbsp;</div>Dmitry<di=
v><br></div></div><div><br></div></span></body></html>=

--Apple-Mail-3-647148214--
