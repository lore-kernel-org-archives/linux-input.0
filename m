From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: am335x: IIO/ADC fixes if used together with TSC
Date: Wed, 18 Dec 2013 17:25:09 +0000
Message-ID: <d916c9be-2614-41b8-ae92-67bf1a57ed74@email.android.com>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Given timing I suspect that by the we have reviewed these will be too late in this cycle so will hit in the merge window plus stable.

Also some of these are cleanups rather than fixes so should normally be separate from fixes and applied after them as they are not 
Stable material.

Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>Hi,
>
>this series got a little bigger than expected with a biggy at the end.
>I didn't managed to split the patches across the three subsystems it
>touches due to the changes are required to keep it working and break
>the
>logic.
>Even in 5/5 which does three logical changes I didn't manage to split
>it
>in three patches because the driver would not be functional (sometimes
>it would
>get worse than before). This is all documented in the changelog. 
>Thefore I ask to get this series applied via one tree, the iio tree
>which contains
>or depends on the most changes.
>
>The two bigger issues here are fixed by the last patch incuding
>- time outs on the iio/adc side while TSC&ADC is used together
>- a lockup issue which occurs while TSC&ADC is used together.
>
>Sebastian
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
