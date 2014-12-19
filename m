From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: touchscreen-iproc: Add Broadcom iProc touchscreen driver
Date: Fri, 19 Dec 2014 11:56:48 -0800
Message-ID: <3710249.R7buLtFklK@dtor-glaptop>
References: <549481C5.7050802@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <549481C5.7050802@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Joe Perches <joe@perches.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Friday, December 19, 2014 11:51:33 AM Jonathan Richardson wrote:
> Thanks Joe. I'll send out a new patch set with your suggestions/fixes
> shortly.

You can also drop the remove() code since we clear drvdata automatically and 
input device is managed so does not need to be unregistered explicitly.

Thanks.

-- 
Dmitry
