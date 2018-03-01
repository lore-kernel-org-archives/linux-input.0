From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] Input: gpio-keys - allow setting wakeup event
 action in DT
Date: Thu, 1 Mar 2018 15:26:20 -0600
Message-ID: <20180301212620.bfrz6qjqsg4xkdaa@rob-hp-laptop>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180210110907.5504-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com, dianders@google.com, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Sat, Feb 10, 2018 at 07:09:06PM +0800, Jeffy Chen wrote:
> Allow specifying event actions to trigger wakeup when using the
> gpio-keys input device as a wakeup source.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
