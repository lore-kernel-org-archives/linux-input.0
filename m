From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 21 Jul 2015 10:01:33 -0700
Message-ID: <20150721170133.GA39076@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609174211.GH6338@dtor-ws>
 <55AE299F.3010002@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33864 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbbGURBi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 13:01:38 -0400
Content-Disposition: inline
In-Reply-To: <55AE299F.3010002@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jul 21, 2015 at 01:14:39PM +0200, Vlastimil Babka wrote:
> On 06/09/2015 07:42 PM, Dmitry Torokhov wrote:
> > From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > This change creates a new input handler called "leds" that exports LEDs on input
> > devices as standard LED class devices in sysfs and allows controlling their
> > ptate via sysfs or via any of the standard LED triggers. This allows to
> > re-purpose and reassign LDEs on the keyboards to represent states other
> > than the standard keyboard states (CapsLock, NumLock, etc).
> > 
> > The old API of controlling input LEDs by writing into /dev/input/eventX
> > devices is still present and will take precedence over acessing via LEDs
> > subsystem (i.e. it may override state set by a trigger). If input device is
> > "grabbed" then requests coming through LED subsystem will be ignored.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> > +	led_no = 0;
> > +	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
> > +		struct input_led *led = &leds->leds[led_no];
> > +
> > +		led->handle = &leds->handle;
> > +		led->code = led_code;
> > +
> > +		if (WARN_ON(!input_led_info[led_code].name))
> > +			continue;
> > +
> 
> Hi,
> I get several warnings on booting 4.2-rc2 here. Should I be worried?
> 
> [    2.782432] ------------[ cut here ]------------
> [    2.782440] WARNING: CPU: 2 PID: 356 at ../drivers/input/input-leds.c:115 input_leds_connect+0x22b/0x260()
> [    2.782441] Modules linked in: btrfs xor raid6_pq crc32c_intel radeon i2c_algo_bit sr_mod cdrom drm_kms_helper ttm e1000e drm xhci_pci ptp pps_core xhci_hcd sg
> [    2.782453] CPU: 2 PID: 356 Comm: kworker/2:2 Not tainted 4.2.0-rc2-1.g288d56b-desktop #1
> [    2.782454] Hardware name: Dell Inc. OptiPlex 9010/0M9KCM, BIOS A13 03/27/2013
> [    2.782458] Workqueue: usb_hub_wq hub_event
> [    2.782459]  ffffffff81a917b7 ffff880213ecf298 ffffffff8169f19d 0000000000000007
> [    2.782462]  0000000000000000 ffff880213ecf2d8 ffffffff810674f6 ffff880213ecf2f8
> [    2.782463]  ffff8802132fb000 0000000000000003 000000000000000b ffff8800369ff000
> [    2.782465] Call Trace:
> [    2.782470]  [<ffffffff8169f19d>] dump_stack+0x4c/0x6e
> [    2.782474]  [<ffffffff810674f6>] warn_slowpath_common+0x86/0xc0
> [    2.782476]  [<ffffffff810675ea>] warn_slowpath_null+0x1a/0x20
> [    2.782478]  [<ffffffff8152ccdb>] input_leds_connect+0x22b/0x260
> [    2.782480]  [<ffffffff815281b2>] input_attach_handler+0x1a2/0x1f0
> [    2.782483]  [<ffffffff81528640>] input_register_device+0x440/0x4f0
> [    2.782486]  [<ffffffff8156e494>] hidinput_connect+0x334/0x5d0
> [    2.782488]  [<ffffffff815683d4>] hid_connect+0x324/0x400

No, this is benign. I guess your keyboard has more LEDs than input
system has defined or several usages refer to the same LED.

Can you try debug patch below and post the messages?

-- 
Dmitry

---
 drivers/hid/hid-input.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 14aebe4..8690a84 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -657,6 +657,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		default: goto ignore;
 		}
+		hid_info(device, "Mapped LED usage %02x as LED %d\n", usage->hid & 0xffff, usage->code);
 		break;
 
 	case HID_UP_DIGITIZER:
@@ -971,6 +972,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		if (field->report_size == 1) {
 			if (field->report->type == HID_OUTPUT_REPORT) {
 				map_led(LED_MISC);
+				hid_info(device, "Mapped output report usage %08x as MISC LED %d\n",
+					 usage->hid, usage->code);
 				break;
 			}
 			map_key(BTN_MISC);
