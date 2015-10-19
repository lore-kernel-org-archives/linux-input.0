From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: Re: [PATCH v2] HID: hiddev: change hiddev_connect() to return bool
Date: Mon, 19 Oct 2015 16:11:56 +0100
Message-ID: <5625083C.4000207@osg.samsung.com>
References: <1444395633-12672-1-git-send-email-luisbg@osg.samsung.com> <CAJKOXPcq8BuVENk=eDAyxyAnRy4YUZy8ibrXxgGb3RZzk55AZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34282 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbbJSPLr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 11:11:47 -0400
In-Reply-To: <CAJKOXPcq8BuVENk=eDAyxyAnRy4YUZy8ibrXxgGb3RZzk55AZg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 13/10/15 02:49, Krzysztof Kozlowski wrote:
> 2015-10-09 22:00 GMT+09:00 Luis de Bethencourt <luisbg@osg.samsung.com>:
>> Since hid_connect() only cares about hiddev_connect() succeeding or
>> failing, there is no need for this function to return an int and it can
>> return a bool instead.
> 
> It can return bool but it would not be in line with kernel coding
> style. The hiddev_connect() I believe is an action, so "the function
> should return an error-code integer.".
> 
> Best regards,
> Krzysztof
>


Hi Krysztof,

The idea to switch the function to return bool was offered by Jiri Kosina,
as a result of my initial patch changing the return errno code to ENOMEM.

Considering the return isn't propagated by the only consumer of the function,
and your point about returning an integer being the kernel coding style. It
doesn't make sense to change this function.

Thanks for your review!
Luis
 
>>
>> Suggested-by: Jiri Kosina <jikos@kernel.org>
>> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>> ---
>>
>> Hi,
>>
>> No idea why my local build did not complain about the obvious mistake
>> on the previous version of the patch.
>>
>> Sorry about that,
>> Luis
>>
>>  drivers/hid/hid-core.c      |  2 +-
>>  drivers/hid/usbhid/hiddev.c | 10 +++++-----
>>  include/linux/hid.h         |  2 +-
>>  include/linux/hiddev.h      |  2 +-
>>  4 files changed, 8 insertions(+), 8 deletions(-)

