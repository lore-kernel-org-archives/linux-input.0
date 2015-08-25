From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCHv2] Input: xpad - Fix double URB submission races
Date: Mon, 24 Aug 2015 21:22:16 -0700
Message-ID: <55DBED78.6060709@redhat.com>
References: <1439252772-28482-1-git-send-email-labbott@fedoraproject.org>
 <20150821165058.GG26302@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbbHYEWR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Aug 2015 00:22:17 -0400
In-Reply-To: <20150821165058.GG26302@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laura Abbott <labbott@fedoraproject.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On 08/21/2015 09:50 AM, Dmitry Torokhov wrote:
> Hi Laura,
>
> On Mon, Aug 10, 2015 at 05:26:12PM -0700, Laura Abbott wrote:
>> v2: Created a proper queue for events instead of just dropping them
>
> How long does it take for the queue to exhaust your memory if you keep
> bombarding the driver with requests?
>

My script which changes the LEDs as fast as possible ran for 7+ hours on
my machine with 16GB of RAM without exhausting all of it. This is also a
very extreme case as almost any kind of delay between sending
commands will drain the queue.
  
> I do not think you need a queue. I believe the nature of LEDs and rumble
> force feedback effect is such that you can discard all requests but the
> latest that arrived between the moment you submitted a request to the
> device and the moment you are ready submit a new one.

So your suggestion is to only keep a single item in the queue?

>
> Thanks.
>

Thanks,
Laura
