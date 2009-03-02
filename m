From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] Input: Accelerated touchscreen support for Marvell
 Zylonite
Date: Mon, 02 Mar 2009 15:15:13 +0100
Message-ID: <49ABE9F1.9060201@gmail.com>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com> <49ABE2BC.9010401@gmail.com> <20090302140044.GA23038@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:43074 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZCBOPS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 09:15:18 -0500
In-Reply-To: <20090302140044.GA23038@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 2.3.2009 15:00, Mark Brown wrote:
> On Mon, Mar 02, 2009 at 02:44:28PM +0100, Jiri Slaby wrote:
>> On 2.3.2009 14:23, Mark Brown wrote:
>>> +	int count = 16;
>>> +	schedule_timeout_uninterruptible(1);
[...]
>>> +	while (count<   16) {
>
>> Weird condition.
>> + conding style
>
> Hrm.  This appears to have been mangled somewhere in the mail path to
> you - the indentation is normal in my send-mail folder and in the copy I
> got back from the list.

OK, anyway the condition looks weird on a semantic layer.

>>> +static void wm97xx_irq_enable(struct wm97xx *wm, int enable)
>>> +{
>>> +	if (enable)
>>> +		enable_irq(wm->pen_irq);
>>> +	else
>>> +		disable_irq(wm->pen_irq);
>
>> sync?
>
> Could you expand on this, please?

No, I was wrong, ignore this one. It's called from within the interrupt 
it disables.
