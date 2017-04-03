From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] Input: silead - list all supported compatible strings in
 binding document
Date: Mon, 3 Apr 2017 11:51:55 -0400
Message-ID: <6574d158-7fe8-7a2f-dab6-1c155780c785@osg.samsung.com>
References: <20170329182531.17349-1-javier@osg.samsung.com>
 <20170403152543.im7tbkhfc3lj7lyt@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59047
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751716AbdDCPwE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 11:52:04 -0400
In-Reply-To: <20170403152543.im7tbkhfc3lj7lyt@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Robert Dolca <robert.dolca@intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Hello Rob,

On 04/03/2017 11:25 AM, Rob Herring wrote:
> On Wed, Mar 29, 2017 at 02:25:31PM -0400, Javier Martinez Canillas wrote:
>> The driver contains compatible strings for different models, but the DT
>> binding doc only lists one of them. Add the remaining to the document.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt       | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> "dt-bindings: input: ..." is preferred for the subject, but no need to 
> respin just for that.
>

Can we document it in Documentation/devicetree/bindings/submitting-patches.txt?

I'm asking because is true that at the beginning we used "dt-bindings: foo" for
all DT bindings patches but then many (most?) maintainers started asking for the
subsystem subject line to be used for both drivers and DT bindings docs since
they would be merging both and also they could miss the DT bindings patches if
their subsystem prefix was not used.

> Acked-by: Rob Herring <robh@kernel.org> 
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
