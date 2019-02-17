From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/3] input: goodix - support Goodix gt5688
Date: Sat, 16 Feb 2019 23:07:06 -0800
Message-ID: <20190217070527.GC148958@dtor-ws>
References: <cover.1550239328.git.agx@sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 15, 2019 at 03:11:50PM +0100, Guido Günther wrote:
> Besides the support for gt5688 two more minimal changes piled up so I'm
> folding these in here. One is a doc update for the goodix bindings, the
> other one makes it a bit simpler to figure out configuration problems
> (like lack of touchscreen-size-{x,y} in the device tree.
> 
> I've kept the original subject to (hopefully) not break the series for
> patchwork. All patches can be applied independently. Series is based on
> next-20190208.
> 
> Changes from v2
> * Add 'dt-bindings: input: Refer to touchscreen.txt for goodix ts'
> * Add 'input: goodix: Print values in case of inconsistencies'
>   (sent out separtely before, no comments so far)
> * Collect 'Reviewed-By' on 'input: goodix - support Goodix gt5688'

Applied the lot, thank you.

-- 
Dmitry
