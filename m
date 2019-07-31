From: Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
Date: Wed, 31 Jul 2019 13:46:46 +0200
Message-ID: <20190731114646.GB22537@dell5510>
References: <20190725145719.8344-1-yuehaibing@huawei.com>
 <20190731105927.GA5092@dell5510>
 <20190731110629.GB5092@dell5510>
 <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Reply-To: Petr Vorel <pvorel@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: YueHaibing <yuehaibing@huawei.com>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Hans,

> Please test my patch titled: "HID: logitech-dj: Really fix return value of logi_dj_recv_query_hidpp_devices"
> which should fix this.
Indeed, patch [1] fixed that, thanks :)

> Regards,

> Hans

Kind regards,
Petr

[1] https://patchwork.kernel.org/patch/11064087/
