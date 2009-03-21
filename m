From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: elantech.c make sure touchpad is really in absolute mode
Date: Fri, 20 Mar 2009 22:46:31 -0700
Message-ID: <200903202246.31493.dmitry.torokhov@gmail.com>
References: <20090320055239.GA19800@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:51364 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbZCUFqh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 01:46:37 -0400
In-Reply-To: <20090320055239.GA19800@adopmeer.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arjan,

On Thursday 19 March 2009 22:52:39 Arjan Opmeer wrote:
> From: Arjan Opmeer <arjan@opmeer.net>
>
> There exist laptops with Elantech touchpads where switching to absolute
> mode does not happen, although writing the configuration register succeeds
> without error. Reading back the register afterwards reveils that the
> absolute mode bit is not set as if masked out by the touchpad firmware.
>
> Always read back register 0x10, make sure that for hardware version 1 the
> absolute mode bit is actually set and fail otherwise. This prevents the
> case where the touchpad is claimed by the Elantech driver but is
> nonetheless not working.
>

Makes sense, will apply. Although, have you tried repeating the switch or
maybe issuing full reset before trying again?

-- 
Dmitry

