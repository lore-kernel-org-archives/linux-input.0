From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Add support for HTC Shift Touchscreen
Date: Sun, 18 May 2008 12:39:29 +0300
Message-ID: <84144f020805180239t4c4952e6i7dcaa224a53bebb7@mail.gmail.com>
References: <482ED31E.2000009@eslack.org> <482F09FC.9050403@eslack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:19855 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYERJja (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2008 05:39:30 -0400
Received: by rv-out-0506.google.com with SMTP id l9so893523rvb.1
        for <linux-input@vger.kernel.org>; Sun, 18 May 2008 02:39:29 -0700 (PDT)
In-Reply-To: <482F09FC.9050403@eslack.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pau Oliva Fora <pau@eslack.org>
Cc: dmitry.torokhov@gmail.com, sam@ravnborg.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 17, 2008 at 7:38 PM, Pau Oliva Fora <pau@eslack.org> wrote:
>>> +struct input_dev *htcpen_dev;
>>
>> Why are you not using isa_register_driver() instead?
>
> I have no specifications from the manufacturer, so don't know how to
> properly prove the device, etc.

You can still use isa_register_driver() which is nicer IMHO.

On Sat, May 17, 2008 at 7:38 PM, Pau Oliva Fora <pau@eslack.org> wrote:
>>> +       printk(KERN_INFO "htcpen: module inserted\n");
>>> +
>>> +       inb_p(HTCPEN_PORT0);
>>
>> So there's no way to probe the existence of this device?
>
> I can add a minimal sanity check if that is a must, but I don't have
> a datasheet and contacting HTC did not help.

Well, you probably want distributions to be able to enable this by
default so any kind probing is helpful, yes.
