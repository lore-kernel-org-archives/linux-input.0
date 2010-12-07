From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v3] input: mt: Move tracking and pointer emulation to
 input-mt
Date: Tue, 07 Dec 2010 21:58:30 +0100
Message-ID: <4CFE9FF6.2080800@euromail.se>
References: <1291722357-22820-1-git-send-email-rydberg@euromail.se>	<alpine.LNX.2.00.1012071553100.14806@pobox.suse.cz>	<4CFE934D.4040309@euromail.se> <AANLkTik=A5xc2RexWqDMvumFqbA6HtzynWmP=Fz6+SvE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:48819 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab0LGU6k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Dec 2010 15:58:40 -0500
In-Reply-To: <AANLkTik=A5xc2RexWqDMvumFqbA6HtzynWmP=Fz6+SvE@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>

> Acked-by: Ping Cheng <pingc@wacom.com>


Thanks.


> I do see an issue when pen coming in prox while fingers were on the
> tablet. Fingers up events are missing.

>
> Since it is unrelated to this patch, I'll submit another patch as a
> bug fix later.

Actually, I believe it is correct as is. One could always argue (and I did at
the time of that change) whether touch up is the right thing to do in the
proximity of the pen, but that is what the code does now. As proof, check how
input_mt_report_slot_state() is used.

Cheers,
Henrik
