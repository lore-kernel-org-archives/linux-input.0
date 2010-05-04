From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3 1/3] TCA6416 keypad : Implement keypad driver for keys
 interfaced to TCA6416
Date: Mon, 3 May 2010 23:46:19 -0700
Message-ID: <20100504064618.GA17482@core.coreip.homeip.net>
References: <1269357035-19754-1-git-send-email-srk@ti.com>
 <1269357035-19754-2-git-send-email-srk@ti.com>
 <20100416052500.GA1078@core.coreip.homeip.net>
 <FCCFB4CDC6E5564B9182F639FC3560870304E80EDC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45753 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab0EDGq0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 May 2010 02:46:26 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870304E80EDC@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Apr 30, 2010 at 07:49:20PM +0530, Govindarajan, Sriramakrishnan
wrote:
> > 
> [Sriram] Dmitry, once you have reviewed the changes, should I re-post
> the patch series with your patch added to the series?
> 

Sriram,

Thank you for reviewing my changes.

I folded my changes into your original patch and will commit it to the
next bramch of my tree. The board-specific changes will have to go
thotugh maintainer of the arch in question.

-- 
Dmitry
