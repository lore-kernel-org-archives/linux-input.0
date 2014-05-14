From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [STLinux Kernel] [PATCH v4 2/7] driver: reset: sti: add keyscan
 for stih415
Date: Wed, 14 May 2014 11:15:53 +0200
Message-ID: <1400058953.13056.2.camel@paszta.hi.pengutronix.de>
References: <1397228856-9218-1-git-send-email-gabriel.fernandez@linaro.org>
	 <1397228856-9218-3-git-send-email-gabriel.fernandez@linaro.org>
	 <53732EAB.1050709@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53732EAB.1050709@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org, kernel@stlinux.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriel Fernandez <gabriel.fernandez@linaro.org>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Giuseppe Condorelli <giuseppe.condorelli@st.com>
List-Id: linux-input@vger.kernel.org

Hi Maxime,

Am Mittwoch, den 14.05.2014, 10:51 +0200 schrieb Maxime Coquelin:
> Hi Philipp,
> 
> 	I am preparing the arm_soc pull request for STi platforms.
> 
> 	In this series, there are DT patches depending on this reset patch 
> (same for patch 3).
> 
> 	Can I queue theses two reset patches in my pull request for arm_soc to 
> avoid compilation breakage?

Yes, please do. For both of them, feel free to add my
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

best regards
Philipp

