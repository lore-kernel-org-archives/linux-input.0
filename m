From: Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 3/6 v2] input: Add support for VIA VT8500 and compatibles
 in i8042
Date: Sat, 13 Nov 2010 03:00:47 +0300
Message-ID: <AANLkTikK5L=pEgWpsFH4GUG9dO79ZpLViHbPTc+TzA9Y@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-3-git-send-email-alchark@gmail.com>
	<AANLkTi=zvGxpukjAv-XFAMLpKYiqqKD=p9S5FtGowdDu@mail.gmail.com>
	<20101112233013.GA30946@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44436 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218Ab0KMAAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 19:00:49 -0500
In-Reply-To: <20101112233013.GA30946@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, vt8500-wm8505-linux-kernel@googlegroups.com, Tony Lindgren <tony@atomide.com>, Feng Tang <feng.tang@intel.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

2010/11/13 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Looks good to me (ignoring the fact that whole i8042 initialization
> needs to be reworked and pushed into arch/board code which is out of
> scope of these series).
>
> I expect it will be merged with the rest of VT8500 patches through
> whatever tree takes them.

Thanks, Dmitry!

Best regards,
Alexey
