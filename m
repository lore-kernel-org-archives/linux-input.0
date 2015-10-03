From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: Re: [PATCH] HID: hiddev: fix returned errno code in hiddev_connect()
Date: Sat, 03 Oct 2015 22:34:41 +0100
Message-ID: <561049F1.5040507@osg.samsung.com>
References: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com> <alpine.LNX.2.00.1509302138380.30132@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1509302138380.30132@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 30/09/15 20:40, Jiri Kosina wrote:
> On Wed, 30 Sep 2015, Luis de Bethencourt wrote:
> 
>> The driver is using -1 instead of the -ENOMEM defined macro to specify
>> that a buffer allocation failed. Since the error number is propagated,
>> the caller will get a -EPERM which is the wrong error condition.
> 
> Generally I agree that the more specific errno, the better.
> 
> But I am not really sure where you are seeing the bug (mapping to -EPERM) 
> in this case? I think the only caller of hiddev_connect() should be 
> hid_connect(), and the only thing that guy cares about whether individual 
> callbacks succeed or fail, so that it sets hdev->clamed flags accordingly.
> 
> Could you please be more specific about the -EPERM mapping you are talking 
> about?
> 
> Thanks,
> 

I agree with you. The only caller of hiddev_connect() only checks if the
callback succeded. It checks if the return < 0.
What I meant is that -1 means -EPERM. [0]

This patch is purely about the correctness of using -ENOMEM. The word
"propagated" was not the best way to describe this problem. I could edit
the commit message if you would like.

Thanks for the review,
Luis

[0] http://lxr.free-electrons.com/source/include/uapi/asm-generic/errno-base.h#L15
