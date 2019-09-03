From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: general protection fault in pk_probe
Date: Tue, 3 Sep 2019 15:27:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1909031516520.1859-100000@iolanthe.rowland.org>
References: <0000000000002725f40591a4f118@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000002725f40591a4f118@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com>
Cc: andreyknvl@google.com, benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Tue, 3 Sep 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c3589e600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
> dashboard link: https://syzkaller.appspot.com/bug?extid=1088533649dafa1c9004
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1667cc66600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f30dbc600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com
> 
> prodikeys 0003:041E:2801.0001: unknown main item tag 0x0
> prodikeys 0003:041E:2801.0001: unknown main item tag 0x0
> prodikeys 0003:041E:2801.0001: hidraw0: USB HID v0.00 Device [HID  
> 041e:2801] on usb-dummy_hcd.0-1/input1
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc5+ #28
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:pcmidi_submit_output_report drivers/hid/hid-prodikeys.c:300  
> [inline]
> RIP: 0010:pcmidi_set_operational drivers/hid/hid-prodikeys.c:558 [inline]
> RIP: 0010:pcmidi_snd_initialise drivers/hid/hid-prodikeys.c:686 [inline]
> RIP: 0010:pk_probe+0xb51/0xfd0 drivers/hid/hid-prodikeys.c:836

The reason for this bug seems pretty clear: pcmidi_get_output_report() 
can return an error, but pcmidi_set_operational() doesn't bother to 
check the return code.

Alan Stern

#syz test: https://github.com/google/kasan.git eea39f24

Index: usb-devel/drivers/hid/hid-prodikeys.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-prodikeys.c
+++ usb-devel/drivers/hid/hid-prodikeys.c
@@ -551,10 +551,14 @@ static void pcmidi_setup_extra_keys(
 
 static int pcmidi_set_operational(struct pcmidi_snd *pm)
 {
+	int rc;
+
 	if (pm->ifnum != 1)
 		return 0; /* only set up ONCE for interace 1 */
 
-	pcmidi_get_output_report(pm);
+	rc = pcmidi_get_output_report(pm);
+	if (rc < 0)
+		return rc;
 	pcmidi_submit_output_report(pm, 0xc1);
 	return 0;
 }
@@ -683,7 +687,11 @@ static int pcmidi_snd_initialise(struct
 	spin_lock_init(&pm->rawmidi_in_lock);
 
 	init_sustain_timers(pm);
-	pcmidi_set_operational(pm);
+	err = pcmidi_set_operational(pm);
+	if (err < 0) {
+		pk_error("failed to find output report\n");
+		goto fail_register;
+	}
 
 	/* register it */
 	err = snd_card_register(card);
