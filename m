From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - add support for polled
 configuration
Date: Thu, 2 May 2019 16:32:17 -0500
Message-ID: <20190502213217.GA14901@bogus>
References: <20190430185859.24015-1-nsaenzjulienne@suse.de>
 <20190430185859.24015-2-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430185859.24015-2-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 30 Apr 2019 20:58:59 +0200, Nicolas Saenz Julienne wrote:
> Some devices might not provide an interrupt line for the touchscreen.
> In that case the driver defaults to using a polled interface.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.txt  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
