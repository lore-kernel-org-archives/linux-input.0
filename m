From: Paul Bolle <pebolle@tiscali.nl>
Subject: MODULE_LICENSE(): "GPL"  vs. "GPL v2" (Was: [PATCH 1/2] Input: add
 support for Semtech SX8654 I2C touchscreen controller)
Date: Wed, 11 Mar 2015 11:56:45 +0100
Message-ID: <1426071405.4244.88.camel@x220>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
	 <20150306182155.GB4540@dtor-ws> <20150307005717.GD26151@dtor-ws>
	 <1425731545.2281.3.camel@tiscali.nl> <20150307212543.GA38770@dtor-ws>
	 <1425765281.2300.17.camel@x220>
	 <64C774DE-93CD-41FB-AF78-301503025592@gmail.com>
	 <1425766340.2300.29.camel@x220>
	 <FACD03DB-5CFC-4C18-A185-1031903E3AAE@gmail.com>
	 <1425767935.2300.48.camel@x220> <20150308045115.GA4054@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:59067 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359AbbCKK4s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 06:56:48 -0400
In-Reply-To: <20150308045115.GA4054@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rusty Russell <rusty@rustcorp.com.au>

[Added Rusty and Dave.]

On Sat, 2015-03-07 at 20:51 -0800, Dmitry Torokhov wrote:
> On Sat, Mar 07, 2015 at 11:38:55PM +0100, Paul Bolle wrote:
> > From a technological standpoint it would be easy to declare "GPL" (or
> > any other string) to mean "GPL v2 compatible", which is, I think, all
> > that matters. But license_is_gpl_compatible() doesn't do that. And I
> > fear that's for a reason. Is my fear unfounded?
> 
> Well we might ask Rusty on the off chance that he remembers but my guess
> would be that he added "GPL v2" in addition to "GPL" and other license
> stings because at the time there was one driver,
> drivers/net/tulip/xircom_tulip_cb.c, that used MODULE_LICENSE("GPL v2").

Dmitry and I discussed the fact that license_is_gpl_compatible() accepts
both "GPL" and "GPL v2" as strings indicating a GPL compatible license.
"GPL" is documented to mean "GNU Public License v2 or later" while "GPL
v2" is documented to mean "GNU Public License v2".

It turns out people regularly confuse these license string. (To
demonstrate just how often I hope to send comments for all patches sent
yesterday and the day before yesterday that I spotted getting that
wrong. I already sent a bunch of similar messages last week.) That's not
surprising, because either one passes the compatibility test, whatever
the actual license of the module might be.

So are these two strings intended to correctly identify to the actual
GPL version(s) of that module? Or is the fact that there are checks for
both strings mostly a result of the way these two strings were
introduced in a few steps? (I'll summarize these steps at the end of
this message.) 


Paul Bolle

0) MODULE_LICENSE() was introduced in v2.4.10. It documented four
"idents" acceptable for free software modules:
    "GPL"                      
    "GPL and additional rights"
    "Dual BSD/GPL"             
    "Dual MPL/GPL"

1) In v2.4.11 the license ident used in
drivers/net/pcmcia/xircom_tulip_cb.c was changed from "GPL" to "GPL v2".

2) In v2.5.40
    "GPL v2"

was also documented as an acceptable free software ident. At that time
only drivers/net/tulip/xircom_tulip_cb.c used that ident.

3) And in v2.5.55 license_is_gpl_compatible() was added. It accepted
both license idents (since it accepted all then documented license
idents). At that time the only user of "GPL v2" was still
drivers/net/tulip/xircom_tulip_cb.c. (At that time there were over a
thousand users of "GPL".)

For comparison: in v4.0-rc3 there are nearly six thousand users of "GPL"
and over a thousand users of "GPL v2".

