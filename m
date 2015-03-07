From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: add support for Semtech SX8654 I2C touchscreen controller
Date: Sat, 07 Mar 2015 14:26:45 -0800
Message-ID: <FACD03DB-5CFC-4C18-A185-1031903E3AAE@gmail.com>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com> <20150306182155.GB4540@dtor-ws> <20150307005717.GD26151@dtor-ws> <1425731545.2281.3.camel@tiscali.nl> <20150307212543.GA38770@dtor-ws> <1425765281.2300.17.camel@x220> <64C774DE-93CD-41FB-AF78-301503025592@gmail.com> <1425766340.2300.29.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36137 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbbCGW07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2015 17:26:59 -0500
In-Reply-To: <1425766340.2300.29.camel@x220>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?ISO-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>

On March 7, 2015 2:12:20 PM PST, Paul Bolle <pebolle@tiscali.nl> wrote:
>On Sat, 2015-03-07 at 14:02 -0800, Dmitry Torokhov wrote:
>> On March 7, 2015 1:54:41 PM PST, Paul Bolle <pebolle@tiscali.nl>
>wrote:
>> >By that logic we might as well simplify the logic of
>> >license_is_gpl_compatible() and MODULE_LICENSE() quite a bit. Why
>check
>> >for six variants instead of just one and be done with it?
>> 
>> Because nobody wants to go through  hundreds of drivers and change
>them?
>
>Not fun, but surely doable.
>
>> >Anyhow, "GPL" and "GPL v2" are both allowed but not identical. So,
>> >unless a patch is applied to treat them interchangeably, somehow, in
>> >the module license checking code, 
>> 
>> They are treated interchangeably as far as I can see. Where do you
>see
>> "GPL" is being treated differently than "GPL v2".
>
>I'm not going to explain here why "GPL v2" or "GPL v2 or later" differ.

I was talking about them being treated differently from technological standpoint (i.e. the code), not from legal one.

>
>"GPL" is documented to mean "GPL v2 or later". "GPL v2" is documented
>to
>mean just that (see include/linux/module.h). Again, you're free to
>submit a patch to somehow simplify that. But unless a patch like that
>is
>applied, we should make sure MODULE_LICENSE() matches the actual
>license
>of the module involved.

If you want to fix up input drivers I'll take such patch, but I am sure more such cases will sneak in unless you also make sure that there are tools (such as checkpatch.pl) that can alert developers to the inconsistency.
 


Thanks.

-- 
Dmitry
