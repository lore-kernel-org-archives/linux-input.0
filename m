From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] Input notifier support
Date: Wed, 25 Feb 2009 13:33:14 +0530
Message-ID: <5d5443650902250003g7df7093bn59e0fc052ffb6ed@mail.gmail.com>
References: <20090225044730.GA9106@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:19372 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbZBYIDQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2009 03:03:16 -0500
In-Reply-To: <20090225044730.GA9106@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Kyungmin,

On Wed, Feb 25, 2009 at 10:17 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> Some hardware doesn't connected with key button and led. In this case key should be connected with led by software. Of course each application can control it however it's too big burden to application programmer.
>

I am not able to understand this.

> So add input notifier and then use it at other frameworks such as led.
> Of course, other input device can use this one.

If it is just LED, then you may write some led-input-trigger?

>
> Any commnets are welcome.

Could you please show example driver too, in-order to explain its usage. Thanks.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
