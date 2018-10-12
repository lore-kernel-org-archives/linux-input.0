From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/8] dt-bindings: regulator: document stpmic1 pmic
  regulators
Date: Fri, 12 Oct 2018 10:32:22 -0500
Message-ID: <20181012153222.GA29914@bogus>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-4-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539016176-4072-4-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

On Mon, 8 Oct 2018 16:29:40 +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3: nothing
> 
>  .../bindings/regulator/st,stpmic1-regulator.txt    | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
