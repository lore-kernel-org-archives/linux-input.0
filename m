From: Reinis Danne <rei4dan@gmail.com>
Subject: [RFC] tty: kb_value with flags for better Unicode support
Date: Fri, 26 Apr 2019 13:52:24 +0300
Message-ID: <20190426105224.GB11020@rd-oc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, kbd@lists.altlinux.org
List-Id: linux-input@vger.kernel.org

Compliment already existing kbdiacruc and kbdiacrsuc structs and
KD[GS]KBDIACRUC ioctls with Unicode equivalents for kb_value, kbentry and
KD[GS]KBENT ioctls.

```
struct kb_valueuc {
	__u32 flags;		/* 15 used by KTYP */
	__u32 kb_valueuc;	/* Unicode range: 0x0–0x10ffff */
};

struct kbentryuc {
	__u32 kb_table;
	__u32 kb_index;
	struct kb_valueuc;
};

extern kb_valueuc *key_maps[MAX_NR_KEYMAPS];

#define KDGKBENTUC	0x????	/* get one entry in translation table */
#define KDSKBENTUC	0x????	/* set one entry in translation table */
```

Motivation
==========

Since I learned touchtyping, I want to have the same keyboard layout in VT as I
have in X.  So I wrote a keymap file for Latvian (modern) keyboard layout [1]
to use with the kbd package and it works, mostly.

I have three issues:
- Compose sequences with base above Latin-1 not working (fixed).
- CapsLock not working as expected for characters above Latin-1.
- Can't use Meta key with characters above Latin-1.

There are three letters above 0xff on level 1 of this keyboard layout:
ē — U+0113 Dec:275 LATIN SMALL LETTER E WITH MACRON
ā — U+0101 Dec:257 LATIN SMALL LETTER A WITH MACRON
ī — U+012B Dec:299 LATIN SMALL LETTER I WITH MACRON


Compose
=======

I have added some extra letters in the free places to be able to type not only
Latvian and English, but also German and Finnish (e.g., there is letter ö on
level 3 of ē key) for the rare occasions I need them.

This keyboard layout uses a dead key (dead_acute) to access level 3 symbols
(the same as AltGr):

compose diacr base to result
compose '\'' U+0113 to U+00F6

But it didn't work if the base in the compose sequence was above 0xff (patch
[2] is in tty-next).


Key value and flags
===================

The other two issues could be attributed to the lack of proper flags for key
values (key type is encoded in its value).

According to keymaps manual:
```
Each  keysym  may  be prefixed by a '+' (plus sign), in wich case this keysym
is treated as a "letter" and therefore affected by the "CapsLock" the same way
as by "Shift" (to be correct, the CapsLock inverts the Shift state).  The ASCII
letters ('a'-'z' and 'A'-'Z') are made CapsLock'able by default.  If
Shift+CapsLock should not produce a lower case symbol, put lines like

      keycode 30 = +a  A

in the map file.
```

But it doesn't work — CapsLock is ignored for codepoints above 0xff.  Adding
plus signs to all four maps should make them behave the same way (like in X):

#              0              1              2              3
#              Plain          Shift          AltGr          AltGr+Shift
keycode  16 = +U+0113        +U+0112        +U+00F6        +U+00D6

                          |     X       VT
--------------------------+---------------
CapsLock                ē |     Ē       ē
CapsLock+Shift          ē |     ē       Ē
CapsLock+AltGr          ē |     Ö       Ö
CapsLock+Shift+AltGr    ē |     ö       ö

For the key to behave properly, its key type (KTYP) has to be 'letter':

include/uapi/linux/keyboard.h:
#define KT_LETTER	11	/* symbol that can be acted upon by CapsLock */


Thus it is necessary to set KTYP for characters beyond Latin-1; which is not
possible now.

Currently they are defined like this:
```
include/linux/keyboard.h:

extern unsigned short *key_maps[MAX_NR_KEYMAPS];


drivers/tty/vt/defkeymap.c_shipped:

ushort *key_maps[MAX_NR_KEYMAPS] = {
	plain_map, shift_map, altgr_map, NULL,
	ctrl_map, shift_ctrl_map, NULL, NULL,
	alt_map, NULL, NULL, NULL,
	ctrl_alt_map, NULL
};


include/uapi/linux/kd.h:

struct kbentry {
	unsigned char kb_table;
	unsigned char kb_index;
	unsigned short kb_value;	<-- Important!
};


#define KDGKBENT	0x4B46	/* gets one entry in translation table */
#define KDSKBENT	0x4B47	/* sets one entry in translation table */


include/linux/kbd_kern.h:

#define U(x) ((x) ^ 0xf000)

#define BRL_UC_ROW 0x2800


include/uapi/linux/keyboard.h:

#define K(t,v)		(((t)<<8)|(v))
#define KTYP(x)		((x) >> 8)
#define KVAL(x)		((x) & 0xff)
```

