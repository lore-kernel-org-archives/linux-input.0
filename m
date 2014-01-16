From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv2 0/3] Input: edt-ft5x06: Add DT support
Date: Thu, 16 Jan 2014 09:02:15 +0100
Message-ID: <1389859338-11685-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Silvio F <silvio.fricke@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Changes wrt. v1:
addressed the comments from Jingoo Han and Mark Rutland
- added another patch to convert the driver to use devm_* functions
- removed sysfs reference from bindings documentation
- changed '_' to '-' in property name
- added 'edt,' prefix to properties names
- added sanity check for parameters read from DT
- cleaned up the gpio handling code

