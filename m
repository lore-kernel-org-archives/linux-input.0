From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH] drm: bridge: DRM_SIL_SII8620 should depend on, not
 select INPUT
Date: Mon, 1 Jul 2019 11:26:25 +0200
Message-ID: <d01a9ad5-edcd-81ec-6528-9b6a4e9a8754@samsung.com>
References: <CGME20190701033927epcas2p2d7d0b611a0d32b7b208acc787069a83a@epcas2p2.samsung.com>
        <8baa25c0-498b-d321-4e6a-fe987a4989ba@infradead.org>
        <a7edece4-fec4-5811-27a9-ca6c275a4c40@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a7edece4-fec4-5811-27a9-ca6c275a4c40@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>
Cc: Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 01.07.2019 11:23, Andrzej Hajda wrote:
> On 01.07.2019 05:39, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> A single driver should not enable (select) an entire subsystem,
>> such as INPUT, so change the 'select' to "depends on".
>>
>> Fixes: d6abe6df706c ("drm/bridge: sil_sii8620: do not have a dependency of RC_CORE")
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Inki Dae <inki.dae@samsung.com>
>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>> Linus has written this a couple of times in the last 15 years or so,
>> but my search fu cannot find it.  And there are a few drivers in the
>> kernel tree that do this, but we shouldn't be adding more that do so.
>
> The proper solution has been already posted [1], but it has not been
> applied yet to input tree?
>
> Randy are there chances your patchset will appear in ML in near future,
> or should I merge your sii8620 patch alone?


Ups, I used wrong surname, I meant Ronald, added him input ML to cc.


Regards

Andrzej



>
>
> [1]:
> https://lore.kernel.org/lkml/20190419081926.13567-2-ronald@innovation.ch/
>
>
> Regards
>
> Andrzej
>
>
>
>>  drivers/gpu/drm/bridge/Kconfig |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> --- lnx-52-rc7.orig/drivers/gpu/drm/bridge/Kconfig
>> +++ lnx-52-rc7/drivers/gpu/drm/bridge/Kconfig
>> @@ -83,10 +83,9 @@ config DRM_PARADE_PS8622
>>  
>>  config DRM_SIL_SII8620
>>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>> -	depends on OF
>> +	depends on OF && INPUT
>>  	select DRM_KMS_HELPER
>>  	imply EXTCON
>> -	select INPUT
>>  	select RC_CORE
>>  	help
>>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>>
>>
>>
>>
