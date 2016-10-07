From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] hid: hid-led: fix issue with transfer buffer not
 being dma capable
Date: Fri, 7 Oct 2016 18:22:03 +0200
Message-ID: <20161007162203.GG30411@mail.corp.redhat.com>
References: <fca778a4-9a20-f0a9-b20e-ccb335fc0b0c@gmail.com>
 <237d1c6f-933a-e218-bbda-04920bbf3a2a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <237d1c6f-933a-e218-bbda-04920bbf3a2a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Oct 03 2016 or thereabouts, Heiner Kallweit wrote:
> The hid-led driver works fine under 4.8.0, however with the next
> kernel from today I get this:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2578 at drivers/usb/core/hcd.c:1584 usb_hcd_map_urb_for_dma+0x373/0x550 [usbcore]
> transfer buffer not dma capable
> Modules linked in: hid_led(+) usbhid vfat fat ir_sony_decoder iwlmvm led_class mac80211 snd_hda_codec_realtek snd_hda_codec_generic x86_pkg_temp_thermal iwlwifi crc32c_intel snd_hda_codec_hdmi i2c_i801 i2c_smbus snd_hda_intel cfg80211 snd_hda_codec snd_hda_core snd_pcm r8169 snd_timer mei_me mii snd mei ir_lirc_codec lirc_dev nuvoton_cir rc_core btusb btintel bluetooth rfkill usb_storage efivarfs ipv6 ehci_pci ehci_hcd xhci_pci xhci_hcd usbcore usb_common ext4 jbd2 mbcache ahci libahci libata
> CPU: 0 PID: 2578 Comm: systemd-udevd Not tainted 4.8.0-rc8-next-20161003 #1
> Hardware name: ZOTAC ZBOX-CI321NANO/ZBOX-CI321NANO, BIOS B246P105 06/01/2015
>  ffffc90003dbb7e0 ffffffff81280425 ffffc90003dbb830 0000000000000000
>  ffffc90003dbb820 ffffffff8105b086 0000063003dbb800 ffff88006f374480
>  0000000000000000 0000000000000000 0000000000000001 ffff880079544000
> Call Trace:
>  [<ffffffff81280425>] dump_stack+0x68/0x93
>  [<ffffffff8105b086>] __warn+0xc6/0xe0
>  [<ffffffff8105b0ea>] warn_slowpath_fmt+0x4a/0x50
>  [<ffffffffa0143a43>] usb_hcd_map_urb_for_dma+0x373/0x550 [usbcore]
>  [<ffffffffa01441b6>] usb_hcd_submit_urb+0x316/0x9c0 [usbcore]
>  [<ffffffff810bce80>] ? rcu_read_lock_sched_held+0x40/0x80
>  [<ffffffff810e0043>] ? module_assert_mutex_or_preempt+0x13/0x50
>  [<ffffffff810e0c07>] ? __module_address+0x27/0xf0
>  [<ffffffffa01456e4>] usb_submit_urb+0x2c4/0x520 [usbcore]
>  [<ffffffffa0145fea>] usb_start_wait_urb+0x5a/0xe0 [usbcore]
>  [<ffffffffa014612c>] usb_control_msg+0xbc/0xf0 [usbcore]
>  [<ffffffff810e0c07>] ? __module_address+0x27/0xf0
>  [<ffffffffa079a724>] usbhid_raw_request+0xa4/0x180 [usbhid]
>  [<ffffffffa07a93b1>] hidled_recv+0x71/0xe0 [hid_led]
>  [<ffffffffa07a947d>] thingm_init+0x2d/0x50 [hid_led]
>  [<ffffffffa07a969b>] hidled_probe+0xcb/0x24a [hid_led]
>  [<ffffffff814d96f2>] hid_device_probe+0xd2/0x150
>  [<ffffffff8146023d>] driver_probe_device+0x1fd/0x2c0
>  [<ffffffff8146039a>] __driver_attach+0x9a/0xa0
>  [<ffffffff81460300>] ? driver_probe_device+0x2c0/0x2c0
>  [<ffffffff8145e25d>] bus_for_each_dev+0x5d/0x90
>  [<ffffffff8145fa79>] driver_attach+0x19/0x20
>  [<ffffffff8145f5ff>] bus_add_driver+0x11f/0x220
>  [<ffffffffa07ac000>] ? 0xffffffffa07ac000
>  [<ffffffff8146086b>] driver_register+0x5b/0xd0
>  [<ffffffffa07ac000>] ? 0xffffffffa07ac000
>  [<ffffffff814d83d1>] __hid_register_driver+0x61/0xa0
>  [<ffffffffa07ac01e>] hidled_driver_init+0x1e/0x20 [hid_led]
>  [<ffffffff81000408>] do_one_initcall+0x38/0x150
>  [<ffffffff810bce80>] ? rcu_read_lock_sched_held+0x40/0x80
>  [<ffffffff81194ca0>] ? kmem_cache_alloc_trace+0x1d0/0x230
>  [<ffffffff811342f9>] do_init_module+0x5a/0x1cb
>  [<ffffffff810e3862>] load_module+0x1e42/0x2530
>  [<ffffffff810e0990>] ? __symbol_put+0x50/0x50
>  [<ffffffff810dfc50>] ? show_coresize+0x30/0x30
>  [<ffffffff811ad650>] ? kernel_read_file+0x100/0x190
>  [<ffffffff811ad794>] ? kernel_read_file_from_fd+0x44/0x70
>  [<ffffffff810e415a>] SYSC_finit_module+0xba/0xc0
>  [<ffffffff810e4179>] SyS_finit_module+0x9/0x10
>  [<ffffffff815e082a>] entry_SYSCALL_64_fastpath+0x18/0xad
> ---[ end trace c9e6ea27003ecf9e ]---
> 
> Fix this by using a kmalloc'ed buffer when calling hid_hw_raw_request.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> v2:
> - Based on a comment from Alan Stern allocate the buffer to be provided to
>   hid_hw_raw_request separately (and not as part of struct hidled_device).
>   Alternative would have been to allocate the buffer dynamically in each
>   function calling hidled_send/_recv. However this would mean more overhead
>   IMHO, and we'd need an error path in callers to free the buffer in case
>   of an error.
>   In addition we have better control that a proper buffer is used in case
>   the driver is extended by somebody for supporting another LED device.
> ---

