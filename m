From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe	fail	before	retrying
Date: Tue, 20 Apr 2010 23:33:28 -0700
Message-ID: <20100421063328.GJ4364@core.coreip.homeip.net>
References: <4BC8EA42.6030507@canonical.com>
 <1271502098.4155.27.camel@lovely>
 <4BC9D444.3090802@canonical.com>
 <1271523195.3676.5.camel@lovely>
 <4BCC77B4.5030703@canonical.com>
 <1271723857.6652.6.camel@lovely>
 <4BCE17CC.8020804@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:56070 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0DUGdd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 02:33:33 -0400
Received: by ywh32 with SMTP id 32so3897539ywh.33
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 23:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BCE17CC.8020804@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini@cvml.unipv.it

On Tue, Apr 20, 2010 at 05:08:28PM -0400, Peter M. Petrakis wrote:
> Ugh... I never get out of suspend with this patch, also
> tried i8042_toggle_aux(false) followed by ... (true) with the
> same result. Any other ideas? Thanks.

I think retrying the probe is fine, however it shoudl only be done in
resume path, otheriwse you will make people that really do not use PS/2
mice unhappy.

BTW, what kind of laptop and touchpad is it?

-- 
Dmitry
