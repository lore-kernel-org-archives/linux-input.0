From: Samuel Thibault <sthibault@debian.org>
Subject: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Sun, 24 Oct 2010 16:41:51 +0200
Message-ID: <20101024144150.GV24091@const.famille.thibault.fr>
References: <20100823154353.2805.13525.reportbug@tom.tse> <20100903235540.GA9149@const> <4C866913.3030201@triadsys.com> <4C8E6861.1070502@triadsys.com>
Reply-To: Samuel Thibault <sthibault@debian.org>, 594089@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.594089.B594089.128793131918775@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <4C8E6861.1070502@triadsys.com>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Tom Vier <tom@triadsys.com>
Cc: 594089@bugs.debian.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dtor@mail.ru
List-Id: linux-input@vger.kernel.org

The short story is: Tom's keyboard sends all that when he presses caps
lock:

press: 0x3a 0xe0 0x66
repeat: 0x3a
release: 0xba 0xe0 0xe6

0xe0 0x66 happens to be the "favorites" key on his keyboard with
internet navigation keys.  I thus believe there's a bug in his keyboard
that needs to be filtered at the kernel level.

The long story can be read on http://bugs.debian.org/cgi-bin/bugreport.cg=
i?bug=3D594089

Tom Vier, le Mon 13 Sep 2010 14:07:29 -0400, a =E9crit :
> Here's xev from Stable. It looks like in Testing that some of the extra=
=20
> key codes that show up in showkey are getting interpreted as additional=
=20
> key presses in Testing's xorg but not Stable's.

Yes, as I said in a previous mail, squeeze Xorg now interprets the
internet scancodes by default, while it wouldn't in lenny and previous,
thus not showing the bug.

Samuel
