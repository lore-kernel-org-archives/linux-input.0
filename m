From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 0/3] mfd: max8997: add regmap support
Date: Thu, 29 Jan 2015 10:03:26 -0800
Message-ID: <20150129180326.GB26625@dtor-ws>
References: <1415776996-11569-1-git-send-email-r.baldyga@samsung.com>
 <54C8F01B.5030300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54C8F01B.5030300@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: lee.jones@linaro.org, a.zummo@towertech.it, sameo@linux.intel.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, cooloney@gmail.com, rpurdie@rpsys.net, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, paul.gortmaker@windriver.com, sachin.kamat@linaro.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hi Robert,

On Wed, Jan 28, 2015 at 03:20:11PM +0100, Robert Baldyga wrote:
> Hi,
> 
> The first version of this patchset was send to kernel list almost 9
> months ago and still I don't have all needed Acks. The missing ones are
> for changes in INPUT and RTC subsystems.
> 
> Dmitry, Alessandro, could you please have a look at this patches and
> give your Acks?

Sorry, there was nothing input-specific in the change (even though it
did touch one of the input drivers) so I did not realize you were
waiting for an ack.

Just for the record I am fine with the change.

Thanks.

-- 
Dmitry
