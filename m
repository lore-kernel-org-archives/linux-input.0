From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] WM97xx updates
Date: Wed, 4 Mar 2009 14:32:12 +0000
Message-ID: <20090304143212.GA1308@rakim.wolfsonmicro.main>
References: <20090303182402.GA29542@rakim.wolfsonmicro.main> <20090304091538.GD7394@dtor-d630.eng.vmware.com> <49AE492F.6020006@atmel.com> <20090304105358.GA32107@rakim.wolfsonmicro.main> <49AE65FF.2060309@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34337 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751227AbZCDOcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 09:32:15 -0500
Content-Disposition: inline
In-Reply-To: <49AE65FF.2060309@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

On Wed, Mar 04, 2009 at 12:29:03PM +0100, Hans-Christian Egtvedt wrote:

> What is this patch based against? Linus tree, master branch?

This branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

(though the noticable differences should be Makefile and Kconfig ones).
