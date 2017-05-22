From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH 1/2] xen/input: use string constants from PV protocol
Date: Mon, 22 May 2017 16:24:48 +0300
Message-ID: <5d6c42c3-20ca-6a8b-2c59-a718cabe0f48@gmail.com>
References: <1492083484-31786-1-git-send-email-andr2000@gmail.com>
 <1492083484-31786-2-git-send-email-andr2000@gmail.com>
 <20170421021100.GC23279@dtor-ws>
 <696b4545-2fb9-4267-8561-55d3f67d83ad@gmail.com>
 <b16fa500-0776-3544-b442-20239d4ffcb1@gmail.com>
 <390ca032-8123-d9d6-734d-e424dce43708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <390ca032-8123-d9d6-734d-e424dce43708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, joculator@gmail.com, al1img@gmail.com, vlad.babchuk@gmail.com, andrii.anisov@gmail.com, olekstysh@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-Id: linux-input@vger.kernel.org

Hi, Dmitry!

It's been quite a while now, I'm just wondering if
you had a chance to look at the patch?

Thank you,
Oleksandr

On 05/12/2017 04:43 PM, Oleksandr Andrushchenko wrote:
> gentle reminder
>
>
> On 05/05/2017 07:43 AM, Oleksandr Andrushchenko wrote:
>> Hello, Dmitry!
>> On 04/21/2017 09:42 AM, Oleksandr Andrushchenko wrote:
>>> On 04/21/2017 05:11 AM, Dmitry Torokhov wrote:
>>>> On Thu, Apr 13, 2017 at 02:38:03PM +0300, Oleksandr Andrushchenko 
>>>> wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>
>>>>> Xen input para-virtual protocol defines string constants
>>>>> used by both back and frontend. Use those instead of
>>>>> explicit strings in the frontend driver.
>>>>>
>>>>> Signed-off-by: Oleksandr Andrushchenko 
>>>>> <oleksandr_andrushchenko@epam.com>
>>>> I'll have to postpone it until I receive changes containing these new
>>>> string constants.
>>> fair enough
>>>>   Otherwise it looks OK.
>>> thank you
>> As all the dependencies are now merged into the kernel,
>> can we please proceed with this patch?
>>
>>>>>   drivers/input/misc/xen-kbdfront.c | 22 +++++++++++++---------
>>>>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/input/misc/xen-kbdfront.c 
>>>>> b/drivers/input/misc/xen-kbdfront.c
>>>>> index 2fc7895373ab..01c27b4c3288 100644
>>>>> --- a/drivers/input/misc/xen-kbdfront.c
>>>>> +++ b/drivers/input/misc/xen-kbdfront.c
>>>>> @@ -135,14 +135,17 @@ static int xenkbd_probe(struct xenbus_device 
>>>>> *dev,
>>>>>           goto error_nomem;
>>>>>         /* Set input abs params to match backend screen res */
>>>>> -    abs = xenbus_read_unsigned(dev->otherend, 
>>>>> "feature-abs-pointer", 0);
>>>>> -    ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend, 
>>>>> "width",
>>>>> +    abs = xenbus_read_unsigned(dev->otherend,
>>>>> +                   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
>>>>> +    ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
>>>>> +                          XENKBD_FIELD_WIDTH,
>>>>>                             ptr_size[KPARAM_X]);
>>>>> -    ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend, 
>>>>> "height",
>>>>> +    ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
>>>>> +                          XENKBD_FIELD_HEIGHT,
>>>>>                             ptr_size[KPARAM_Y]);
>>>>>       if (abs) {
>>>>>           ret = xenbus_write(XBT_NIL, dev->nodename,
>>>>> -                   "request-abs-pointer", "1");
>>>>> +                   XENKBD_FIELD_REQ_ABS_POINTER, "1");
>>>>>           if (ret) {
>>>>>               pr_warning("xenkbd: can't request abs-pointer");
>>>>>               abs = 0;
>>>>> @@ -271,14 +274,15 @@ static int xenkbd_connect_backend(struct 
>>>>> xenbus_device *dev,
>>>>>           xenbus_dev_fatal(dev, ret, "starting transaction");
>>>>>           goto error_irqh;
>>>>>       }
>>>>> -    ret = xenbus_printf(xbt, dev->nodename, "page-ref", "%lu",
>>>>> +    ret = xenbus_printf(xbt, dev->nodename, 
>>>>> XENKBD_FIELD_RING_REF, "%lu",
>>>>>                   virt_to_gfn(info->page));
>>>>>       if (ret)
>>>>>           goto error_xenbus;
>>>>> -    ret = xenbus_printf(xbt, dev->nodename, "page-gref", "%u", 
>>>>> info->gref);
>>>>> +    ret = xenbus_printf(xbt, dev->nodename, XENKBD_FIELD_RING_GREF,
>>>>> +                "%u", info->gref);
>>>>>       if (ret)
>>>>>           goto error_xenbus;
>>>>> -    ret = xenbus_printf(xbt, dev->nodename, "event-channel", "%u",
>>>>> +    ret = xenbus_printf(xbt, dev->nodename, 
>>>>> XENKBD_FIELD_EVT_CHANNEL, "%u",
>>>>>                   evtchn);
>>>>>       if (ret)
>>>>>           goto error_xenbus;
>>>>> @@ -353,7 +357,7 @@ static void xenkbd_backend_changed(struct 
>>>>> xenbus_device *dev,
>>>>>   }
>>>>>     static const struct xenbus_device_id xenkbd_ids[] = {
>>>>> -    { "vkbd" },
>>>>> +    { XENKBD_DRIVER_NAME },
>>>>>       { "" }
>>>>>   };
>>>>>   @@ -390,4 +394,4 @@ module_exit(xenkbd_cleanup);
>>>>>     MODULE_DESCRIPTION("Xen virtual keyboard/pointer device 
>>>>> frontend");
>>>>>   MODULE_LICENSE("GPL");
>>>>> -MODULE_ALIAS("xen:vkbd");
>>>>> +MODULE_ALIAS("xen:" XENKBD_DRIVER_NAME);
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>> Thank you,
>>> Oleksandr
>> Thank you,
>> Oleksandr
>
