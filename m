From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
Date: Mon, 23 Mar 2015 09:01:33 -0700
Message-ID: <20150323160133.GB8666@dtor-ws>
References: <1426899446-16873-1-git-send-email-jonathar@broadcom.com>
 <1426899446-16873-2-git-send-email-jonathar@broadcom.com>
 <550FE779.8010703@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550FE779.8010703@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Jonathan Richardson <jonathar@broadcom.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Scott Branden <sbranden@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, Joe Perches <joe@perches.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Hi Bo,

On Mon, Mar 23, 2015 at 06:14:17PM +0800, Bo Shen wrote:
> Hi Jonathan Richardson,
> 
> On 03/21/2015 08:57 AM, Jonathan Richardson wrote:
> >+static struct platform_driver iproc_ts_driver = {
> >+	.probe = iproc_ts_probe,
> 
> Just a little curious, is the .remove function missing or it doesn't
> need it.

When all resources used by a driver are managed (i.e. acquired via devm
API) such driver does not need remove() method.

Thanks.

-- 
Dmitry
