From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v3 2/3] Input: add devicetree binding note for egalax_ts
Date: Thu, 16 Aug 2012 14:48:00 +0800
Message-ID: <502C97A0.2010902@gmail.com>
References: <1345026708-14139-1-git-send-email-jason77.wang@gmail.com> <1345026708-14139-2-git-send-email-jason77.wang@gmail.com> <1345026708-14139-3-git-send-email-jason77.wang@gmail.com> <20120815125353.GA2258@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53339 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab2HPGsx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 02:48:53 -0400
In-Reply-To: <20120815125353.GA2258@S2101-09.ap.freescale.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Hui Wang <jason77.wang@gmail.com>, dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Shawn Guo wrote:
> On Wed, Aug 15, 2012 at 06:31:47PM +0800, Hui Wang wrote:
>   
>> The egalax_ts driver needs to get the gpio number of the irq pin,
>> and use this gpio to wake up the controller. So add a note
>> for this change.
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>>  .../bindings/input/touchscreen/egalax-ts.txt       |   19 +++++++++++++++++++
>>  1 files changed, 19 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
>> new file mode 100644
>> index 0000000..df70318
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
>> @@ -0,0 +1,19 @@
>> +* EETI eGalax Multiple Touch Controller
>> +
>> +Required properties:
>> +- compatible: must be "eeti,egalax_ts"
>>     
>
> Since we define this in the binding anyway, can we have an corresponding
> .of_match_table in the driver?
>
> Regards,
> Shawn
>
>   
OK, will add it in the driver.

Regards,
Hui.
