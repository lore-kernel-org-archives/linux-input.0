From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 29 Jun 2009 09:26:19 -0700
Message-ID: <20090629162619.GB24533@dtor-d630.eng.vmware.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com> <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com> <200906112103.54043.dmitry.torokhov@gmail.com> <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com> <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:20116 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbZF2Q0f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 12:26:35 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1303510rvb.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 09:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Hi Eric,

On Fri, Jun 12, 2009 at 09:26:43PM +0800, Eric Miao wrote:
> 
> Hi Dmitry,
> 
> I've tested the driver code, and it's basically OK except for two minor
> fixes:
> 
> 1) GPIO and IRQs have to be initialized before input_register_device(),
> otherwise input->open() will be invoked before that, which will schedule
> an immediate scan work and fail.
> 
> 2) disable_irq_rows() called in init_matrix_gpio() so that by default it's
> initialized to disabled - and will be enabled by input->open()
> 

Could you please take a look at the driver as it is commited to
'for-linus' branch of my tree and let me know if you see anything wrong
there? Otherwise I inted to submit it in my next update to Linus.

Thanks!

-- 
Dmitry
