From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: rfkill-input understanding help
Date: Tue, 22 Jan 2008 00:55:37 +0000
Message-ID: <200801220055.39044.carlos@strangeworlds.co.uk>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <d120d5000801111234k5c0faaeeya0c5487ede8f0c19@mail.gmail.com> <200801120032.41263.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:49396 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYAVAzq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2008 19:55:46 -0500
In-Reply-To: <200801120032.41263.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-input@vger.kernel.org

On Saturday 12 January 2008 00:32:40 Carlos Corbacho wrote:
> On Friday 11 January 2008 20:34:09 Dmitry Torokhov wrote:
> > On Jan 11, 2008 2:08 PM, Ivo van Doorn <ivdoorn@gmail.com> wrote:
> > > Perhaps the rfkill-input needs to be registered before input
> > > devices are being registered. But I am not sure, Dmitry propably
> > > knows more about possible ordering requirements for input
> > > device and input trigger registration.
> >
> > No, it is ok for rfkill-input handler to be installed later, but of
> > course it will miss any events that happen before.
>
> Unfortunately, moving the load order of rfkill-input doesn't solve my
> acer-wmi problems:

Some experimentation shows that something is going wrong in input.c - 
rfkill_connect() is not being executed on the first load of rfkill-input.

Shoving some printk's into input.c shows that it fails in 
input_match_handler() on:

	id = input_match_device(handler->id_table, dev);
	if (!id)
		return -ENODEV;

This test always fails for every call of input_match_handler() in 
input_register_handler().

Unloading and reloading rfkill-input then somehow causes this test to not 
fail, and rfkill-input is then properly registered...

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
