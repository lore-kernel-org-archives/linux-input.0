From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: add support for Semtech SX8654 I2C
 touchscreen controller
Date: Sat, 7 Mar 2015 13:25:43 -0800
Message-ID: <20150307212543.GA38770@dtor-ws>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
 <20150306182155.GB4540@dtor-ws>
 <20150307005717.GD26151@dtor-ws>
 <1425731545.2281.3.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35295 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbCGVZt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2015 16:25:49 -0500
Content-Disposition: inline
In-Reply-To: <1425731545.2281.3.camel@tiscali.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>

On Sat, Mar 07, 2015 at 01:32:25PM +0100, Paul Bolle wrote:
> Dmitry Torokhov schreef op vr 06-03-2015 om 16:57 [-0800]:
> > Applied with some cosmetic edits and DT bindings folded into this patch.
> 
> Was one of these cosmetic edits perhaps an edit to use
>     MODULE_LICENSE("GPL v2");
> 
> in sx8654.c?

No it wasn't.

> That would make that macro match the license stated in the
> comment at the top of that file.

I am not sure if anyone cares about exact version of GPL in module
information (2 only vs 2+) since it only used to figure out if the
module taints kernel or not. In fact there are more modules that are v2
only that claim GPL than the ones claiming GPL v2.

dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l 'MODULE_LICENSE("GPL")'`; do grep -H '2 as published' $file; done | wc -l
259
dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l 'MODULE_LICENSE("GPL v2")'`; do grep -H '2 as published' $file; do ne | wc -l
150

Also:

dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l 'MODULE_LICENSE("GPL v2")'`; do grep -H '2 or ' $file; done | wc -l
68
dtor@dtor-ws:~/kernel/master$ for file in `grep -r -l 'MODULE_LICENSE("GPL")'`; do grep -H '2 or ' $file; done | wc -l
237

Thanks.

-- 
Dmitry
