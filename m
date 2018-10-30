From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/8] dt-bindings: mfd: document stpmic1
Date: Tue, 30 Oct 2018 14:32:20 -0500
Message-ID: <20181030193220.GA29498@bogus>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-2-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540830122-2577-2-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2018 16:22:04 +0000, Pascal PAILLET-LME wrote:
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v5:
> * removed st properties
> * added buck modes definitions in the header
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 61 ++++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               | 50 ++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
