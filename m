From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Fri, 4 Dec 2009 22:15:16 +0100
Message-ID: <38c9179b0912041315y25d9bc62w633ff5e810a691a3@mail.gmail.com>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
	<20091204061158.28288.17664.stgit@localhost.localdomain> <20091204150621.16e4036e@destiny.ordissimo>
	<20091204181956.GA25669@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48246 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170AbZLDVPd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 16:15:33 -0500
In-Reply-To: <20091204181956.GA25669@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

On Fri, Dec 4, 2009 at 19:19, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Dec 04, 2009 at 03:06:21PM +0100, Anisse Astier wrote:
> > On Thu, 03 Dec 2009 22:11:58 -0800, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote :
> >
> > > +
> > > +/**
> > > + * sparse_keymap_report_event - report event corresponding to given key entry
> > You meant _report_entry ?
> >
>
> Indeed. Can I add your "Reviewed-by:" please?

You can, but I didn't review the whole thing, just read the patch
quickly and checked if it applied.



--
Anisse
