From: Jesse Sung <jesse.sung@canonical.com>
Subject: Re: [PATCH resend] N-Trig: change default value of logical/physical
 width/height to 1
Date: Wed, 26 Sep 2012 00:11:15 +0800
Message-ID: <CAH10aOg3WUjovL+mH57kSHas09j0UXGuqwNUJ9xBC4_ZohYcAg@mail.gmail.com>
References: <1347956828-5967-1-git-send-email-jesse.sung@canonical.com>
	<1348570267-15322-1-git-send-email-jesse.sung@canonical.com>
	<50619CE4.2020604@seas.upenn.edu>
	<alpine.LNX.2.00.1209251522590.1391@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41065 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968Ab2IYQLT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 12:11:19 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <jesse.sung@canonical.com>)
	id 1TGXjB-0000Zc-L9
	for linux-input@vger.kernel.org; Tue, 25 Sep 2012 16:11:17 +0000
Received: by dady13 with SMTP id y13so350156dad.19
        for <linux-input@vger.kernel.org>; Tue, 25 Sep 2012 09:11:16 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1209251522590.1391@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org

2012/9/25 Jiri Kosina <jkosina@suse.cz>:
> On Tue, 25 Sep 2012, Rafi Rubin wrote:
>
>> > Since something will be divided by these variables in
>> > show_min_width()/show_min_height() and show_activate_width()/
>> > show_activate_height(), a divided error would be triggered if they are
>> > zero.
>>
>> Fair point about the divide by zero.  Would it be preferable to use real
>> values.  As far as I know these devices all have logical dimensions of
>> 9600x7200.  Unfortunately both logical and physical are used as denominators,
>> so 1 for the physicals is probably sensible.

Rafi,

Thanks for your reply.
Should I change the value of logical (width, height) to (9600, 7200)
instead of (1, 1)?

> Applied, thanks.

Thank you Jiri. :)

Regards,
Jesse
