From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: sysfs change of input/event devices in 2.6.23rc breaks udev
Date: Sat, 8 Sep 2007 23:46:47 +0400
Message-ID: <200709082346.53956.arvidjaar@mail.ru>
References: <46E2D712.1010402@gmail.com> <20070908182928.5AEAA402B15@smtp03.mtu.ru> <46E2FA3F.7050000@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5213425.UgdHdkh6qf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46E2FA3F.7050000@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-hotplug-devel@lists.sourceforge.net, michal.k.k.piotrowski@gmail.com
Cc: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart5213425.UgdHdkh6qf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 08 September 2007, Anssi Hannula wrote:
> Andrey Borzenkov wrote:
> > Anssi Hannula wrote:
> >> Hi!
> >>
> >> There seem to be changes in sysfs input structure between 2.6.22 and
> >> 2.6.23-rc5 which cause some breakage.
>
> [...]
>
> >> There is no longer:
> >> /sys/class/input/eventX =3D> /sys/class/input/inputX/eventX
> >> instead there is:
> >> /sys/class/inputX/input:eventX =3D> /sys/class/input/eventX
> >> Notice the added "input:". I don't know if any software depends on thi=
s,
> >> though.
> >>
> >> However, the change that broke id_path of udev is that
> >> /sys/class/input/event5/device is now a symlink to the inputX directory
> >> instead of being the same as the device symlink in inputX directory,
> >> i.e. to ../../../devices/platform/pcspkr in this case.
> >>
> >> Udev id_path uses that directory to construct the ID_PATH variable.
> >> Should the sysfs structure be reverted or should udev be adapted to
> >> handle traversing /device symlink twice? I think the former, as there
> >> should be considerably more time to adapt udev for coming changes in
> >> sysfs.
> >
> > I am using 2.6.23-rc5 in current cooker
>
> Same kernel here, but on an older system (MDV2007.1). I tested with a
> path_id from a recent udev as well, though, but the problem was there as
> well.
>
> > and I did not notice any breakage;
> > could you please show example of wrong path? E.g. I have
> >
> > {pts/0}% LC_ALL=3DC ll /dev/input/by-path
> > total 0
> > lrwxrwxrwx 1 root root 9 Sep  2 15:00
> > platform-i8042-serio-0-event-kbd -> ../event0
> > lrwxrwxrwx 1 root root 9 Sep  2 15:00
> > platform-i8042-serio-1-event-mouse -> ../event1
> > lrwxrwxrwx 1 root root 9 Sep  2 15:00
> > platform-i8042-serio-1-mouse -> ../mouse0
> >
> > and it looks pretty sane for me.
>
> I don't have anything under /dev/input/by-path as the lookup in path_id
> fails.
>
> > Oh, and I do not have CONFIG_SYSFS_DEPRECATED which probably explains w=
hy
> > it works for me :)
>
> Probably.
>
> > {pts/0}% LC_ALL=3DC ll /sys/class/input/input2/
> > total 0
> > drwxr-xr-x 2 root root    0 Sep  8 22:25 capabilities/
> > drwxr-xr-x 3 root root    0 Sep  8 22:22 event2/
> > drwxr-xr-x 2 root root    0 Sep  8 22:25 id/
> > -r--r--r-- 1 root root 4096 Sep  8 22:25 modalias
> > -r--r--r-- 1 root root 4096 Sep  8 22:25 name
> > -r--r--r-- 1 root root 4096 Sep  8 22:25 phys
> > drwxr-xr-x 2 root root    0 Sep  8 22:25 power/
> > lrwxrwxrwx 1 root root    0 Sep  8 22:25
> > subsystem -> ../../../../class/input/
> > -rw-r--r-- 1 root root 4096 Sep  8 22:25 uevent
> > -r--r--r-- 1 root root 4096 Sep  8 22:25 uniq
>
> What does this print as devpath for you:
> $ udevinfo -q all --name=3Dinput/event0
>

{pts/1}% udevinfo -q all --name input/event0
P: /devices/platform/i8042/serio0/input/input0/event0
N: input/event0
S: input/by-path/platform-i8042-serio-0-event-kbd
E: ID_CLASS=3Dkbd
E: ID_SERIAL=3Dnoserial
E: ID_PATH=3Dplatform-i8042-serio-0

> For me on 2.6.23rc5 it prints:
> P: /class/input/event0
> and on 2.6.22:
> P: /class/input/input0/event0
>
> Both are detected as "old sysfs layout" by path_id, but only on 2.6.22
> is there a /device symlink pointing to the expected location.
>
> I suspect it prints something like /devices/xyz for you, right?
> That seems to be detected as "new sysfs layout" by path_id and handled
> differently.
>
> > this implies that SYSFS_DEPRECATED may be broken w.r.t. udev; OTOH it
> > *is* deprecated, is not it?
>
> Indeed, at least regarding input subsystem, for which there was a recent
> switchover [1] from class_device.
>

If this does not work with current udev this can be considred kernel=20
regression as far as I can tell.

=2Dandrey

> [1]
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdi
>ff;h=3D9657d75c5f0f7d0a9cb507521d3ad1436aea28c9



--nextPart5213425.UgdHdkh6qf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBG4vwoR6LMutpd94wRAnBdAJ9pOVwI8NbdslYRqkww4MrZjHuv2gCghtYk
Xe/bCkNJE4pJlvPie5e18JY=
=wiyg
-----END PGP SIGNATURE-----

--nextPart5213425.UgdHdkh6qf--
