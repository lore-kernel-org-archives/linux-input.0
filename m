From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] Input: Add driver for Microchip's CAP1106
Date: Fri, 11 Jul 2014 19:42:27 +0200
Message-ID: <53C02203.50601@zonque.org>
References: <1405064550-12222-1-git-send-email-zonque@gmail.com> <CANq1E4ThSi5x23uzBbjidM9qnLnWYBwAxeg+i8Dmv0HCPR8CZw@mail.gmail.com> <53BFB300.1040500@zonque.org> <20140711173336.GA492@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:36377 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbaGKRma (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2014 13:42:30 -0400
In-Reply-To: <20140711173336.GA492@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "list@mail.zonque.de: HID CORE LAYER" <linux-input@vger.kernel.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org

On 07/11/2014 07:33 PM, Dmitry Torokhov wrote:
> On Fri, Jul 11, 2014 at 11:48:48AM +0200, Daniel Mack wrote:
>> On 07/11/2014 11:43 AM, David Herrmann wrote:
>>>> +static void cap1106_work(struct work_struct *w)
>>>>> +{
>>>>> +       struct cap1106_priv *priv = container_of(w, struct cap1106_priv, work);
>>>>> +       unsigned int status;
>>>>> +       int ret, i;
>>>>> +
>>>>> +       spin_lock(&priv->lock);
>>> If your worker started and is _about_ to take the spinlock, you might
>>> dead-lock with cap1106_close(). They might already hold the spinlock
>>> and then call cancel_work_sync(), thus waiting for this task to take
>>> the lock end exit..
>>>
>>> How about you add "bool closed : 1;" to your cap1106_priv structure
>>> and drop the lock here, but..
>>>
>>
>> Thanks for the review, David. Will look into it and send a v2 with these
>> changes soon.
> 
> Why aren't you using threaded oneshot IRQ for this? Then you would not
> need all this dancing around with worker and enabling/disabling
> interrupt.

Ah, right, that's much nicer indeed.
Thanks for the pointer! I'll post v3 later.


Daniel

