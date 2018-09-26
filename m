From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 7/8] dt-bindings: watchdog: document stpmic1 pmic
 watchdog
Date: Wed, 26 Sep 2018 10:29:23 -0500
Message-ID: <20180926152923.GA1821@bogus>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-8-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536325173-16617-8-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

On Fri, 7 Sep 2018 12:59:45 +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 PMIC embeds a watchdog which is disabled by default.
> In case of watchdog, the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
