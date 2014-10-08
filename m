From: Pramod Gurav <pramod.gurav.etc@gmail.com>
Subject: Re: [PATCH] Input: adp5588-keys: cancel workqueue in failure path
Date: Wed, 8 Oct 2014 15:55:45 +0530
Message-ID: <CAMf-jSkLsSw6EZZCZ-AMqvaRZYhh8oJ6uwvEwZUJXG8SxicEuw@mail.gmail.com>
References: <1412667049-6128-1-git-send-email-pramod.gurav@smartplayin.com>
	<20141007163856.GE16469@dtor-ws>
	<CAMf-jS=jvo2hzULv_MtvbeAq_A2z0aJS2F=1Zx5tPonKsJTrNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:38841 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000AbaJHKZr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 06:25:47 -0400
In-Reply-To: <CAMf-jS=jvo2hzULv_MtvbeAq_A2z0aJS2F=1Zx5tPonKsJTrNg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Oct 8, 2014 at 3:48 PM, Pramod Gurav <pramod.gurav.etc@gmail.com> wrote:
> Hi Dmitry,
>
> On Tue, Oct 7, 2014 at 10:08 PM, Dmitry Torokhov
>

..

> Thanks. I saw the change in your tree. Shouldn't
> cancel_delayed_work_sync(&kpad->work) be called under label
> err_free_mem so that it will executed in case adp5588_read,
> input_register_device, request_irq etc.
> Or else we will still have workqueue instance hanging around.
>

Sorry, Should have read Michael's reply more carefully. I get the
reason behind cancelling workquequq after freeing irq.


-- 
Thanks and Regards
Pramod
