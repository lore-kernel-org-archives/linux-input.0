From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Fri, 4 Dec 2009 00:37:56 -0800
Message-ID: <20091204083756.GA22570@core.coreip.homeip.net>
References: <20091204060701.28288.91430.stgit@localhost.localdomain> <20091204061158.28288.17664.stgit@localhost.localdomain> <1259913744.3593.62.camel@falcon.domain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:56140 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbZLDIhx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 03:37:53 -0500
Content-Disposition: inline
In-Reply-To: <1259913744.3593.62.camel@falcon.domain.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anisse Astier <anisse@astier.eu>

On Fri, Dec 04, 2009 at 04:02:24PM +0800, Wu Zhangjin wrote:
> On Thu, 2009-12-03 at 22:11 -0800, Dmitry Torokhov wrote:
> > More and more devices choose to reimplement support for sparse keymaps
> > first introduced by wistron driver. Move it into a library module so it
> > can be easily used by interested parties.
> 
> Hi, Dmitry
> 
> I have tried to apply this patch to the latest 2.6.32 and the linux-mips
> tree, both rejected.
> 
> So, which git tree should I use?
> 

Mine ;)

	git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

-- 
Dmitry
