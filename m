From: Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 0/2] input: atakbd.c bug fixes
Date: Fri,  7 Sep 2018 11:40:41 +1200
Message-ID: <1536277243-3821-1-git-send-email-schmitzmic@gmail.com>
Return-path: <bounce-debian-68k=debian-68k=m.gmane.org@lists.debian.org>
Resent-Message-ID: <5WOtNHzEXeE.A.CxH.YsbkbB@bendel>
List-URL: <https://lists.debian.org/debian-68k/>
List-Post: <mailto:debian-68k@lists.debian.org>
List-Help: <mailto:debian-68k-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-68k-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-68k-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1536277243-3821-1-git-send-email-schmitzmic@gmail.com
To: linux-input@vger.kernel.org
Cc: debian-68k@lists.debian.org, linux-m68k@lists.linux-m68k.org
List-Id: linux-input@vger.kernel.org

Two bug fixes for the Atari keyboard input driver:

- keymap fixes: multiple keymap errors that had gone unnoticed
  since migration of the m68k keyboard driver code to the
  input framework. Correct the wrong keycodes - keymap is stil
  US but keypad, help and undo keys all generate the correct keycodes now.

- capslock fix: the Atari driver incorrectly assumed that capslock
  were a toggle key (i.e. sending no break scancodes), and synthesized
  a make/break keycode pair on each capslock scancode. This resulted in
  duplicate make/break codes on key release, and capslock functioning as
  a shift key. Remove code sending make/break pairs to get functional
  capslock behaviour.

Tested on my own Atari Falcon 030.

TIA for your review. Please CC linux-m68k in replies.

Cheers,

	Michael

CC to debian-68k, for consideration at the upcoming m68k hackers meeting.
