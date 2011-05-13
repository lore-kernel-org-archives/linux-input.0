From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add __weak attributed functions for pwm operations
Date: Fri, 13 May 2011 09:25:28 -0700
Message-ID: <8yad3jmk1on.fsf@huya.qualcomm.com>
References: <1305290602-29859-1-git-send-email-mpallaka@codeaurora.org>
	<1305290602-29859-2-git-send-email-mpallaka@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1305290602-29859-2-git-send-email-mpallaka@codeaurora.org>
	(Mohan Pallaka's message of "Fri, 13 May 2011 18:13:21 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mohan Pallaka <mpallaka@codeaurora.org>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.intradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk
List-Id: linux-input@vger.kernel.org

On Fri, May 13 2011, Mohan Pallaka wrote:

> For chip drivers that support both pwm and non-pwm modes
> would encounter compilation errors if the platform doesn't
> have support for pwm though the chip is programmed to work
> in non-pwm mode. Add __weak attributed pwm functions to avoid
> compilation issues in these scenarios.
>
> Change-Id: Ia507bf659d4d67d71f135012e7d919aca6c45c6c

Make sure you remove these 'Change-Id' lines before sending patches.
They aren't supposed to be in the kernel since they refer to an internal
server, and aren't useful to anyone else.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
