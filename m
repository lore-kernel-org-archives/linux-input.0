From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/joystick: warnings in xpad_start_input and xpad_try_sending_next_out_packet
Date: Tue, 12 Sep 2017 17:36:47 +0200
Message-ID: <CAAeHK+xgUSfaufHO_G4+AhmZFwqhjizufaeyXJtqQwmvCtm89g@mail.gmail.com>
References: <CAAeHK+wp5Q15BZ7M26SUGMYW7jCcNo+ckNfOHV+VEHgUUJnN+g@mail.gmail.com>
 <46e1a068-ae72-51f6-c2ef-977f4bc7493b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46e1a068-ae72-51f6-c2ef-977f4bc7493b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Valentin <benpicco@googlemail.com>, Pavel Rojtberg <rojtberg@gmail.com>, Daniel Tobias <dan.g.tob@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 12, 2017 at 5:42 AM, Cameron Gutman <aicommander@gmail.com> wrote:
> On 09/11/2017 05:26 AM, Andrey Konovalov wrote:
>> Hi!
>>
>> I've got the following crashes while fuzzing the kernel with syzkaller.
>>
>> On commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432 (Sep 3).
>>
>> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
>> WARNING: CPU: 1 PID: 2574 at drivers/usb/core/urb.c:449
>> usb_submit_urb+0xf8a/0x11d0
>> Modules linked in:
>> CPU: 1 PID: 2574 Comm: kworker/1:2 Not tainted 4.13.0+ #88
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> Workqueue: usb_hub_wq hub_event
>> task: ffff880067ec9a00 task.stack: ffff880067988000
>> RIP: 0010:usb_submit_urb+0xf8a/0x11d0 drivers/usb/core/urb.c:448
>> RSP: 0018:ffff88006798e0b0 EFLAGS: 00010082
>> RAX: 0000000000000029 RBX: ffff88006b9ca200 RCX: 0000000000000000
>> RDX: 0000000000000029 RSI: ffff88006c915c78 RDI: ffffed000cf31c08
>> RBP: ffff88006798e1b0 R08: fffffbfff0fe00ff R09: fffffbfff0fe00ff
>> R10: 0000000000000001 R11: fffffbfff0fe00fe R12: 1ffff1000cf31c1d
>> R13: 0000000000000003 R14: 0000000000000001 R15: ffff88006b164798
>> FS:  0000000000000000(0000) GS:ffff88006c900000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fde04686518 CR3: 000000006a539000 CR4: 00000000000006e0
>> Call Trace:
>>  xpad_try_sending_next_out_packet+0xe1/0x1d0 drivers/input/joystick/xpad.c:1000
>>  xpad_send_led_command drivers/input/joystick/xpad.c:1372
>>  xpad_led_set+0x465/0x6e0 drivers/input/joystick/xpad.c:1392
>>  __led_set_brightness drivers/leds/led-core.c:34
>>  led_set_brightness_nopm+0x53/0x100 drivers/leds/led-core.c:261
>>  led_set_brightness_nosleep+0x17f/0x220 drivers/leds/led-core.c:278
>>  led_set_brightness+0xfe/0x130 drivers/leds/led-core.c:253
>>  xpad_identify_controller drivers/input/joystick/xpad.c:1383
>>  xpad_led_probe drivers/input/joystick/xpad.c:1426
>>  xpad_init_input+0xd40/0xfe0 drivers/input/joystick/xpad.c:1667
>>  xpad_probe+0x13d4/0x1e00 drivers/input/joystick/xpad.c:1811
>>  usb_probe_interface+0x351/0x8d0 drivers/usb/core/driver.c:361
>>  really_probe drivers/base/dd.c:385
>>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
>>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
>>  bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
>>  __device_attach+0x269/0x3c0 drivers/base/dd.c:682
>>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
>>  bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
>>  device_add+0xcf9/0x1640 drivers/base/core.c:1703
>>  usb_set_configuration+0x1064/0x1890 drivers/usb/core/message.c:1932
>>  generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
>>  usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
>>  really_probe drivers/base/dd.c:385
>>  driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
>>  __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
>>  bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
>>  __device_attach+0x269/0x3c0 drivers/base/dd.c:682
>>  device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
>>  bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
>>  device_add+0xcf9/0x1640 drivers/base/core.c:1703
>>  usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
>>  hub_port_connect drivers/usb/core/hub.c:4890
>>  hub_port_connect_change drivers/usb/core/hub.c:4996
>>  port_event drivers/usb/core/hub.c:5102
>>  hub_event+0x23c8/0x37c0 drivers/usb/core/hub.c:5182
>>  process_one_work+0x9fb/0x1570 kernel/workqueue.c:2097
>>  worker_thread+0x1e4/0x1350 kernel/workqueue.c:2231
>>  kthread+0x324/0x3f0 kernel/kthread.c:231
>>  ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
>> Code: 48 8b 85 30 ff ff ff 48 8d b8 98 00 00 00 e8 8e 93 07 ff 45 89
>> e8 44 89 f1 4c 89 fa 48 89 c6 48 c7 c7 a0 e5 55 86 e8 20 08 8f fd <0f>
>> ff e9 9b f7 ff ff e8 4a 04 d6 fd e9 80 f7 ff ff e8 60 11 a6
>> ---[ end trace 5b20fc700a17a457 ]---
>
> I assume you're doing some sort of USB emulation to fuzz these? I don't
> think we'd get that far with any real device that wasn't explicitly designed
> to trick us.
>
> In any case, this patch should take care of it.

Yes, it fixes the issue, could you submit it upstream?

Tested-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

>
> Regards,
> Cameron
>
> ----
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index f8e34ef643c7..d86e59515b9c 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1764,10 +1764,12 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>                 struct usb_endpoint_descriptor *ep =
>                                 &intf->cur_altsetting->endpoint[i].desc;
>
> -               if (usb_endpoint_dir_in(ep))
> -                       ep_irq_in = ep;
> -               else
> -                       ep_irq_out = ep;
> +               if (usb_endpoint_xfer_int(ep)) {
> +                       if (usb_endpoint_dir_in(ep))
> +                               ep_irq_in = ep;
> +                       else
> +                               ep_irq_out = ep;
> +               }
>         }
>
>         if (!ep_irq_in || !ep_irq_out) {
>
>
>
>
