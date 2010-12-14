From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v6 0/5] da850-evm: add gpio-{keys,leds} for UI and BB expanders
Date: Mon, 13 Dec 2010 23:31:09 -0500
Message-ID: <AANLkTin7v4opWvjTt7KLVek=t-Q9_TwhENk+5k-Z3BNW@mail.gmail.com>
References: <cover.1290635422.git.bengardiner@nanometrics.ca>
	<cover.1291931041.git.bengardiner@nanometrics.ca>
	<87tyild2ms.fsf@deeprootsystems.com>
	<AANLkTik78Lb0ejUiAvqbkToi=QAKSXXj_6JaBkPYw70Z@mail.gmail.com>
	<AANLkTi=HiJGwtznGRzFDz-4ywsB3rYPW0yF5U_RUruzV@mail.gmail.com>
	<8762ux49w7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42576 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757833Ab0LNEbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 23:31:11 -0500
In-Reply-To: <8762ux49w7.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Chris Cordahi <christophercordahi@nanometrics.ca>, Paul Mundt <lethal@linux-sh.org>, Sekhar Nori <nsekhar@ti.com>, Gabor Juhos <juhosg@openwrt.org>

On Mon, Dec 13, 2010 at 4:53 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Ben Gardiner <bengardiner@nanometrics.ca> writes:
> [...]
> Yes, there will be double commits in master, because of the way I man=
age
> master using 'git merge -ours'. =A0But there shouldn't be double comm=
its
> between my "rebuild from braches" merges. =A0It can be confusing, but=
 if
> you look at the history with a graphical tool like 'gitk', it might s=
hed
> some light on what is going on.

Ok. I'll consider a graphical investigation. Thanks for confirming the
state of master is as-designed.

> I know it's confusing, but the davinci-next branch is the only import=
ant
> branch in this tree for upstream purposes.

Understood. Thanks for the clarification.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
