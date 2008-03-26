From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Date: Wed, 26 Mar 2008 11:29:44 +0000
Message-ID: <20080326112943.GA26346@sirena.org.uk>
References: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se> <20080321155515.bb9f945e.akpm@linux-foundation.org> <aec7e5c30803252103x1534e43dv3f31a3bc731fc9bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1029 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbYCZMAc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Mar 2008 08:00:32 -0400
Content-Disposition: inline
In-Reply-To: <aec7e5c30803252103x1534e43dv3f31a3bc731fc9bf@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

On Wed, Mar 26, 2008 at 01:03:09PM +0900, Magnus Damm wrote:

> interrupt and handle everything from a different context. Apart from
> avoiding serious latency issues, doing things from interrupt context
> simply won't work since the i2c bus driver may be interrupt driven and
> may sleep while waiting for the serial bus data to be sent.

Given that having devices that generate interrupts that need to be
serviced over interrupt driven buses is a fairly common pattern it seems
like it would be worth adding some helper code - if nothing else, it
would help with the documentation.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
