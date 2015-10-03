From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 00/18] Input - Fix make coccicheck warnings
Date: Sat, 3 Oct 2015 13:13:23 +0200
Message-ID: <560FB853.6040000@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <20151002182507.GQ8437@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47159 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbbJCLNe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 3 Oct 2015 07:13:34 -0400
In-Reply-To: <20151002182507.GQ8437@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ferruh Yigit <fery@cypress.com>, Axel Lin <axel.lin@ingics.com>, Pramod Gurav <pramod.gurav@smartplayin.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Heiko Stuebner <heiko.stuebner@bq.com>, Fabio Estevam <fabio.estevam@freescale.com>, Hans de Goede <hdegoede@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Benson Leung <bleung@chromium.org>, Shailendra Verma <shailendra.capricorn@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org, Duson Lin <dusonlin@emc.com.tw>, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Henrik Rydberg <rydberg@bitmath.org>, Daniel Mack <linux@zonque.org>, Nick Dyer <nick.dyer@itdev.co.uk>, Matt Ranostay <mranostay@gmail.com>

Hello Dmitry,

On 10/02/2015 08:25 PM, Dmitry Torokhov wrote:
> Hi Javier,
> 
> On Fri, Oct 02, 2015 at 03:40:11PM +0200, Javier Martinez Canillas wrote:
>> Hello Dmitry,
>>
>> This series contains trivial patches with fixes to different warnings
>> reported by make coccichek M=drivers/input.
>>
>> The patches don't contain functional changes but makes the functions
>> simpler and removes unnecessary lines of code.
> 
> I disagree with some "simplify function return logic" patches: when
> there are several actions that may fail I prefer explicit:
> 
> 	error = actionN();
> 	if (error)
> 		return error;
> 
> 	return 0;
> 
> even on the last one as it keep with the code flow and makes it easier
> to move stuff around.
>
> Please consider patches that not explicitly replied to as applied a
> dropped.

Thanks a lot for taking the time to explain this. I understand your
rationale and I tend to agree.

I'll see if the scripts/coccinelle/misc/simple_return.cocci semantic
patch can be modified to take this into account and not report a
warning for that pattern.

> 
> Thanks.
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
