From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 2/8] mfd: stpmic1: add stpmic1 driver
Date: Tue, 27 Nov 2018 08:57:42 +0000
Message-ID: <20181127085742.GG4272@dell>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-3-git-send-email-p.paillet@st.com>
 <20181113074037.GC29388@dell>
 <5BFC2B69.1050204@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5BFC2B69.1050204@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

On Mon, 26 Nov 2018, Pascal PAILLET-LME wrote:
> Hi Lee,
> I have just one question regarding i2c_device_id.

Don't forget to trim your responses.

Lots of unrequired quotes here.

[...]

> >> +static const struct i2c_device_id stpmic1_id[] = {
> >> +	{ "stpmic1"},
> >> +	{}
> >> +};
> > I don't think this is required any more.
> should I replace with the following ?
> 
> static const struct of_device_id stpmic1_of_match[] = {
>      { .compatible = "st,stpmic1", },
>      {},
> };
> MODULE_DEVICE_TABLE(of, stpmic1_of_match);

I think it should have had that already.  So yes, please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
