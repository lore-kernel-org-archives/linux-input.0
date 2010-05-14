From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH v2 3/4] OMAP4: Keyboard board support
Date: Thu, 13 May 2010 23:01:45 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E113DD9@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E113BFB@dlee03.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703050DEF02@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab0ENEBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 May 2010 00:01:47 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703050DEF02@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram,

> From: Pandita, Vikram

[..]

> >+
> >+struct omap_device *od;
> 
> Any reason to have this global?

Not really... I'll change it local to the keyboard init function, thanks!

Best Regards
Abraham
