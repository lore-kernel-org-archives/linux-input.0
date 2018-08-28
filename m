From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: core: fix memory leak on probe
Date: Tue, 28 Aug 2018 14:07:35 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1808281407170.25787@cbobk.fhfr.pm>
References: <20180828112955.11318-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828112955.11318-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 28 Aug 2018, Stefan Agner wrote:

> The dynamically allocted collection stack does not get freed in
> all situations. Make sure to also free the collection stack when
> using the parser in hid_open_report().
> 
> Fixes: 08a8a7cf1459 ("HID: core: do not upper bound the collection stack")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Found with kmemleak:
> 
> unreferenced object 0xc57f0700 (size 64):
>   comm "kworker/0:1", pid 20, jiffies 131383 (age 28.750s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 02 00 00 00 00 00 00 00 68 80 c5  .............h..
>     80 07 7f c5 01 00 00 00 08 48 80 c5 08 48 80 c5  .........H...H..
>   backtrace:
>     [<1b437483>] __kmalloc_track_caller+0x1dc/0x300
>     [<ecd3baad>] krealloc+0x54/0xc0
>     [<c565bd75>] hid_parser_main+0x258/0x2c8
>     [<210b9aaa>] hid_open_report+0x134/0x2ac
>     [<61cd8964>] hid_generic_probe+0x20/0x38
>     [<e02107d6>] hid_device_probe+0xdc/0x13c
>     [<334f035e>] really_probe+0x1d8/0x2c4
>     [<351dc2c0>] driver_probe_device+0x68/0x184
>     [<7e3e3d3c>] __device_attach_driver+0xa0/0xd4
>     [<1b053a89>] bus_for_each_drv+0x60/0xc0
>     [<732716d8>] __device_attach+0xdc/0x144
>     [<dd3a0e76>] device_initial_probe+0x14/0x18
>     [<f3a47b76>] bus_probe_device+0x90/0x98
>     [<d5a1f0b4>] device_add+0x424/0x62c
>     [<46595a15>] hid_add_device+0x108/0x2b8
>     [<a0e2824c>] usbhid_probe+0x2d4/0x3bc

Also queued for 4.19. Thank you Stefan,

-- 
Jiri Kosina
SUSE Labs
