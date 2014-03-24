From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
Date: Mon, 24 Mar 2014 13:36:42 +0000
Message-ID: <20140324133642.GB21665@lee--X1>
References: <1395154806-2810-1-git-send-email-gabriel.fernandez@st.com>
 <1395154806-2810-2-git-send-email-gabriel.fernandez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395154806-2810-2-git-send-email-gabriel.fernandez@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Giuseppe Condorelli <giuseppe.condorelli@st.com>
List-Id: linux-input@vger.kernel.org

> This patch adds ST Keyscan driver to use the keypad hw a subset
> of ST boards provide. Specific board setup will be put in the
> given dt.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> ---
>  .../devicetree/bindings/input/st-keyscan.txt       |  60 +++++
>  drivers/input/keyboard/Kconfig                     |  12 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/st-keyscan.c                | 260 +++++++++++=
++++++++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st-keysca=
n.txt
>  create mode 100644 drivers/input/keyboard/st-keyscan.c

=46WIW: This looks good to me now:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
