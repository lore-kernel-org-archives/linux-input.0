From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Behaviour of input-polldev?
Date: Tue, 3 Sep 2013 13:54:45 +0200
Message-ID: <CANq1E4Tr4gigvtTA7mqDgqjGfjGaLM477D2uW4qdFGkySaGPWA@mail.gmail.com>
References: <5225CA65.7030104@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59898 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733Ab3ICLyq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 07:54:46 -0400
Received: by mail-ie0-f172.google.com with SMTP id c11so3796135ieb.3
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 04:54:45 -0700 (PDT)
In-Reply-To: <5225CA65.7030104@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Florian

On Tue, Sep 3, 2013 at 1:39 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello everyone,
>
> I'm in the process of writing an input driver for the Microsoft
> Pixelsense (formerly Surface 2.0). The device only has bulk endpoints
> and consequently needs to be polled regularly. My beta driver uses
> input-polldev for this, and it appears to work nicely, however, I
> couldn't find out how input-polldev behaves if one polling cycle takes
> longer than expected and a new poll would already be triggered while the
> first one is still running?

(CC'ing polldev author Dmitry in case I'm missing something)

input-polldev uses the system-freezable-wq. The related code is
./drivers/input/input-polldev.c:33:
  queue_delayed_work(system_freezable_wq, &dev->work, delay);

Since the wq-rewrite all default workqueues are non-reentrant. That
is, the new work is still scheduled but only executed after the
previous worker returned (in this case, once your ->poll() callback
returns).

Regards
David
