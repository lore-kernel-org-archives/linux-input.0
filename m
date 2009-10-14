From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: gpio_get_value in atomic context (was: make gpio-keys use IRQF_SHARED)
Date: Wed, 14 Oct 2009 13:03:20 +0200
Message-ID: <87eip6jkzr.fsf_-_@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<20090916162853.GA4970@core.coreip.homeip.net>
	<87hbuvggfl.fsf@tac.ki.iif.hu>
	<20090922164136.GA22639@core.coreip.homeip.net>
	<87fxae3ile.fsf@tac.ki.iif.hu>
	<20090928170301.GG21455@core.coreip.homeip.net>
	<87fxa3xleg.fsf@tac.ki.iif.hu> <877hv0y1wh.fsf@tac.ki.iif.hu>
	<20091014080437.GF5318@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:48395 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213AbZJNLD5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 07:03:57 -0400
In-Reply-To: <20091014080437.GF5318@core.coreip.homeip.net> (Dmitry Torokhov's
	message of "Wed, 14 Oct 2009 01:04:38 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Mon, Oct 12, 2009 at 07:09:50PM +0200, Ferenc Wagner wrote:
>
>>     The gpio_get_value function may sleep, so it should not be
>>     called in a timer function.
>> 
>> So is drivers/staging/dream/gpio_input.c in error, too?
>
> I guess so. Initially gpio method did not sleep but that has
> changed.

Let's make Arve aware of this then (even though it may not affect
Android in practice).
-- 
Feri.
