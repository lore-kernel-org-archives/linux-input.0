From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: Add Lenovo Miix 630
Date: Fri, 26 Apr 2019 21:42:45 -0700
Message-ID: <20190427044245.GD3137@builder>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161115.16466-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415161115.16466-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, lee.jones@linaro.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon 15 Apr 09:11 PDT 2019, Jeffrey Hugo wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
[..]
> +	thermal-zones {
> +		battery-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 0>;

I guess you inherited the battery and skin thermal nodes from my MTP
dts. Unfortunately after talking to Amit I think I got these wrong, and
they should be &pmi8998_adc 0 and 5 instead.

Can you confirm this?

> +
> +			trips {
> +				battery_crit: trip0 {
> +					temperature = <60000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};

Regards,
Bjorn
