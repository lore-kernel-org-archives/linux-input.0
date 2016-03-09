From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] hid: sony: Add power supply support for PS3 remote
Date: Wed, 09 Mar 2016 17:58:58 +0100
Message-ID: <1457542738.2648.113.camel@hadess.net>
References: <1457487659-3970-1-git-send-email-frederic.jacob.78@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:39719 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397AbcCIRD2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 12:03:28 -0500
In-Reply-To: <1457487659-3970-1-git-send-email-frederic.jacob.78@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frederic Jacob <frederic.jacob.78@gmail.com>, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hey Frederic,

On Tue, 2016-03-08 at 20:40 -0500, Frederic Jacob wrote:
> Add power supply support for the PS3 remote controller

Isn't something like "add battery state reporting for PS3 remotes"
better?

Also, as I don't think it's physically possible to have the PS3 remote
both connected and charging at the same time, maybe the comment
in=C2=A0sixaxis_parse_report() should be modified to make it clear that=
 the
PS3 remote doesn't have that problem.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
