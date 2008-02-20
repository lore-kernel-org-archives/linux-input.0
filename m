From: Johannes Berg <johannes@sipsolutions.net>
Subject: kernel segfault with evdev grab
Date: Wed, 20 Feb 2008 10:33:18 +0100
Message-ID: <1203499998.17534.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lkYzS/4efxxi4JAfQhy/"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:60347 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbYBTSav (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2008 13:30:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input <linux-input@vger.kernel.org>


--=-lkYzS/4efxxi4JAfQhy/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I just got the following:

[10744.820626] Unable to handle kernel paging request for data at address 0=
x6b6b6b6b
[10744.820632] Faulting instruction address: 0xc01b8f84
[10744.820647] Oops: Kernel access of bad area, sig: 11 [#1]
[10744.820652] PREEMPT PowerMac
[10744.820658] Modules linked in: ... [last unloaded: appletouch]
[10744.820761] NIP: c01b8f84 LR: c031cf98 CTR: 00000000
[10744.820767] REGS: eed8fd80 TRAP: 0300   Not tainted  (2.6.25-rc2-00261-g=
54a6132-dirty)
[10744.820774] MSR: 00001032 <ME,IR,DR>  CR: 24008482  XER: 00000000
[10744.820788] DAR: 6b6b6b6b, DSISR: 40000000
[10744.820793] TASK =3D eefb6000[3154] 'Xorg' THREAD: eed8e000
[10744.820798] GPR00: c031cf98 eed8fe30 eefb6000 eed8fe48 6b6b6b6b eecb0664=
 6b6b6b6b 00000025=20
[10744.820816] GPR08: 00000000 eecb0664 00000001 c0640000 24008488 101f85a4=
 10212a20 101f0724=20
[10744.820834] GPR16: 101f074c bfebc630 00000000 1021564c 1021524c 102152cc=
 1021554c bfebc3c4=20
[10744.820853] GPR24: 1021534c 101f0858 eed8fe48 eecb0664 eefb6000 eed8e000=
 00009032 eecb0650=20
[10744.820872] NIP [c01b8f84] __list_add+0x1c/0x7c
[10744.820884] LR [c031cf98] __mutex_lock_slowpath+0x7c/0x204
[10744.820892] Call Trace:
[10744.820896] [eed8fe30] [eed8e000] 0xeed8e000 (unreliable)
[10744.820907] [eed8fe40] [c031cf98] __mutex_lock_slowpath+0x7c/0x204
[10744.820917] [eed8fe90] [c024496c] input_release_device+0x24/0x48
[10744.820929] [eed8feb0] [f248712c] evdev_ungrab+0x4c/0x64 [evdev]
[10744.820941] [eed8fec0] [f248728c] evdev_release+0xec/0xf0 [evdev]
[10744.820953] [eed8fee0] [c009ea88] __fput+0xc8/0x1e0
[10744.820964] [eed8ff00] [c009b0e4] filp_close+0x5c/0xa4
[10744.820974] [eed8ff20] [c009b1bc] sys_close+0x90/0xf8
[10744.820984] [eed8ff40] [c0012328] ret_from_syscall+0x0/0x38


The reason is that I unloaded appletouch, which had an input device open
that was grabbed by Xorg. Now, when Xorg tried to release the input
device, the kernel segfaulted trying to access an invalidated mutex that
was in released memory (0x6b6b6b6b slab poison).

I think the problem will be solved by iterating the client_list in
evdev_disconnect() and calling evdev_ungrab() if any of them has sa
grab, rather than waiting for userspace to close the file handle.

johannes

--=-lkYzS/4efxxi4JAfQhy/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR7vz3aVg1VMiehFYAQJ1aA/+MvidIKSZtHFRFApWoFQG+g/Iswwwc7XP
owzIGLBPPNuywSywlC3o7KrQZE7RIdylji8btVBzRGquG/NKtr1bT5AIx7DlLYNs
N04qvSY+DWfo1zhY8RmSjZaIhcsGtZ8DyS826KEViBKXpSj0mbpxhf9D3OmandzZ
CX27FiRV4xhUQjrrHmlMjFttDGVglOhW9/R8LDDv1xAWEqEV+foln5lTy1a6xv8f
FrBCpoaIEj03eQZeQ9bkfR1nbeZItQcLOnD+lOtQZUp2TCx0ITgRrN1KIaNUnP54
EzL+bJpg3hEyR0FTN1PxbgJbVXggy+fvkgYtwY67+vnJmnQouXip+ecZ9nLY8vwV
lsSEnhBe7nWp/DWlZW9OAFL1mLovZvDCAY95hhbVkbBkADhqlad5/N1VI84vnv7A
BQNzGavlTzN86vQdW7IxjHmHwE+5qExHKRfnYnH41jzAyyYSCyTnlD3AcXv1/3PA
YnKJyGziZCyI6YwxU6oW+Pj7WDore8a4gCZIg87Zgz1DoWuVvM1HOx5SMwzzSm1Y
1nHUoDgJ8Otjr86SmMYyw605UeZfbVQ8pSDVDP2A94aeXvduBlJAzwpCvmUIePRH
/CS4IOMnMcbcDCUzqYJMgRU2aQkapj5O5nlap9dKf5OPFKIdQgSa8QwnWAaJBByK
2wzgxeefiGI=
=H8mC
-----END PGP SIGNATURE-----

--=-lkYzS/4efxxi4JAfQhy/--

