From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Date: Wed, 24 Oct 2018 12:54:46 +0000
Message-ID: <5BD06B96.3080809@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019115015.GC5895@sirena.org.uk>
Content-Language: en-US
Content-ID: <25C03AB68B403D46ADF5E95C06741A59@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

Hello Mark,

Le 10/19/2018 01:50 PM, Mark Brown a écrit :
> On Thu, Oct 18, 2018 at 09:02:12AM +0000, Pascal PAILLET-LME wrote:
>
>> +	for (i = 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
>> +		/* Parse DT & find regulators to register */
>> +		init_data = stpmic1_regulators_matches[i].init_data;
>> +		if (init_data)
>> +			init_data->regulator_init = &stpmic1_regulator_parse_dt;
>> +
>> +		rdev = stpmic1_regulator_register(pdev, i, init_data, regul);
>> +		if (IS_ERR(rdev))
>> +			return PTR_ERR(rdev);
> This looks mostly good, the only big thing is this - the default is to
> just unconditionally register all the regulators that exist rather than
> only those that are configured on that particular platform.  This is a
> bit simpler and means that all the readback of the configuration for the
> unconfigured regulators is available for diagnostics.  Is there a reason
> not to do that?
I'm sorry, I'm not sure to understand. Would you prefer to not register 
regulators that
are not described in the device-tree ?

In that case I could add:
     if (!init_data)
         continue;

This would permit to keep some regulators unmodified by the kernel. This 
can be useful
because we have some regulators configured by boot loaders (for the DDR 
at least) and
it would be more simple to not handle them in the kernel.

best regards,
pascal