Looks like the receive function is only called from .probe(), so this
should be safe.
However, for the send function, is there a chance there can be a
concurrent access of the buffer? (like 2 userspace processes writing a
different values at the same time).

If so, then you'll need to add a locking mechanism (can't recall if the
LED API provide one for us or not), or just alloc/free the buffers
directly.

If no, the patch is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Cheers,
Benjamin

>  drivers/hid/hid-led.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
> index d8d55f3..555c88e 100644
> --- a/drivers/hid/hid-led.c
> +++ b/drivers/hid/hid-led.c
> @@ -100,6 +100,7 @@ struct hidled_device {
>  	const struct hidled_config *config;
>  	struct hid_device       *hdev;
>  	struct hidled_rgb	*rgb;
> +	u8			*buf;
>  	struct mutex		lock;
>  };
>  
> @@ -118,13 +119,19 @@ static int hidled_send(struct hidled_device *ldev, __u8 *buf)
>  
>  	mutex_lock(&ldev->lock);
>  
> +	/*
> +	 * buffer provided to hid_hw_raw_request must not be on the stack
> +	 * and must not be part of a data structure
> +	 */
> +	memcpy(ldev->buf, buf, ldev->config->report_size);
> +
>  	if (ldev->config->report_type == RAW_REQUEST)
> -		ret = hid_hw_raw_request(ldev->hdev, buf[0], buf,
> +		ret = hid_hw_raw_request(ldev->hdev, buf[0], ldev->buf,
>  					 ldev->config->report_size,
>  					 HID_FEATURE_REPORT,
>  					 HID_REQ_SET_REPORT);
>  	else if (ldev->config->report_type == OUTPUT_REPORT)
> -		ret = hid_hw_output_report(ldev->hdev, buf,
> +		ret = hid_hw_output_report(ldev->hdev, ldev->buf,
>  					   ldev->config->report_size);
>  	else
>  		ret = -EINVAL;
> @@ -147,17 +154,21 @@ static int hidled_recv(struct hidled_device *ldev, __u8 *buf)
>  
>  	mutex_lock(&ldev->lock);
>  
> -	ret = hid_hw_raw_request(ldev->hdev, buf[0], buf,
> +	memcpy(ldev->buf, buf, ldev->config->report_size);
> +
> +	ret = hid_hw_raw_request(ldev->hdev, buf[0], ldev->buf,
>  				 ldev->config->report_size,
>  				 HID_FEATURE_REPORT,
>  				 HID_REQ_SET_REPORT);
>  	if (ret < 0)
>  		goto err;
>  
> -	ret = hid_hw_raw_request(ldev->hdev, buf[0], buf,
> +	ret = hid_hw_raw_request(ldev->hdev, buf[0], ldev->buf,
>  				 ldev->config->report_size,
>  				 HID_FEATURE_REPORT,
>  				 HID_REQ_GET_REPORT);
> +
> +	memcpy(buf, ldev->buf, ldev->config->report_size);
>  err:
>  	mutex_unlock(&ldev->lock);
>  
> @@ -447,6 +458,10 @@ static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (!ldev)
>  		return -ENOMEM;
>  
> +	ldev->buf = devm_kmalloc(&hdev->dev, MAX_REPORT_SIZE, GFP_KERNEL);
> +	if (!ldev->buf)
> +		return -ENOMEM;
> +
>  	ret = hid_parse(hdev);
>  	if (ret)
>  		return ret;
> -- 
> 2.10.0
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
