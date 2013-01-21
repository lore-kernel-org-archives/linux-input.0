From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/33] Input: Convert to devm_ioremap_resource()
Date: Mon, 21 Jan 2013 16:27:03 +0530
Message-ID: <CAKohpomN3tzdyHpv4ms2kgMK2DAQ9Q-8554He-1LjkVF0iXr_Q@mail.gmail.com>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
	<1358762966-20791-13-git-send-email-thierry.reding@avionic-design.de>
	<CAOh2x==ECCN-2wEkFuNQ6DN2K6LMe3kvYMXXpk1bzQvUVo19Wg@mail.gmail.com>
	<20130121104946.GA27252@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130121104946.GA27252@avionic-0098.adnet.avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 21 January 2013 16:19, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> Can you specify why? devm_request_and_ioremap() and the new
> devm_ioremap_resource() both already output an error message if they
> can't request or ioremap the memory region, so all this does is output a
> duplicate error message.

because i missed implementations of these routines.. Ignore this comment
wherever i gave it :)
