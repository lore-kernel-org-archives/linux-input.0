From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 3/4] da850-evm: extract defines for SEL{A, B, C} pins
 in UI expander
Date: Fri, 19 Nov 2010 10:38:34 -0500
Message-ID: <AANLkTikqdWmD6ze7x3ABqqwOLSuuSbJmKSWJrAgkXemZ@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<aa85c5d83111add3a2ed3495ac13bffe5e6b885d.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EA9EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43746 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752531Ab0KSPig (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 10:38:36 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302477EA9EE@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Sehkar,

On Fri, Nov 19, 2010 at 6:19 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> [...]
> In this case, I think in this case indexed array initialization
> will help keep the offsets and names matched. Here is an untested
> patch on your patch, please consider using it.

I love it. I'll post a re-spin with this patch integrated and you SOB
added. Thank you, Sehkar.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
