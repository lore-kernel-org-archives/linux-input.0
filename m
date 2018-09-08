From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH V2 4/8] regulator: stpmic1: add stpmic1 regulator driver
Date: Sat, 8 Sep 2018 11:37:29 +0200
Message-ID: <CAAj6DX2tnT5wjmy9nfRx7ut62_6rsQ00RNjaXX3WxMsB+mSHYw@mail.gmail.com>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com> <1536325173-16617-5-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536325173-16617-5-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: p.paillet@st.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, lee.jones@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org, linux@roeck-us.net, linux-input <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, benjamin.gaignard@linaro.org, eballetbo@gmail.com
List-Id: linux-input@vger.kernel.org

On Fri, Sep 7, 2018 at 3:15 PM Pascal PAILLET-LME <p.paillet@st.com> wrote:
>
> From: pascal paillet <p.paillet@st.com>
>
> The stpmic1 PMIC embeds several regulators and witches with
> different capabilities.

While fixing Kconfig, as Mark suggest, would you mind to fix also the
typo s/witches/switches/ in the commit message?

Antonio
