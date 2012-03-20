From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 18/20] Input: atmel_mxt_ts - read num messages, then all
 messages
Date: Tue, 20 Mar 2012 08:28:54 -0700
Message-ID: <4F68A236.3020003@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-19-git-send-email-djkurtz@chromium.org> <4F600355.5040605@samsung.com> <CAGS+omAPBSqs9BZQJ4dLYADE=htZdXOZkAne=eD_4GNLmoUv4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:42137 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760553Ab2CTP26 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 11:28:58 -0400
In-Reply-To: <CAGS+omAPBSqs9BZQJ4dLYADE=htZdXOZkAne=eD_4GNLmoUv4w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Bowens, Alan" <Alan.Bowens@atmel.com>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>

Daniel Kurtz wrote:
> On Wed, Mar 14, 2012 at 10:32 AM, Joonyoung Shim
> <jy0922.shim@samsung.com> wrote:
>> On 03/13/2012 09:04 PM, Daniel Kurtz wrote:
>>>
>>> Implement the MXT DMA method of reading messages.
>>> On an interrupt, the T44 report always contains the number of messages
>>> pending to be read.  So, read 1 byte from T44 in 1 i2c transaction, then
>>> read the N pending messages in a second transaction.
>>
>>
>> My mXT224 chip datasheet hasn't T44 object, is it updated?
>> If not, need to consider chips which doesn't have T44 object.
> 
> I could consider merging the use of T44 with the older 'check reportid
> 0xff' method, but would require help verifying the change with
> hardware that doesn't have T44.
> Does anybody out there have such hardware and is willing to test?

As he said, many maxtouch chips don't have T44. Although for chips that do
have T44, this would be a useful performance improvement.

What are you testing these patches on?

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
