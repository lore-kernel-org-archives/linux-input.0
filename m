From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 4/4] da850-evm: add baseboard UI expander buttons,
 switches and LEDs
Date: Fri, 19 Nov 2010 12:15:32 -0500
Message-ID: <AANLkTiniSAbRUkDROyaa9jD28iBd423e3=hqP4+R4uB4@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<d6d59b4a3c34149008f3681e0d6106efa15f354d.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EAA89@dbde02.ent.ti.com>
	<AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
	<20101119170232.GB6236@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60458 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755069Ab0KSRPd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 12:15:33 -0500
In-Reply-To: <20101119170232.GB6236@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Dmitry,

On Fri, Nov 19, 2010 at 12:02 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Another question is why do you want to poll the same device at
> different intervals? The processor is already woken up so it makes sense
> to do as much as possible instead of going to sleep. In your case
> 200/700 for every 1400ms interval you wake an extra time to poll
> switches so unless polling switches takes very long time it is better to
> combine them together (and into one input device, probably).

I see. That is a good question :)

I didn't realize that splitting into two separate input devices with
different polling intervals would have the opposite effect than what I
intended. Thank you for pointing this out. I will definitely integrate
them into one input device polled at 200ms.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
