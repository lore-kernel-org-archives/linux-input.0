From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
Date: Mon, 5 Aug 2019 10:51:33 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908051051080.5899@cbobk.fhfr.pm>
References: <20190725145719.8344-1-yuehaibing@huawei.com> <20190731105927.GA5092@dell5510> <20190731110629.GB5092@dell5510> <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>, YueHaibing <yuehaibing@huawei.com>, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 31 Jul 2019, Hans de Goede wrote:

> >>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
> >>> may return positive value while success now, so check it
> >>> correctly.
> > 
> >>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of
> >>> Fixes: logi_dj_recv_query_hidpp_devices")
> >>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > OK, not only it didn't fix problems with logitech mouse (see below),
> > but removing mouses USB dongle effectively crashes kernel, so this one
> > probably
> > shouldn't be applied :).
> > 
> > [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with
> > error 7
> > [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback:
> > logi_dj_recv_query_paired_devices error: 7
> 
> Please test my patch titled: "HID: logitech-dj: Really fix return value of
> logi_dj_recv_query_hidpp_devices"
> which should fix this.

Hans, have I been CCed on that patch? I don't seem to see it in in inbox.

Thanks,

-- 
Jiri Kosina
SUSE Labs
