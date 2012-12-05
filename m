From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4 4/4] input: Cypress PS/2 Trackpad simulated multitouch
 (disabled)
Date: Wed, 5 Dec 2012 21:13:07 +0100
Message-ID: <20121205201307.GA1357@polaris.bitmath.org>
References: <1354674245-25768-1-git-send-email-kamal@canonical.com>
 <1354674245-25768-5-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:50504 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2LEULH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 15:11:07 -0500
Content-Disposition: inline
In-Reply-To: <1354674245-25768-5-git-send-email-kamal@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dudley Du <dudl@cypress.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>

Hi Kamal,

> This feature is disabled by default; enable with CYPRESS_SIMULATED_MT.
> 
> Instead of SEMI_MT, present a full mt interface with simulated contact
> positions for >=3 fingers.  Enables e.g. multi-finger tap and drag for
> old userspace applications which only count the contact positions.
> 
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> ---
>  drivers/input/mouse/cypress_ps2.c |   18 ++++++++++++++++++
>  drivers/input/mouse/cypress_ps2.h |   16 ++++++++++++++--
>  2 files changed, 32 insertions(+), 2 deletions(-)

No thanks. Millions of devices are supported via semi-mt, there is no
reason why this one should be different. If there are userland issues,
something broke recently. You may want to check with Chase, for
instance, for the full history of commodity trackpad MT support.

Thanks.
Henrik
