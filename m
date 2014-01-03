From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 06/10] Input: pm8xxx-vibrator - Add DT match table
Date: Thu, 02 Jan 2014 17:27:15 -0800
Message-ID: <52C611F3.8090306@codeaurora.org>
References: <1388709460-19222-1-git-send-email-sboyd@codeaurora.org> <1388709460-19222-7-git-send-email-sboyd@codeaurora.org> <20140103011722.GA9300@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140103011722.GA9300@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/02/14 17:17, Dmitry Torokhov wrote:
> Hi Stephen,
>
> On Thu, Jan 02, 2014 at 04:37:36PM -0800, Stephen Boyd wrote:
>> The driver is only supported on DT enabled platforms. Convert the
>> driver to DT so that it can probe properly.
> I do not see MFD_PM8XXX depending on OF, should it be added if it only
> supported on DT?

No that would unnecessarily limit the compile coverage of this driver.
This one is so simple that it doesn't even use any OF APIs because it is
all hidden behind the platform bus.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
