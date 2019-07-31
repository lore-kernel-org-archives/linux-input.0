From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
Date: Wed, 31 Jul 2019 12:59:27 +0200
Message-ID: <20190731105927.GA5092@dell5510>
References: <20190725145719.8344-1-yuehaibing@huawei.com>
Reply-To: Petr Vorel <pvorel@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725145719.8344-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

> In delayedwork_callback(), logi_dj_recv_query_paired_devices
> may return positive value while success now, so check it
> correctly.

> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
