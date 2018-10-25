From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Date: Thu, 25 Oct 2018 13:23:08 +0000
Message-ID: <5BD1C3BB.6060500@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk> <5BD06B96.3080809@st.com>
 <20181024131716.GQ2103@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024131716.GQ2103@sirena.org.uk>
Content-Language: en-US
Content-ID: <AF637F4DFBD7E54B9A25F414B9E1D73B@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

Hello Mark,

Le 10/24/2018 03:17 PM, Mark Brown a écrit :
> On Wed, Oct 24, 2018 at 12:54:46PM +0000, Pascal PAILLET-LME wrote:
>
>> I'm sorry, I'm not sure to understand. Would you prefer to not register
>> regulators that
>> are not described in the device-tree ?
> No, I'm saying register all regulators regardless of if they are in the
> device tree - you shouldn't be looking at the init data at all here,
> just let the framework match them using of_match.
I have reworked the code so that we don't touch any more to the init_data.
the new loop to register the regulators is below:

     for (i = 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
         ret = stpmic1_regulator_register(pdev, i, &stpmic1_matches[i],
                          regul);
         if (ret < 0)
             return ret;
         regul++;
     }

Each regulator is registered, even is it is not described in the 
device-tree.

stpmic1_regulator_parse_dt() and stpmic1_regulator_init() are now merged 
inside
stpmic1_regulator_register() function.

Thank You,
pascal
