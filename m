From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Input: Let the FT5x06 driver build without debugfs
Date: Fri, 17 Aug 2012 12:21:34 -0700
Message-ID: <87boi91g01.fsf@xmission.com>
References: <87k3wy1ii3.fsf@xmission.com> <502DFC1D.20903@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:45384 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2HQTWF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Aug 2012 15:22:05 -0400
In-Reply-To: <502DFC1D.20903@kernelconcepts.de> (Simon Budig's message of
	"Fri, 17 Aug 2012 10:09:01 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Simon Budig <simon.budig@kernelconcepts.de> writes:

> On 08/17/2012 02:15 AM, Eric W. Biederman wrote:
>> When testing to make certain my user namespace code works in
>> various configurations I tripped over the tf5x06.c not building
>> with debugfs disabled.
>
> Sorry for that.
>
> There already is a patch for this issue which I slightly prefer. You
> can find it in the mail from Guenther Roeck:
>    http://www.mail-archive.com/linux-input@vger.kernel.org/msg00646.html

If you guys could get that merged into 3.6 I would appreciate it.

Thanks,
Eric
