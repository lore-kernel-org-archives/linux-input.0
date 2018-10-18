From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Date: Thu, 18 Oct 2018 13:47:26 -0500
Message-ID: <20181018184726.GA27696@bogus>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539853324-29051-2-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

On Thu, 18 Oct 2018 09:02:11 +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators , 3 switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v4:
> * remove interrupt-parent description
> * pmic1@33 renamed to pmic@33
> * fix indentation
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 131 +++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  46 ++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
