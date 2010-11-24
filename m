From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
Date: Wed, 24 Nov 2010 15:28:32 -0500
Message-ID: <AANLkTinjRRkpzEmgCzNpKTkSNwTr30M5KdHHEQ33Y11R@mail.gmail.com>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
	<1290524800-21419-10-git-send-email-juhosg@openwrt.org>
	<AANLkTikQ=oen3jmz=BfY7y=s6Qo7R8DQ1-79puby-Snt@mail.gmail.com>
	<4CED5F83.6070301@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41130 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756449Ab0KXU2e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 15:28:34 -0500
Received: by mail-vw0-f54.google.com with SMTP id 9so146127vws.41
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 12:28:33 -0800 (PST)
In-Reply-To: <4CED5F83.6070301@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>, Cliff Holden <Cliff.Holden@atheros.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

Hi Gabor,

On Wed, Nov 24, 2010 at 1:54 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> Hi Ben,
>> [...]
>> Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>
>
> Thanks!

You are most welcome.

>[...]
>
> Thank you for the valuable comments. I will create a new patch.

Actually, I've done a little hacking on the patch here while
integrating with the da850-evm changes. I will post the series here,
feel free to pick an choose the changes as you see fit -- hopefully it
can save you some time.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
