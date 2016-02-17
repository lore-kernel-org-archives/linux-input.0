From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
Date: Wed, 17 Feb 2016 10:45:40 +0100
Message-ID: <13357929.DDBX61jLXt@wuerfel>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com> <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-input@vger.kernel.org

On Wednesday 17 February 2016 15:13:44 Raveendra Padasalagi wrote:
> +
> +       ts_adc_syscon: ts_adc_syscon@0x180a6000 {
> +               compatible = "syscon";
> +               reg = <0x180a6000 0xc30>;
> +       };
> 

This should have a more specific compatible string in addition to the
generic "syscon" one.

	Arnd
