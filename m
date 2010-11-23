From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 2/4] da850-evm: add UI Expander pushbuttons
Date: Tue, 23 Nov 2010 08:29:17 -0500
Message-ID: <AANLkTi=LHjLS=8EMkh9REOqs0s00wOR2-KGM+HY-Y6Yj@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<95f48a32a0256ecdb7148aa08d16f64928a7e5d8.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EA939@dbde02.ent.ti.com>
	<AANLkTi=HS7ym8n6=hF8vAg2WR33Md5=YRZL2NS7a+F2y@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EB2BE@dbde02.ent.ti.com>
	<AANLkTimRbsmR6xMok8P_wXpQAd1Xykew6_pPhqUWGsEN@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247931247@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53651 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751568Ab0KWN3U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 08:29:20 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247931247@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Sekhar,

On Tue, Nov 23, 2010 at 7:38 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> On Mon, Nov 22, 2010 at 19:20:48, Ben Gardiner wrote:
>> [...]
>> config KEYBOARD_GPIO
>> =A0 =A0 =A0 =A0 default MACH_DAVINCI_DA850_EVM
>> =A0 =A0 =A0 =A0 select INPUT_POLLDEV
>>
>> So 1) gpio-keys functionality is default for the da850evm and 2)
>> whenever gpio-keys is enabled so is INPUT_POLLDEV.
>
> This looks better than what was posted earlier, but I am not
> sure if platforms should influence driver configuration this
> way.
>
> I guess I am just afraid that this makes a precedent for
> many driver config symbols to get replicated in the platform
> Kconfig files.

Ok . I understand your concerns.

> Lets see if others have an opinion on this.

Yes, good idea.  I would welcome more opinions on this and any other
aspects of the patch series.

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
