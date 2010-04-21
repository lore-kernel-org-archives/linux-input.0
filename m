From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe	fail	before	retrying
Date: Wed, 21 Apr 2010 15:38:59 -0400
Message-ID: <4BCF5453.5060703@canonical.com>
References: <4BC8EA42.6030507@canonical.com> <1271502098.4155.27.camel@lovely> <4BC9D444.3090802@canonical.com> <1271523195.3676.5.camel@lovely> <4BCC77B4.5030703@canonical.com> <1271723857.6652.6.camel@lovely> <4BCE17CC.8020804@canonical.com> <20100421063328.GJ4364@core.coreip.homeip.net> <4BCF2263.40306@canonical.com> <20100421171055.GB10566@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57372 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012Ab0DUTjA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 15:39:00 -0400
In-Reply-To: <20100421171055.GB10566@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini@cvml.unipv.it

This issue only occurs on resume, boot is fine. It is indeed
a multitouch. It doesn't have the $OTHER_OS installed but it
could if necessary. 

Peter

On 04/21/2010 01:10 PM, Dmitry Torokhov wrote:
> On Wed, Apr 21, 2010 at 12:05:55PM -0400, Peter M. Petrakis wrote:
>> The laptop is a Dell "yet to be officially released" laptop,
>> the touchpad reports itself as:
>>
>> Apr 21 11:24:05 ubuntu-laptop kernel: [  983.174813]
>> input: PS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input14
> 
> Umm, Synaptics but not using SynPS protocol. Some users will not be
> happy... Is it after cold boot or resume? Also, is it a multiouch model
> (does the box have the $OTHER_OS on it)?
> 
>>
>> I didn't find any additional attributes in sysfs that could give me
>> the fw revision or model. It doesn't show up in dmidecode either.
>>
>> With regards to retrying the probe... which resume path? psmouse
>> currently doesn't have one. Thanks.
> 
> 
> That'd be "reconnect" in serio speak, so you need to look into
> psmouse_reconnect().
> 
