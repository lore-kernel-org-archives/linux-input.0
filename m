From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: haptics devices linux driver support
Date: Sun, 23 Aug 2009 13:21:18 +0530
Message-ID: <5d5443650908230051wa8fa77cu280707281fe450ff@mail.gmail.com>
References: <5d5443650908221004y5b893382m368dc18a38636c1b@mail.gmail.com>
	 <4A902904.2090008@gmail.com>
	 <9c9fda240908222145j1938baa3v3ecf8c5899ce3850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:18804 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbZHWHvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Aug 2009 03:51:18 -0400
In-Reply-To: <9c9fda240908222145j1938baa3v3ecf8c5899ce3850@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi Kyungmin,

On Sun, Aug 23, 2009 at 10:15 AM, Kyungmin Park<kmpark@infradead.org> wrote:
> Hi,
>
> There's three types as I know,
>
> 1) just GPIO enable motor
> 2) GPIO & PWM motor.
> 3) I2C based GPIO & PWM motor.
>
> Frankly we made a motor framework at kernel. but I 'm not sure motor
> is right naming or not.
> I think we need new framework. since it's not input device.

I am looking at 3rd type, and evaulating that for embedded systems
devices having haptics chips can be programmed under drivers/input or
not. It is kind of early discussion and gathering inputs on what could
be lacking part in input subsystem for support such category of
devices.

Is it possible for you to submit your version of code and drivers? It
will be good starting point for discussion.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
