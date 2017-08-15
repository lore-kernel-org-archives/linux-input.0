From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/3] constify snd_rawmidi_ops structures
Date: Tue, 15 Aug 2017 10:36:51 +0200
Message-ID: <1502786211-20520-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

These snd_rawmidi_ops structures are only passed as the third
argument of snd_rawmidi_set_ops.  This argument is const, so the
snd_rawmidi_ops structures can be const too.

Done with the help of Coccinelle.

---

 drivers/hid/hid-prodikeys.c          |    2 +-
 drivers/usb/gadget/function/f_midi.c |    4 ++--
 sound/firewire/motu/motu-midi.c      |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)
