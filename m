From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH v2] xen, input: try to read screen resolution
 for xen-kbdfront
Date: Mon, 30 Jan 2017 12:23:28 +0100
Message-ID: <93add6b1-c9b9-9f96-16d3-994fa9deb6aa@suse.com>
References: <20170127071239.913-1-jgross@suse.com>
 <5cbb25fa-2dee-f82f-e656-bc733c67c398@gmail.com>
 <a27287e1-463e-c91b-5a0f-512baf08ef95@suse.com>
 <803639e7-e62e-cce1-6108-05a727612937@gmail.com>
 <feaf5ee6-2a65-af7c-2dfb-ce9af29163ee@suse.com>
 <3ec171a9-c38a-87e6-d1f6-5493211dc87e@gmail.com>
 <99484bfc-a64f-094c-bb09-3b265bcad40b@suse.com>
 <2844AF83-1C04-4D5C-BC40-B5F70EEAFDA4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52215 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbdA3LXf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 06:23:35 -0500
In-Reply-To: <2844AF83-1C04-4D5C-BC40-B5F70EEAFDA4@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oleksandr Andrushchenko <andr2000@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xen-devel@lists.xenproject.org

On 27/01/17 17:10, Dmitry Torokhov wrote:
> On January 27, 2017 12:31:19 AM PST, Juergen Gross <jgross@suse.com> wrote:
>> On 27/01/17 09:26, Oleksandr Andrushchenko wrote:
>>> On 01/27/2017 10:14 AM, Juergen Gross wrote:
>>>> On 27/01/17 08:53, Oleksandr Andrushchenko wrote:
>>>>> On 01/27/2017 09:46 AM, Juergen Gross wrote:
>>>>>> On 27/01/17 08:21, Oleksandr Andrushchenko wrote:
>>>>>>> On 01/27/2017 09:12 AM, Juergen Gross wrote:
>>>>>>>> Instead of using the default resolution of 800*600 for the
>> pointing
>>>>>>>> device of xen-kbdfront try to read the resolution of the
>> (virtual)
>>>>>>>> framebuffer device. Use the default as fallback only.
>>>>>>>>
>>>>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>>>>> ---
>>>>>>>> V2: get framebuffer resolution only if CONFIG_FB (Dmitry
>> Torokhov)
>>>>>>>> ---
>>>>>>>>     drivers/input/misc/xen-kbdfront.c | 15 ++++++++++++---
>>>>>>>>     1 file changed, 12 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/input/misc/xen-kbdfront.c
>>>>>>>> b/drivers/input/misc/xen-kbdfront.c
>>>>>>>> index 3900875..3aae9b4 100644
>>>>>>>> --- a/drivers/input/misc/xen-kbdfront.c
>>>>>>>> +++ b/drivers/input/misc/xen-kbdfront.c
>>>>>>>> @@ -16,6 +16,7 @@
>>>>>>>>     #include <linux/kernel.h>
>>>>>>>>     #include <linux/errno.h>
>>>>>>>>     #include <linux/module.h>
>>>>>>>> +#include <linux/fb.h>
>>>>>>>>     #include <linux/input.h>
>>>>>>>>     #include <linux/slab.h>
>>>>>>>>     @@ -108,7 +109,7 @@ static irqreturn_t input_handler(int rq,
>> void
>>>>>>>> *dev_id)
>>>>>>>>     static int xenkbd_probe(struct xenbus_device *dev,
>>>>>>>>                       const struct xenbus_device_id *id)
>>>>>>>>     {
>>>>>>>> -    int ret, i;
>>>>>>>> +    int ret, i, width, height;
>>>>>>>>         unsigned int abs;
>>>>>>>>         struct xenkbd_info *info;
>>>>>>>>         struct input_dev *kbd, *ptr;
>>>>>>>> @@ -173,9 +174,17 @@ static int xenkbd_probe(struct
>> xenbus_device
>>>>>>>> *dev,
>>>>>>>>         ptr->id.product = 0xfffe;
>>>>>>>>           if (abs) {
>>>>>>>> +        width = XENFB_WIDTH;
>>>>>>>> +        height = XENFB_HEIGHT;
>>>>>>>> +#ifdef CONFIG_FB
>>>>>>>> +        if (registered_fb[0]) {
>>>>>>> This still will not help if FB gets registered after kbd+ptr
>>>>>> Hmm, so you think I should add a call to fb_register_client() to
>> get
>>>>>> events for new registered framebuffer devices?
>>>>> yes, but also pay attention to CONFIG_FB_NOTIFY: you may still
>>>>> end up w/o notification.
>>>> Okay, that's not worse than today.
>>> agree
>>>>>> This would probably work. I'll have a try.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Juergen
>>>>> My bigger concern here is that we try to tie keyboard and pointer
>> device
>>>>> to the framebuffer. IMO, these are independent parts of the system
>> and
>>>>> the relation
>>>>> depends on the use-case. One can have graphics enabled w/o
>> framebuffer
>>>>> at all, e.g.
>>>>> DRM/KMS + OpenGLES + Weston + kbd + ptr...
>>>> Again: that's a use case which will work as today. The current
>> defaults
>>>> are being used.
>>>>
>>>> The question is whether we should add a module parameter switching
>> off
>>>> the automatic adaption of the resolution as there might be use cases
>>>> where we don't want this feature.
>>> I think for those who doesn't want this resolution there is
>>> still a possibility to change it on backend's XenbusStateConnected
>>> So, no need for module parameter, IMO
>>
>> Fine.
>>
>> I'll send V3 soon.
> 
> How about you do the axis adjustment from userspace (udev rule), and leave kernel as is?

Hmm, is this a good idea?

I'd need a udev rule to trigger when either the pointing device or a
new frame buffer is showing up. In both cases I need to read the
geometry of the frame buffer (in case it exists) and set the geometry
of the pointing device (in case it exists) to the same values. This
seems to be much more complicated than the required changes in the
driver.

I could be wrong, of course, especially as I'm no expert in writing
udev rules. :-)


Juergen
