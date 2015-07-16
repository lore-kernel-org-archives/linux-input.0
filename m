From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: zforce - use irq handler instead of gpio
 polling
Date: Thu, 16 Jul 2015 10:43:41 -0700
Message-ID: <20150716174341.GC32571@dtor-ws>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
 <20150713170413.GB5039@dtor-ws>
 <55A4BD48.9000705@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f196.google.com ([209.85.223.196]:33115 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbbGPRnp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 13:43:45 -0400
Received: by iesj1 with SMTP id j1so4437766ies.0
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 10:43:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55A4BD48.9000705@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On Tue, Jul 14, 2015 at 09:42:00AM +0200, Dirk Behme wrote:
> Hi Dmitry,
> 
> On 13.07.2015 19:04, Dmitry Torokhov wrote:
> >On Mon, Jul 13, 2015 at 02:49:37PM +0200, Dirk Behme wrote:
> >>From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> >>
> >>Remove the IRQ GPIO polling and request. Existing DTS should not be affected
> >>since the IRQ registration was and is based on "interrupts" descriptor of DTS.
> >
> >But this means that consecutive touchscreen readings will be delayed by
> >the time it takes to schedule the thread.
> >
> >What is the motivation for this change?
> 
> 
> This is the generic part we've done for a special hardware
> configuration: There is some hardware which uses an I2C Serializer /
> Deserializer (SerDes) to communicate with the zFroce touch driver.
> In this case the SerDes will be configured as an interrupt
> controller and the zForce driver will have no access to poll the
> GPIO line.

In this case can we make gpio optional and use it if it is specified
falling back on one read per ISR invocation in its absence?

Thanks.

-- 
Dmitry
