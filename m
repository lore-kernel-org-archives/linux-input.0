From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Input notifier support
Date: Wed, 25 Feb 2009 18:55:58 +0900
Message-ID: <9c9fda240902250155p107fb657wafcd4aa92f7e093d@mail.gmail.com>
References: <20090225044730.GA9106@july>
	 <5d5443650902250003g7df7093bn59e0fc052ffb6ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:6831 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbZBYJ4B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2009 04:56:01 -0500
In-Reply-To: <5d5443650902250003g7df7093bn59e0fc052ffb6ed@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi,

On Wed, Feb 25, 2009 at 5:03 PM, Trilok Soni <soni.trilok@gmail.com> wrote:
> Hi Kyungmin,
>
> On Wed, Feb 25, 2009 at 10:17 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>> Some hardware doesn't connected with key button and led. In this case key should be connected with led by software. Of course each application can control it however it's too big burden to application programmer.
>>
>
> I am not able to understand this.

it's simple there's one led and it's for key input. so when there's
key input, it's blink. that's all

>
>> So add input notifier and then use it at other frameworks such as led.
>> Of course, other input device can use this one.
>
> If it is just LED, then you may write some led-input-trigger?

Please see the LED key input trigger patch.

Thank you,
Kyungmin Park
