From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: Input: add MAX7359 key switch controller driver
Date: Sat, 9 May 2009 12:56:51 +0900
Message-ID: <4d34a0a70905082056g599aef37i46b0db46854bab51@mail.gmail.com>
References: <4A012C64.1020101@samsung.com> <20090508031859.GE30616@dtor-d630.eng.vmware.com>
	<4d34a0a70905081858y56dacf34of004301f93daf3e3@mail.gmail.com>
	<200905082036.26204.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:22223 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbZEID5L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2009 23:57:11 -0400
In-Reply-To: <200905082036.26204.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Sat, May 9, 2009 at 12:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Kim,
>
> On Friday 08 May 2009 18:58:45 Kim Kyuwon wrote:
>> By the way, can I ask the same question which I ask to Trilok.
>> Even though I guard suspend/resume with #ifdef CONFIG_PM in the new
>> patch, Could I know the good reason for this protection? Because
>> '/Documentation/SubmittingPatches' says "ifdefs are ugly"
>
> If kernel is compiled without CONFIG_PM then these functions would
> be just dead weight. Generally speaking, #ifdefs are considered ugly
> if they are in the middle of function code, affecting logic. But to
> to compile out unneeded functionality they are OK. That's why you
> often see in the kernel
>
> #ifdef CONFIG_BAZ
> void do_baz()
> {
>        .. real code ..
> }
> #else
> void do_baz()
> {
> }
> #endif
>
> and then...
>
> int foo()
> {
>        bar1();
>        bar2();
>        do_baz();
>        bar3();
> }
>
>
> As you can see, foo()'s logic stays the same, there are no #ifdefs
> cluttering it, but baz code either executed or not.
>
> Hope this helps.

Thank you for your kind explanation. It is very helpful to me and my colleagues.

Kyuwon
