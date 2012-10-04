From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Bug#689368: Mouse and keyboard freeze on Ivy Bridge platform
Date: Thu, 4 Oct 2012 15:59:21 -0700
Message-ID: <20121004225921.GA25847@xanatos>
References: <20121004194347.GB6927@dinot.net>
 <Pine.LNX.4.44L0.1210041654550.1441-100000@iolanthe.rowland.org>
 <20121004213606.GA8409@dinot.net>
Reply-To: Sarah Sharp <sarah.a.sharp@linux.intel.com>, 689368@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.689368.B689368.13493922567374@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20121004213606.GA8409@dinot.net>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: =?UTF-8?Q?S=C3=A9bastien?= Dinot <sebastien.dinot@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, 689368@bugs.debian.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 04, 2012 at 11:36:06PM +0200, S=E9bastien Dinot wrote:
> Alan Stern a =E9crit :
> > The log file shows lots and lots of low-level communication errors.
> > They could be caused by bad cabling or by bad USB hardware in your
> > computer. It's unlikely that they were caused by the mouse or
> > keyboard, because the log shows errors for both of them starting at
> > exactly the same times.
>=20
> In my humble opinion, this issue is not caused by a bad USB hardware
> because I am encountering it with two different motherboards (MSI
> Z77A-G43 and ASUS P8Z77-V LX), both with an uptodate BIOS.
>=20
> May be it is caused by a bad cabling but my mouse and my keyboard worke=
d
> fine with my previous PC. They are connected to USB2 ports in both
> cases. But to clear up this point, I will try new mouse and keyboard.
>=20
> A last question: if it is a cable failure, why does it disappear
> temporarily when I unload then reload the module? I do not have deep
> experience and knowledge of hardware, may be there is a rational
> explanation to it.
>=20
> > You could try getting a USB-2 hub and attaching your mouse and
> > keyboard through the hub. That might help ... or it might not.
>=20
> Sorry, I do not understand the aim of this operation. Could you explain
> me it?

Sometimes USB 2.0 hubs can handle more electrical noise from the host
controller, especially if they are externally powered by a wall-wort.
So introducing a USB 2.0 hub may fix the transfer errors caused by the
host.

BTW, do these Ivy Bridge systems have any (blue) USB 3.0 ports?  If so,
does your mouse and keyboard work under those ports?

Sarah Sharp


--=20
To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian=
.org
Archive: http://lists.debian.org/20121004225921.GA25847@xanatos
