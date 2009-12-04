From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Fri, 4 Dec 2009 09:34:06 +0100
Message-ID: <20091204093406.36d81aec@destiny.ordissimo>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
	<20091204061158.28288.17664.stgit@localhost.localdomain>
	<1259913744.3593.62.camel@falcon.domain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:54529 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbZLDIfn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 03:35:43 -0500
In-Reply-To: <1259913744.3593.62.camel@falcon.domain.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wuzhangjin@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>

Hi Wu,

On Fri, 04 Dec 2009 16:02:24 +0800, Wu Zhangjin <wuzhangjin@gmail.com>
wrote :

> 
> I have tried to apply this patch to the latest 2.6.32 and the linux-mips
> tree, both rejected.
> 
> So, which git tree should I use?

Last time I had to use Dmitry's input tree:
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
Just checked it, this one applies.

Regards,

Anisse
