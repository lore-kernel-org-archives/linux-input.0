From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
Date: Tue, 23 Nov 2010 14:24:47 -0500
Message-ID: <AANLkTinoOOU=yWvF2HQV9-Rp9NBxNDUO=G+kT7y=9MrY@mail.gmail.com>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
	<1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45904 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752866Ab0KWTYz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 14:24:55 -0500
Received: by mail-pv0-f170.google.com with SMTP id 33so3485296pvf.15
        for <linux-input@vger.kernel.org>; Tue, 23 Nov 2010 11:24:48 -0800 (PST)
In-Reply-To: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>, Cliff Holden <Cliff.Holden@atheros.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

Hi Gabor,

On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The existing gpio-keys driver can be usable only for GPIO lines with
> interrupt support. Several devices have buttons connected to a GPIO
> line which is not capable to generate interrupts. This patch adds a
> new input driver using the generic GPIO layer and the input-polldev
> to support such buttons.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: linux-input@vger.kernel.org

I'm excited to see this patch posted. As I understand it, this
"separate polling gpio button driver" approach is preferred to the
"polling extensions in gpio-keys approach". I'm sorry I missed the RFC
[1] : I posted a revised version of Alex Clouter's and Paul Mundt's
polling gpio-keys support [2]. But now I can try integrating this
driver. :)

I will be posting a version of the patch shortly that is still using
the polling-gpio-keys support -- because there are discussions in the
machine-specific parts. Then I will try to integrate this driver into
the series.

Best Regards,
Ben Gardiner

[1] http://article.gmane.org/gmane.linux.kernel.input/16468
[2] http://article.gmane.org/gmane.linux.kernel.input/16587

---
Nanometrics Inc.
http://www.nanometrics.ca
