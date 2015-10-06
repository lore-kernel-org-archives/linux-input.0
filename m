From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: Re: [PATCH] HID: hiddev: fix returned errno code in hiddev_connect()
Date: Tue, 06 Oct 2015 09:58:54 +0100
Message-ID: <56138D4E.1070008@osg.samsung.com>
References: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com> <alpine.LNX.2.00.1509302138380.30132@pobox.suse.cz> <561049F1.5040507@osg.samsung.com> <alpine.LNX.2.00.1510051616280.2758@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47435 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbbJFI65 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Oct 2015 04:58:57 -0400
In-Reply-To: <alpine.LNX.2.00.1510051616280.2758@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 05/10/15 15:24, Jiri Kosina wrote:
> On Sat, 3 Oct 2015, Luis de Bethencourt wrote:
> 
>>> But I am not really sure where you are seeing the bug (mapping to 
>>> -EPERM) in this case? I think the only caller of hiddev_connect() 
>>> should be hid_connect(), and the only thing that guy cares about 
>>> whether individual callbacks succeed or fail, so that it sets 
>>> hdev->clamed flags accordingly.
>>>
>>> Could you please be more specific about the -EPERM mapping you are 
>>> talking about?
>>>
>> I agree with you. The only caller of hiddev_connect() only checks if the
>> callback succeded. It checks if the return < 0.
>> What I meant is that -1 means -EPERM. [0]
> 
> I still don't understand what problem you are chasing here, sorry. EPERM 
> is defined to be 1, yes. So are many other completely unrelated #defines.
> 
>> This patch is purely about the correctness of using -ENOMEM. The word 
>> "propagated" was not the best way to describe this problem. I could edit 
>> the commit message if you would like.
> 
> You seem to imply that someone might be interpreting that -1 as a define 
> from errno.h. But that's not the case.
> 
> Are you going to look at every 'return -1' occurence in the kernel and 
> convert it to something else? That can keep you busy for quite some time:
> 
> 	$ git grep 'return -1' | wc -l
> 	9167
> 
> The only cleanup I'd imagine at least remotely possible in this case would 
> be to convert the ->connect() callbacks return bool.
> 

This is a very good point. I will write a second version of the patch that
converts the return to a boolean.

Thanks for the review,
Luis
