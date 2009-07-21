From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RFC/RFT] serio - switch to using dev_pm_ops
Date: Tue, 21 Jul 2009 22:48:05 +0100
Message-ID: <9b2b86520907211448t24a091e2i6d8ad89f709f35ff@mail.gmail.com>
References: <20090721080612.GC10168@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:42245 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZGUVsH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 17:48:07 -0400
In-Reply-To: <20090721080612.GC10168@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>  drivers/input/serio/serio.c |   30 ++++++++++++++++--------------
>  1 files changed, 16 insertions(+), 14 deletions(-)

> -	if (!serio->suspended && state.event == PM_EVENT_SUSPEND)
> -		serio_cleanup(serio);
> -
> -	serio->suspended = state.event == PM_EVENT_SUSPEND ||
> -			   state.event == PM_EVENT_FREEZE;

> -	if (serio->suspended) {
> -		serio->suspended = false;
> -		serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
> -	}

It looks like you should be able to remove the suspended field of
struct serio.  Or is it used somewhere else?

Regards
Alan
