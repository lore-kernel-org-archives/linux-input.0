From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] HID: hiddev: change hiddev_connect() to return bool
Date: Tue, 20 Oct 2015 08:56:27 +0900
Message-ID: <5625832B.9010908@samsung.com>
References: <1444395633-12672-1-git-send-email-luisbg@osg.samsung.com>
 <CAJKOXPcq8BuVENk=eDAyxyAnRy4YUZy8ibrXxgGb3RZzk55AZg@mail.gmail.com>
 <5625083C.4000207@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:23209 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbJSX4c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2015 19:56:32 -0400
In-reply-to: <5625083C.4000207@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 20.10.2015 00:11, Luis de Bethencourt wrote:
> On 13/10/15 02:49, Krzysztof Kozlowski wrote:
>> 2015-10-09 22:00 GMT+09:00 Luis de Bethencourt <luisbg@osg.samsung.com>:
>>> Since hid_connect() only cares about hiddev_connect() succeeding or
>>> failing, there is no need for this function to return an int and it can
>>> return a bool instead.
>>
>> It can return bool but it would not be in line with kernel coding
>> style. The hiddev_connect() I believe is an action, so "the function
>> should return an error-code integer.".
>>
>> Best regards,
>> Krzysztof
>>
> 
> 
> Hi Krysztof,
> 
> The idea to switch the function to return bool was offered by Jiri Kosina,
> as a result of my initial patch changing the return errno code to ENOMEM.

I did not see the original comment from Jiri. Actually changing it to
ENOMEM makes more sense to me...

> 
> Considering the return isn't propagated by the only consumer of the function,
> and your point about returning an integer being the kernel coding style. It
> doesn't make sense to change this function.

Jiri is the maintainer here but for me sticking to coding convention
(return errno) makes it easier to read.

Best regards,
Krzysztof
