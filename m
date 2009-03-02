From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] Input: Accelerated touchscreen support for Marvell
	Zylonite
Date: Mon, 2 Mar 2009 14:00:44 +0000
Message-ID: <20090302140044.GA23038@rakim.wolfsonmicro.main>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com> <49ABE2BC.9010401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43554 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751789AbZCBOAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 09:00:47 -0500
Content-Disposition: inline
In-Reply-To: <49ABE2BC.9010401@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 02, 2009 at 02:44:28PM +0100, Jiri Slaby wrote:
> On 2.3.2009 14:23, Mark Brown wrote:

>> +static int pressure;
>> +module_param(pressure, int, 1);

> Weird permissions.

Fixed.

>> +	int count = 16;
>> +	schedule_timeout_uninterruptible(1);

> You meant ssleep(1)?

msleep, but yes.  Shows how old the code is - I'll update.

>> +
>> +	while (count<  16) {

> Weird condition.
> + conding style

Hrm.  This appears to have been mangled somewhere in the mail path to 
you - the indentation is normal in my send-mail folder and in the copy I
got back from the list.


>> +	if (tries>  5) {

> Where is tries defined?

Further up the file as a global static.  I've pulled the variables into
the function since it's the only place they're used.

>> +static int wm97xx_acc_startup(struct wm97xx *wm)
>> +{
>> +	int idx = 0;

> No need to initialize.

Fixed.

>> +static void wm97xx_irq_enable(struct wm97xx *wm, int enable)
>> +{
>> +	if (enable)
>> +		enable_irq(wm->pen_irq);
>> +	else
>> +		disable_irq(wm->pen_irq);

> sync?

Could you expand on this, please?
