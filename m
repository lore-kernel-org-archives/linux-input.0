From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH] Input: xen-kbdfront - signal the backend that
 we disconnect
Date: Fri, 22 Mar 2019 13:09:22 +0200
Message-ID: <9b814fc6-d130-ec63-65a1-fbfd957de52b@gmail.com>
References: <20190315092348.32613-1-andr2000@gmail.com>
 <32add426-ae36-ecc9-aa3e-6169fe04f231@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32add426-ae36-ecc9-aa3e-6169fe04f231@suse.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, boris.ostrovsky@oracle.com
Cc: Volodymyr_Babchuk@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 3/22/19 1:03 PM, Juergen Gross wrote:
> On 15/03/2019 10:23, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> While disconnecting from the backend we clean up shared resources
>> (event channel, ring buffer), but never let the backend know about
>> that. This may lead to inconsistent backend state and/or shared
>> resources use.
>> Fix this by explicitly letting the backend know that frontend has
>> destroyed shared resources by changing its Xen bus state accordingly.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/input/misc/xen-kbdfront.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
>> index 24bc5c5d876f..ecb6e719e0e2 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -488,6 +488,8 @@ static int xenkbd_connect_backend(struct xenbus_device *dev,
>>   
>>   static void xenkbd_disconnect_backend(struct xenkbd_info *info)
>>   {
>> +	xenbus_switch_state(info->xbdev, XenbusStateClosing);
>> +
>>   	if (info->irq >= 0)
>>   		unbind_from_irqhandler(info->irq, info);
>>   	info->irq = -1;
>>
> As already stated for the related netfront patch: I'm not sure this
> is really what we want. Have you tested xl save/restore or migration
> of the guest with your patch applied?
Well, it comes out that this is not enough and needs much more work,
so please let's abandon this patch
>
> Juergen
Thank you,
Oleksandr
