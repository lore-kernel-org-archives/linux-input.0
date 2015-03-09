From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v7 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Mon, 09 Mar 2015 09:35:10 +0900
Message-ID: <54FCEABE.9000007@samsung.com>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
 <20150307201340.GF5233@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <20150307201340.GF5233@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On 03/08/2015 05:13 AM, Sebastian Reichel wrote:
> On Mon, Mar 02, 2015 at 07:10:35PM +0900, Jaewon Kim wrote:
>> From: Beomho Seo <beomho.seo@samsung.com>
>>
>> This patch adds device driver of max77843 charger. This driver provide
>> initialize each charging mode(e.g. fast charge, top-off mode and constant
>> charging mode so on.). Additionally, control charging paramters to use
>> i2c interface.
>>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> 
> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> 
> I can't take it as is, since it depends on the private header file
> of PATCHv1.
> 
> -- Sebastian
> 

This patch reviewed by Sebastian.
Could you Please merge that your git tree ?

Best regards,
Beomho Seo
