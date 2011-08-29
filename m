From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH trivial] input: apanel: remove a redundant MODULE_ALIAS
Date: Mon, 29 Aug 2011 18:00:24 -0400
Message-ID: <20110829220024.GA27009@redhat.com>
References: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21735 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361Ab1H2WBi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 18:01:38 -0400
Content-Disposition: inline
In-Reply-To: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Hemminger <shemminger@linux-foundation.org>, linux-kernel@vger.kernel.org

On Mon, Aug 29, 2011 at 11:26:29PM +0200, Jonathan Neusch=E4fer wrote:
=20
 > -MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
 >  MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
=20
                                         ^
Is the module matching code case-insensitive ?

	Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
