From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Fix test of unsigned in altera_ps2_probe()
Date: Tue, 15 Dec 2009 09:52:01 -0800
Message-ID: <20091215175200.GB21995@core.coreip.homeip.net>
References: <4B27C140.6000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:63995 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759988AbZLORwL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 12:52:11 -0500
Content-Disposition: inline
In-Reply-To: <4B27C140.6000105@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Dec 15, 2009 at 06:02:56PM +0100, Roel Kluin wrote:
> ps2if->irq is unsigned so the test does not work.
> 

Applied, tahnk you.

-- 
Dmitry
