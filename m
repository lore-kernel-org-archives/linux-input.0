From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: picoLCD: Remove use of deprecated function
Date: Fri, 7 Sep 2012 15:11:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209071511060.21679@pobox.suse.cz>
References: <1346942780-8091-1-git-send-email-emilgoode@gmail.com> <20120906221252.1402ba50@neptune.home> <20120906201538.GK29092@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43713 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064Ab2IGNMB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Sep 2012 09:12:01 -0400
In-Reply-To: <20120906201538.GK29092@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Emil Goode <emilgoode@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, 6 Sep 2012, Tejun Heo wrote:

> > > The flush_delayed_work_sync function is deprecated,
> > > we can instead call flush_delayed_work directly.
> > >=20
> > > Sparse is giving a warning:
> > > drivers/hid/hid-picolcd_fb.c:611:2: warning:
> > > 	=E2=80=98flush_delayed_work_sync=E2=80=99 is deprecated
> > > 	(declared at include/linux/workqueue.h:454)
> > > 	[-Wdeprecated-declarations]
> > >=20
> > > Signed-off-by: Emil Goode <emilgoode@gmail.com>
> >=20
> > Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> >=20
> > This matches a patch by Tejun a few weeks ago which was partially
> > skipped in -next due to merge conflict with code split in picoLCD.
> >=20
> > See http://comments.gmane.org/gmane.linux.kernel.next/23740
> >=20
> > For the sake of proper bisectability, this should go in after
> > Tejun's workqueue changes (if needed at all depending on how merge
> > happens during pull by Linus).
>=20
> Yeah, we either can ask Linus to fix it up during merge or send a
> separate patch afterwards.  In this case, I don't think it matters to=
o
> much either way.  I tend to send out pull request fairly early in the
> merge window, I'll try to remember to poke Linus about the merge
> conflict.

Okay, fair enough. I'll try not to forget to CC you on my pull request=20
which will include those picolcd changes, and mention the potential=20
conflict to Linus as well. We'll see which one goes in first :)

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
