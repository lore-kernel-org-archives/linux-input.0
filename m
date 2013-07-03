From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [patch 3/3] Input: cyttsp4 - leak on error path in probe()
Date: Wed, 3 Jul 2013 16:53:23 +0300
Message-ID: <51D42CD3.2000705@cypress.com>
References: <20130702214455.GC1598@elgon.mountain> <51D42350.10504@cypress.com> <20130703135013.GU5714@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay-s04-hub002.domainlocalhost.com ([74.115.207.101]:12219
	"EHLO relay-S04-HUB002.domainlocalhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521Ab3GCNxb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jul 2013 09:53:31 -0400
In-Reply-To: <20130703135013.GU5714@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On 07/03/2013 04:50 PM, Dan Carpenter wrote:
> On Wed, Jul 03, 2013 at 04:12:48PM +0300, Ferruh Yigit wrote:
>> On 07/03/2013 12:44 AM, Dan Carpenter wrote:
>>> We leak "cd" if the cd->xfer_buf allocation fails.  It was weird to
>>> "goto error_gpio_irq" so I changed the label name.  (Label names should
>>> reflect the label location not the goto location otherwise you get an
>>> "all roads lead to Rome problem").
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>> xfer_buf still may not be freed, I propose following one instead:
>>
> That's a good point.  I missed that leak.  The problem is that my
> patch was already applied so this patch would have to be re-written
> on top of that.  Also this patch is whitespace dammaged and won't
> apply.
OK, I am preparing the patch over previous one.

Thanks,
ferruh
This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
