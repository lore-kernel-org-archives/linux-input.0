From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v5 2/2] hid-sony: fix endiannes of Sixaxis accel/gyro
 values
Date: Mon, 13 Jun 2011 13:22:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106131322150.22872@pobox.suse.cz>
References: <1b0af21baa09ca623bbe62ee253f5d36.squirrel@host171.canaca.com> <1307700027-10657-2-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33638 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab1FMLWZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 07:22:25 -0400
In-Reply-To: <1307700027-10657-2-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Simon Wood <simon@mungewell.org>, Marcin Tolysz <tolysz@gmail.com>, Michael Bauer <michael@m-bauer.org>

On Fri, 10 Jun 2011, Antonio Ospite wrote:

> From: Simon Wood <simon@mungewell.org>
> 
> The accelerometers/gyro on the Sixaxis are reported in the wrong
> endianness (ie. not compatible with HID), so this patch intercepts
> the report and swaps the appropriate bytes over.
> 
> Accelerometers are scaled with a nominal value of +/-4000 = 1G,
> maximum value would be around +/-32768 = 8G.
> 
> Gyro on my device always reports -32768, might need some calibration
> set within the controller.
> 
> Fix extracted from previous patch submission:
> https://patchwork.kernel.org/patch/95212/
> 
> Signed-off-by: Marcin Tolysz <tolysz@gmail.com>
> Signed-off-by: Simon Wood <simon@mungewell.org>
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Applied, thanks guys.

-- 
Jiri Kosina
SUSE Labs
