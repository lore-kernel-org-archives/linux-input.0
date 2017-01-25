From: Wade Berrier <wberrier@gmail.com>
Subject: I2C touchpad not working: Lenovo Yoga 700
Date: Tue, 24 Jan 2017 22:53:04 -0700
Message-ID: <20170125055304.GB6021@miniwade.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36326 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdAYFxI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 00:53:08 -0500
Received: by mail-io0-f194.google.com with SMTP id q20so871801ioi.3
        for <linux-input@vger.kernel.org>; Tue, 24 Jan 2017 21:53:08 -0800 (PST)
Received: from miniwade.lan (71-219-56-10.slkc.qwest.net. [71.219.56.10])
        by smtp.googlemail.com with ESMTPSA id z42sm9763962ita.6.2017.01.24.21.53.06
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jan 2017 21:53:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm not sure this is the correct place to ask...

The touchpad isn't working on a Lenovo Yoga 700 (Fedora 25 4.9.4).

I'm not sure about how to debug this further.  The main questionable
item I see in dmesg is:

[    4.209019] i801_smbus 0000:00:1f.4: can't find IRQ for PCI INT A; please try using pci=biosirq
[    4.209428] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.209452] genirq: Flags mismatch irq 0. 00000080 (i801_smbus) vs. 00015a00 (timer)
[    4.209505] CPU: 2 PID: 630 Comm: systemd-udevd Not tainted 4.9.4-201.fc25.x86_64 #1
[    4.209506] Hardware name: LENOVO 80QE/Lenovo YOGA 700-, BIOS DDCN26WW(V1.10) 09/12/2016
[    4.209508]  ffffaf1bc1207918 ffffffffbc3f3ddd ffff9c28a5b96680 00000000fffffff0
[    4.209511]  ffffaf1bc1207970 ffffffffbc101f37 0000000000000246 ffff9c28ab03089c
[    4.209514]  ffff9c28a9f5ba40 00000000fb8335f5 ffff9c28a5b96680 0000000000000000
[    4.209517] Call Trace:
[    4.209523]  [<ffffffffbc3f3ddd>] dump_stack+0x63/0x86
[    4.209526]  [<ffffffffbc101f37>] __setup_irq+0x5e7/0x640
[    4.209528]  [<ffffffffbc10216b>] request_threaded_irq+0x10b/0x1a0
[    4.209534]  [<ffffffffc0537320>] ? i801_transaction+0x190/0x190 [i2c_i801]
[    4.209536]  [<ffffffffbc10434b>] devm_request_threaded_irq+0x6b/0xb0
[    4.209539]  [<ffffffffc0536f78>] i801_probe+0x5a8/0x720 [i2c_i801]
[    4.209542]  [<ffffffffbc819ce2>] ? mutex_lock+0x12/0x30
[    4.209545]  [<ffffffffbc449b65>] local_pci_probe+0x45/0xa0
[    4.209547]  [<ffffffffbc44afb3>] pci_device_probe+0x103/0x150
[    4.209549]  [<ffffffffbc54b743>] driver_probe_device+0x223/0x430
[    4.209550]  [<ffffffffbc54ba2f>] __driver_attach+0xdf/0xf0
[    4.209552]  [<ffffffffbc54b950>] ? driver_probe_device+0x430/0x430
[    4.209555]  [<ffffffffbc54912c>] bus_for_each_dev+0x6c/0xc0
[    4.209557]  [<ffffffffbc54ae8e>] driver_attach+0x1e/0x20
[    4.209559]  [<ffffffffbc54a8c0>] bus_add_driver+0x170/0x270
[    4.209562]  [<ffffffffc03c5000>] ? 0xffffffffc03c5000
[    4.209563]  [<ffffffffbc54c350>] driver_register+0x60/0xe0
[    4.209564]  [<ffffffffc03c5000>] ? 0xffffffffc03c5000
[    4.209567]  [<ffffffffbc44948c>] __pci_register_driver+0x4c/0x50
[    4.209569]  [<ffffffffc03c50af>] i2c_i801_init+0xaf/0x1000 [i2c_i801]
[    4.209570]  [<ffffffffc03c5000>] ? 0xffffffffc03c5000
[    4.209573]  [<ffffffffbc002190>] do_one_initcall+0x50/0x180
[    4.209576]  [<ffffffffbc22f2b9>] ? kmem_cache_alloc_trace+0x159/0x1b0
[    4.209579]  [<ffffffffbc1c017a>] ? do_init_module+0x27/0x1ef
[    4.209581]  [<ffffffffbc1c01b2>] do_init_module+0x5f/0x1ef
[    4.209583]  [<ffffffffbc12fe01>] load_module+0x25b1/0x2980
[    4.209585]  [<ffffffffbc12c6e0>] ? __symbol_put+0x60/0x60
[    4.209588]  [<ffffffffbc130343>] SYSC_init_module+0x173/0x190
[    4.209590]  [<ffffffffbc13047e>] SyS_init_module+0xe/0x10
[    4.209592]  [<ffffffffbc003c17>] do_syscall_64+0x67/0x180
[    4.209595]  [<ffffffffbc81cd2b>] entry_SYSCALL64_slow_path+0x25/0x25
[    4.209599] i801_smbus 0000:00:1f.4: Failed to allocate irq 0: -16
[    4.209638] i801_smbus 0000:00:1f.4: SMBus using polling

I have filed a bug here with additional details:

https://bugzilla.redhat.com/show_bug.cgi?id=1415727

Any suggestions of where to go from here?

Thanks,

Wade
