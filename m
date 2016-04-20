From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/5] input: twl6040-vibra: fix DT node memory management
Date: Wed, 20 Apr 2016 11:03:01 +0200
Message-ID: <311BF03D-607A-410A-B678-9D7ED12A806F@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com> <fa39d5e67bd71ba0cde980313747f5b4d2f9be94.1461009340.git.hns@goldelico.com> <20160418212200.GC1006@dtor-ws> <25D4CEE0-DEDE-4E12-8D7A-B0E4EBD1772B@goldelico.com> <20160419170637.GB2881@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:8958 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbcDTJDO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2016 05:03:14 -0400
In-Reply-To: <20160419170637.GB2881@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org


> Am 19.04.2016 um 19:06 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> On Tue, Apr 19, 2016 at 09:43:08AM +0200, H. Nikolaus Schaller wrote:
>> 
>>> Am 18.04.2016 um 23:22 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>> 
>>> On Mon, Apr 18, 2016 at 09:55:37PM +0200, H. Nikolaus Schaller wrote:
>>>> commit e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")
>>>> 
>>>> made the separate vibra DT node to a subnode of the twl6040.
>>>> 
>>>> It now calls of_find_node_by_name() to locate the "vibra" subnode.
>>>> This function has a side effect to call of_node_put on() for the twl6040
>>>> parent node passed in as a parameter. This causes trouble later on.
>>>> 
>>>> Solution: we must call of_node_get() before of_find_node_by_name()
>>> 
>>> God, what messed up API.
>> 
>> Yes, indeed. It is opposite to the usual object ownership rule that the code
>> fragment that asks for a handle has to release it.
>> 
>> Usually it does not become obvious because often CONFIG_OF_DYNAMIC=n.
>> This disables all of_node refcounting completely so such bugs remain unnoticed.
>> 
>>> Any chance we can make it a bit more sane and
>>> not drop the reference inside it instead?
>> 
>> Well, if you want to change ~2000 files, test on all platforms and ask Linus
>> for agreement?
> 
> It's not that bad, let's see what DT maintainers say to the patch I
> posted...

Thanks! Would make me more happy a well.

Nikolaus