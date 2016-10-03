From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] hid: hid-led: fix issue with transfer buffer not being
 dma capable
Date: Mon, 3 Oct 2016 20:35:56 +0200
Message-ID: <3761f11c-3603-7674-7f89-2d6ba035198c@gmail.com>
References: <Pine.LNX.4.44L0.1610031418370.1751-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35621 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbcJCSgB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 14:36:01 -0400
In-Reply-To: <Pine.LNX.4.44L0.1610031418370.1751-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

Am 03.10.2016 um 20:22 schrieb Alan Stern:
> On Mon, 3 Oct 2016, Heiner Kallweit wrote:
> 
>> The hid-led driver works fine under 4.8.0, however with the next
>> kernel from today I get this:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 2578 at drivers/usb/core/hcd.c:1584 usb_hcd_map_urb_for_dma+0x373/0x550 [usbcore]
>> transfer buffer not dma capable
>> Modules linked in: hid_led(+) usbhid vfat fat ir_sony_decoder iwlmvm led_class mac80211 snd_hda_codec_realtek snd_hda_codec_generic x86_pkg_temp_thermal iwlwifi crc32c_intel snd_hda_codec_hdmi i2c_i801 i2c_smbus snd_hda_intel cfg80211 snd_hda_codec snd_hda_core snd_pcm r8169 snd_timer mei_me mii snd mei ir_lirc_codec lirc_dev nuvoton_cir rc_core btusb btintel bluetooth rfkill usb_storage efivarfs ipv6 ehci_pci ehci_hcd xhci_pci xhci_hcd usbcore usb_common ext4 jbd2 mbcache ahci libahci libata
>> CPU: 0 PID: 2578 Comm: systemd-udevd Not tainted 4.8.0-rc8-next-20161003 #1
>> Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
>>  ffffc90003dbb7e0 ffffffff81280425 ffffc90003dbb830 0000000000000000
>>  ffffc90003dbb820 ffffffff8105b086 0000063003dbb800 ffff88006f374480
>>  0000000000000000 0000000000000000 0000000000000001 ffff880079544000
>> Call Trace:
>>  [<ffffffff81280425>] dump_stack+0x68/0x93
>>  [<ffffffff8105b086>] __warn+0xc6/0xe0
>>  [<ffffffff8105b0ea>] warn_slowpath_fmt+0x4a/0x50
>>  [<ffffffffa0143a43>] usb_hcd_map_urb_for_dma+0x373/0x550 [usbcore]
>>  [<ffffffffa01441b6>] usb_hcd_submit_urb+0x316/0x9c0 [usbcore]
>>  [<ffffffff810bce80>] ? rcu_read_lock_sched_held+0x40/0x80
>>  [<ffffffff810e0043>] ? module_assert_mutex_or_preempt+0x13/0x50
>>  [<ffffffff810e0c07>] ? __module_address+0x27/0xf0
>>  [<ffffffffa01456e4>] usb_submit_urb+0x2c4/0x520 [usbcore]
>>  [<ffffffffa0145fea>] usb_start_wait_urb+0x5a/0xe0 [usbcore]
>>  [<ffffffffa014612c>] usb_control_msg+0xbc/0xf0 [usbcore]
>>  [<ffffffff810e0c07>] ? __module_address+0x27/0xf0
>>  [<ffffffffa079a724>] usbhid_raw_request+0xa4/0x180 [usbhid]
>>  [<ffffffffa07a93b1>] hidled_recv+0x71/0xe0 [hid_led]
>>  [<ffffffffa07a947d>] thingm_init+0x2d/0x50 [hid_led]
> 
> ...
> 
>> Fix this by using a kmalloc'ed buffer when calling hid_hw_raw_request.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/hid/hid-led.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
>> index d8d55f3..6c2b8e0 100644
>> --- a/drivers/hid/hid-led.c
>> +++ b/drivers/hid/hid-led.c
>> @@ -67,6 +67,8 @@ union delcom_packet {
>>  #define DELCOM_RED_LED		1
>>  #define DELCOM_BLUE_LED		2
>>  
>> +#define MAX_REPORT_SIZE		16
>> +
>>  struct hidled_device;
>>  struct hidled_rgb;
>>  
>> @@ -100,11 +102,10 @@ struct hidled_device {
>>  	const struct hidled_config *config;
>>  	struct hid_device       *hdev;
>>  	struct hidled_rgb	*rgb;
>> +	u8			buf[MAX_REPORT_SIZE];
>>  	struct mutex		lock;
>>  };
>>  
>> -#define MAX_REPORT_SIZE		16
>> -
>>  #define to_hidled_led(arg) container_of(arg, struct hidled_led, cdev)
>>  
>>  static bool riso_kagaku_switch_green_blue;
>> @@ -118,13 +119,16 @@ static int hidled_send(struct hidled_device *ldev, __u8 *buf)
>>  
>>  	mutex_lock(&ldev->lock);
>>  
>> +	/* buffer provided to hid_hw_raw_request must not be on the stack */
>> +	memcpy(ldev->buf, buf, ldev->config->report_size);
> 
> In fact, this is not the best way to solve the problem.  Not only must 
> the buffer be dynamically allocated, it also must not be part of a 
> larger structure (such as struct hidled_device).
> 
> Instead you should change the routines that call hidled_recv and 
> hidled_send.  Make each of them allocate a buffer using kmalloc rather 
> than use a buffer on the stack.
> 
I see, thanks for the hint. I'll provide a v2.

> Alan Stern
> 
> 

