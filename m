From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Wed, 7 Oct 2015 01:31:28 +0200
Message-ID: <561459D0.4080300@osg.samsung.com>
References: <20151006185155.GA8997@mwanda>
 <20151006225726.545f4ce5@heffalump.sk2.org>
 <20151006230150.598b24f0@heffalump.sk2.org>
 <561441F5.4070806@osg.samsung.com> <20151006224938.GE31850@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47565 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbbJFXbc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Oct 2015 19:31:32 -0400
In-Reply-To: <20151006224938.GE31850@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Kitt <steve@sk2.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org

Hello Dmitry,

On 10/07/2015 12:49 AM, Dmitry Torokhov wrote:
> On Tue, Oct 06, 2015 at 11:49:41PM +0200, Javier Martinez Canillas wrote:
>> Hello Stephen,
>>
>> On 10/06/2015 11:01 PM, Stephen Kitt wrote:
>>> On Tue, 6 Oct 2015 22:57:26 +0200, Stephen Kitt <steve@sk2.org> wrote:
>>>> On Tue, 6 Oct 2015 21:51:55 +0300, Dan Carpenter <dan.carpenter@oracle.com>
>>>> wrote:
>>>>> The patch 999b874f4aa3: "Input: joydev - validate axis/button maps
>>>>> before clobbering current ones" from Aug 25, 2009, leads to the
>>>>> following static checker warning:
>>>>>
>>>>> 	drivers/input/joydev.c:466 joydev_handle_JSIOCSAXMAP()
>>>>> 	error: 'abspam' dereferencing possible ERR_PTR()
>>>>>
>>>>> drivers/input/joydev.c
>>>>>    437  static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
>>>>>    438                                       void __user *argp, size_t
>>>>> len) 439  {
>>>>>    440          __u8 *abspam;
>>>>>    441          int i;
>>>>>    442          int retval = 0;
>>>>>    443  
>>>>>    444          len = min(len, sizeof(joydev->abspam));
>>>>>    445  
>>>>>    446          /* Validate the map. */
>>>>>    447          abspam = memdup_user(argp, len);
>>>>>    448          if (IS_ERR(abspam)) {
>>>>>    449                  retval = PTR_ERR(abspam);
>>>>>    450                  goto out;
>>>>>
>>>>> out labels are error prone.  It's safer to return directly.
>>>>>
>>>>> https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ
>>>>>
>>>>> joydev_handle_JSIOCSBTNMAP() has the same issue.
>>>>
>>>> Perhaps I'm missing something here, but that's not the code I wrote, nor is
>>>> it the code that's currently in the kernel. What I have in my copy of the
>>>> kernel tree is
>>>>
>>>>         /* Validate the map. */
>>>>         abspam = kmalloc(len, GFP_KERNEL);
>>>>         if (!abspam)
>>>>                 return -ENOMEM;
>>>>
>>>> which does as you recommend. If you look up the commit you're referring to
>>>> you'll see that's also the code as I wrote it back in 2009; I'm not sure
>>>> where your IS_ERR() and PTR_ERR() stuff is coming from.
>>>
>>> After further investigation I'm guessing this is
>>> https://lkml.org/lkml/2015/10/2/370, so cc'ing Javier and Dmitry.
>>>
>>
>> It is indeed a bug introduced by my "cleanup" patch, sorry for the mess :(
>>
>> I double checked when posting the patch but got confused and used the old
>> error logic. Following is a fixup patch [0].
>>
>> I don't know if Dmitry prefers to squash with the other patch since it
>> didn't hit mainline yet or if not I can post it as a proper patch so he
>> can pick it on his next branch.
> 
> The original patch is buried under a merge so I'll just apply this one
> without squashing.
> 
> Thanks.
> 

Ok, I just posted to the list as a proper patch then and also
added Dan's Reported-by tag. Again, sorry for the issue.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
