From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] input: Clean up maple keyboard driver
Date: Sat, 19 Jul 2008 07:43:23 +0900
Message-ID: <20080718224323.GA19263@linux-sh.org>
References: <1213559019.22707.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:20954 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757176AbYGRWno (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jul 2008 18:43:44 -0400
Content-Disposition: inline
In-Reply-To: <1213559019.22707.12.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, Jun 15, 2008 at 08:43:39PM +0100, Adrian McMenamin wrote:
> Have a single probe function instead of a probe and a connect function.
> Also tidy a comment.
> 1 files changed, 33 insertions(+), 48 deletions(-)
> 
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

Ok, so I was going to take this through my tree, but it doesn't apply any
more. Please send an updated version that can be merged.
