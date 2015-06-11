From: Samuel Thibault <sthibault@debian.org>
Subject: Bug#514464: caps lock led does not show up
Date: Thu, 11 Jun 2015 16:28:03 +0200
Message-ID: <20150611142803.GA3056@type.access.network>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
 <20150609141723.GE3045@type>
 <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
 <20150611080809.GD3184@type.bordeaux.inria.fr>
Reply-To: Samuel Thibault <sthibault@debian.org>, 514464@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-boot=debian-boot=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.514464.B514464.143403289022549@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20150611080809.GD3184@type.bordeaux.inria.fr>
List-URL: <http://lists.debian.org/debian-boot/>
List-Post: <mailto:debian-boot@lists.debian.org>
List-Help: <mailto:debian-boot-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-boot-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-boot-request@lists.debian.org?subject=unsubscribe>
To: Anton Zinoviev <anton@lml.bas.bg>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Pali =?UTF-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 514464@bugs.debian.org
List-Id: linux-input@vger.kernel.org

Samuel Thibault, le Thu 11 Jun 2015 10:08:09 +0200, a =E9crit :
> Putting
>=20
> SUBSYSTEM=3D=3D"leds", ENV{DEVPATH}=3D=3D"*/input*::capslock", ATTR{tri=
gger}=3D"kbd-ctrlllock"
>=20
> in /etc/udev/rules.d/50-leds.rules seems to be doing the work.

Except that it makes my system unbootable. For whatever reason, systemd
indefinitely waits for the network to become available...

Samuel


--=20
To UNSUBSCRIBE, email to debian-boot-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian=
.org
Archive: https://lists.debian.org/20150611142803.GA3056@type.access.netwo=
rk
