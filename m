From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] HID: picoLCD: Remove use of deprecated function
Date: Thu, 6 Sep 2012 13:15:38 -0700
Message-ID: <20120906201538.GK29092@google.com>
References: <1346942780-8091-1-git-send-email-emilgoode@gmail.com>
 <20120906221252.1402ba50@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44530 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2IFUPn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 16:15:43 -0400
Content-Disposition: inline
In-Reply-To: <20120906221252.1402ba50@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Emil Goode <emilgoode@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Sep 06, 2012 at 10:12:52PM +0200, Bruno Pr=C3=A9mont wrote:
> On Thu, 06 September 2012 Emil Goode <emilgoode@gmail.com> wrote:
> > The flush_delayed_work_sync function is deprecated,
> > we can instead call flush_delayed_work directly.
> >=20
> > Sparse is giving a warning:
> > drivers/hid/hid-picolcd_fb.c:611:2: warning:
> > 	=E2=80=98flush_delayed_work_sync=E2=80=99 is deprecated
> > 	(declared at include/linux/workqueue.h:454)
> > 	[-Wdeprecated-declarations]
> >=20
> > Signed-off-by: Emil Goode <emilgoode@gmail.com>
>=20
> Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
>=20
> This matches a patch by Tejun a few weeks ago which was partially
> skipped in -next due to merge conflict with code split in picoLCD.
>=20
> See http://comments.gmane.org/gmane.linux.kernel.next/23740
>=20
> For the sake of proper bisectability, this should go in after
> Tejun's workqueue changes (if needed at all depending on how merge
> happens during pull by Linus).

Yeah, we either can ask Linus to fix it up during merge or send a
separate patch afterwards.  In this case, I don't think it matters too
much either way.  I tend to send out pull request fairly early in the
merge window, I'll try to remember to poke Linus about the merge
conflict.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
