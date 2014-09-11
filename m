From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/4] Input: misc: Add haptic driver on max77693
Date: Thu, 11 Sep 2014 10:10:02 -0700
Message-ID: <20140911171002.GC13083@core.coreip.homeip.net>
References: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
 <1410440062-19963-3-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410440062-19963-3-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Sep 11, 2014 at 09:54:20PM +0900, Jaewon Kim wrote:
> This patch add max77693-haptic device driver to support the haptic controller
> on MAX77693. The MAX77693 is a Multifunction device with PMIC, CHARGER, LED,
> MUIC, HAPTIC and the patch is haptic device driver in the MAX77693. This driver
> support external pwm and LRA(Linear Resonant Actuator) motor. User can control
> the haptic driver by using force feedback framework.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

How do we want to merge this?

-- 
Dmitry
