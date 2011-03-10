From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: Re: [PATCH 0/2] Support for isa1200 haptic chip
Date: Thu, 10 Mar 2011 17:53:43 +0530
Message-ID: <4D78C2CF.1030708@codeaurora.org>
References: <1299496182-26177-1-git-send-email-mpallaka@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:50649 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1CJMWq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 07:22:46 -0500
In-Reply-To: <1299496182-26177-1-git-send-email-mpallaka@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohan Pallaka <mpallaka@codeaurora.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/7/2011 4:39 PM, Mohan Pallaka wrote:
> This patchset includes a __weak attributed pwm apis in pwm.h and
> a ff-memless based isa1200 driver.
> 
> ISA1200 chip can operate in two modes and if the chip has been
> configured for pwm-generation mode, which doesn't use pwm standard
> apis then it'd encounter compilation errors if the host doesn't
> support PWM. This driver is based on Park's isa1200 driver that uses
> haptic class.
> 
> Kyungmin Park (1):
>   input: misc: Add support for isa1200 chip
> 
> Mohan Pallaka (1):
>   pwm: Add __weak attributed functions for pwm operations
> 
>  drivers/input/misc/Kconfig    |   12 ++
>  drivers/input/misc/Makefile   |    1 +
>  drivers/input/misc/isa1200.c  |  440 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/input/isa1200.h |   45 +++++
>  include/linux/pwm.h           |   21 ++-
>  5 files changed, 514 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/input/misc/isa1200.c
>  create mode 100644 include/linux/input/isa1200.h
> 

Ping.

Dmitry, could you spend sometime to review this.

Thanks,
Mohan.

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
