From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH 1/2] Add module parameters to control OLPC touchpad
 delays
Date: Tue, 16 Dec 2008 14:40:59 -0500
Message-ID: <20081216144059.54901ec0@ephemeral>
References: <20081216193500.GA15380@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.queued.net ([207.210.101.209]:3112 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbYLPTrw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 14:47:52 -0500
In-Reply-To: <20081216193500.GA15380@trantor.hsd1.or.comcast.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dsaxena@laptop.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, pgf@laptop.org

Acked-By: Andres Salomon <dilinger@debian.org>

Is this from Paul or you?



On Tue, 16 Dec 2008 11:35:00 -0800
Deepak Saxena <dsaxena@laptop.org> wrote:

> The HPGK touchpad that is found on the XO driver has
> historically exhibitted eratic behaviour in various
> environments (very dry, very humid, etc) that can be
> worked around via some delays. This patch turns those
> delays into module parameters to make testing simpler.
> 
> Signed-off-by: Paul Fox <pgf@laptop.org>
> Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
> ---
>  drivers/input/mouse/hgpk.c |   32 ++++++++++++++++++++++++++++----
>  1 files changed, 28 insertions(+), 4 deletions(-)
> 
