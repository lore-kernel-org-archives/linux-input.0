From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] ARM: davinci: tnetv107x removal
Date: Wed, 26 Feb 2014 14:46:28 +0100
Message-ID: <201402261446.29257.arnd@arndb.de>
References: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, davinci-linux-open-source@linux.davincidsp.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 26 February 2014, Arnd Bergmann wrote:

> The five patches are completely independent of one another,
> and applying them out of order is fine since we just want
> to remove the code. However, I'm looking for an Ack from
> Cyril Chemparathy and Sekhar Nori first, to be sure we
> won't need this code in the future. Kevin Hilman has
> already mentioned that he sees no reason to keep this
> code.

Hmm, apparently Cyril is no longer at TI. If anyone has his
current email address and thinks he might have an opinion,
could you forward the original email?

	Arnd
