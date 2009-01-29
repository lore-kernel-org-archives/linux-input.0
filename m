From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and
     clean up maple bus driver (3/3)
Date: Thu, 29 Jan 2009 10:34:43 -0000 (UTC)
Message-ID: <509354d63a44246cefe01bd35eb1374c.squirrel@newgolddream.dyndns.info>
References: <1233186456.6734.16.camel@localhost.localdomain>
    <1233187069.6734.21.camel@localhost.localdomain>
    <1233187750.6734.27.camel@localhost.localdomain>
    <1233188287.6734.32.camel@localhost.localdomain>
    <20090129025754.GC31096@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mk-filter-1-a-1.mail.uk.tiscali.com ([212.74.100.52]:1472 "EHLO
	mk-filter-1-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734AbZA2Kf5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2009 05:35:57 -0500
In-Reply-To: <20090129025754.GC31096@linux-sh.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Adrian McMenamin <adrian@newgolddream.dyndns.info>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@in>

On Thu, January 29, 2009 2:57 am, Paul Mundt wrote:
> On Thu, Jan 29, 2009 at 12:18:07AM +0000, Adrian McMenamin wrote:
>> +	if (!(mdev->function & MAPLE_FUNC_KEYBOARD)) {
>> +		error = EINVAL;
>> +		goto fail;
>> +	}
>>
> What is this all about? If the function doesn't match, you should never
> enter the probe routine in the first place. The bus code should already
> get this right.
>

It does, it is a fragment of old code from when the bus code was wrong
which for reasons which pass understanding I rewrote rather than just
excised.

