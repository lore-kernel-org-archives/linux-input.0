From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/03] [INPUT][KEYBOARD] Kconfig support for s3c matrix
 keypad
Date: Sat, 5 Sep 2009 16:56:43 +0100
Message-ID: <20090905155642.GA10326@sirena.org.uk>
References: <00b001ca2e30$6c79ccf0$456d66d0$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53831 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZIEP4s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 11:56:48 -0400
Content-Disposition: inline
In-Reply-To: <00b001ca2e30$6c79ccf0$456d66d0$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv7IK8?= =?utf-8?B?7ISx7KCE7J6Q?= <ki0351.kim@samsung.com>, =?utf-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQpLw==?= =?utf-8?B?7IK87ISx7KCE7J6QJw==?= <kgene.kim@samsung.com>

On Sat, Sep 05, 2009 at 10:54:44PM +0900, =EC=96=91=EC=A7=84=EC=84=B1 w=
rote:
> This patch supports to select configuration for s3c matrix keypad.

> Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>

A relatively technical point but you should always try to order your
patch series so that the kernel always builds, even with the patch
series partly applied.  This means that if you've split out the build
system changes that should be the last patch in the series.

Doing this is useful when people use tools such as 'git bisect' which
walk through history and also means that it's possible to do things lik=
e
partially apply the series (for example, if you get a situation where
the earlier patches are all OK but there's some issues that need to be
resolved in the later ones).

It'd probably also help to combine more of your changes together - in
general it's better if patches achieve some goal in a self-contained
fashion.  This normally makes things easier to review.  Things like
doing the build system separately are normally there in order to split =
a
very large driver into managable chunks.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
