From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Input: atmel_mxt_ts - simplify mxt_initialize a bit
Date: Thu, 24 Jul 2014 16:39:45 +0100
Message-ID: <53D128C1.9020707@itdev.co.uk>
References: <20140723215054.GA14362@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:7598 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759405AbaGXPjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2014 11:39:47 -0400
In-Reply-To: <20140723215054.GA14362@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Iiro Valkonen <iiro.valkonen@atmel.com>, linux-kernel@vger.kernel.org

On 23/07/14 22:50, Dmitry Torokhov wrote:
> I think having control flow with 2 goto/labels/flags is quite hard to read,
> this version is a bit more readable IMO.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yes, this looks much clearer to me. Although I can't see anything wrong
looking at it, I think I should probably regression test it for the
different failure paths before it is applied, I will bring it into my series.
