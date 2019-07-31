From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
Date: Wed, 31 Jul 2019 19:41:15 +0800
Message-ID: <917e5209-8e58-076d-bb25-0716d7414e5a@huawei.com>
References: <20190725145719.8344-1-yuehaibing@huawei.com>
 <20190731105927.GA5092@dell5510> <20190731110629.GB5092@dell5510>
 <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Petr Vorel <pvorel@suse.cz>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2019/7/31 19:29, Hans de Goede wrote:
> Hi Petr,
> 
> On 31-07-19 13:06, Petr Vorel wrote:
>> Hi,
>>
>>>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
>>>> may return positive value while success now, so check it
>>>> correctly.
>>
>>>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> OK, not only it didn't fix problems with logitech mouse (see below),
>> but removing mouses USB dongle effectively crashes kernel, so this one probably
>> shouldn't be applied :).
>>
>> [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with error 7
>> [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback: logi_dj_recv_query_paired_devices error: 7
> 
> Please test my patch titled: "HID: logitech-dj: Really fix return value of logi_dj_recv_query_hidpp_devices"
> which should fix this.

Yes, this is better one, thanks!

> 
> Regards,
> 
> Hans
> 
> .
> 
