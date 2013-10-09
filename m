From: Wouter van der Graaf <wouter@dynora.nl>
Subject: Re: PROBLEM: XPS 12-9Q33 touchpad not recognized, problem with i2c_hid
 module
Date: Wed, 09 Oct 2013 14:17:47 +0200
Message-ID: <5255496B.9050806@dynora.nl>
References: <525274D2.8080707@dynora.nl> <CAN+gG=GnpGYVfrXL9ZB6mX1p+ODEWWp9SDKYnd_aw7bpCuf8dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail6.webfaction.com ([74.55.86.74]:50217 "EHLO
	smtp.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3JIMRv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 08:17:51 -0400
In-Reply-To: <CAN+gG=GnpGYVfrXL9ZB6mX1p+ODEWWp9SDKYnd_aw7bpCuf8dw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Benjamin,

Thank you very much for your response.

> ok, this is something which was expected to happen at some point (at
> least which does not surprise me :-P ).

Is HID over i2c something new, only found in newer 'ultrabooks'?

> The solution is to write a proper driver for the Synaptics i2c-hid
> touchpad, when in HID mode. I started doing this some months ago, and
> I will have to ping Synaptics again to this extend.

If there is anything I can contribute to, let me know. I'm not a kernel 
dev with any C experience, but I am a developer using Linux 10+ years. 
The least I can do is test the bunch :-)

> However, I will not be able to do anything before Nov. 1st.

That's fine, of course. Is there a way for me to follow progress on this 
issue, e.g. bug tracker? Do you want me to take action?

Again thank you for your time.

Wouter
