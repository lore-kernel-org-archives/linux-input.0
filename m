From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 2/4] da850-evm: add UI Expander pushbuttons
Date: Tue, 23 Nov 2010 12:58:46 -0500
Message-ID: <AANLkTinCm8rUCDN7zMHiecgfGYLQY_nVrN2ORUHJw8dj@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<95f48a32a0256ecdb7148aa08d16f64928a7e5d8.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EA939@dbde02.ent.ti.com>
	<AANLkTi=HS7ym8n6=hF8vAg2WR33Md5=YRZL2NS7a+F2y@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EB2BE@dbde02.ent.ti.com>
	<AANLkTimRbsmR6xMok8P_wXpQAd1Xykew6_pPhqUWGsEN@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247931247@dbde02.ent.ti.com>
	<8739qshwhm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60987 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754101Ab0KWR6r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 12:58:47 -0500
In-Reply-To: <8739qshwhm.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Kevin,

Thank you for weighing in.

On Tue, Nov 23, 2010 at 10:48 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Nori, Sekhar" <nsekhar@ti.com> writes:
>>> [...]
>>> -- which is less than Ideal. How about I replace the current change=
s
>>> to arch/arm/mach-davinci/Kconfig with:
>>>
>>> config KEYBOARD_GPIO
>>> =A0 =A0 =A0 =A0 default MACH_DAVINCI_DA850_EVM
>>> =A0 =A0 =A0 =A0 select INPUT_POLLDEV
>>>
>>> So 1) gpio-keys functionality is default for the da850evm and 2)
>>> whenever gpio-keys is enabled so is INPUT_POLLDEV.
>>
>> This looks better than what was posted earlier, but I am not
>> sure if platforms should influence driver configuration this
>> way.
>
> Agreed. =A0In general, we should not have machine/platform specific
> conditionals in generic Kconfigs. =A0 Generally, this should be handl=
ed in
> machine/platform specific Kconfigs.

My understanding is that Sekhar was expressing concern over putting
generic config conditionals into machine/platform specific Kconfigs.
It sounds like you are OK with generic config conditionals in
machine/platform specific Kconfigs ala recent pca953x module build
changes [1].

To be clear: I am proposing the following additions to
arch/arm/mach-davinci/Kconfig: (slightly different than above).

config KEYBOARD_GPIO
 =A0 =A0 =A0 =A0 default MACH_DAVINCI_DA850_EVM
 =A0 =A0 =A0 =A0 select INPUT_POLLDEV if MACH_DAVINCI_DA850_EVM

I know it is always better to show the code: I will extract these
contentious Kconfig changes into their own patch in the series when I
post a new version.

Best Regards,
Ben Gardiner

[1] http://article.gmane.org/gmane.linux.davinci/20918

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
