From: =?UTF-8?Q?S=C3=A9bastien?= Dinot <sebastien.dinot@free.fr>
Subject: Bug#689368: Mouse and keyboard freeze on Ivy Bridge platform
Date: Thu, 4 Oct 2012 23:36:06 +0200
Message-ID: <20121004213606.GA8409@dinot.net>
References: <20121004194347.GB6927@dinot.net>
 <Pine.LNX.4.44L0.1210041654550.1441-100000@iolanthe.rowland.org>
Reply-To: =?UTF-8?Q?S=C3=83=C2=A9bastien?= Dinot <sebastien.dinot@free.fr>, 689368@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.689368.B689368.134938657731904@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1210041654550.1441-100000@iolanthe.rowland.org>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, 689368@bugs.debian.org
List-Id: linux-input@vger.kernel.org

Alan Stern a =C3=A9crit :
> The log file shows lots and lots of low-level communication errors.
> They could be caused by bad cabling or by bad USB hardware in your
> computer. It's unlikely that they were caused by the mouse or
> keyboard, because the log shows errors for both of them starting at
> exactly the same times.

In my humble opinion, this issue is not caused by a bad USB hardware
because I am encountering it with two different motherboards (MSI
Z77A-G43 and ASUS P8Z77-V LX), both with an uptodate BIOS.

May be it is caused by a bad cabling but my mouse and my keyboard worked
fine with my previous PC. They are connected to USB2 ports in both
cases. But to clear up this point, I will try new mouse and keyboard.

A last question: if it is a cable failure, why does it disappear
temporarily when I unload then reload the module? I do not have deep
experience and knowledge of hardware, may be there is a rational
explanation to it.

> You could try getting a USB-2 hub and attaching your mouse and
> keyboard through the hub. That might help ... or it might not.

Sorry, I do not understand the aim of this operation. Could you explain
me it?

Thanks for your help,

S=C3=A9bastien

--=20
S=C3=A9bastien Dinot, sebastien.dinot@free.fr
http://sebastien.dinot.free.fr/
Ne go=C3=BBtez pas au logiciel libre, vous ne pourriez plus vous en passe=
r !
