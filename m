From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] input: add ADC resistor ladder driver
Date: Mon, 1 Aug 2016 13:19:38 -0500
Message-ID: <CAL_JsqKbzP1FfYstGQAf9C_GUt_N21SKpyh1amfOuZ3HEqJYYg@mail.gmail.com>
References: <1469745873-14611-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160801175103.GB3231@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55508 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578AbcHAS4j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Aug 2016 14:56:39 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A235020451
	for <linux-input@vger.kernel.org>; Mon,  1 Aug 2016 18:20:00 +0000 (UTC)
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com [209.85.161.177])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D0E46203DC
	for <linux-input@vger.kernel.org>; Mon,  1 Aug 2016 18:19:59 +0000 (UTC)
Received: by mail-yw0-f177.google.com with SMTP id j12so179699911ywb.2
        for <linux-input@vger.kernel.org>; Mon, 01 Aug 2016 11:19:59 -0700 (PDT)
In-Reply-To: <20160801175103.GB3231@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>

On Mon, Aug 1, 2016 at 12:51 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Jul 29, 2016 at 12:44:33AM +0200, Alexandre Belloni wrote:
>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> A common way of multiplexing buttons on a single input in cheap devices is
>> to use a resistor ladder on an ADC. This driver supports that configuration
>> by polling an ADC channel provided by IIO.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> ---
>>
>> Changes in v5:
>>  - Dmitry's changes
>>  - s/mvolt/millivolt/
>
> Rob, is "millivolt" OK with you?

No, because -microvolt is what is documented in
Documentation/devicetree/bindings/property-units.txt. We could add
millivolt, but I don't really see any reason to as microvolt provides
enough range. I don't want just any units because then it's just at
the whim of the binding author.

Rob