The use of ``unsigned short kb_value`` in ``struct kbentry`` prevents setting
KTYP for Unicode characters beyond Latin-1 since there are only two bytes in an
``unsigned short`` and KTYP needs one, not leaving enough space for code points
beyond 0xff.

This breaks CapsLock for keyboard layouts with characters above Latin-1 [3–6].

I think those bugs are closed by mistake, since, to this day, it doesn't work.
And it can't work because of the aforementioned kernel limitations (at least as
far as CapsLock issue in Unicode mode is concerned).

To illustrate, keysym is 16 bits long:

	mmmm tttt nnnn nnnn

	m — mask for (non-)Unicode characters (U macro)
	t — KTYP
	n — KVAL

This also limits the number of Unicode characters — from 0xf000 the mask is
lost. (No Klingon input in VT [not that I want one]. I think
Documentation/admin-guide/unicode.rst talks only about the output. Or am I
missing something?)

See vt_do_kdsk_ioctl() and kbd_keycode() in drivers/tty/vt/keyboard.c for how
the mask and U macro is used.

As a side note: It seems CapsShift has never worked either.  It was suggested
as a workaround to this issue in one of the kernel bugs, but it obviously
wouldn't work.  First, CapsShift needs key map 256 and up (limited by
MAX_NR_KEYMAPS).  Second, in struct kbentry the kb_table index is unsigned char
(0–255).  So, even if one increased MAX_NR_KEYMAPS and recompiled the kernel,
they still wouldn't be able to set the key map, because the ioctl can't index
the table.


Solution
========

A possible fix could be a proper, extensible struct with flags [7] for
kb_value, used in the key_map[] and a pair of new ioctls (see the top of the
mail).

I think the increase in memory usage here is not something to worry about.

That would change key_map[] from ushort to __u64.  So instead of 2 bytes per
keysym, it would use 8 bytes.  The memory usage of keymaps would increase 4
times.  Since there are 7 keymaps by default with 256 keys each, that would
increase memory usage by:

	(8-2)*7*256=42*256=10752 B

Each additional keymap would increase memory usage by:

	8*256=2048 B

Increasing the size of kb_table and kb_index might be useful in the future for
adding multiple keyboard layout support to VT [8].

---
The increase of memory usage could be cut in half if ``__u32 flags`` is dropped
and KTYP is put at the last byte of ``__u32 kb_valueuc``:

#define K(t,v)		(((t)<<24)|(v))
#define KTYP(x)		((x) >> 24)
#define KVAL(x)		((x) & 0xffffff)

But in this case the future-proofing for flags [7,9] would be lost.

Also, there is possible conflict for programs built with old version of K
macros running on newer kernels.  The macros would have to be renamed.
---


Affected users
==============

KTYP or KVAL are used in (they would all have to be updated):
- kernel/debug/kdb/kdb_keyboard.c
- drivers/s390/char/keyboard.c
- drivers/s390/char/tty3270.c
- drivers/staging/speakup/main.c
- drivers/tty/vt/keyboard.c
- drivers/accessibility/braille/braille_console.c
- arch/m68k/atari/atakeyb.c

In addition to those, ``key_maps`` are used in:
- drivers/s390/char/defkeymap.c
- drivers/tty/vt/defkeymap.c_shipped
- drivers/input/keyboard/amikbd.c
- include/linux/keyboard.h
- arch/m68k/amiga/config.c

Also kbd package would have to be updated to take advantage of the change.


Is anybody already working on this? Maybe somebody has done it a long time ago
already, and I just have to do some magic incantations to make it work?

Is it even worth doing?

I'm new to kernel programming, comments from people with better insights are
very much appreciated.


-Reinis


[1] https://odo.lv/xwiki/bin/download/Recipes/LatvianKeyboard/Modern.png
[2] https://lkml.org/lkml/2019/4/11/362
[3] https://bugzilla.kernel.org/show_bug.cgi?id=7063
[4] https://bugzilla.kernel.org/show_bug.cgi?id=7746
[5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=404503
[6] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/16638
[7] https://blog.ffwll.ch/2013/11/botching-up-ioctls.html
[8] https://www.happyassassin.net/2013/11/23/keyboard-layouts-in-fedora-20-and-previously/
[9] https://lwn.net/Articles/585415/
