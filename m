From: Liang Yan <lyan@suse.com>
Subject: Re: [PATCH] input/xen-kbdfront: Enable auto repeat for xen keyboard
 frontend driver
Date: Thu, 24 Aug 2017 08:39:09 -0400
Message-ID: <99296e64-b8b0-7a55-3edc-04af94d51171@suse.com>
References: <20170823181026.8084-1-lyan@suse.com>
 <20170823183648.GA37905@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:59896 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdHXMjd (ORCPT
        <rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
        Thu, 24 Aug 2017 08:39:33 -0400
In-Reply-To: <20170823183648.GA37905@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi, Dmitry

On 8/23/17 2:36 PM, Dmitry Torokhov wrote:
> Hi Liang,
>
> On Wed, Aug 23, 2017 at 02:10:26PM -0400, Liang Yan wrote:
>> Long pressed key could not show right in XEN vncviewer after tigervnc
>> client changed the way how to send repeat keys, from "Down Up Down Up
>> ..." to "Down Down ... Up". By enable EV_REP bit here, XEN keyboard
>> device will trigger default auto repeat process from input subsystem,
>> and make auto repeat keys work correctly.
> I almost applied it, but then I started to wonder: enabling autorepeat
> in guest kernel means that autorepeat settings might differ between the
> VNC client and the guest. Maybe the better fix would be to actually
> assume that backend/client does not send duplicate events, but
> autorepeat events, 
Yeah, you are right, indeed it is a better idea by sending autorepeat
event to handler rather than simulate new "Up" and "Down" events from
input level, really should think deeper. I will send new patch soon,
thanks for the review.

Thanks,
Liang
> and do the following in xenkbd_handle_key_event():
>
> static void xenkbd_handle_key_event(struct xenkbd_info *info,
> 				    struct xenkbd_key *key)
> {
> 	struct input_dev *dev;
> 	int value = key->pressed;
>
> 	if (test_bit(key->keycode, info->ptr->keybit)) {
> 		dev = info->ptr;
> 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
> 		dev = info->kbd;
> 		/* See if the key is already pressed */
> 		if (test_bit(key->keycode, info->kbd->key))
> 			value = 2; /* Report autorepeat */
> 	} else {
> 		pr_warn("unhandled keycode 0x%x\n", key->keycode);
> 		return;
> 	}
>
> 	input_event(dev, EV_KEY, key->keycode, value);
> 	input_sync(dev);
> }
>
> Thanks.
>
>> Signed-off-by: Liang Yan <lyan@suse.com>
>> ---
>>  drivers/input/misc/xen-kbdfront.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
>> index fa130e7b734c..0dce9830e2f4 100644
>> --- a/drivers/input/misc/xen-kbdfront.c
>> +++ b/drivers/input/misc/xen-kbdfront.c
>> @@ -248,6 +248,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
>>  	kbd->id.product = 0xffff;
>>  
>>  	__set_bit(EV_KEY, kbd->evbit);
>> +	__set_bit(EV_REP, kbd->evbit);
>>  	for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
>>  		__set_bit(i, kbd->keybit);
>>  	for (i = KEY_OK; i < KEY_MAX; i++)
>> -- 
>> 2.14.1
>>

