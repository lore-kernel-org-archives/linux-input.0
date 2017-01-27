From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH v2] xen, input: try to read screen resolution
 for xen-kbdfront
Date: Fri, 27 Jan 2017 09:14:13 +0100
Message-ID: <feaf5ee6-2a65-af7c-2dfb-ce9af29163ee@suse.com>
References: <20170127071239.913-1-jgross@suse.com>
 <5cbb25fa-2dee-f82f-e656-bc733c67c398@gmail.com>
 <a27287e1-463e-c91b-5a0f-512baf08ef95@suse.com>
 <803639e7-e62e-cce1-6108-05a727612937@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <803639e7-e62e-cce1-6108-05a727612937@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On 27/01/17 08:53, Oleksandr Andrushchenko wrote:
> On 01/27/2017 09:46 AM, Juergen Gross wrote:
>> On 27/01/17 08:21, Oleksandr Andrushchenko wrote:
>>> On 01/27/2017 09:12 AM, Juergen Gross wrote:
>>>> Instead of using the default resolution of 800*600 for the pointing
>>>> device of xen-kbdfront try to read the resolution of the (virtual)
>>>> framebuffer device. Use the default as fallback only.
>>>>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> ---
>>>> V2: get framebuffer resolution only if CONFIG_FB (Dmitry Torokhov)
>>>> ---
>>>>    drivers/input/misc/xen-kbdfront.c | 15 ++++++++++++---
>>>>    1 file changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/input/misc/xen-kbdfront.c
>>>> b/drivers/input/misc/xen-kbdfront.c
>>>> index 3900875..3aae9b4 100644
>>>> --- a/drivers/input/misc/xen-kbdfront.c
>>>> +++ b/drivers/input/misc/xen-kbdfront.c
>>>> @@ -16,6 +16,7 @@
>>>>    #include <linux/kernel.h>
>>>>    #include <linux/errno.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/fb.h>
>>>>    #include <linux/input.h>
>>>>    #include <linux/slab.h>
>>>>    @@ -108,7 +109,7 @@ static irqreturn_t input_handler(int rq, void
>>>> *dev_id)
>>>>    static int xenkbd_probe(struct xenbus_device *dev,
>>>>                      const struct xenbus_device_id *id)
>>>>    {
>>>> -    int ret, i;
>>>> +    int ret, i, width, height;
>>>>        unsigned int abs;
>>>>        struct xenkbd_info *info;
>>>>        struct input_dev *kbd, *ptr;
>>>> @@ -173,9 +174,17 @@ static int xenkbd_probe(struct xenbus_device *dev,
>>>>        ptr->id.product = 0xfffe;
>>>>          if (abs) {
>>>> +        width = XENFB_WIDTH;
>>>> +        height = XENFB_HEIGHT;
>>>> +#ifdef CONFIG_FB
>>>> +        if (registered_fb[0]) {
>>> This still will not help if FB gets registered after kbd+ptr
>> Hmm, so you think I should add a call to fb_register_client() to get
>> events for new registered framebuffer devices?
> yes, but also pay attention to CONFIG_FB_NOTIFY: you may still
> end up w/o notification.

Okay, that's not worse than today.

>> This would probably work. I'll have a try.
>>
>>
>> Thanks,
>>
>> Juergen
> My bigger concern here is that we try to tie keyboard and pointer device
> to the framebuffer. IMO, these are independent parts of the system and
> the relation
> depends on the use-case. One can have graphics enabled w/o framebuffer
> at all, e.g.
> DRM/KMS + OpenGLES + Weston + kbd + ptr...

Again: that's a use case which will work as today. The current defaults
are being used.

The question is whether we should add a module parameter switching off
the automatic adaption of the resolution as there might be use cases
where we don't want this feature.


Juergen
