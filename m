From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 02/12] Input: synaptics - do not invert y if 0
Date: Wed, 6 Jul 2011 07:02:43 +0800
Message-ID: <CAGS+omBzzKWn+RgQ9m09F=F4HLqwH7=U6O4mO9dRw52V5k45hw@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-3-git-send-email-djkurtz@chromium.org> <20110704210838.GA23915@polaris.bitmath.org>
 <CAGS+omDXhiZz2i5eniu_eOCES1Eq_fKs4JVWU-+wz6ot7kyhSA@mail.gmail.com> <20110705180712.GA29224@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:14495 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1GEXDG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:03:06 -0400
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com [172.25.105.79])
	by smtp-out.google.com with ESMTP id p65N34wX030200
	for <linux-input@vger.kernel.org>; Tue, 5 Jul 2011 16:03:05 -0700
Received: from yxl11 (yxl11.prod.google.com [10.190.3.203])
	by kpbe15.cbf.corp.google.com with ESMTP id p65N33cj004703
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 5 Jul 2011 16:03:03 -0700
Received: by yxl11 with SMTP id 11so1640819yxl.21
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:03:03 -0700 (PDT)
In-Reply-To: <20110705180712.GA29224@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jul 6, 2011 at 2:07 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > > In some cases, however, y = 0 is sent by the touchpad.
>> > > In these cases, the kernel driver should not invert, and just report 0.
>> > >
>> > > This patch also refactors the inversion into a macro, and moves it
>> > > into packet processing instead of during position reporting.
>> >
>> > The patch seems to invert the current output?
>>
>> By 'current' do you mean referenced from the previous implementation?
>> Or referenced from the raw input.
>> It does indeed invert the raw input.
>> This is the same as the previous implementation did.
>> The difference is that it does not also invert the special 'y=0' into
>> an arbitrarily large value.
>> Is this your concern?
>
> It would be clearer to just change the argument of the
> input_report_abs() instances, would it not? An explanation why zero,
> outside the value range, should be output also needs a rationale. It
> would seem such packets should be masked somehow.

Actually, I think it is clearer to change all the y's in one function,
during parsing, rather than scattered about in various output
functions.

I'm sorry, I think I was misleading in my commit message.  This change
doesn't affect how packets get masked.  The y=0 is not handled
differently now that it is no longer inverted.  If it wasn't sent to
userspace before, it still won't be sent.

The older inverted y=0 was also, by definition, out of range, so
hopefully those packets are masked, and continue to be masked.  Not
inverting y=0 just makes it a bit easier to debug the driver, by
slightly more accurately parsing the incoming raw data.

>
> Thanks,
> Henrik
>
