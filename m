From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add keyreset driver.
Date: Mon, 25 Jun 2012 11:59:23 -0700
Message-ID: <20120625185922.GA20660@core.coreip.homeip.net>
References: <1340140414-9720-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33453 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab2FYS7b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 14:59:31 -0400
Content-Disposition: inline
In-Reply-To: <1340140414-9720-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-input@vger.kernel.org, john.stultz@linaro.org, linux-kernel@vger.kernel.org, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, kernel-team@android.com

Hi Arve,

On Tue, Jun 19, 2012 at 03:13:34PM -0600, mathieu.poirier@linaro.org wr=
ote:
> From: Arve Hj=F8nnev=E5g <arve@android.com>
>=20
> This patch originates from the Android tree and is being submitted
> for review and inclusion in the mainline kernel.
>=20
> Add a platform device in the board file to specify a reset key-combo.
> The first time the key-combo is detected a work function that syncs
> the filesystems is scheduled. If all the keys are released and then
> pressed again, it calls panic. Reboot on panic should be set for
> this to work.

This sounds a lot like SYSRQ handler, but with configurable key sequenc=
e.
Why don't you extend drivers/tty/sysrq.c instead?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
