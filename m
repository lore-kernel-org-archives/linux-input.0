From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-prodikeys: Fix general protection fault during
 probe
Date: Thu, 5 Sep 2019 15:03:33 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909051503210.31470@cbobk.fhfr.pm>
References: <Pine.LNX.4.44L0.1909041149390.1722-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1909041149390.1722-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: andreyknvl@google.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Wed, 4 Sep 2019, Alan Stern wrote:

> The syzbot fuzzer provoked a general protection fault in the
> hid-prodikeys driver:
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc5+ #28
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:pcmidi_submit_output_report drivers/hid/hid-prodikeys.c:300  [inline]
> RIP: 0010:pcmidi_set_operational drivers/hid/hid-prodikeys.c:558 [inline]
> RIP: 0010:pcmidi_snd_initialise drivers/hid/hid-prodikeys.c:686 [inline]
> RIP: 0010:pk_probe+0xb51/0xfd0 drivers/hid/hid-prodikeys.c:836
> Code: 0f 85 50 04 00 00 48 8b 04 24 4c 89 7d 10 48 8b 58 08 e8 b2 53 e4 fc  
> 48 8b 54 24 20 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
> 85 13 04 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
> 
> The problem is caused by the fact that pcmidi_get_output_report() will
> return an error if the HID device doesn't provide the right sort of
> output report, but pcmidi_set_operational() doesn't bother to check
> the return code and assumes the function call always succeeds.
> 
> This patch adds the missing check and aborts the probe operation if
> necessary.
> 
> Reported-and-tested-by: syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: <stable@vger.kernel.org>

Applied, thanks a lot Alan.

-- 
Jiri Kosina
SUSE Labs
