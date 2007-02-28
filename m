From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PROBLEM: "BUG:" when resuming from suspend-to-ram
Date: Wed, 28 Feb 2007 13:45:14 +0100
Message-ID: <200702281345.15098.rjw@sisk.pl>
References: <1172601905.5428.28.camel@localhost.localdomain> <200702272330.22968.rjw@sisk.pl> <1172622441.4587.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1172622441.4587.14.camel@localhost.localdomain>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristian =?iso-8859-15?q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wednesday, 28 February 2007 01:27, Kristian Gr=F8nfeldt S=F8rensen wrote:
> On Tue, 2007-02-27 at 23:30 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, 27 February 2007 23:04, Rafael J. Wysocki wrote:
> > > Hi,
> > >=20
> > > On Tuesday, 27 February 2007 19:45, Kristian Gr=F8nfeldt S=F8rensen w=
rote:
> > > > Hi.
> > > >=20
> > > > PROBLEM: "BUG:" when resumimg from suspend-to-ram=20
> > > > =09
> > > > My laptop have a problem with resuming from suspend-to-ram.=20
> > > > It does not occur every time - most of the time, resume works witho=
ut
> > > > any problem.at all.
> > > >=20
> > > > After it occurs, the laptop refuses to go into suspend-to-ram mode =
until
> > > > next reboot.
> > >=20
> > > What do you mean by "refuses"?  Are there any suspicious messages in
> > > dmesg?
> > >=20
> > > > The system is a Debian unstable running with a self-compiled 2.6.20
> > > > kernel downloaded from kernel.org.=20
> > > >=20
> > > > I've only tried suspend-to-ram on 2.6.20 so I don't know whether or=
 not
> > > > other versions might have the same problem.
> > > >=20
> > > > I'm not subscribed to the list. Please CC me.
> > >=20
> > > I guess one of the drivers you use goes awry at some point.  Please p=
rovide
> > > us with more information (like dmesg output after a failing resume).
> >=20
> > I'm sorry, I've just been told you sent it. :-)
> >=20
> > > CLASS: Unregistering class device. ID =3D 'event3'
> > > class_uevent - name =3D event3
> > > class_device_create_uevent called for event3
> > > device class 'event3': release.
> > > class_device_create_release called for event3
> > > BUG: unable to handle kernel paging request at virtual address 6b6b6b=
6b
> > >  printing eip:
> > > f8825a81
> > > *pde =3D 00000000
> > > Oops: 0000 [#1]
> > > PREEMPT
> > > Modules linked in: tg3 battery ac thermal fan button i915 drm binfmt_=
misc
> > > rfcomm l2cap ipv6 fuse capability commoncap cpufreq_performance aoe
> > > af_packet nls_utf8 ntfs nls_iso8859_1 nls_cp437 vfat fat dm_snapshot
> > > dm_mirror dm_mod ieee80211_cr ypt_tkip ieee80211_crypt pd6729 snd_seq=
_dummy
> > > snd_seq_oss snd_seq_midi snd_rawmi di snd_seq_midi_event snd_seq
> > > snd_seq_device sermouse hci_vhci hci_uart wbsd mmc _block mmc_core tu=
n msr
> > > cpuid cpufreq_stats container video speedstep_lib speeds tep_centrino
> > > processor sr_mod sbp2 scsi_mod ide_cd cdrom eth1394 hci_usb bluetoo th
> > > pcmcia firmware_class irda snd_intel8x0m snd_intel8x0 snd_ac97_codec
> > > crc_ccit t ac97_bus snd_pcm_oss snd_mixer_oss rtc i2c_i801 snd_pcm
> > > snd_timer ohci1394 iee e1394 i2c_core serio_raw intel_agp iTCO_wdt snd
> > > soundcore snd_page_alloc ehci_hc d pcspkr uhci_hcd yenta_socket
> > > rsrc_nonstatic pcmcia_core usbcore agpgart moused ev evdev
> > > CPU:    0
> > > EIP:    0060:[<f8825a81>]    Not tainted VLI
> > > EFLAGS: 00010202   (2.6.20-x300 #1)
> > > EIP is at evdev_disconnect+0xb1/0xe0 [evdev]
> >=20
> > This points us to a suspect.  Can you please run "gdb vmlinux" against =
the
> > vmlinux in your kernel sources directory and then
> >=20
> > gdb> l *evdev_disconnect+0xb1
>=20
> OK. Recopiled the kernel with CONFIG_DEBUG_INFO=3Dy
>=20
> This gives:=20
>=20
> (gdb) l *evdev_disconnect+0xb1
> No symbol "evdev_disconnect" in current context.
>=20
> I guess you meant gdb drivers/input/evdev.ko

Yes, exactly.

> This gives:
>=20
> (gdb) l *evdev_disconnect+0xb1
> 0xa81 is in evdev_disconnect (include/asm/processor.h:716).
> 711        However we don't do prefetches for pre XP Athlons currently
> 712        That should be fixed. */
> 713     #define ARCH_HAS_PREFETCH
> 714     static inline void prefetch(const void *x)
> 715     {
> 716             alternative_input(ASM_NOP4,
> 717                               "prefetchnta (%1)",
> 718                               X86_FEATURE_XMM,
> 719                               "r" (x));
> 720     }

Hm, interesting.  Looks like a pointer points to nowhere in
input_unregister_device(), but I don't know which one.  This may be
an evdev problem ...

Rafael
