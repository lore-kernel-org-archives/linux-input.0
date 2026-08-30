Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3B1DDFE
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788048278; cv=none; b=jwkpUwaTMclK5Wuk5nezpuTE/6rMDYi9YCouNKk4rmjQ9xbG50SElMNH47d83rq7Jq4MnnmB4jVumoGx6aj5mFz7mmgooZ5YtN4qQu64rmNNAMpWvmakc9DJHKrSyPNI32Krqf/6bREieAVeofHz4+YyMPeHPsGygNp5O0dw0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788048278; c=relaxed/simple;
	bh=h0cLZNbIO9EpQcmI/Lgesza1J8PK+C/w3hpTts1hOuE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YBOgfp+sctzkQPb58fSudDj/HJRlTCzNB1VkLzaef0VrVKpZxzzjSUbHbE+cSh/i1QAoQTZlluPmSmfK5xLsGF28zhPMnPgEZvkRa3M/iALvBq/+ouxqco+k3GjN2dvT2cwCaVxuXDqOqqoq/1hKhl0H/iPtHa2bE7c9GA4OdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a49b13b745so776509b6e.0
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 17:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788048275; x=1788653075;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTr545jna5OarBhaxCWTMLAe80kQW9kEMW42OJalPm4=;
        b=Q+OX4Yqa51facwEVnhzpbBU0xcQ5JuMWu59hnxJEwQfl2KR1vfp/qSl/+XQ04K3fty
         AFlnU1uHpuzQA15DPf6n8mahUfyReOQmqY7qiWA4PBOOgF9AhFqUPriJ8R8NWHeY2fTM
         D9qyptXJW9baUUDv9B5dB7/q2ssIwXe5Z1CXxzzT4WUZF9XMXy424q62V7xrwI6hL9Fk
         5A1x8x7bGxeyj0H+bYu8jKmFhpxHxSao+4+EXiaT34p7IvEZar1xyIvvnaF3Dr0VNQGZ
         mSQErp4nlowYY151vLuyotkFcsbv/SHL9LC10MwKmUeNmrnGTyUuZAgRai9mHSeRWise
         fPNQ==
X-Gm-Message-State: AFuF++kyepVc2fwTIsEiPFVmCEaxHyVT4dZQZsqT8t1OgZAws8btGERJ
	HhICMh2gxjhZobWWk7Dv56YjVICdi7hmAV9yONOqjadba4U/FjNh8+gc/jermoQdISS5GxgAg1d
	+Kanm93mp842VpLV700ElpgXuUq0RTVFqQ8mKg/ezcZTuHRRqDVvoqdVmuboGIg==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6809:3cd:10b0:4b5:5bfb:f25c with SMTP id
 5614622812f47-4b55bfbfccbmr3577365b6e.21.1788048275642; Sat, 29 Aug 2026
 17:04:35 -0700 (PDT)
Date: Sat, 29 Aug 2026 17:04:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a937393.1d9ded08.62e62.0113.GAE@google.com>
Subject: [syzbot] [usb?] [input?] KASAN: slab-use-after-free Read in k90_record_led_work
From: syzbot <syzbot+0b8bff5929865345b29e@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66498c75b4f8 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e57549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb409d4da8c3b304
dashboard link: https://syzkaller.appspot.com/bug?extid=0b8bff5929865345b29e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7e63332dd55/disk-66498c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bb4ee047025/vmlinux-66498c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bea2f3b309e/bzImage-66498c75.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b8bff5929865345b29e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in k90_record_led_work+0x19a/0x1e0 drivers/hid/hid-corsair.c:235
Read of size 1 at addr ffff88805dc14300 by task kworker/0:[  120.589162][    T9] Read of size 1 at addr ffff88805dc14300 by task kworker/0:0/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events k90_record_led_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 k90_record_led_work+0x19a/0x1e0 drivers/hid/hid-corsair.c:235
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5718:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 k90_init_macro_functions drivers/hid/hid-corsair.c:474 [inline]
 corsair_probe+0x21c/0xbc0 drivers/hid/hid-corsair.c:584
 __hid_device_probe drivers/hid/hid-core.c:2839 [inline]
 hid_device_probe+0x46a/0x870 drivers/hid/hid-core.c:2878
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:3065
 usbhid_probe+0x9dc/0xde0 drivers/hid/usbhid/hid-core.c:1452
 usb_probe_interface+0x653/0xc60 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1ad8/0x2180 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c7/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x99a/0x1680 drivers/usb/core/hub.c:2703
 hub_port_connect drivers/usb/core/hub.c:5575 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x28cf/0x4cf0 drivers/usb/core/hub.c:5961
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 5718:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6792
 k90_cleanup_macro_functions drivers/hid/hid-corsair.c:547 [inline]
 corsair_remove+0xfd/0x260 drivers/hid/hid-corsair.c:602
 hid_device_remove+0xc8/0x1d0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5415 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5961
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2272
 __queue_work+0xd4b/0x1120 kernel/workqueue.c:2448
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2501
 led_classdev_unregister+0x113/0x270 drivers/leds/led-class.c:632
 k90_cleanup_macro_functions drivers/hid/hid-corsair.c:544 [inline]
 corsair_remove+0xd7/0x260 drivers/hid/hid-corsair.c:602
 hid_device_remove+0xc8/0x1d0 drivers/hid/hid-core.c:2897
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 hid_remove_device drivers/hid/hid-core.c:3126 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3148
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1479
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x449/0x560 drivers/base/bus.c:664
 device_del+0x528/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x32d/0x990 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5415 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x1bb7/0x4cf0 drivers/usb/core/hub.c:5961
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88805dc14000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 768 bytes inside of
 freed 1024-byte region [ffff88805dc14000, ffff88805dc14400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5dc10
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ffb9dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ffb9dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1386, tgid 1386 (kworker/u8:12), ts 119040566074
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2591/0x2600 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x230/0x5c0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x339/0x690 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x54b/0x790 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 ieee802_11_parse_elems_full+0x14b/0x2de0 net/mac80211/parse.c:1071
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2548 [inline]
 ieee80211_inform_bss+0x163/0x10d0 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0xd98/0x1bf0 net/wireless/scan.c:2410
 cfg80211_inform_bss_data+0x263/0x3cc0 net/wireless/scan.c:3266
 cfg80211_inform_bss_frame_data+0x3c7/0x840 net/wireless/scan.c:3358
 ieee80211_bss_info_update+0x791/0xa50 net/mac80211/scan.c:230
 ieee80211_rx_bss_info net/mac80211/ibss.c:1065 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1546 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1ce3/0x2c40 net/mac80211/ibss.c:1573
 ieee80211_iface_process_skb net/mac80211/iface.c:1769 [inline]
 ieee80211_iface_work+0x78a/0x1010 net/mac80211/iface.c:1823
 cfg80211_wiphy_work+0x29e/0x420 net/wireless/core.c:541
page last free pid 5696 tgid 5696 ts 118905325757 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xf8e/0x1070 mm/page_alloc.c:2962
 __slab_free+0x250/0x2a0 mm/slub.c:5815
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x360/0x690 mm/slub.c:5010
 alloc_filename fs/namei.c:147 [inline]
 do_getname+0x2e/0x250 fs/namei.c:187
 class_filename_flags_constructor include/linux/fs.h:2587 [inline]
 do_readlinkat+0xc8/0x510 fs/stat.c:569
 __do_sys_readlink fs/stat.c:605 [inline]
 __se_sys_readlink fs/stat.c:602 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:602
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805dc14200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805dc14280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805dc14300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88805dc14380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805dc14400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
