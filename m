From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Fix for the multitouch panel of the Asus T91MT
Date: Fri, 30 Jul 2010 08:39:11 -0400
Message-ID: <1280493551.3448.116.camel@mini>
References: <20100716094611.C9A089520B@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51039 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450Ab0G3MjW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 08:39:22 -0400
In-Reply-To: <20100716094611.C9A089520B@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: jkosina@suze.cz, linux-input@vger.kernel.org, chatty@enac.fr

On Fri, 2010-07-16 at 11:46 +0200, Stephane Chatty wrote:
> Fixed bug in management of the multitouch panel of the Asus T91MT: it was
> erroneously added to the ignore list instead of the black list.
> 
> Signed-off-by: Stephane Chatty <chatty@enac.fr>

Jiri,

What's the status of this patch? It seems relatively straightforward,
and I'd like to put it into Ubuntu, but we don't typically do so until
at least the upstream maintainer applies it to his tree.

Thanks,

-- Chase

