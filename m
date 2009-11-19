From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/4] input: atmel_tsadcc: touchscreen rework setting	capabilities
Date: Thu, 19 Nov 2009 11:47:39 +0100
Message-ID: <4B05224B.8050403@atmel.com>
References: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com> <20091118173033.GA4385@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757435AbZKSKry@vger.kernel.org>
In-Reply-To: <20091118173033.GA4385@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, avictor.za@gmail.com
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov :
> Hi Nicolas,
> 
> On Wed, Nov 18, 2009 at 03:12:12PM +0100, Nicolas Ferre wrote:
>> Tiny patch for setting capabilities using input API function.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> All looks good. Since the series span platform and input subtrees how do
> you want to merge it?

I propose that you merge the whole series using the input path.

I had the acknowledgment from Andrew Victor offline. So, could you
please add on patches #3 & #4:

Acked-by: Andrew Victor <linux@maxim.org.za>

Thanks a lot.

Best regards,
-- 
Nicolas Ferre
