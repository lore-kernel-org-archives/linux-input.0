From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Input: ili210x - switch to using threaded IRQ
Date: Fri, 23 Aug 2019 12:34:13 +0200
Message-ID: <1bee0866-d022-2adf-3734-aeb2689d28f1@denx.de>
References: <20190811161104.GA43556@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190811161104.GA43556@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 8/11/19 6:11 PM, Dmitry Torokhov wrote:
> Let's switch the driver to using threaded IRQ so that we do not need to
> manage the interrupt and work separately, and we do not acknowledge
> interrupt until we finished handling it completely.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On ILI2117
Tested-by: Marek Vasut <marex@denx.de>
