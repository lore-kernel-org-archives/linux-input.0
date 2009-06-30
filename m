From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Tue, 30 Jun 2009 12:13:04 +0530
Message-ID: <5d5443650906292343i5ac0452fq4232147fb4e419a3@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
	 <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
	 <200906112103.54043.dmitry.torokhov@gmail.com>
	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
	 <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
	 <20090629162619.GB24533@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f193.google.com ([209.85.221.193]:57823 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbZF3GnC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2009 02:43:02 -0400
Received: by qyk31 with SMTP id 31so5419405qyk.33
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 23:43:05 -0700 (PDT)
In-Reply-To: <20090629162619.GB24533@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Jun 29, 2009 at 9:56 PM, Dmitry
Torokhov<dmitry.torokhov@gmail.com> wrote:
> Hi Eric,
>
> On Fri, Jun 12, 2009 at 09:26:43PM +0800, Eric Miao wrote:
>>
>> Hi Dmitry,
>>
>> I've tested the driver code, and it's basically OK except for two minor
>> fixes:
>>
>> 1) GPIO and IRQs have to be initialized before input_register_device(),
>> otherwise input->open() will be invoked before that, which will schedule
>> an immediate scan work and fail.
>>
>> 2) disable_irq_rows() called in init_matrix_gpio() so that by default it's
>> initialized to disabled - and will be enabled by input->open()
>>
>
> Could you please take a look at the driver as it is commited to
> 'for-linus' branch of my tree and let me know if you see anything wrong
> there? Otherwise I inted to submit it in my next update to Linus.
>

Are you planning to take "MAX7359 input switch controller driver" too
for submission to Linus in -rc1?

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
