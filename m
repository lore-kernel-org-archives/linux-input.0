From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v3] Input: ad7879: split bus logic
	out
Date: Fri, 21 May 2010 04:10:12 -0400
Message-ID: <AANLkTimUPkH9iIeus-jIvrMjZu3z63mzVj6kHp2ueV1d@mail.gmail.com>
References: <20100119082652.GA19338@core.coreip.homeip.net>
	<1263891413-18194-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.211.180]:48366 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab0EUIKd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 04:10:33 -0400
Received: by ywh10 with SMTP id 10so427516ywh.1
        for <linux-input@vger.kernel.org>; Fri, 21 May 2010 01:10:32 -0700 (PDT)
In-Reply-To: <1263891413-18194-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

On Tue, Jan 19, 2010 at 04:56, Mike Frysinger wrote:
> The ad7879 driver is using the old bus method of only supporting one =
at a
> time (I2C or SPI). =C2=A0So refactor it like the other input drivers =
that
> support multiple busses simultaneously.

doesnt seem like this was picked up ?
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
