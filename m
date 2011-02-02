From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [rtc-linux] [RFC v2 PATCH 5/7] input: pmic8058-othc: Add	support
 for PM8058 based OTHC
Date: Wed, 02 Feb 2011 13:21:50 +0530
Message-ID: <4D490D16.3030601@codeaurora.org>
References: <1296568063-12010-1-git-send-email-aghayal@codeaurora.org> <1296568063-12010-6-git-send-email-aghayal@codeaurora.org> <20110201143356.GB20088@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110201143356.GB20088@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Anirudh Ghayal <aghayal@codeaurora.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Mark,

On 2/1/2011 8:03 PM, Mark Brown wrote:
> On Tue, Feb 01, 2011 at 07:17:41PM +0530, Anirudh Ghayal wrote:
>> One-touch headset controller is a hardware module in Qualcomm's PMIC8058.
>> It supports headset insert/remove and switch press/release detection events
>> over 3 MIC BIAS lines. The MIC BIAS lines can be configured to support
>> headset detection or act as regular BIAS lines.
> 
> This should probably be integrated with ASoC for management of the
> biases if nothing else, though it'd also allow other stuff.  ALSA has
> support for creating input devices from jacks already.
> 
>> +	input_set_capability(ipd, EV_SW, SW_HEADPHONE_INSERT);
>> +	input_set_capability(ipd, EV_KEY, KEY_MEDIA);
> 
> The ALSA (well, ASoC) stuff would also allow the input device to be
> merged with that for other detection methods so if you've got a headset
> jack capable of detecting other things (eg, mechanical insertion or
> separate mic and headphone detection).

Thanks for the review. We will analyze on how much we should be able to move
from this OTHC driver to ALSA jack detection.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
