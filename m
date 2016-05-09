From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] input: rmi4: Acquire and enable VDD and VIO
 supplies
Date: Mon, 9 May 2016 14:58:40 -0500
Message-ID: <20160509195840.GA15582@rob-hp-laptop>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
 <1462596008-21381-3-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462596008-21381-3-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, May 06, 2016 at 09:40:07PM -0700, Bjorn Andersson wrote:
> For systems where the rmi4 device is not powered by always-on regulators
> we need to acquire handles to VDD and VIO and enable these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Added patch 1 and 3
> - Moved regulator handling to the core driver
> 
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt       |  6 ++++++
>  .../devicetree/bindings/input/rmi4/rmi_spi.txt       |  6 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/rmi4/rmi_driver.c                      | 20 ++++++++++++++++++++
>  include/linux/rmi.h                                  |  4 +++-
>  4 files changed, 35 insertions(+), 1 deletion(-)
