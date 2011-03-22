From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] input: tsc2005: fix locking issue
Date: Tue, 22 Mar 2011 16:59:02 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103221655370.2634@esdhcp041196.research.nokia.com>
References: <1300724650-6641-1-git-send-email-aaro.koskinen@nokia.com> <20110322061958.GA7990@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:16588 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab1CVPBh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2011 11:01:37 -0400
In-Reply-To: <20110322061958.GA7990@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Mar 2011, Dmitry Torokhov wrote:
> On Mon, Mar 21, 2011 at 06:24:10PM +0200, Aaro Koskinen wrote:
>> Commit 0b950d3 (Input: tsc2005 - add open/close) introduced a
>> locking issue with the ESD watchdog: __tsc2005_disable() is calling
>> cancel_delayed_work_sync() with mutex held, and the work also needs the
>> same mutex.
>>
>> Fix the problem by using cancel_delayed_work() on disable. If
>> the ESD work was running it will check if the device is closed
>> or suspended, and in that case it will do nothing and skip
>> re-arming. cancel_delayed_work_sync() is still needed when the module
>> is removed.
>
> Hmm, indeed. However, instead of moving cancel_delayed_work_sync() to
> remove maybe we should use mutex_trylock() in tsc2005_esd_work()?
> If trylock fails that means that device is in the middle of open/close
> transition. We should just reschedule the work and get out of there.

But I guess the reschedule should not happen if we are in the middle of
close/disable? And without the mutex we cannot know that.

A.
