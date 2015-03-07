From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: add support for Semtech SX8654 I2C touchscreen controller
Date: Sat, 07 Mar 2015 14:02:27 -0800
Message-ID: <64C774DE-93CD-41FB-AF78-301503025592@gmail.com>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com> <20150306182155.GB4540@dtor-ws> <20150307005717.GD26151@dtor-ws> <1425731545.2281.3.camel@tiscali.nl> <20150307212543.GA38770@dtor-ws> <1425765281.2300.17.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37187 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbbCGWCs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2015 17:02:48 -0500
In-Reply-To: <1425765281.2300.17.camel@x220>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?ISO-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>

On March 7, 2015 1:54:41 PM PST, Paul Bolle <pebolle@tiscali.nl> wrote:
>On Sat, 2015-03-07 at 13:25 -0800, Dmitry Torokhov wrote:
>> I am not sure if anyone cares about exact version of GPL in module
>> information (2 only vs 2+) since it only used to figure out if the
>> module taints kernel or not. In fact there are more modules that are
>v2
>> only that claim GPL than the ones claiming GPL v2.
>> 
>> dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l
>'MODULE_LICENSE("GPL")'`; do grep -H '2 as published' $file; done | wc
>-l
>> 259
>> dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l
>'MODULE_LICENSE("GPL v2")'`; do grep -H '2 as published' $file; do ne |
>wc -l
>> 150
>> 
>> Also:
>> 
>> dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l
>'MODULE_LICENSE("GPL v2")'`; do grep -H '2 or ' $file; done | wc -l
>> 68
>> dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l
>'MODULE_LICENSE("GPL")'`; do grep -H '2 or ' $file; done | wc -l
>> 237
>
>By that logic we might as well simplify the logic of
>license_is_gpl_compatible() and MODULE_LICENSE() quite a bit. Why check
>for six variants instead of just one and be done with it?

Because nobody wants to go through  hundreds of drivers and change them?

>
>Anyhow, "GPL" and "GPL v2" are both allowed but not identical. So,
>unless a patch is applied to treat them interchangeably, somehow, in
>the
>module license checking code, 

They are treated interchangeably as far as I can see. Where do you see "GPL" is being treated differently than "GPL v2".

> we ought to make each instance of
>MODULE_LICENSE() match the actual license of the module it's used for.
>
>Yes, that's annoying. You're free to submit a patch to end all the
>busywork this brings along. But I fear there's a reason for all that
>busywork. Please prove me wrong. It would make everyone's life a bit
>easier.
>
>
>Paul Bolle


Thanks.

-- 
Dmitry
