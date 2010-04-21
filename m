From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe	fail	before	retrying
Date: Wed, 21 Apr 2010 10:10:55 -0700
Message-ID: <20100421171055.GB10566@core.coreip.homeip.net>
References: <4BC8EA42.6030507@canonical.com>
 <1271502098.4155.27.camel@lovely>
 <4BC9D444.3090802@canonical.com>
 <1271523195.3676.5.camel@lovely>
 <4BCC77B4.5030703@canonical.com>
 <1271723857.6652.6.camel@lovely>
 <4BCE17CC.8020804@canonical.com>
 <20100421063328.GJ4364@core.coreip.homeip.net>
 <4BCF2263.40306@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52537 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab0DURLC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 13:11:02 -0400
Received: by vws18 with SMTP id 18so148788vws.19
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 10:11:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BCF2263.40306@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini@cvml.unipv.it

On Wed, Apr 21, 2010 at 12:05:55PM -0400, Peter M. Petrakis wrote:
> The laptop is a Dell "yet to be officially released" laptop,
> the touchpad reports itself as:
> 
> Apr 21 11:24:05 ubuntu-laptop kernel: [  983.174813]
> input: PS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input14

Umm, Synaptics but not using SynPS protocol. Some users will not be
happy... Is it after cold boot or resume? Also, is it a multiouch model
(does the box have the $OTHER_OS on it)?

> 
> I didn't find any additional attributes in sysfs that could give me
> the fw revision or model. It doesn't show up in dmidecode either.
> 
> With regards to retrying the probe... which resume path? psmouse
> currently doesn't have one. Thanks.


That'd be "reconnect" in serio speak, so you need to look into
psmouse_reconnect().

-- 
Dmitry
